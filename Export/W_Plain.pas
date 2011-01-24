unit W_Plain;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses Classes, IBQuery, DB, ExcelXP, WordXP, W_Base, X_List;

type
  TWriteHTMLPlain = class(TWriteHTMLBase)
  private
    { Private-Deklarationen }
    R: TStrings;
    FColumnNames: TStrings;
    TableHeader: TStrings;
    function AddTableContent: TStrings;
    function AddTableHeader:TStrings;
  protected
    { Protected-Deklarationen }
    procedure DoHeader(GroupStr: String); override;
    procedure DoFooter(GroupStr: String); override;
  public
    { Public-Deklarationen }
    procedure DoSingle(Query: TIBQuery; Item: TExportItem); override;
  end;

  TWriteExcelPlain = class(TWriteExcelBase)
  private
    { Private-Deklarationen }
    FColumnNames: TStrings;
    procedure DoTableHeader;
  protected
    { Protected-Deklarationen }
    procedure DoHeader(GroupStr: String); override;
    procedure DoFooter(GroupStr: String); override;
  public
    { Public-Deklarationen }
    procedure DoSingle(Query: TIBQuery; Item: TExportItem;
      Sheet: _WorksheetDisp); override;
  end;

  TWriteWordPlain = class(TWriteWordBase)
  private
    { Private-Deklarationen }
    ovStart: OleVariant;
    RowText: String;
    SubCount, TableCount : Integer;
    FColumnNames: TStrings;
    procedure DoTableHeader;
  protected
    { Protected-Deklarationen }
    procedure DoHeader(GroupStr: String); override;
    procedure DoFooter(GroupStr: String); override;
  public
    { Public-Deklarationen }
    procedure DoSingle(Query: TIBQuery; Item: TExportItem;
      Doc: WordDocument); override;
  end;

  TWriteCalcPlain = class(TWriteCalcBase)
  private
    { Private-Deklarationen }
    GroupStrType: String;
    FColumnIsNum, FColumnIsStr, FColumnIsDate,
      FColumnIsDateTime: Array of Boolean;
  protected
    { Protected-Deklarationen }
    FColumnNames, FColumnFormats: TStrings;
    procedure InitColumn(Item: TExportItem);
    procedure CellFmt(ICol, Row: Integer);
    function  GetGroupString: String; override;
    procedure DoHeader(GroupStr: String); override;
    procedure DoFooter(GroupStr: String); override;
    procedure DoTableHeader; virtual;
    procedure DoColumnFmt; virtual;
  public
    { Public-Deklarationen }
    procedure DoSingle(Query: TIBQuery; Item: TExportItem;
      ooInstance, Sheet: Variant); override;
  end;

  TWriteTextPlain = class(TWriteTextBase)
  private
    { Private-Deklarationen }
    procedure DoTableHeader;
    procedure FormatHeader;
  protected
    { Protected-Deklarationen }
    FColumnNames, FColumnFormats: TStrings;
    procedure DoHeader(GroupStr: String); override;
    procedure DoFooter(GroupStr: String); override;
    procedure DrawCell(aCol, aRow: Integer; aField: TField); virtual;
  public
    { Public-Deklarationen }
    procedure DoSingle(Query: TIBQuery; Item: TExportItem;
      Doc: Variant); override;
  end;

implementation

uses SysUtils, Variants, Dialogs;

{ TWriteHTMLPlain }

function TWriteHTMLPlain.AddTableContent: TStrings;
Var I: Integer;
begin
  R := TStringList.Create;	{ construct the list object }

  With FQuery do
  begin
    If not IsGrouping then // No Row Grouping
    begin
      R.Append('    <table class="plain">');
      R.AddStrings(TableHeader);
    end;

    while not EOF do // scan the database table
    begin
      BandHeader;

      // Get Field Content
      R.Append('    <tr>');
      For I := 0 to FColumnNames.Count-1 do
        R.Append('      <td>'+Fieldbyname(FColumnNames[I]).AsString+'</td>');
      R.Append('    </tr>');

      Next;
      BandFooter; // After Next !!
    end; // while
    If not IsGrouping then R.Append('    </table>'); // No Row Grouping
  end;

  Result := R;
end;

function TWriteHTMLPlain.AddTableHeader: TStrings;
Var I: Integer;
begin
  Result := TStringList.Create;	{ construct the list object }
  With Result do
  begin
    Append('    <tr>');
    For I := 0 to FColumnNames.Count-1 do
      Append('      <th>'+FColumnNames[I]+'</th>');
    Append('    </tr>');
  end;
end;

procedure TWriteHTMLPlain.DoHeader(GroupStr: String);
begin
  R.Append('  <h2>'+FGroupStr+'</h2>');
  R.Append('  <table class="plain">');
  R.AddStrings(TableHeader);
end;

procedure TWriteHTMLPlain.DoFooter(GroupStr: String);
begin
  R.Append('  </table>'); // Group Footer
end;

procedure TWriteHTMLPlain.DoSingle;
Var TableContent: TStrings; // declare HTML Line
begin
  inherited;
  FColumnNames := Item.Headers;
  TableHeader  := AddTableHeader; // Before AddTableContent
  TableContent := AddTableContent;

  try    { use the string list }
    Lines.AddStrings(TableContent);
  finally
    {clean up, destroy the list object}
    TableHeader.Free;
    TableContent.Free;
  end;
end;

{ TWriteExcelPlain }

procedure TWriteExcelPlain.DoTableHeader;
Var CC, I: Integer;
begin
  CC:= FColumnNames.Count;
  StartRow:=Row;
  For I := 0 to CC-1 do
  begin
    ExR := SetExR (Char(I+65),Row);
    ExR.Value2 := FColumnNames[I];
    With ExR.Font do begin Size:=11; Bold:=1; end;
  end;
  Inc (Row);
end;

procedure TWriteExcelPlain.DoHeader(GroupStr: String);
begin
  ExR := SetExR ('A','B',Row,Row);
  ExR.MergeCells := True;
  ExR.Value2 := FGroupStr;
  With ExR.Font do begin Size:=13; Bold:=1; end;
  Inc (Row);

  DoTableHeader;
end;

procedure TWriteExcelPlain.DoFooter(GroupStr: String);
begin
  // Format Header, Body and Footer
  // AutoFormat (StartRow, Row, False);
  Inc (Row);
end;

procedure TWriteExcelPlain.DoSingle;
Var CC, I: Integer;
begin
  inherited;
  FColumnNames := Item.Headers;
//  AFmt:=6;

  CC:= FColumnNames.Count;
  OpenSheet(Char(CC+65-1));

  With FQuery do
  begin
    StartRow:=4; Row:=StartRow;

    If not IsGrouping then DoTableHeader;

    while not EOF do
    begin // scan the database table
      BandHeader;

      For I := 0 to CC-1 do
        SetExR (Char(I+65),Row).Value2
          := Fieldbyname(FColumnNames[I]).AsString;
      Inc (Row);

      FQuery.Next;
      BandFooter; // After Next !!
    end; // while

    // Format Header, Body and Footer
    // If not IsGrouping then AutoFormat (StartRow, Row);

  end; // with

  Tidy;
end;

{ TWriteWordPlain }

procedure TWriteWordPlain.DoTableHeader;
Var I: Integer;
begin
  ovStart := DocEnd_;

  RowText:=FColumnNames[0];
  For I := 1 to FColumnNames.Count-1 do
    RowText := RowText + #9 + FColumnNames[I];

  With WordDoc.Paragraphs.Last.Range do begin
    Text := RowText + #13;
    Font.Size := 12; Font.Bold := 1;
  end;

  With WordDoc.Paragraphs.Last.Range do begin
    Font.Size := 10; Font.Bold := 0;
  end;
end;

procedure TWriteWordPlain.DoHeader(GroupStr: String);
begin
  With WordDoc.Paragraphs.Last.Range do begin
    Text := FGroupStr + #13;
    Font.Size := 13; Font.Bold := 1;
  end;

  DoTableHeader;
end;

procedure TWriteWordPlain.DoFooter(GroupStr: String);
begin
  ConvertToTable // Formatting Table, For Each Row
    (ovStart, DocEnd_, TableCount, SubCount, FColumnNames.Count);
end;

procedure TWriteWordPlain.DoSingle(Query: TIBQuery; Item: TExportItem;
  Doc: WordDocument);
Var I : Integer;
begin
  inherited;
  FColumnNames := Item.Headers;
  NewDoc;

  With FQuery do
  begin
    SubCount:=0;
    TableCount:=0;

    If not IsGrouping then DoTableHeader;

    while not EOF do
    begin // scan the database table
      BandHeader;

      RowText:=Fieldbyname(FColumnNames[0]).AsString;
      For I := 1 to FColumnNames.Count-1 do
        RowText := RowText + #9 + Fieldbyname(FColumnNames[I]).AsString;

      WordDoc.Paragraphs.Last.Range.Text := RowText + #13;

      Inc(SubCount);
      FQuery.Next;
      BandFooter; // After Next !!
    end; // EOF

    If not IsGrouping then ConvertToTable // Formatting Table, For Each Row
      (ovStart, DocEnd_, TableCount, SubCount, FColumnNames.Count);
  end; // with
end;

{ TWriteCalcPlain }

procedure TWriteCalcPlain.DoSingle(Query: TIBQuery; Item: TExportItem;
  ooInstance, Sheet: Variant);
Var CC, I: Integer;
begin
  inherited;
  AFmt := 'Cinta Biru';

  InitColumn(Item);
  FColumnNames := Item.Headers;
  CC := FColumnNames.Count;
  OpenSheet(CC);

  With FQuery do
  begin
    StartRow:=4; Row:=StartRow;

    If not IsGrouping then DoTableHeader;
    If not EOF then DoColumnFmt;

    while not EOF do
    begin // scan the database table
      BandHeader;

      For I := 0 to CC-1 do
      With FieldByName(FColumnNames[I]) do
        CellFmt (I, Row);

      Inc (Row);

      FQuery.Next;
      BandFooter; // After Next !!
    end; // while

    // Format Header, Body and Footer
    If not IsGrouping then
      AutoFormat(StartRow, Row, AFmt);

  end; // with

  Tidy(CC);
end;

procedure TWriteCalcPlain.DoTableHeader;
Var
  CC, I: Integer;
begin
  CC:= FColumnNames.Count;
  StartRow:=Row;
  For I := 0 to CC-1 do
  begin
    aCell := SetExR (I, Row);
    aCell.SetFormula (FColumnNames[I]);
    aCell.CharHeight := 13;
    aCell.CharWeight := 150;  // 150%
  end;

  Inc (Row);
end;

procedure TWriteCalcPlain.DoHeader(GroupStr: String);
begin
  Sheet.getCellRangeByPosition(0,Row,1,Row).merge(True);
  aCell := Sheet.getCellByPosition(0, Row);
  aCell.SetString( FGroupStr );
  aCell.CharHeight := 13;
  aCell.CharWeight := 150;  // 150%
  aCell.CharColor := $003399;
  aCell.CellBackColor := $ffff80;

  Inc (Row);
  StartRow:=Row;

  DoTableHeader;
end;

procedure TWriteCalcPlain.DoFooter(GroupStr: String);
begin
  GroupRow   (StartRow, Row);
  // Format Header, Body and Footer
  AutoFormat (StartRow, Row, AFmt);
end;

procedure TWriteCalcPlain.DoColumnFmt;
Var
  CC, I: Integer;
  aFmt: String;
  aColumn, Columns : Variant;
begin
  CC:= FColumnNames.Count;
  Columns := Sheet.getColumns;
  For I := 0 to CC-1 do
  begin
    aFmt := FColumnFormats.Names[I];
    If (aFmt='') then aFmt:=FColumnFormats[I];
    aColumn := Columns.getByIndex(I);
    If (aFmt='Rp') then aColumn.NumberFormat := 4;
    If (aFmt='Date') then aColumn.NumberFormat := 80;
    If (aFmt='DateTime') then aColumn.NumberFormat := 51;
  end;
end;

procedure TWriteCalcPlain.CellFmt(ICol, Row: Integer);
Var
  TextValue: String;
begin
  With FQuery.FieldByName(FColumnNames[ICol]) do
  begin
    If FColumnIsNum[ICol] then
      SetExR (ICol, Row).setValue( AsCurrency )
    else if FColumnIsStr[ICol] then
      SetExR (ICol, Row).setString( AsString ) // Cell = #39 + AsString
    else  
    begin
      if FColumnIsDate[ICol] then
        TextValue := FormatDateTime('YYYY-MM-DD', AsDateTime)
      else if FColumnIsDateTime[ICol] then
        TextValue := FormatDateTime('YYYY-MM-DD hh:nn:ss', AsDateTime)
      else TextValue := AsString;

      SetExR (ICol, Row).setFormula(TextValue);
    end;
  end;
end;

function TWriteCalcPlain.GetGroupString: String;
begin
  With FQuery.Fieldbyname(FGroupField) do
  begin
    If (GroupStrType='Date') then
       Result := FormatDateTime('YYYY-MM-DD', AsDateTime)
    else if (GroupStrType='DateTime') then
       Result := FormatDateTime('YYYY-MM-DD hh:nn:ss', AsDateTime)
    else
       Result := AsString;
    if (GroupStrType='Str') then
       Result := '''' + Result;  // #39
  end;
end;

procedure TWriteCalcPlain.InitColumn(Item: TExportItem);
Var
  CC, I: Integer;
  S: String;
begin
  // Header Group's Type
  If (FGroupField<>'') then
  begin
    I := Item.Headers.IndexOf(FGroupField);
    if (I<>-1) then
      GroupStrType := Item.FmtID[I];
  end;

  // Column's Format
  FColumnFormats := Item.FmtID;
  CC:= FColumnFormats.Count;

  SetLength(FColumnIsNum, CC);
  SetLength(FColumnIsStr, CC);
  SetLength(FColumnIsDate, CC);
  SetLength(FColumnIsDateTime, CC);

  For I := 0 to CC-1 do
  begin
    S := FColumnFormats.Names[I];
    If (S='') then S:=FColumnFormats[I];
    FColumnIsNum[I]      := (S = 'Rp');
    FColumnIsStr[I]      := (S = 'Str');
    FColumnIsDate[I]     := (S = 'Date');
    FColumnIsDateTime[I] := (S = 'DateTime');
  end;
end;

{ TWriteTextPlain }

procedure TWriteTextPlain.DoFooter(GroupStr: String);
begin
  FormatHeader;
  TextDoc.insertControlCharacter( TextCursor, 0, false ); // PARAGRAPH_BREAK
  // Nggak dipakek soale djelek
  // TextCursor.PageDescName := TextCursor.PageStyleName;    // New Page
end;

procedure TWriteTextPlain.DoHeader(GroupStr: String);
begin
  TextCursor.ParaStyleName := 'Heading 2';
  TextDoc.insertString( TextCursor, GroupStr+#13, false );
  TextCursor.ParaStyleName := 'Standard';

  DoTableHeader;
end;

procedure TWriteTextPlain.DoSingle(Query: TIBQuery; Item: TExportItem;
  Doc: Variant);
Var
  I, RowCount : Integer;
  TableRows: Variant;
begin
  inherited;
  FColumnNames := Item.Headers;
  FColumnFormats := Item.FmtID;
  NewDoc;

  With FQuery do
  begin
    If not IsGrouping then DoTableHeader;

    while not EOF do
    begin // scan the database table
      TextComponent.lockControllers;
      BandHeader;

      TableRows := TextTable.getRows;
      RowCount := TableRows.getCount;
      TableRows.insertByIndex(RowCount, 1);

      For I := 0 to FColumnNames.Count-1 do
        DrawCell(I, RowCount, FieldByName(FColumnNames[I]));

      Inc(RowCount);
      FQuery.Next;
      BandFooter; // After Next !!
      TextComponent.unlockControllers;
    end; // EOF

    If not IsGrouping then FormatHeader;
  end; // with
end;

procedure TWriteTextPlain.DrawCell(aCol, aRow: Integer; aField: TField);
  begin TextTable.getCellByPosition(aCol,aRow).setString(aField.AsString); end;

procedure TWriteTextPlain.DoTableHeader;
Var
  CC, I, BaseWidth, SumOfCWR: Integer;
  CWR: Array of Integer; // Column Width Ratio
  ColSeps: Variant;
begin
  TextTable := TextComponent.createInstance('com.sun.star.text.TextTable');
  TextTable.initialize(1, FColumnNames.Count);
  TextDoc.insertTextContent( TextCursor, TextTable, False);

  For I := 0 to FColumnNames.Count-1 do
    TextTable.getCellByPosition(I, 0).setString(FColumnNames[I]);

  // additional, setting column width
  If (FColumnFormats.CommaText <> '') then
  begin
    CC := FColumnFormats.Count;
    SetLength(CWR, CC);

    Try
      For I := 0 to CC-1 do
        CWR[I] := StrToInt( FColumnFormats.ValueFromIndex[I] );
    except
      on exception do exit;  // silence
    end;

    SumOfCWR := 0; { Note that open array index range is always zero-based. }
    For I := 0 to CC-1 do Inc(SumOfCWR, CWR[I]);

    BaseWidth := TextTable.TableColumnRelativeSum div SumOfCWR;

    ColSeps := TextTable.TableColumnSeparators;
    For I := 0 to CC-2 do  // Separator is less than Columns Count
      If (I=0) then ColSeps[0].Position := BaseWidth * CWR[I]
      else ColSeps[I].Position := ColSeps[I-1].Position + (BaseWidth * CWR[I]);
    TextTable.TableColumnSeparators := ColSeps;
  end;
end;

procedure TWriteTextPlain.FormatHeader;
Var
  I: Integer;
  FirstRow, CellCursor : Variant;
begin
  FirstRow := TextTable.getRows.getByIndex(0);
  FirstRow.BackColor := $b0b0ff;

  For I := 0 to FColumnNames.Count-1 do
  begin
    CellCursor := TextTable.getCellByPosition(I, 0).createTextCursor;
    CellCursor.gotoEndOfParagraph(True);
    CellCursor.CharHeight := 12;
    CellCursor.CharWeight := 150;  // 150%
  end;
end;

end.
