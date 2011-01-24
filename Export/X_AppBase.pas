unit X_AppBase;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  SysUtils, Classes, IBQuery, ExcelXP, WordXP,
  X_Base, X_List, W_Base;

type
  EooError= class(Exception);  // Terror Handler, catch any horror

const
  ooMsg1 = 'Couldn''t get ServiceManager. '
         + 'OpenOffice connection is impossible.';

type
  
  TExportHTMLBase = class(TExportBase) //(TThread)
  private
    { Private declarations }
  protected
    { Protected declarations }
    FHTML: TWriteHTMLBase;
    procedure DoSingle; override;
  public
    { Public declarations }
    constructor Create(dbName: String; NewList: TExportList;
      NewHTML: TWriteHTMLBase); reintroduce; virtual;
    destructor Destroy; override;
  end;

  TExportExcelBase = class(TExportBase)
  private
    { Private declarations }
    ExcelApp: TExcelApplication;
    xls: _WorksheetDisp;
    FirstSheet: Boolean;
  protected
    { Protected declarations }
    FExcel: TWriteExcelBase;
    procedure DoSingle; override;
    { Thread Methods }
    procedure Execute; override;
    procedure StartExcel;
    { Event }
    procedure ExcelAppNewWorkbook(ASender: TObject; const Wb: _Workbook);
  public
    constructor Create(dbName: String; NewList: TExportList;
      NewExcel: TWriteExcelBase); reintroduce; virtual;
    destructor Destroy; override;
  end;

  TExportWordBase = class(TExportBase)
  private
    { Private declarations }
    WordApp: TWordApplication;
    WordDoc: WordDocument;
  protected
    { Protected declarations }
    FWord: TWriteWordBase;
    procedure DoSingle; override;
    { Thread Methods }
    procedure Execute; override;
  public
    constructor Create(dbName: String; NewList: TExportList;
      NewWord: TWriteWordBase); reintroduce; virtual;
    destructor Destroy; override;
  end;

  TExportSQL = class(TExportBase) //(TThread)
  private
    { Private declarations }
    APrefix, AFilename: String;
    FLines: TStrings;
  protected
    { Protected declarations }
    FSQL: TWriteSQL;
    procedure DoSingle; override;
    procedure Execute; override;
  public
    { Public declarations }
    constructor Create(dbName, Filename, Prefix: String; NewList: TExportList;
      NewSQL: TWriteSQL); reintroduce; virtual;
    destructor Destroy; override;
  end;

  TExportCalcBase = class(TExportBase)
  private
    { Private declarations }
    SpreadsheetComponent, ooServMan : Variant;
    FirstSheet: Boolean;
  protected
    { Protected declarations }
    FCalc: TWriteCalcBase;
    procedure DoSingle; override;
    { Thread Methods }
    procedure Execute; override;
    procedure StartCalc;
    { Event }
//    procedure ExcelAppNewWorkbook(ASender: TObject; const Wb: _Workbook);
    procedure setAutoFormat;
  public
    constructor Create(dbName: String; NewList: TExportList;
      NewCalc: TWriteCalcBase); reintroduce; virtual;
    destructor Destroy; override;
  end;

  TExportTextBase = class(TExportBase)
  private
    { Private declarations }
    oneDesktop, ooServMan : Variant;
  protected
    { Protected declarations }
    FText: TWriteTextBase;
    procedure DoSingle; override;
    { Thread Methods }
    procedure Execute; override;
    procedure StartText;
  public
    constructor Create(dbName: String; NewList: TExportList;
      NewText: TWriteTextBase); reintroduce; virtual;
    destructor Destroy; override;
  end;

implementation

uses Controls, Forms, ActiveX, ComObj, Variants;

{ TExportHTML }

constructor TExportHTMLBase.Create(dbName: String; NewList: TExportList;
  NewHTML: TWriteHTMLBase);
begin
  FHTML := NewHTML;
  inherited Create(dbName, NewList); // Create suspended
end;

destructor TExportHTMLBase.Destroy;
begin
  FHTML.Free;
  inherited;
end;

procedure TExportHTMLBase.DoSingle;
begin
  DoStatus('Writing File '+FTitle+'...');
  FHTML.DoSingle(qrExport, Item);

  DoStatus('Opening Browser...');
  FHTML.SaveAndShow;
end;

{ TExportExcelBase }

constructor TExportExcelBase.Create(dbName: String; NewList: TExportList;
  NewExcel: TWriteExcelBase);
begin
  FExcel := NewExcel;

  ExcelApp := TExcelApplication.Create(nil);
  ExcelApp.OnNewWorkbook := ExcelAppNewWorkbook;

  inherited Create(dbName, NewList); // Create suspended
end;

destructor TExportExcelBase.Destroy;
begin
  Dec(FExcelThd);
  ExcelApp.Disconnect;
  ExcelApp.Free;

  FExcel.Free;   
  inherited;
end;

procedure TExportExcelBase.DoSingle;
begin
  DoStatus('Creating Sheet ' + FTitle);

  If not FirstSheet then
    xls := _WorksheetDisp( ExcelApp.Worksheets.Add(null,null,1,null,0) );
  xls.Name := FTitle;
  FirstSheet := False;

  FExcel.DoSingle(qrExport, Item, xls);
end;

procedure TExportExcelBase.Execute;
begin
  Inc(FExcelThd);

  FirstSheet := True;
  CoInitialize (nil);
  StartExcel;

  inherited;
end;

procedure TExportExcelBase.StartExcel;
Var SaveUserName: String;
begin
  // create and show
  DoStatus('Opening Excel...');
  With ExcelApp do
  begin
    Connect;
    Visible [0] := True;
    Caption := 'Directory Report';

    SaveUserName := UserName[0];
    Try
      UserName[0] := 'Iluni Yellow Pages';
      Workbooks.Add (NULL, 0);
    Finally
      UserName[0] := SaveUserName;
    end;
  end;
end;

procedure TExportExcelBase.ExcelAppNewWorkbook
  (ASender: TObject; const Wb: _Workbook);
begin
  DoStatus('Opening new workbook for ' + FTitle);

  Wb.Comments[0] := FormatDateTime
    ('"Report created : " dddd, mmmm d, yyyy, hh:mm AM/PM', Now);
  Wb.Title[0]    := FTitle;
  Wb.Subject[0]  := FSubject;
  Wb.KeyWords[0] := 'Alumni, Iluni, FTUI, Yellow Pages, Buku';

  Wb.Windows[1].Caption := FTitle;

  While Wb.Worksheets.Count>1 do
      Variant(Wb.Worksheets[2]).Delete;

  xls := _WorksheetDisp(Wb.Worksheets[1]);
end;

{ TWordThread }

constructor TExportWordBase.Create(dbName: String; NewList: TExportList;
  NewWord: TWriteWordBase);
begin
  FWord := NewWord;
  WordApp := TWordApplication.Create(nil);
  inherited Create(dbName, NewList); // Create suspended
end;

destructor TExportWordBase.Destroy;
begin
  Dec(FWordThd);
  WordApp.Disconnect;
  WordApp.Free;

  FWord.Free;
  inherited;
end;

procedure TExportWordBase.DoSingle;
Var
  ov, ovn, ovt, ovf, ovns: OleVariant;
begin
  DoStatus('Opening New Document...');
  ovn := null; ovt := true; ovf := false; ovns:='';      // Local Variables
  ov  := wdNewBlankDocument;
  WordDoc := WordApp.Documents.Add(ovns, ovf, ov, ovt);

  DoStatus('Creating Document ' + FTitle);
  FWord.DoSingle(qrExport, Item, WordDoc);
end;

procedure TExportWordBase.Execute;
begin
  DoStatus('Opening WinWord...');

  Inc(FWordThd);
  CoInitialize (nil);

  // create and show
  WordApp.Connect;
  WordApp.Visible:= True;

  inherited;
end;

{ TExportSQL }

constructor TExportSQL.Create(dbName, Filename, Prefix: String; NewList: TExportList;
  NewSQL: TWriteSQL);
begin
  AFilename := Filename;
  APrefix := Prefix;
  FSQL := NewSQL;
  FLines := TStringList.Create;
  inherited Create(dbName, NewList); // Create suspended
end;

destructor TExportSQL.Destroy;
begin
  FSQL.Free;
  FLines.Free;
  inherited;
end;

procedure TExportSQL.DoSingle;
begin
  DoStatus('Populating '+FTitle+'...');
  Item.IDName := APrefix; // bend the rule...
  FSQL.DoSingle(qrExport, Item);
  FLines.Append('# '+FTitle);
  FLines.AddStrings(FSQL.Lines);
end;

procedure TExportSQL.Execute;
begin
  FLines.Clear;
  inherited;
  FLines.SaveToFile(AFilename);
  FLines.Clear;
end;

{ TExportCalcBase }

constructor TExportCalcBase.Create(dbName: String; NewList: TExportList;
  NewCalc: TWriteCalcBase);
begin
  FCalc := NewCalc;

//  ExcelApp := TExcelApplication.Create(nil);
//  ExcelApp.OnNewWorkbook := ExcelAppNewWorkbook;

  inherited Create(dbName, NewList); // Create suspended
end;

destructor TExportCalcBase.Destroy;
begin
  Dec(FCalcThd);
  FCalc.Free;
  SpreadsheetComponent := Unassigned;
  inherited;
end;

procedure TExportCalcBase.Execute;
begin
  Inc(FCalcThd);

  FirstSheet := True;
  CoInitialize (nil);
  StartCalc;

  inherited;
end;

procedure TExportCalcBase.DoSingle;
var
  Sheet, Spreadsheets, Controller, DocumentInfo : Variant;
  Title : String;
begin
  Title := StringReplace( FTitle, '-', ' ', [rfReplaceAll]);

  // Frame-Controller-Model (FCM)
  DoStatus('Preparing Sheet ' + Title);

  // document data (model)
  Spreadsheets := SpreadsheetComponent.getSheets;       // XSpreadsheetDocument
  Spreadsheets.insertNewByName(Title, 0);              // XSpreadsheets
  Sheet := Spreadsheets.getByName(Title);              // Any, XSpreadsheet

  // interaction (controller), between a frame and document model
  Controller := SpreadsheetComponent.getCurrentController; // XSpreadsheetModel
  Controller.setActiveSheet(Sheet);                     // XSpreadsheetView

  If FirstSheet then
  begin
    If Spreadsheets.hasByName('Sheet1') then
       Spreadsheets.removeByName('Sheet1');
    If Spreadsheets.hasByName('Sheet2') then
       Spreadsheets.removeByName('Sheet2');
    If Spreadsheets.hasByName('Sheet3') then
       Spreadsheets.removeByName('Sheet3');
    FirstSheet := False;

    setAutoFormat;
  end;

  DocumentInfo := SpreadsheetComponent.getDocumentInfo;
  DocumentInfo.Title := FTitle;
  DocumentInfo.Subject := FSubject;
  DocumentInfo.KeyWords := 'Alumni, Iluni, FTUI, Yellow Pages, Buku';
  DocumentInfo.Description := FormatDateTime
    ('"Report created : " dddd, mmmm d, yyyy, hh:mm AM/PM', Now);

//  Wb.Windows[1].Caption := FTitle;

  DoStatus('Getting sheet ' + FTitle);
  FCalc.DoSingle(qrExport, Item, ooServMan, Sheet);
  DoStatus('Done.');
end;

procedure TExportCalcBase.setAutoFormat;
var
  AutoFormatName: String;
  nRow, nCol : Integer;
  nRowlaCouleur, nlaCouleur : Longword;      // laCouleur
  AutoFormatExist: Boolean;
  autoFormats, autoFormat, afField: Variant;
begin
  autoFormats := ooServMan.createInstance
    ('com.sun.star.sheet.TableAutoFormats');
  AutoFormatName :=  'Cinta Biru';
  AutoFormatExist := autoFormats.hasByName(AutoFormatName);
  If AutoFormatExist then
    autoFormat := autoFormats.getByName(AutoFormatName)
  else
  begin
    autoFormat := SpreadsheetComponent.createInstance
      ('com.sun.star.sheet.TableAutoFormat');
    autoFormats.insertByName(AutoFormatName, autoFormat);
  end;

    // set properties of all auto format fields
    autoFormat.IncludeNumberFormat := False;
    for nRow := 0 to 3 do     
    begin
      case nRow of
      0: nRowlaCouleur := $b0b0ff;
      1: nRowlaCouleur := $ffffff;
      2: nRowlaCouleur := $ffffe0;
      else nRowlaCouleur := $ffffff;
      end;

      for nCol := 0 to 3 do
      begin
        nlaCouleur := nRowlaCouleur;
        if nCol in [0] then nlaCouleur := nlaCouleur - $080800;
        afField := autoFormat.getByIndex(4*nRow+nCol);
        afField.CellBackColor := nlaCouleur;
        if (nRow in [0,3]) then afField.CharWeight := 150;
        if (nRow=0) then afField.CharHeight:=12 else afField.CharHeight:=10;
      end;
    end;
end;

procedure TExportCalcBase.StartCalc;
var theDesktop, LoadParams : Variant;
begin
  // initiate COM interface towards OpenOffice
  DoStatus('Connecting to Service Manager');
  if VarIsEmpty(ooServMan) then
    try ooServMan := CreateOleObject('com.sun.star.ServiceManager');
    except raise EooError.Create(ooMsg1); exit;
    end;

  If not (VarIsEmpty(ooServMan) or VarIsNull(ooServMan)) then
    DoStatus('Connected to a running office ...');

  Screen.Cursor:= crHourglass;
  Application.ProcessMessages;
  try
    // Desktop Environment, The root frame,
    // liaison between viewable components and the window system.
    theDesktop := ooServMan.createInstance('com.sun.star.frame.Desktop');
    LoadParams := VarArrayCreate([0, -1], varVariant);

    DoStatus('Opening an empty Calc document');
    SpreadsheetComponent := theDesktop.LoadComponentFromURL
      ( 'private:factory/scalc', '_blank', 0,  LoadParams); // XComponentLoader
    // _blank : Creates a new top-level frame as a child frame of the desktop
  finally
    Screen.Cursor:= crDefault;
  end;
end;

{ TExportTextBase }

constructor TExportTextBase.Create(dbName: String; NewList: TExportList;
  NewText: TWriteTextBase);
begin
  FText := NewText;
  inherited Create(dbName, NewList); // Create suspended
end;

destructor TExportTextBase.Destroy;
begin
  Dec(FTextThd);
  FText.Free;
  OneDesktop := Unassigned;
  inherited;
end;

procedure TExportTextBase.DoSingle;
var
  LoadParams, TextComponent, DocumentInfo : Variant;
  Title : String;
begin
  Screen.Cursor:= crHourglass;
  Application.ProcessMessages;
  try
    DoStatus('Opening an empty Writer document');
    LoadParams := VarArrayCreate([0, -1], varVariant);
    TextComponent := oneDesktop.LoadComponentFromURL      // XComponentLoader
      ( 'private:factory/swriter', '_blank', 0,  LoadParams);
    // _blank : Creates a new top-level frame as a child frame of the desktop
  finally
    Screen.Cursor:= crDefault;
  end;

  Title := StringReplace( FTitle, '-', ' ', [rfReplaceAll]);

  // Frame-Controller-Model (FCM)
  DoStatus('Preparing Sheet ' + Title);

  DocumentInfo := TextComponent.getDocumentInfo;
  DocumentInfo.Title := FTitle;
  DocumentInfo.Subject := FSubject;
  DocumentInfo.KeyWords := 'Alumni, Iluni, FTUI, Yellow Pages, Buku';
  DocumentInfo.Description := FormatDateTime
    ('"Report created : " dddd, mmmm d, yyyy, hh:mm AM/PM', Now);

  DoStatus('Getting Text Data ' + FTitle);
  FText.DoSingle(qrExport, Item, TextComponent);
  DoStatus('Done.');
end;

procedure TExportTextBase.Execute;
begin
  Inc(FTextThd);
  CoInitialize (nil);
  StartText;

  inherited;
end;

procedure TExportTextBase.StartText;
begin
  // initiate COM interface towards OpenOffice
  DoStatus('Connecting to Service Manager');
  if VarIsEmpty(ooServMan) then
    try ooServMan := CreateOleObject('com.sun.star.ServiceManager');
    except raise EooError.Create(ooMsg1); exit;
    end;

  If not (VarIsEmpty(ooServMan) or VarIsNull(ooServMan)) then
    DoStatus('Connected to a running office ...');

  // Desktop Environment, The root frame,
  // liaison between viewable components and the window system.
  oneDesktop := ooServMan.createInstance('com.sun.star.frame.Desktop');
end;

end.
