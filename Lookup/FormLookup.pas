unit FormLookup;

// to copy

// To do
// filter angkatan mask
//     AllowedGroupingView := AllowedGroupingView + ', Angkatan, Department, Program';
// make it single object SQL Statement
// branch on iluniDB org

// all report di Trans ke object baru

// formula u/ balance
// uppercase DEBITS
// Anggota koperasi, bph
// make it single object
// commit kalo buka detail ajah

// Efisiensi GLTree

interface

uses
  SysUtils, Forms, Classes, Controls, StdCtrls, ExtCtrls, Buttons, Grids,
  DBGrids, DBCtrls, DB, IBCustomDataSet, IBQuery, Windows, ComCtrls,
  dmMain, FormFilter, FormOrdering, FormSortColumn, ToolWin, ActnMan,
  ActnCtrls, XPStyleActnCtrls, ActnList, ImgList,
  SQLStatement, X_List;

type
  TfrmLookup = class(TForm)
    PanelBtm: TPanel;
    BtnSelect: TBitBtn;
    BtnCancel: TBitBtn;
    DBNav: TDBNavigator;
    DBGrid: TDBGrid;
    qrLookup: TIBQuery;
    dsLookup: TDataSource;
    StatusBar: TStatusBar;
    CoolBar: TCoolBar;
    PanelSelect: TPanel;
    ChooseQueryBox: TComboBox;
    sbApply: TSpeedButton;
    PanelExport: TPanel;
    Label3: TLabel;
    cbExport: TComboBox;
    sbExport: TSpeedButton;
    PanelContent: TPanel;
    sbOrdering: TSpeedButton;
    sbHeader: TSpeedButton;
    Label1: TLabel;
    SortbyBox: TComboBox;
    cbDesc: TCheckBox;
    PanelFilter: TPanel;
    sbFilter: TSpeedButton;
    PanelFind: TPanel;
    LocateBtn: TSpeedButton;
    FindEdit: TEdit;
    FindFilter: TCheckBox;
    SearchByBox: TComboBox;
    Label2: TLabel;
    Label4: TLabel;
    cbExportKind: TComboBox;
    GroupViewBox: TComboBox;
    Label5: TLabel;
    GroupRowBox: TComboBox;
    Label6: TLabel;
    { Event Handlers }
    procedure FormResize(Sender: TObject);
    procedure qrLookupBeforeOpen(DataSet: TDataSet);
    procedure BtnApplyClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtnFilterClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnSelectClick(Sender: TObject);
    procedure BtnExportClick(Sender: TObject);
    procedure ChooseQueryBoxChange(Sender: TObject);
    procedure DBGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure BtnOrderingClick(Sender: TObject);
    procedure BtnHeaderClick(Sender: TObject);
    procedure LocateBtnClick(Sender: TObject);
    procedure FindFilterClick(Sender: TObject);
    procedure qrLookupFilterRecord(DataSet: TDataSet; var Accept: Boolean);
  private
    { Private declarations }
    FID: Integer;
    FUniformID : Boolean;
    ColumnWidthRatio: Array of Integer;
    GroupFilter: String;
    IsFilteringByGroup: Boolean;
    procedure SetGridColumnNames;
    { Property Handlers }
    procedure SetChooseQuerySet(const Value: String);
    function GetQueryIndex: Integer;
    procedure SetUniformID(const Value: Boolean);
  protected
    { Protected declarations }
    FilterDialog: TfrmFilter;
    OrderingDialog: TfrmOrdering;
    SortColumnDialog: TfrmSortColumn;
    procedure InitQueryNames; virtual; abstract;
    procedure InitSelectedQuery; virtual; abstract;
    procedure InitProperties; virtual; abstract;
    procedure SetConstraint; virtual;
    procedure DoReport(List: TExportList); virtual;    
    procedure MakeList(List: TExportList); virtual;
    procedure GetThisItem(List: TExportList);
    procedure GetGroupViewItem(List: TExportList);    
    { Protected Property }
    property ChooseQuerySet: String write SetChooseQuerySet;
  public
    { Public declarations }
    DefaultQueryIndex: Integer;
    SQLStat: TSQLStat;
    function GetFieldID(Var ID: Integer): Boolean;
    procedure RefreshGrid(Sender: TObject);
    property QueryIndex: Integer read GetQueryIndex;
    property UniformID: Boolean write SetUniformID;
  end;

var
  frmLookup: TfrmLookup;

implementation

uses
  Dialogs,
  X_Base, X_AppBase, W_Plain;

{$R *.dfm}

{ Constructor/ Destructor }

procedure TfrmLookup.FormCreate(Sender: TObject);
begin
  FilterDialog := nil;
  OrderingDialog := nil;
  SortColumnDialog := nil;

  FUniformID := False;
  FID:=0;   // Cursor

  SQLStat := nil;
end;

procedure TfrmLookup.FormDestroy(Sender: TObject);
begin
  SQLStat.Free;   // Clean up
end;

procedure TfrmLookup.DBGridDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  // Do not erase
  // to make descendant methods respond  this event
end;

procedure TfrmLookup.ChooseQueryBoxChange(Sender: TObject);
begin
  If FUniformID then
    If (not qrLookup.IsEmpty) and (qrLookup.Active) then
      FID := qrLookup[SQLStat.IDName];  // saved it

  qrLookup.Close;

  SQLStat.Reset;
  InitSelectedQuery;  // Call Descendant method

  // Update Dialog
  FilterDialog.Columns    := SQLStat.SortBy;
  OrderingDialog.SortBy   := SQLStat.SortBy;
  SortColumnDialog.Titles := SQlStat.TitleNames;

  // SetSortByBox;
  SortByBox.Items.Clear;
  SortByBox.Items.AddStrings(SQLStat.SortBy);
  SortByBox.Text     := '';
  SortByBox.ItemIndex:= SQLStat.DefaultSortIndex;
  SortbyBox.Enabled  := True;
  cbDesc.Enabled     := SortbyBox.Enabled;
  cbDesc.Checked     := False;

  // SetGroupViewBox
  GroupViewBox.Items.Clear;
  GroupViewBox.Items.AddStrings(SQLStat.GroupingView);
  GroupViewBox.Text  := '';

  // SetGroupRowBox
  GroupRowBox.Items.Clear;
  GroupRowBox.Items.AddStrings(SQLStat.GroupingView);
  GroupRowBox.Text  := '';

  // SetSearchByBox;
  SearchByBox.Items.Clear;
  SearchByBox.Text   := '';
  SearchByBox.Items.AddStrings(SQlStat.TitleNames);

  // update GUI
  SetGridColumnNames;  // based on ColumnDialog
end;

procedure TfrmLookup.SetGridColumnNames;
Var
  I, J: Integer;
  S, SH: TStrings;
begin
  S  := SortColumnDialog.Titles;
  SH := SQlStat.GetFieldPairs;

  DBGrid.Columns.Clear;
  For I := 0 to S.Count-1 do
  begin
    DBGrid.Columns.Add;
    DBGrid.Columns[I].FieldName := S[I];
    DBGrid.Columns[I].Title.Caption := S[I];
  end;

  // additional, setting column width
  SetLength(ColumnWidthRatio, S.Count);
  For I := 0 to S.Count-1 do
  begin
    J := SH.IndexOfName(S[I]);
    ColumnWidthRatio[I] := StrToInt(SH.ValueFromIndex[J]);
  end;

  FormResize(nil);
end;

procedure TfrmLookup.FindFilterClick(Sender: TObject);
begin
  If (FindEdit.Text = '') then FindFilter.Checked := False;
  qrLookup.Filtered := FindFilter.Checked;
end;

procedure TfrmLookup.qrLookupFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
Var Field, S1, S2: String;
begin
  Field := SearchByBox.Items[SearchByBox.ItemIndex];
  S1 := lowercase(FindEdit.Text);
  S2 := lowercase(qrLookup.FieldByName(Field).AsString);
  Accept := ( Pos (S1, S2) <> 0);
end;

procedure TfrmLookup.LocateBtnClick(Sender: TObject);
Var Field: String;
begin
//Field := SQLStat.GetOrdersVal( SearchByBox.Items[SearchByBox.ItemIndex] );
  Field := SearchByBox.Items[SearchByBox.ItemIndex];

  if not qrLookup.
    Locate(Field, FindEdit.Text, [loCaseInsensitive, loPartialKey])
    then MessageDlg('Unable to locate match', mtInformation, [mbOk], 0);
end;

{ Properties Handlers }

procedure TfrmLookup.SetChooseQuerySet(const Value: String);
begin
  ChooseQueryBox.Items.CommaText := Value;
end;

function TfrmLookup.GetQueryIndex: Integer;
begin
  Result := ChooseQueryBox.ItemIndex;

  If (Result> ChooseQueryBox.Items.Count - 1) or (Result<0)
  then Result := 0;  // Default one
end;

{ Form Methods }

procedure TfrmLookup.SetConstraint;
Var
  I :Integer;
  Temp, Desc :String;
  SortTemp :TStrings;
begin
  // Where clause
  SQLStat.Filters.Clear;
  SQLStat.Filters.AddStrings(FilterDialog.Clause);

  // Where clause on group view
  If IsFilteringByGroup then
    SQLStat.Filters.Append(GroupFilter);

  // Order by clause
  SQLStat.Ordering.Clear;

  If not OrderingDialog.IsEmpty then
    SQLStat.Ordering.AddStrings(OrderingDialog.SortBy)
  else if (SortByBox.ItemIndex<>-1) then
  begin
    If cbDesc.Checked then Desc := 'Desc' else Desc := 'Asc';
    SortTemp := TStringList.Create;
    SortTemp.CommaText := SortByBox.Items[SortByBox.ItemIndex];
    for I:=0 to SortTemp.Count-1 do
      SortTemp[I] := SortTemp[I] +'='+Desc;
    SQLStat.Ordering.AddStrings(SortTemp);
    SortTemp.Free;
  end;

  // Order by clause on group row
  If GroupRowBox.ItemIndex<>-1 then
  begin
    Temp := GroupRowBox.Items[GroupRowBox.ItemIndex];
    If (SQLStat.Ordering.IndexOfName(Temp) = -1) then
      SQLStat.Ordering.Insert(0, Temp+'=Asc');  // add it
  end;

end;

{ Form Behaviours }

procedure TfrmLookup.FormResize(Sender: TObject);
Var Sum, I, BaseWidth : Integer;
begin  // Low Bound to High Bound
  Sum := 0; { Note that open array index range is always zero-based. }
  for I := 0 to High(ColumnWidthRatio) do Sum := Sum + ColumnWidthRatio[I];

  BaseWidth := (DBGrid.Width-35) div Sum;
  for I := 0 to High(ColumnWidthRatio) do
    DBGrid.Columns[I].Width := BaseWidth * ColumnWidthRatio[I];
end;

procedure TfrmLookup.FormShow(Sender: TObject);
begin
  IF SQLStat=nil then SQLStat := TSQLStat.Create;
  InitQueryNames;  // Call Descendant method
  
  // Load Dialogs to Memory only on Showing Lookup Form
  // Reserved memory and speed-up splash form.
  FilterDialog := TfrmFilter.Create(Application);
  OrderingDialog := TfrmOrdering.Create(Application);
  SortColumnDialog := TfrmSortColumn.Create(Application);
  FilterDialog.SQLStat := SQLStat;

  // Set query, and query filter after dialog created
  ChooseQueryBox.ItemIndex := DefaultQueryIndex;
  ChooseQueryBoxChange(Sender);

  qrLookup.Open;
  qrLookup.Locate(SQLStat.IDName, FID, []);

  // Fix width by getting new width from descendant form
  FormResize(Sender);
end;

procedure TfrmLookup.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  qrLookup.Close;

  // Clean up Dialogs
  If FilterDialog     <> nil  then FilterDialog.Release;
  If OrderingDialog   <> nil  then OrderingDialog.Release;
  If SortColumnDialog <> nil  then SortColumnDialog.Release;

  FilterDialog := nil;
  OrderingDialog:=nil;
  SortColumnDialog:=nil;
end;

procedure TfrmLookup.BtnSelectClick(Sender: TObject);
begin
  // Save FieldID before closing table on closing lookup form
  FID := qrLookup[SQLStat.IDName]
end;

procedure TfrmLookup.BtnFilterClick(Sender: TObject);
begin
  FilterDialog.ShowModal;
end;

procedure TfrmLookup.BtnOrderingClick(Sender: TObject);
begin
  with OrderingDialog do
  begin
    ShowModal;
    SortbyBox.Enabled := IsEmpty;
    cbDesc.Enabled    := SortbyBox.Enabled;
  end;
end;

procedure TfrmLookup.BtnHeaderClick(Sender: TObject);
begin
  SortColumnDialog.ShowModal;
  SetGridColumnNames;
end;

procedure TfrmLookup.BtnApplyClick(Sender: TObject);
Var ID:Integer;
begin
  If qrLookup.IsEmpty then ID:=FID
  else ID := qrLookup[SQLStat.IDName];
  qrLookup.Close;
  FindFilter.Checked := False;

  StatusBar.SimpleText := 'Running Query for Browsing...';
  Cursor := crSQLWait;
  Try
    qrLookup.Open;
  Finally
    StatusBar.SimpleText := '';
    Cursor := crDefault;
  end;

  SetGridColumnNames;

  If ID<>0 then
    qrLookup.Locate(SQLStat.IDName, ID, []);
end;

{ Execute Form Related Method }

function TfrmLookup.GetFieldID(Var ID: Integer): Boolean;
begin
  FID := ID;
  Result := (ShowModal = mrOK);
  If Result then ID := FID;
end;

{ SQL Related Method }

procedure TfrmLookup.qrLookupBeforeOpen(DataSet: TDataSet);
var TempSQL: TStrings;
begin
  // Calling descendant method if necessary
  SetConstraint;

  TempSQL := SQLStat.MakeSQL;
  qrLookup.SQL.Assign(TempSQL);
  TempSQL.Free;
end;

procedure TfrmLookup.RefreshGrid(Sender: TObject);
begin
  If qrLookup.Active=False then
  begin
    qrLookup.EnableControls;
    qrLookup.Open;
  end;
end;

procedure TfrmLookup.SetUniformID(const Value: Boolean);
begin
  FUniformID := Value;
end;

procedure TfrmLookup.GetThisItem(List: TExportList);
Var
  TempSQL: TStrings;
  QueryName, Headers, FmtID, IDName, GroupRowField : String;
begin
  Headers := SortColumnDialog.Titles.CommaText;
  FmtID := SQLStat.GetFormatsByHeaders (Headers);
  QueryName := ChooseQueryBox.Items[ChooseQueryBox.ItemIndex];
  IDName := SQLStat.IDName;
  GroupRowField := GroupRowBox.Items[GroupRowBox.ItemIndex];

  // Calling descendant method if necessary
  SetConstraint;
  TempSQL := SQLStat.MakeSQL;
  List.AddQuery(TempSQL, Headers, FmtID, QueryName, IDName, GroupRowField);
  TempSQL.Free;
end;

procedure TfrmLookup.GetGroupViewItem(List: TExportList);
Var
  TempSQL: TStrings;
  QueryName, GroupName, Headers, FmtID, IDName, GroupRowField: String;
  GroupViewField, GroupViewValues: String;
  SaveSQL : TStrings;
  qrGroup: TIBQuery;
begin
  Headers := SortColumnDialog.Titles.CommaText;
  FmtID := SQLStat.GetFormatsByHeaders (Headers);
  QueryName := ChooseQueryBox.Items[ChooseQueryBox.ItemIndex];
  IDName := SQLStat.IDName;
  GroupRowField := GroupRowBox.Items[GroupRowBox.ItemIndex];

  GroupViewField := GroupViewBox.Items[GroupViewBox.ItemIndex];

  SetConstraint;
  TempSQL := SQLStat.MakeSQL;
  SaveSQL := TStringList.Create;
  SaveSQL.Append('SELECT DISTINCT '+GroupViewField);
  SaveSQL.Append('FROM (');
  SaveSQL.AddStrings(TempSQL);
  SaveSQL.Append(')');
  TempSQL.Free;
  qrGroup := TIBQuery.Create(self);
  qrGroup.Transaction := qrLookup.Transaction;
  qrGroup.Database := qrLookup.Database;
  qrGroup.SQL.AddStrings(SaveSQL);
  SaveSQL.Free;

  With qrGroup do
  Try
    IsFilteringByGroup := True;
    Open; First;
    while not EOF do
    begin
      GroupViewValues := FieldByName(GroupViewField).AsString;
      If GroupViewValues <> '' then
        GroupFilter := Format('%s = ''%s''', [GroupViewField, GroupViewValues])
      else GroupFilter := GroupViewField+' IS NULL';


      case cbExport.ItemIndex of
      0, 2: GroupName := QueryName + ' - ' + GroupViewValues;
      else
        begin // excel sheet
          GroupName := GroupViewValues;
          If Length(GroupName)>31 then GroupName := Copy(GroupName, 1, 31);
        end;
      end;

      // Fix for file name and sheet name
      If GroupName='' then GroupName := 'undefined';
      GroupName := StringReplace(GroupName, '/', '-', [rfReplaceAll]);

      // Calling descendant method if necessary
      SetConstraint;
      TempSQL := SQLStat.MakeSQL;
      List.AddQuery(TempSQL, Headers, FmtID, GroupName, IDName, GroupRowField);
      TempSQL.Free;
      
      Next;
    end;
  Finally
    IsFilteringByGroup := False;
    Close;
  end;
end;

procedure TfrmLookup.BtnExportClick(Sender: TObject);
Var
  List: TExportList;
begin
  IsFilteringByGroup:=False;
  List := TExportList.Create;

  MakeList(List);
  DoReport(List);

  // No need to free list as it freed by thread
end;

procedure TfrmLookup.MakeList(List: TExportList);
Var I: Integer;
begin
  case cbExportKind.ItemIndex of
    0: If GroupViewBox.ItemIndex = -1
       then GetThisItem(List)
       else GetGroupViewItem(List);
    1: begin
      GroupRowBox.ItemIndex:=-1;
      For I:= 0 to ChooseQueryBox.Items.Count-1 do
      begin // Iterate for each QueryBox (loop)
        ChooseQueryBox.ItemIndex := I;
        ChooseQueryBoxChange(nil);
        GetThisItem(List);
      end;
    end;
  end; // case
end;

procedure TfrmLookup.DoReport(List: TExportList);
Var
  CommonExport: TExportBase;
  HTML  : TWriteHTMLPlain;
  Excel : TWriteExcelPlain;
  Word  : TWriteWordPlain;
  Calc  : TWriteCalcPlain;
  Text  : TWriteTextPlain;      
  dbName: String;
begin
  dbName := qrLookup.Database.DatabaseName;
  If cbExportKind.ItemIndex in [0, 1]then
  begin
    Case cbExport.ItemIndex of // launch second process
    0: begin
         HTML := TWriteHTMLPlain.Create;
         CommonExport := TExportHTMLBase.Create (dbName, List, HTML);
       end;
    1: begin
         Excel := TWriteExcelPlain.Create;
         CommonExport := TExportExcelBase.Create (dbName, List, Excel);
       end;
    2: begin
         Word := TWriteWordPlain.Create;
         CommonExport := TExportWordBase.Create (dbName, List, Word);
       end;
    3: begin
         Calc := TWriteCalcPlain.Create;
         CommonExport := TExportCalcBase.Create (dbName, List, Calc);
       end;
    4: begin
         Text := TWriteTextPlain.Create;
         CommonExport := TExportTextBase.Create (dbName, List, Text);
       end;
    else CommonExport := nil;
    end;

    If cbExport.ItemIndex in [0..4] then
      CommonExport.Resume;   // Thread;
  end;
end;

end.
