unit X_Base;

interface

uses
  Classes,
  DB, IBDatabase, IBQuery,
  X_List;

{Common Type}

type
  TReportInfo = record
    Name, Desc: String;
  end;

  TReportKinds = set of (rkExcel, rkWord, rkCalc, rkText);

Var
  ThreadsRunning, FExcelThd, FWordThd, FCalcThd, FTextThd: Integer;

Function IsThreadRunning(Kind: TReportKinds;
  Silence: Boolean = False): Boolean;

Type
  TExportBase = class(TThread)
  private
    { Private declarations }
    txExport: TIBTransaction;
    dbExport: TIBDatabase;
    rdbName: String;
    FCount: Integer;
    FRecNum: Integer;
    FStatus: String;
    FOnAfterQuery: TNotifyEvent;
    procedure SetupDBTX(dbName: String);
    procedure UpdateStatus;
    procedure UpdateProgress;
    procedure OpenQuery;
    { Property Writer }
    procedure AfterNext(DataSet: TDataSet);
  protected
    { Protected declarations }
    FTitle, FSubject: String;
    qrExport: TIBQuery;
    List : TExportList;
    Item: TExportItem;
    FIDName: String;
    FID: Integer;
    procedure NextRecord;
    procedure DoSingle; virtual; abstract;
    procedure Execute; override;
  public
    { Public declarations }
    constructor Create(dbName: String; NewList: TExportList); virtual;
    destructor Destroy; override;
    procedure DoStatus(Text: String); virtual;
  end;

implementation

uses
  IB, Dialogs, Controls, Forms, Variants,
  FormStatus;

Function IsThreadRunning(Kind: TReportKinds;
  Silence: Boolean = False): Boolean;
begin           // use raise, not that funky messgae
  If (rkExcel in Kind) and (FExcelThd > 0) then
  begin
    If not Silence then
      ShowMessage('A Report thread is still running Excel');
    Result:= True;
    exit;
  end;

  If (rkWord in Kind) and (FWordThd > 0) then
  begin
    If not Silence then
      ShowMessage('A Report thread is still running WinWord');
    Result:= True;
    exit;
  end;

  If (Kind = []) and (ThreadsRunning > 0) then
  begin
    If not Silence then
      ShowMessage('One or more report thread is still running');
    Result:= True;
    exit;
  end;

  Result := False;
end;

{ TExportBase }

constructor TExportBase.Create(dbName: String; NewList: TExportList);
begin
  List := NewList;  // pointer assignment
  frmStatus.Show;
  rdbName:=dbname;

  FreeOnTerminate := True;
  inherited Create(True); // Always create suspended
end;

destructor TExportBase.Destroy;
begin
  Dec(ThreadsRunning);
  If (ThreadsRunning = 0) then
    frmStatus.Close;
  Application.BringToFront;
  List.Free;

  inherited;
end;

procedure TExportBase.SetupDBTX(dbName: String);
begin
  dbExport := TIBDatabase.Create(nil);
  txExport := TIBTransaction.Create(nil);
  qrExport := TIBQuery.Create(nil);

  dbExport.AllowStreamedConnected := False;
  dbExport.Params.Append('user_name=sysdba');
  dbExport.Params.Append('password=masterkey');
  dbExport.LoginPrompt:=False;
  dbExport.IdleTimer := 0;
  dbExport.DatabaseName := dbName;
  dbExport.TraceFlags := [ tfQExecute ];
  //-- Complete version --
  //  [ tfQPrepare, tfQExecute, tfQFetch, tfError, tfStmt,
  //    tfConnect,  tfTransact, tfBlob, tfService, tfMisc ];

  txExport.AutoStopAction := saRollBack;

  dbExport.DefaultTransaction := txExport;
  txExport.DefaultDatabase := dbExport;
  qrExport.Database := dbExport;
  qrExport.Transaction := txExport;

  dbExport.Open;
  txExport.StartTransaction;
end;

procedure TExportBase.Execute;
var
  I: Integer;
begin
  // initialize
  Inc(ThreadsRunning);
  SetupDBTX(rdbName);
  qrExport.AfterScroll := AfterNext;

  try
    for I:=0 to List.Count - 1 do
    begin
    FRecNum := 0;
    FCount  := 0;

    Item       := List.Items[I];
    FSubject   := 'Test';

    FTitle     := Item.Name;
    FIDName    := Item.IDName;

    qrExport.SQL.Clear;
    qrExport.SQL.AddStrings(Item.SQL);

    DoStatus('Running Query '+FTitle+'...');
    Synchronize(OpenQuery);
    DoStatus('Fetching Table '+FTitle+'...');    
    qrExport.FetchAll;
    FCount := qrExport.RecordCount;
    qrExport.First;
    DoStatus('Running Report '+FTitle+'...');
    DoSingle;

    DoStatus('');
    qrExport.Close;
    end;
  finally
    txExport.RemoveDatabases;

    qrExport.Free;
    dbExport.Free;
    txExport.Free;
  end;

  inherited;
end;

procedure TExportBase.OpenQuery;
begin                   // critical
  Screen.Cursor := crSQLWait;
  Try
    qrExport.Open;
  Finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TExportBase.UpdateProgress;
begin
  frmStatus.StatusBar.SimpleText := FStatus;
  frmStatus.ProgressBar.Max:= FCount;
  frmStatus.ProgressBar.Position:= FRecNum;
  frmStatus.ProgressBar.Visible  := (FRecNum > 0) and (FRecNum < FCount-1);
end;

procedure TExportBase.UpdateStatus;
begin
  UpdateProgress;
  frmStatus.BringToFront;
end;

procedure TExportBase.DoStatus(Text: String);
begin
  FStatus := Text;
  Synchronize(UpdateStatus);
end;

procedure TExportBase.NextRecord;
begin
  qrExport.Next;
end;

procedure TExportBase.AfterNext(DataSet: TDataSet);
begin
  Inc(FRecNum);
  Synchronize(UpdateProgress);
end;

initialization
  ThreadsRunning := 0;  FExcelThd := 0;  FWordThd := 0;  FCalcThd := 0;
end.
