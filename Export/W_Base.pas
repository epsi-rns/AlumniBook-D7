unit W_Base;
// Contain Abstract Classes
{$WARN SYMBOL_PLATFORM OFF}

interface

uses Classes, DB, IBQuery, ExcelXP, WordXP, X_List;

type
  TWriteBase = class
  private
    { Private-Deklarationen }
  protected
    { Protected-Deklarationen }
    FRL: TList;  // Free Report List  ;-)
    FItem: TExportItem;
    FQuery: TIBQuery;
    FTitle: String;
    IsGrouping: Boolean;
    FGroupField, FGroupStr: String;
    // DoRow Related Var
    DataSet: TDataSet;
    ReportBand: TStringList;
    procedure DoRow; virtual; abstract;
    procedure PrepareList; virtual; 
    procedure makeSQL(Query: TIBQuery; Index: Integer; ParamID: Integer);
    procedure DoReport(ADataSet: TDataSet; IsIterate:Boolean;
      DelimitedText: String);
    procedure DoQReport(Query: TIBQuery; Index: Integer; ParamID: Integer;
      IsIterate: Boolean; DelimitedText: String);
    // Band Methods
    function GetGroupString: String; virtual;
    function IsStartHeader: Boolean;
    function IsEndFooter: Boolean;
    procedure BandHeader;
    procedure BandFooter;
    procedure DoHeader(GroupStr: String); virtual; abstract;
    procedure DoFooter(GroupStr: String); virtual; abstract;
  public
    { Public-Deklarationen }
    constructor Create; virtual;
    destructor Destroy; override;
    procedure DoSingle(Query: TIBQuery; Item: TExportItem); virtual;
  end;

  TWriteHTMLBase = class(TWriteBase)
  private
    { Private-Deklarationen }
    CSS: String;
    { Common DoRow Detail }
    procedure ParseBand(CommaText: String);
    procedure CheckEnvironment;
  protected
    { Protected-Deklarationen }
    Lines: TStrings;
    { Common Abstract Implementation }
    procedure DoRow; override;
    { HTMLApp Methods }
    function AddDocHeader: TStrings;
    function AddDocFooter: TStrings;
  public
    { Public-Deklarationen }
    SavePath: String;
    constructor Create; override;
    destructor Destroy; override;
    procedure DoSingle(Query: TIBQuery; Item: TExportItem); override;
    procedure SaveAndShow;
  end;

  TWriteExcelBase = class(TWriteBase)
  private
    { Private-Deklarationen }
    { Common DoRow Detail }
    procedure ParseBand(CommaText: String);
  protected
    { Protected-Deklarationen }
    xls: _WorksheetDisp;
    ExR: ExcelRange;
    StartRow, Row : Integer;
    AFmt: Cardinal;
    LastCol : Char;
    ChartType: Cardinal;
    FComments: String;
    { Common Abstract Implementation }
    procedure DoRow; override;
    { ExcelApp Methods }
    procedure SetAutoFormat(xlAutoFormat: Integer);
    procedure SetChartType(Index: Integer);
    procedure OpenSheet(EndCol: Char);
    procedure Tidy;
    { ExcelRange ShortCut }
    function SetExR(Col: String; Row: Integer):ExcelRange; overload;
    function SetExR(Col1, Col2: String;
      Row1, Row2: Integer):ExcelRange; overload;
    procedure SetExVal(Col: String; Row: Integer; Value: Variant);
    procedure WriteCol(StCol: Char; Row: Integer; Ss: array of String);
    procedure WriteCumulative(DebCol, CreCol, Col: Char;
      StartRow, EndRow: Integer);
    procedure AutoFormat(StartRow, EndRow: Integer;
      Default: Boolean = True); Overload;
    procedure AutoFormat(StartCol, EndCol: Char;
      StartRow, EndRow: Integer; Default: Boolean = True); Overload;
  public
    { Public-Deklarationen }
    constructor Create; override;
    procedure DoSingle(Query: TIBQuery; Item: TExportItem;
      NewSheet: _WorksheetDisp); reintroduce; virtual;
  end;

  TWriteWordBase = class(TWriteBase)
  private
    { Private-Deklarationen }
    { Common DoRow Detail }
    function ParseBand(Text: String):string;
  protected
    { Protected-Deklarationen }
    WordDoc: WordDocument;
    AFmt: OleVariant;
    { Common Abstract Implementation }
    procedure DoRow; override;
    { WordApp Methods }
    procedure SetAutoFormat(wdTableAutoFormat: Integer);
    procedure NewDoc;
    { ShortCut }
    function DocEnd_: OleVariant;
    { Common Word-Doc }
    procedure ConvertToTable(ovStart, OvEnd: OleVariant;
      Var TableCount: Integer; SubCount: Integer; ColCount: Integer);
  public
    { Public-Deklarationen }
    procedure DoSingle(Query: TIBQuery; Item: TExportItem;
      Doc: WordDocument); reintroduce; virtual;
  end;

  TWriteSQL = class(TWriteBase)
  private
    { Private-Deklarationen }
    procedure SetInsertText;
    function ValuesText:String;
    procedure GetStruct;
    { Common DoRow Detail }
  protected
    { Protected-Deklarationen }
    SInsert: String;
    { Common Abstract Implementation }
    procedure DoRow; override;
    { SQLapp Methods }
  public
    { Public-Deklarationen }
    Lines: TStrings;
    constructor Create; override;
    destructor Destroy; override;
    procedure DoSingle(Query: TIBQuery; Item: TExportItem); override;
  end;

  TWriteCalcBase = class(TWriteBase)
  private
    { Private-Deklarationen }
    { Common DoRow Detail }
    procedure ParseBand(CommaText: String);
  protected
    { Protected-Deklarationen }
    OpenOffice, Sheet: Variant;
    aCell, aCellRange, aBorder: Variant;  // Common variable declarations
    StartRow, Row, LastCol : Integer;
    FComments: String;
    { Common Abstract Implementation }
    procedure DoRow; override;
    { CalcApp Methods }
    procedure OpenSheet(EndCol: Integer);
    procedure Tidy(EndCol: Integer);
    { Calc Helper }
    function SetExR(Col, Row: Integer): Variant; overload;
    function SetExR(Col: Char; Row: Integer): Variant; overload;
    procedure GroupRow(stRow, ndRow: Integer);    
    procedure WriteCol(StCol, Row: Integer; Ss: array of String);
    procedure FormatCol(StCol, Row: Integer; Ss: array of String);
    procedure WriteCumulative(DebCol, CreCol, Col: Char;
      stRow, ndRow: Integer);  // Start and end row
    procedure AutoFormat (StartCol, StartRow,
      EndCol, EndRow: Integer; Fmt: String); overload;
    procedure AutoFormat (StartRow,
      EndRow: Integer; Fmt: String); overload;
  public
    { Public-Deklarationen }
    AFmt: String;
    constructor Create; override;
    procedure DoSingle(Query: TIBQuery; Item: TExportItem;
      ooInstance, NewSheet: Variant); reintroduce; virtual;
  end;

  TWriteTextBase = class(TWriteBase)
  private
    { Private-Deklarationen }
    { Common DoRow Detail }
    function ParseBand(leTexte: String):string;
  protected
    { Protected-Deklarationen }
    TextComponent, TextDoc, TextCursor, TextTable : Variant;
    AFmt: String;
    FComments: String;
    { Common Abstract Implementation }
    procedure DoRow; override;
    { WordApp Methods }
    procedure NewDoc;
    { ShortCut }
  public
    { Public-Deklarationen }
    constructor Create; override;
    procedure DoSingle(Query: TIBQuery; Item: TExportItem;
      NewDoc: Variant); reintroduce; virtual;
  end;

Var
  ovn, ovt, ovf, ovns: OleVariant;

implementation
uses SysUtils, Forms, ShellAPI, Windows, Variants;

{ TWriteWordBase }

constructor TWriteBase.Create;
begin
  inherited;

  FRL := TList.Create;
  ReportBand := TStringList.Create;
  ReportBand.Delimiter := ';';

  // Prepare multiple same query with different ID in where clause
  // using a consistent report format
  PrepareList;
end;

destructor TWriteBase.Destroy;
var
  I: Integer;
  Item: TReportItem;
begin
  With FRL do
  begin
    for I:=Count - 1 downto 0 do
    begin
      Item := Items[I];
      Item.Free;
    end;
    Free;
  end;

  ReportBand.Free;

  inherited;
end;

procedure TWriteBase.PrepareList;
begin
  // Do Nothing, since there is no child query
end;

procedure TWriteBase.makeSQL(Query: TIBQuery; Index, ParamID: Integer);
Var Item: TReportItem;
begin
  Item := FRL[Index];
  Query.SQL.Assign(Item.Make(ParamID));
end;

procedure TWriteBase.DoQReport(Query: TIBQuery; Index, ParamID: Integer;
  IsIterate: Boolean; DelimitedText: String);
begin
  MakeSQL(Query, Index, ParamID);
  DoReport(Query, IsIterate, DelimitedText);
end;

procedure TWriteBase.DoReport(ADataSet: TDataSet; IsIterate: Boolean;
  DelimitedText: String);
var Auto: Boolean;
begin
  DataSet := ADataSet;
  ReportBand.DelimitedText := DelimitedText;  // Clear all, assign new one

  If DataSet=nil then Auto:=False
  else Auto := not DataSet.Active;
  If Auto then DataSet.Open;

  If IsIterate then
  begin
    DataSet.First;
    while not DataSet.EOF do    // Foreach Row
    begin
      DoRow;
      DataSet.Next;
    end;
  end
  else DoRow;

  If Auto then DataSet.Close;
end;

procedure TWriteBase.DoSingle(Query: TIBQuery; Item: TExportItem);
begin 
  FQuery := Query;  // assume one directional cursor
  FItem := Item;
  FTitle := Item.Name;
  FGroupField := FItem.GroupField;
  FGroupStr := '';
  IsGrouping := FGroupField<>'';
end;

function TWriteBase.GetGroupString: String;
begin
  Result := FQuery.FieldByName(FGroupField).AsString;
end;

function TWriteBase.IsStartHeader: Boolean;
Var S: String;
begin
  S := GetGroupString;
  Result := (S <> FGroupStr) or FQuery.BOF;
  // if true, also change comparison string
  If Result then FGroupStr := S;
end;

function TWriteBase.IsEndFooter: Boolean;
begin
  With FQuery do
  Result := (GetGroupString <> FGroupStr) or EOF;
end;

procedure TWriteBase.BandHeader;
begin
  If IsGrouping then
    If IsStartHeader then
      DoHeader(FGroupStr);
end;

procedure TWriteBase.BandFooter;
begin
  If IsGrouping then
    If IsEndFooter then
      DoFooter(FGroupStr);
end;

{ TWriteHTMLBase }

constructor TWriteHTMLBase.Create;
begin
  inherited;
  CheckEnvironment;
  // Don't know which query to run yet

  Lines := TStringList.Create;	{ construct the list object }
end;

destructor TWriteHTMLBase.Destroy;
begin
  Lines.Free;
  inherited;
end;

procedure TWriteHTMLBase.DoRow;
var Index: Integer;
begin
  Lines.Append('  <tr>');
  for Index := 0 to ReportBand.Count - 1 do
    ParseBand(ReportBand[Index]);
  Lines.Append('  </tr>');
end;

procedure TWriteHTMLBase.ParseBand(CommaText: String);
Var
  S: TStrings;
  sText, sAttr: String;
  iSpan: Integer;
begin
    S:= TStringList.Create;
    S.CommaText := CommaText;

    // use special character to enable space ini TStrings
    S[1] := StringReplace(S[1], '~', ' ', [rfReplaceAll]);

    sAttr:='';
    sText:='';
    If S[0]='Text' then  sText := S[1];
    If S[0]='Field' then sText := DataSet.FieldByName(S[1]).AsString;

    // Class
    If S.Count>2 then
      If S[2]<>'' then sAttr := sAttr + ' class="'+S[2]+'"';

    // ColSpan
    If S.Count>3 then
    begin
      iSpan := StrToInt(S[3]);
      If iSpan>1 then
        sAttr := sAttr + ' colspan="'+s[3]+'"';
    end;

    //RowSpan
    If S.Count>4 then
    begin
      if S[4]='cr' then Lines.Append('  </tr><tr>')
      else begin
        iSpan := StrToInt(S[4]);
        If iSpan>1 then
          sAttr := sAttr + ' rowspan="'+s[4]+'"';
      end;
    end;

    S.Free;

    Lines.Append('    <td '+sAttr+'>'+sText+'</td>');
end;

function TWriteHTMLBase.AddDocFooter: TStrings;
begin
  Result := TStringList.Create;	{ construct the list object }
  With Result do
  begin
    append('  <!-- End Document --> ');
    append('  </td></tr>');
    append('  <tr><td><div id="pagewidth"></div></td></tr>');
    append('  </table>');
    append('</body></html>');
  end;
end;

function TWriteHTMLBase.AddDocHeader: TStrings;
begin
  Result := TStringList.Create;	{ construct the list object }
  With Result do
  begin
    append('<html>');
    append('<head>');
    append('<title>'+FTitle+'</title>');
    append('<meta name="Author" content="Epsi Sayidina/ PT. Citra Jayaara Andalan">');
    append('<meta http-equiv=Content-Type content="text/html; charset=iso-8859-1">');
    append('<link href="'+CSS+'" type=text/css rel=stylesheet>');
    append('</head>');
    append('');
    append('<body>');
    append('  <table><tr><td>');
    append('  <!-- Begin Document -->');
    append('<h1>'+FTitle+'</h1><br>');

  end;
end;

procedure TWriteHTMLBase.CheckEnvironment;
var CSS1: String;
begin  // Initialization
  SavePath := ExtractFilePath(Application.ExeName)+'Report\';
  CSS := ChangeFileExt (ExtractFileName(Application.Exename), '.css');

  if not DirectoryExists(SavePath) then
    if not CreateDir(SavePath) then
      raise Exception.Create('Cannot create '+SavePath);

  if not FileExists(SavePath+CSS) then
  begin
    CSS1 := ExtractFilePath(Application.ExeName)+CSS;
    if FileExists(CSS1) then
      CopyFile(PChar(CSS1), PChar(SavePath+CSS), LongBool(0));
  end;

end;

procedure TWriteHTMLBase.SaveAndShow;
Var
  Filename: String;
  Handle: HWnd;
  DocFooter : TStrings; // declare HTML's Closing Tag
begin
  DocFooter := AddDocFooter;
  Lines.AddStrings(DocFooter);
  DocFooter.Free;

  Filename := SavePath+FTitle+'.html';
  Lines.SaveToFile(Filename);
  // open the main html file with the default browser
  ShellExecute (Handle, 'open', pChar (Filename), '', '', sw_ShowNormal);
end;

procedure TWriteHTMLBase.DoSingle(Query: TIBQuery; Item: TExportItem);
Var DocHeader : TStrings; // declare HTML Line
begin
  inherited;
  Lines.Clear;

  DocHeader := AddDocHeader;
  Lines.AddStrings(DocHeader);
  DocHeader.Free;
end;

{ TWriteExcelBase }

constructor TWriteExcelBase.Create;
begin
  inherited;
  FComments := FormatDateTime
    ('"Report created : " dddd, mmmm d, yyyy, hh:mm AM/PM', Now);
end;

procedure TWriteExcelBase.DoSingle(Query: TIBQuery; Item: TExportItem;
  NewSheet: _WorksheetDisp);
begin
  inherited DoSingle(Query, Item);
  xls := NewSheet;
end;

procedure TWriteExcelBase.DoRow;
var Index: Integer;
begin
  for Index := 0 to ReportBand.Count - 1 do
    ParseBand(ReportBand[Index]);
  Inc (Row);
end;

procedure TWriteExcelBase.ParseBand(CommaText: String);
Var
  S: TStrings;
  Col1, Col2: String;
  PS: Integer;
  ExR : ExcelRange;
begin
    S:= TStringList.Create;
    S.CommaText := CommaText;

    // use special character to enable space ini TStrings
    S[2] := StringReplace(S[2], '~', ' ', [rfReplaceAll]);

    PS := Pos('\n',S[0]); // Find New line
    If PS<>0 then
    begin
      Inc(Row);
      S[0] := Copy( S[0], 1, PS-1);
    end;

    PS := Pos(':',S[0]);  // Find Multi Column
    If PS=0 then
      ExR := SetExR (S[0],S[0], Row,Row)
    else
    begin
      Col1 := Copy( S[0], 1, PS-1);
      Col2 := Copy( S[0], PS+1, Length(S[0])-PS);
      ExR := SetExR (Col1,Col2, Row,Row);
      ExR.MergeCells := True;
    end;

    If S[1]='Text' then
      ExR.Value2 := S[2]
    else if S[1]='Field' then
    begin
      With DataSet.FieldByName(S[2]) do
      If not IsNull then
        ExR.Value2 := Value;
    end
    else if S[1]='RecNo' then
      ExR.Value2 := DataSet.RecNo;    

    If S.Count>3 then with ExR.Font do
    begin
      If S[3]='H1' then begin Size := 12; Bold := 1; end;
      If S[3]='H2' then Bold := 1;
    end;

    S.Free;
end;

procedure TWriteExcelBase.AutoFormat(StartRow, EndRow: Integer;
  Default: Boolean);
begin
  AutoFormat('A', LastCol, StartRow, EndRow, Default);
end;

procedure TWriteExcelBase.AutoFormat(StartCol, EndCol: Char; StartRow,
  EndRow: Integer; Default: Boolean);
begin
  With SetExR (StartCol, EndCol, StartRow, EndRow)
  do if Default
     then AutoFormat (AFmt, True, True,  True,  True, True, False)
     else AutoFormat (AFmt, True, False, False, True, True, False);
end;

procedure TWriteExcelBase.OpenSheet(EndCol: Char);
begin
  LastCol := EndCol;

  // insert title
  With xls.Range['A1', LastCol+'1'] do begin
    MergeCells := True;
    Value2:=FTitle;
    Font.Size:=16;
    Font.Bold:=1;
  end;
  With xls.Range['A2', LastCol+'2'] do begin
    MergeCells := True;
    Value2:=FComments;
    Font.Size:=11;
  end;
end;

procedure TWriteExcelBase.SetAutoFormat(xlAutoFormat: Integer);
begin
 If (xlAutoFormat in [$0..$E])
 then AFmt:= xlAutoFormat
 else AFmt:= xlSimple;
end;

procedure TWriteExcelBase.SetChartType(Index: Integer);
begin
  Case Index of
  0: ChartType := xl3DPie;
  1: ChartType := xl3DColumn;
  2: ChartType := xl3DLine;
  3: ChartType := xlXYScatter;
  end;
end;

function TWriteExcelBase.SetExR(Col: String; Row: Integer): ExcelRange;
  begin Result := SetExR (Col, Col, Row, Row); end;

function TWriteExcelBase.SetExR(Col1, Col2: String;
  Row1, Row2: Integer): ExcelRange;
begin
  Result := xls.Range [Col1+IntToStr(Row1), Col2+IntToStr(Row2)];
end;

procedure TWriteExcelBase.SetExVal(Col: String; Row: Integer;
  Value: Variant);
  begin SetExR (Col, Col, Row, Row).Value2 := Value; end;

procedure TWriteExcelBase.Tidy;
begin
  xls.Range['A1',LastCol+'1'].EntireColumn.AutoFit;
  xls.Range['A1',LastCol+'1'].Activate;
{ With ExcelApp.ActiveWindow do
  begin
    Zoom := True;
    If ( Zoom <= 100 ) and ( Zoom > 3)
    then Zoom := Zoom-2 else Zoom := 100;                 // Fix ??
  end;}
  xls.Range['A1',LastCol+'1'].EntireColumn.AutoFit;  // Fix after zoom
end;

procedure TWriteExcelBase.WriteCol(StCol: Char; Row: Integer;
  Ss: array of String);
Var c: Byte; cs: String;
begin
  For c := 0 to High(Ss) do  // Low bound to high bound
  begin
    cs := Char(Ord(stCol)+c) + IntToStr(Row);
    xls.Range [cs, cs].Value2 := Ss[c];
  end;
end;

procedure TWriteExcelBase.WriteCumulative(DebCol, CreCol, Col: Char;
  StartRow, EndRow: Integer);
begin
   SetExR (Col, StartRow).Formula :=    // first row
     Format('=%s%d-%s%d', [DebCol, StartRow, CreCol, StartRow]);

   If (StartRow < EndRow) then          // second
     SetExR (Col, StartRow+1).Formula := Format('=%s%d+%s%d-%s%d',
       [Col, StartRow, DebCol, StartRow+1, CreCol, StartRow+1]);

   If (StartRow+1 < EndRow) then        // and the rest
     SetExR (Col, Col, StartRow+1, EndRow).FillDown;
end;

{ TExportWordBase }

procedure TWriteWordBase.DoSingle(Query: TIBQuery; Item: TExportItem;
  Doc: WordDocument);
begin
  inherited DoSingle(Query, Item);
  WordDoc := Doc;
end;

procedure TWriteWordBase.DoRow;
var
  Style: String;
  ov: OleVariant;
begin
  If (ReportBand.Count>1) then
  begin
    Style:=ReportBand[1];
    If Style='Normal' then ov:=wdStyleNormal;
    If Style='H1' then ov:=wdStyleHeading1;
    If Style='H2' then ov:=wdStyleHeading2;
    If Style='H3' then ov:=wdStyleHeading3;
  end;

  With WordDoc.Paragraphs.Last.Range do
  begin
    Text := ParseBand(ReportBand[0]);
    If (ReportBand.Count>1) then Set_Style(ov);
  end;
end;

function TWriteWordBase.ParseBand(Text: String): String;
var
  TagStart, TagEnd: Integer;
  FreeText, TextInTag: String;
begin
  Result := '';
  Text := StringReplace(Text, '\t', #9,  [rfReplaceAll]);
  Text := StringReplace(Text, '\n', #13, [rfReplaceAll]);

  Repeat
    TagStart := Pos('<#', Text);
    If (TagStart = 0) then
    begin
      Result := Result + Text;
      Text := '';
    end
    else
    begin
      FreeText := Copy( Text, 1, TagStart-1);
      Delete(Text, 1, TagStart-1);
      Result := Result + FreeText;

      TagEnd := Pos('>', Text);
      If (TagEnd <> 0) then
      begin
        TextInTag := Copy( Text, 3, TagEnd-3);
        Delete(Text, 1, TagEnd);

        With DataSet.FieldByName(TextInTag) do
        If not IsNull then
          Result := Result + AsString;
      end;
    end;
  until Length(Text)=0;
end;

procedure TWriteWordBase.ConvertToTable(ovStart, OvEnd: OleVariant;
  var TableCount: Integer; SubCount: Integer; ColCount: Integer);
Var ov: OleVariant;
begin
  If not (OvStart = OvEnd) then
  begin
    OleVariant(WordDoc.Range(ovStart, ovEnd)).
      ConvertToTable (#9, SubCount+1, ColCount);
    Inc(TableCount);

    If AFmt>0 then
    With WordDoc.Tables.Item(TableCount) do
    begin
      ov:=1; AutoFitBehavior(ov);          //
      AutoFormat(AFmt, ovn, ovn, ovn, ovn, ovt, ovf, ovf, ovf, ovn);
      UpdateAutoFormat;
    end;

    WordDoc.Paragraphs.Last.Range.InsertParagraphAfter;
  end;
end;

function TWriteWordBase.DocEnd_: OleVariant;
begin
// for TWordDocuments, Result := WordDoc.Range.End_-1;
  Result := WordDoc.Paragraphs.Last.Range.End_ - 1;
end;

procedure TWriteWordBase.NewDoc;
Var ov: OleVariant;
begin
  // insert title
  With WordDoc.Paragraphs.Last.Range do begin
    Text := FTitle;
    InsertParagraphAfter;
    ov:=wdStyleHeading1;
    Set_Style(ov);
  end;

  With WordDoc.Paragraphs.Last.Range do begin
    Text := #13;  // insert space
    ov:=wdStyleNormal;
    Set_Style(ov);
  end;
end;

procedure TWriteWordBase.SetAutoFormat(wdTableAutoFormat: Integer);
begin
  AFmt:= wdTableAutoFormat;
end;

{ TExportSQL }

constructor TWriteSQL.Create;
begin
  inherited;
  Lines := TStringList.Create;	{ construct the list object }
end;

destructor TWriteSQL.Destroy;
begin
  Lines.Free;
  inherited;
end;

procedure TWriteSQL.DoRow;
begin
  inherited;

end;

procedure TWriteSQL.GetStruct;
var
  StructFile: String;
  I, J, K: Integer;
  BT, BN:Boolean;
  U: String;
  S: TStrings;
begin  // Initialization
  StructFile := ExtractFilePath(Application.ExeName)+'\tables.my.sql';
  S := TStringList.Create;

  if FileExists(StructFile) then
  begin
    S.LoadFromFile(StructFile);

    I:=-1;
    Repeat
      Inc(I);
      U  := Uppercase(S[I]);
      BN := (Pos('`'+Uppercase(FItem.Name)+'`', U) <> 0);
      BT := (Pos('TABLE', U) <> 0);
    until ((I>S.Count-1) or (BN and BT));

    J:=I;
    Repeat
      Inc(J);
    until (J>S.Count-1) or (S[J][1]=')');

    For K:=I to J do
    begin
      If (Pos('CREATE TABLE', Uppercase(S[K])) <> 0)
      or (Pos('DROP TABLE', Uppercase(S[K])) <> 0) then
        S[K] := StringReplace
                       (S[K], ' `', ' `'+FITem.IDName, [rfIgnoreCase]);
      Lines.Append(S[K]);
    end;
  end;

  S.Free;
end;

procedure TWriteSQL.DoSingle(Query: TIBQuery; Item: TExportItem);
begin
  inherited;
  SetInsertText;

  Lines.Clear;
  GetStruct;
  Lines.Append('');

  While not FQuery.EOF do
  begin
    Lines.Append(SInsert + ValuesText);
    FQuery.Next;
  end;

  Lines.Append('');
end;

procedure TWriteSQL.SetInsertText;
Var
  I: Integer;
  S: String;
begin
  S := 'INSERT INTO '+FItem.IDName+FItem.Name+' (';
  For I := 0 to FItem.Headers.Count -1 do
  begin
    If I > 0 Then S := S + ', ';
    S := S + FItem.Headers.Names[I];
  end;

  S := S + ') ';

  SInsert:=S;
end;

function TWriteSQL.ValuesText:String;
Var
  I: Integer;
  S, V: String;
  FName, FType: String; // Field
begin
  S := 'VALUES (';
  For I := 0 to FItem.Headers.Count -1 do
  begin
    If I > 0 Then S := S + ', ';
    FName := FItem.Headers.Names[I];
    FType := UpperCase(FItem.Headers.ValueFromIndex[I]);

    With FQuery.FieldByName(FName) do
    If IsNull then V:= 'NULL'
    else
    begin
      if FType='DATE'
      then V := FormatDateTime('YYYY-MM-DD', AsDateTime)
      else if FType='DATETIME'
      then V := FormatDateTime('YYYY-MM-DD hh:nn:ss', AsDateTime)
      else V := StringReplace(AsString, '''', '''''', [rfReplaceAll]);

      If (FType='TEXT') or (FType='DATE') or (FType='DATETIME')
        then V:= ''''+V+'''';
    end;

    S := S + V;
  end;

  S := S + ');';

  Result := S;
end;

{ TWriteCalcBase }

constructor TWriteCalcBase.Create;
begin
  inherited;
  FComments := FormatDateTime
    ('"Report created : " dddd, mmmm d, yyyy, hh:mm AM/PM', Now);
  AFmt := 'Cinta Biru';
end;

procedure TWriteCalcBase.DoRow;
var Index: Integer;
begin
  for Index := 0 to ReportBand.Count - 1 do
    ParseBand(ReportBand[Index]);
  Inc (Row);
end;

procedure TWriteCalcBase.DoSingle(Query: TIBQuery; Item: TExportItem;
  ooInstance, NewSheet: Variant);
begin
  inherited DoSingle(Query, Item);
  OpenOffice := ooInstance;
  Sheet := NewSheet;

//aCoreReflection := ServiceManager.createInstance
//  ('com.sun.star.reflection.CoreReflection');
//aDispatcher := ooInstance.createInstance
//  ('com.sun.star.frame.DispatchHelper');
  aBorder := ooInstance.Bridge_GetStruct
    ('com.sun.star.table.BorderLine');
end;

procedure TWriteCalcBase.OpenSheet(EndCol: Integer);
begin
  LastCol := EndCol;

  Sheet.getCellRangeByPosition(0,0,EndCol-1,0).merge(True);
  aCell := Sheet.getCellByPosition(0, 0);
  aCell.setString(FTitle);
  aCell.CharHeight := 16;
  aCell.CharWeight := 150;  // 150%
  aCell.CharColor := $003399;

  Sheet.getCellRangeByPosition(0,1,EndCol-1,1).merge(True);
  aCell := Sheet.getCellByPosition(0, 1);
  aCell.setFormula(FComments);
  aCell.CharHeight := 11;
  aCell.CellBackColor := $ffff80;
end;

procedure TWriteCalcBase.ParseBand(CommaText: String);
Var
  S: TStrings;
  S0: String;
  Col1, Col2: Byte;
  PS: Integer;
  ExR: Variant; // ExR : XCell;
begin
    S:= TStringList.Create;
    S.CommaText := CommaText;

    // use special character to enable space ini TStrings
    S[2] := StringReplace(S[2], '~', ' ', [rfReplaceAll]);

    PS := Pos('\n',S[0]); // Find New line
    If PS<>0 then
    begin
      Inc(Row);
      S[0] := Copy( S[0], 1, PS-1);
    end;

    PS := Pos(':',S[0]);  // Find Multi Column
    If PS=0 then
    begin
      Col1 := Ord(S[0][1])-65;
      ExR := Sheet.getCellByPosition(Col1, Row);
    end
    else
    begin
      S0 := Copy( S[0], 1, PS-1);
      Col1 := Ord(S0[1])-65;
      S0 := Copy( S[0], PS+1, Length(S[0])-PS);
      Col2 := Ord(S0[1])-65;
      Sheet.getCellRangeByPosition(Col1,Row,Col2,Row).Merge(True);
      ExR := Sheet.getCellByPosition(Col1, Row);
    end;

    If S[1]='Text' then       ExR.setString(S[2])
    else if S[1]='RecNo' then ExR.setValue(DataSet.RecNo)
    else with DataSet.FieldByName(S[2]) do    // should be a kinda field
      if not IsNull then
      begin
        if S[1]='Field' then
           ExR.setString(AsString);
        if S[1]='Num' then
           ExR.setValue(AsCurrency);
        if S[1]='Date' then
           ExR.setFormula( FormatDateTime('YYYY-MM-DD', AsDateTime) );
        if S[1]='DateTime' then
           ExR.setFormula( FormatDateTime('YYYY-MM-DD hh:nn:ss', AsDateTime) );
      end;

    If S.Count>3 then
    begin
      If S[3]='H1' then begin ExR.CharHeight := 13; ExR.CharWeight := 150; end;
      If S[3]='H2' then begin ExR.CharHeight := 11; ExR.CharWeight := 150; end;
      If S[3]='H3' then ExR.CharWeight := 150;
    end;

    S.Free;
end;
function TWriteCalcBase.SetExR(Col, Row: Integer): Variant;
  begin Result := Sheet.getCellByPosition(Col, Row); end;

function TWriteCalcBase.SetExR(Col: Char; Row: Integer): Variant;
  begin Result := SetExR(Ord(Col)-65, Row); end;

procedure TWriteCalcBase.WriteCol(StCol, Row: Integer; Ss: array of String);
  Var I: Integer; // Low bound to high bound
  begin For I := 0 to High(Ss) do SetExR(StCol+I, Row).SetString(Ss[I]); end;

procedure TWriteCalcBase.FormatCol(StCol, Row: Integer;
  Ss: array of String);
Var
  I: Integer;
  aFmt: String;
  aColumn, Columns : Variant;
begin
  Columns := Sheet.getColumns;
  For I := 0 to High(Ss) do // Low bound to high bound
  begin
    aFmt := Ss[I];
    aColumn := Columns.getByIndex(I);
    If (aFmt='Num') or (aFmt='Rp') then aColumn.NumberFormat := 4;
    If (aFmt='Date') then aColumn.NumberFormat := 80;
    If (aFmt='DateTime') then aColumn.NumberFormat := 51;
    If (aFmt='Month') then aColumn.NumberFormat := 32;    
  end;
end;

procedure TWriteCalcBase.WriteCumulative(DebCol, CreCol, Col: Char;
  stRow, ndRow: Integer);
var
  ICol: Integer;
  CellSeries: Variant;
begin  // All rows are Zero Based!
   SetExR (Col, stRow).SetFormula(    // first row
     Format('=%s%d-%s%d', [DebCol, stRow+1, CreCol, stRow+1]) );

   If (stRow < ndRow) then          // second
     SetExR (Col, stRow+1).SetFormula( Format('=%s%d+%s%d-%s%d',
       [Col, stRow+1, DebCol, stRow+1+1, CreCol, stRow+1+1]) );

   If (stRow+1 < ndRow) then        // and the rest
   begin
     ICol := Ord(Col)-65;
     CellSeries := Sheet.getCellRangeByPosition(ICol, stRow+1, ICol, ndRow);
     CellSeries.fillAuto(0, 1);
  end;
end;

procedure TWriteCalcBase.Tidy(EndCol: Integer);
Var I: Integer;
begin
  For I := 0 to EndCol-1 do
    Sheet.getColumns.getByIndex(I).OptimalWidth := True;

{ With ExcelApp.ActiveWindow do
  begin
    Zoom := True;
    If ( Zoom <= 100 ) and ( Zoom > 3)
    then Zoom := Zoom-2 else Zoom := 100;                 // Fix ??
  end;}
end;

procedure TWriteCalcBase.AutoFormat(StartCol, StartRow,
  EndCol, EndRow: Integer; Fmt: String);
begin
  If (Fmt<>'') then Sheet.getCellRangeByPosition
     (StartCol,StartRow,EndCol,EndRow).autoFormat (Fmt)
  else
  begin // Manual Table Formatting
    aBorder.LineDistance := 0;
    aBorder.InnerLineWidth := 0;

    aCellRange := Sheet.getCellRangeByPosition (0,StartRow,LastCol-1,StartRow);
    aBorder.OuterLineWidth := 35;
    aCellRange.TopBorder := aBorder;
    aBorder.OuterLineWidth := 70;
    aCellRange.BottomBorder := aBorder;

    aBorder.OuterLineWidth := 35;
    aCellRange := Sheet.getCellRangeByPosition (0,EndRow,LastCol-1,EndRow);
    aCellRange.TopBorder := aBorder;
  end;

  Inc (Row);
end;

procedure TWriteCalcBase.GroupRow(stRow, ndRow: Integer);
var aRange: Variant;
begin  // _tableTableOrientationROWS = _*COLS+1
  aRange := Sheet.getCellRangeByPosition(0, stRow, LastCol-1, ndRow);
  Sheet.group(aRange.getRangeAddress, 1);
end;

procedure TWriteCalcBase.AutoFormat(StartRow, EndRow: Integer; Fmt: String);
  begin AutoFormat(0, StartRow, LastCol-1, EndRow, Fmt) end;

{ TWriteTextBase }

constructor TWriteTextBase.Create;
begin
  inherited;
  FComments := FormatDateTime
    ('"Report created : " dddd, mmmm d, yyyy, hh:mm AM/PM', Now);
end;

procedure TWriteTextBase.DoRow;
var
  Style, ooStyle: String;
begin
  If (ReportBand.Count>1) then
  begin
    Style:=ReportBand[1];
    If Style='Normal' then ooStyle:='Standard';
    If Style='H1' then ooStyle:='Heading 1';
    If Style='H2' then ooStyle:='Heading 2';
    If Style='H3' then ooStyle:='Heading 3';
  end;

  If (ReportBand.Count>1) then
     TextCursor.ParaStyleName := ooStyle;

  // letexte
  TextDoc.insertString( TextCursor, ParseBand(ReportBand[0]), false )

end;

procedure TWriteTextBase.DoSingle(Query: TIBQuery; Item: TExportItem;
  NewDoc: Variant);
begin
  inherited DoSingle(Query, Item);
  TextComponent := NewDoc;
  TextDoc := TextComponent.getText;
  TextCursor := TextDoc.createTextCursor;
end;

procedure TWriteTextBase.NewDoc;
begin
  // insert title
  TextCursor.ParaStyleName := 'Heading 1';
  TextDoc.insertString( TextCursor, FTitle, false );
  TextDoc.insertControlCharacter( TextCursor, 0, false );
  TextCursor.ParaStyleName := 'Standard';
  TextCursor.CharColor := $0000ff;
  TextCursor.CharShadowed := True;
  TextDoc.insertString( TextCursor, FComments+#13, false );
  TextDoc.insertControlCharacter( TextCursor, 1, false );
  TextCursor.ParaStyleName := 'Standard';
end;

function TWriteTextBase.ParseBand(leTexte: String): string;
var
  TagStart, TagEnd: Integer;
  FreeText, TextInTag: String;
begin
  Result := '';
  leTexte := StringReplace(leTexte, '\t', #9,  [rfReplaceAll]);
  leTexte := StringReplace(leTexte, '\n', #13, [rfReplaceAll]);

  Repeat
    TagStart := Pos('<#', leTexte);
    If (TagStart = 0) then
    begin
      Result := Result + leTexte;
      leTexte := '';
    end
    else
    begin
      FreeText := Copy( leTexte, 1, TagStart-1);
      Delete(leTexte, 1, TagStart-1);
      Result := Result + FreeText;

      TagEnd := Pos('>', leTexte);
      If (TagEnd <> 0) then
      begin
        TextInTag := Copy( leTexte, 3, TagEnd-3);
        Delete(leTexte, 1, TagEnd);

        With DataSet.FieldByName(TextInTag) do
        If not IsNull then
          Result := Result + AsString;
      end;
    end;
  until Length(leTexte)=0;
end;

initialization
  ovn := null; ovt := true; ovf := false; ovns:='';      // Global Variables
end.
