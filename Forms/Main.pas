unit Main;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, Menus, ComCtrls,
  XPStyleActnCtrls, ActnList, ActnMan, ToolWin, StdActns, ImgList,
  BandActn, ExtActns, ActnMenus, ActnCtrls, ActnColorMaps;

type
  TmyDbStatus = (dbsClosed=0, dbsProcess, dbsOpened);

  TAlumniBook = class(TForm)
    tbAction: TActionToolBar;
    MenuBar: TActionMainMenuBar;
    ActionManager: TActionManager;
    acOpenLocal: TFileOpen;
    acFileSaveAs: TFileSaveAs;
    acFilePrintSetup: TFilePrintSetup;
    acFileExit: TFileExit;
    acFileNew: TAction;
    acFileSave: TAction;
    acHelpContents: THelpContents;
    acHelpTopicSearch: THelpTopicSearch;
    acHelpOnHelp: THelpOnHelp;
    acAbout: TAction;
    acPrint: TAction;
    AlwayOnTop: TAction;
    acLinkGraph: TAction;
    SetupWizard: TAction;
    Company: TAction;
    Security: TAction;
    Preferences: TAction;
    acStayOnTop: TAction;
    acShowTips: TAction;
    acReporter: TAction;
    ManImages: TImageList;
    acOpenDefault: TAction;
    acCloseDB: TAction;
    acPageSetup: TFilePageSetup;
    acMonitor: TAction;
    acRemoteOpen: TAction;
    acSetDefault: TAction;
    imLed: TImageList;
    acAutoDefault: TAction;
    acImport: TAction;
    acAlumni: TAction;
    acOrganization: TAction;
    acQuickEntry: TAction;
    tbEntry: TActionToolBar;
    acCommit: TAction;
    acRollback: TAction;
    acBrowseMisc: TAction;
    aclReopen: TActionList;
    Action4: TAction;
    Action5: TAction;
    Action6: TAction;
    Action7: TAction;
    Action8: TAction;
    acReopen1: TAction;
    acReopen2: TAction;
    acReopen3: TAction;
    acMySQL: TFileSaveAs;
    StatusLine: TStatusBar;
    procedure FormCreate(Sender: TObject);
    procedure ShowHint(Sender: TObject);
    procedure FileOpen1(Sender: TObject);
    procedure FileSave(Sender: TObject);
    procedure FileSaveAs(Sender: TObject);
    procedure FilePrint(Sender: TObject);
    procedure FilePrintSetup(Sender: TObject);
    procedure FileExit(Sender: TObject);
    procedure EditUndo(Sender: TObject);
    procedure EditCut(Sender: TObject);
    procedure EditCopy(Sender: TObject);
    procedure EditPaste(Sender: TObject);
    procedure HelpContents(Sender: TObject);
    procedure HelpSearch(Sender: TObject);
    procedure HelpHowToUse(Sender: TObject);
    procedure HelpAbout(Sender: TObject);
    procedure AlwayOnTopExecute(Sender: TObject);
    procedure acShowTipsExecute(Sender: TObject);
    procedure acOpenDefaultExecute(Sender: TObject);
    procedure acCloseDBExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure acMonitorExecute(Sender: TObject);
    procedure acRemoteOpenExecute(Sender: TObject);
    procedure acSetDefaultExecute(Sender: TObject);
    procedure StatusLineDrawPanel(StatusBar: TStatusBar;
      Panel: TStatusPanel; const Rect: TRect);
    procedure acLinkGraphExecute(Sender: TObject);
    procedure acAutoDefaultExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure acImportExecute(Sender: TObject);
    procedure acAlumniExecute(Sender: TObject);
    procedure acOrganizationExecute(Sender: TObject);
    procedure acQuickEntryExecute(Sender: TObject);
    procedure acCommitExecute(Sender: TObject);
    procedure acRollbackExecute(Sender: TObject);
    procedure acCommitUpdate(Sender: TObject);
    procedure acBrowseMiscExecute(Sender: TObject);
    procedure acReopenExecute(Sender: TObject);
    procedure acMySQLAccept(Sender: TObject);
  private
    { Private-Deklarationen }
    ReopenItem: TActionClientItem;
    DBStatus: TmyDbStatus;
    // -- Reopen related -- see demos
    procedure SetReopenMenu;
    procedure DBAccept4Menu;
    function aclr(I: Integer): TCustomAction; // shortcut;
    function rci (I: Integer): TActionClientItem; // shortcut;
    // -- end of reopen
    procedure WMSysCommand (var Msg: TWMSysCommand);
      message wm_SysCommand;
  public
    { Public-Deklarationen }
    procedure ConnectDB(DBName: String);
    procedure UpdateUI;
  end;

var
  AlumniBook: TAlumniBook;

implementation

  { Add code to create a new file }

uses dmMain, IBDatabase, IBQuery, X_Base, 
  dmCommon, frmMonitorU, PieLink, X_Alumni_Report,
  BFormAlumni, BFormOrganization, BFormAny;

{$r *.dfm}

const
  idSysAbout = 100;

procedure TAlumniBook.WMSysCommand (var Msg: TWMSysCommand);
begin
  // handle a specific command
  if Msg.CmdType = idSysAbout then
  begin
    MessageDlg ('Alumni Yellow Pages'+#13+'First Book Version'+#13+
                'by epsi@citrajaya.net', mtInformation, [mbOk], 0);
    dmC.RegGDBIcon;
   end;
  inherited;   // default system menu commands
end;

procedure TAlumniBook.FormCreate(Sender: TObject);
begin
  // add a separator and a menu item to the system menu
  AppendMenu (GetSystemMenu(Handle,FALSE), MF_SEPARATOR, 0, '');
  AppendMenu (GetSystemMenu(Handle,FALSE), MF_STRING, idSysAbout, '&About...');

  // Fix path for ABMRU
  ActionManager.FileName := ExtractFilePath(Application.ExeName)+'menu.dat';
  SetReopenMenu;
end;

function TAlumniBook.aclr(I: Integer): TCustomAction;
begin
  Result := TCustomAction(aclReopen.Actions[I]);
end;

function TAlumniBook.rci(I: Integer): TActionClientItem;
begin
  Result := ReopenItem.Items[I];
end;

procedure TAlumniBook.SetReopenMenu;
var I: Integer;
begin
  ReopenItem := ActionManager.ActionBars[0].Items[0].Items[3];

  for I := 0 to ReopenItem.Items.Count - 1 do
    aclr(I).Caption := Copy(rci(I).Caption, 5, MaxInt);
end;

procedure TAlumniBook.DBAccept4Menu;
var
  I: Integer;
  Found: Boolean;
begin // If the filename is already in the list then do not add it again
  Found := False;
  for I := 0 to aclReopen.ActionCount - 1 do
    if CompareText(aclr(I).Caption, Data.Database.DatabaseName) = 0 then
    begin Found := True; break; end;

  if not Found then // Update the Reopen menu...
  begin
    if ReopenItem = nil then exit;

    for I := aclReopen.ActionCount - 1 downto 0 do
      if I = 0 then aclr(I).Caption := Data.Database.DatabaseName
      else aclr(I).Caption := aclr(I-1).Caption;

    if ReopenItem.Items.Count < aclReopen.ActionCount then ReopenItem.Items.Add;
    for I := 0 to ReopenItem.Items.Count - 1 do
    begin
      rci(I).Action := aclReopen.Actions[I];
      rci(I).Caption := Format('&%d: %s', [I, aclr(I).Caption]);
    end;
  end;
end;

procedure TAlumniBook.acReopenExecute(Sender: TObject);
begin
  ConnectDB( (Sender as TCustomAction).Caption );
end;

procedure TAlumniBook.ShowHint(Sender: TObject);
begin
  StatusLine.Panels[1].Text := Application.Hint;
end;

procedure TAlumniBook.FileSave(Sender: TObject);
begin
   { Add code to save current file under current name }
end;

procedure TAlumniBook.FileSaveAs(Sender: TObject);
begin
  if dmC.SaveDialog.Execute then
  begin
    { Add code to save current file under SaveDialog.FileName }
  end;
end;

procedure TAlumniBook.FilePrint(Sender: TObject);
begin
  if dmC.PrintSetupDialog.Execute then
  begin
    { Add code to print current file }
  end;
end;

procedure TAlumniBook.FilePrintSetup(Sender: TObject);
begin
  dmC.PrintSetupDialog.Execute;
end;

procedure TAlumniBook.FileExit(Sender: TObject);
begin
  Close;
end;

procedure TAlumniBook.EditUndo(Sender: TObject);
begin
  { Add code to perform Edit Undo }
end;

procedure TAlumniBook.EditCut(Sender: TObject);
begin
  { Add code to perform Edit Cut }
end;

procedure TAlumniBook.EditCopy(Sender: TObject);
begin
  { Add code to perform Edit Copy }
end;

procedure TAlumniBook.EditPaste(Sender: TObject);
begin
  { Add code to perform Edit Paste }
end;

procedure TAlumniBook.HelpContents(Sender: TObject);
begin
  Application.HelpCommand(HELP_CONTENTS, 0);
end;

procedure TAlumniBook.HelpSearch(Sender: TObject);
const
  EmptyString: PChar = '';
begin
  Application.HelpCommand(HELP_PARTIALKEY, Longint(EmptyString));
end;

procedure TAlumniBook.HelpHowToUse(Sender: TObject);
begin
  Application.HelpCommand(HELP_HELPONHELP, 0);
end;

procedure TAlumniBook.HelpAbout(Sender: TObject);
begin
  { Add code to show program's About Box }
//  dmC.AboutBoxDlg.Execute;
end;

procedure TAlumniBook.AlwayOnTopExecute(Sender: TObject);
begin
  with Sender as TAction do
  begin
    Checked := not Checked;
    if Checked then AlumniBook.FormStyle := fsStayOnTop
    else AlumniBook.FormStyle := fsNormal;
  end;
end;

procedure TAlumniBook.acShowTipsExecute(Sender: TObject);
begin
//  with Sender as TAction do
//    If dmC.Tips.Execute then Checked := dmC.Tips.ShowAtStart;
end;

procedure TAlumniBook.StatusLineDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
Var Bitmap : TBitMap;
begin
  If (Panel = StatusLine.Panels[0]) then
  begin
    Bitmap := TBitmap.Create;
    with StatusLine.Canvas do
    try
      imLed.GetBitmap(Ord(DBStatus), Bitmap);
      Bitmap.Transparent := True;
      Bitmap.TransparentMode := tmAuto;
      Draw(3, 3, BitMap);
    finally
      Bitmap.Free;
    end;
  end;
end;

procedure TAlumniBook.ConnectDB(DBName: String);
begin     // Add code to open OpenDialog.FileName
  acCloseDBExecute(nil);
  Application.Hint := 'Opening Database Connection';
  Data.Database.DatabaseName := DBName;
  Data.Database.Open;

  DBAccept4Menu;
  UpdateUI;

  Data.txEntry.StartTransaction;  
end;

procedure TAlumniBook.acCloseDBExecute(Sender: TObject);
begin // not completed without closing all forms first;
  If Data.Database.Connected then
  begin

    With Data.txEntry do
    if InTransaction then
      case Confirm ('Commit Transactions?')
      of mrYes: Commit;
         mrNo: Rollback;
      else Exit;
    end;

    DBStatus := dbsProcess;
    StatusLine.Repaint;

    Application.Hint := 'Closing Database Connection';
    Data.Database.Close;
  end;
  UpdateUI;
end;

procedure TAlumniBook.FileOpen1(Sender: TObject);
begin     // Add code to open OpenDialog.FileName
  ConnectDB( '127.0.0.1:'+acOpenLocal.Dialog.FileName );
end;

procedure TAlumniBook.acRemoteOpenExecute(Sender: TObject);
Var S: String;
begin
  S := InputBox('Open Remote Firebird Database',
         'Enter remote alias or file name:'+#13
       + '  AnyServer:AnyAlias'+#13
       + '  myComputer:myDrive:\myPath\myFile.gdb', '');
  If S <> '' then ConnectDB( S );
end;

procedure TAlumniBook.acOpenDefaultExecute(Sender: TObject);
Var S: String;
begin
  S := dmC.GetDefaultDB;
  If S ='' then ShowMessage('No default database set')
  else ConnectDB( S );
end;

procedure TAlumniBook.FormShow(Sender: TObject);
begin
  // Take over the splash after open. Do this before any action
  Application.OnHint := ShowHint;

  AcAutoDefault.Checked := dmC.IsAutoOpen;
  If AcAutoDefault.Checked then acOpenDefaultExecute(nil);

  UpdateUI;
end;

procedure TAlumniBook.acMonitorExecute(Sender: TObject);
begin
  TfrmMonitor.Create(self).Show;
end;

procedure TAlumniBook.acLinkGraphExecute(Sender: TObject);
begin
  frmPieLink.Show;
end;

procedure TAlumniBook.acSetDefaultExecute(Sender: TObject);
begin
  dmC.PutDefaultDB(Data.Database.DatabaseName);
end;

procedure TAlumniBook.UpdateUI;
Var IsConnected : Boolean;
begin
  IsConnected := Data.Database.Connected;

  If IsConnected then
  begin
    Caption := 'Alumni Yellow Pages - '
      + ExtractFileName( Data.Database.DatabaseName );
    DBStatus := dbsOpened;
  end
  else begin
    Caption := 'Alumni Yellow Pages';
    DBStatus := dbsClosed;
  end;

  StatusLine.Repaint;
  Application.Hint := '';

  acQuickEntry.Enabled      := IsConnected;
  acOrganization.Enabled    := IsConnected;
  acAlumni.Enabled          := IsConnected;
  acBrowseMisc.Enabled      := IsConnected;

  If not IsConnected then
  begin  
//    frmEntryQuick.Close;
    BrowseOrganization.Close;
    BrowseAlumni.Close;
    BrowseMisc.Close;
  end;

  acReporter.Enabled        := IsConnected;
  acLinkGraph.Enabled       := IsConnected;
  acImport.Enabled          := IsConnected;
  acSetDefault.Enabled      := IsConnected;
  acCloseDB.Enabled         := IsConnected;
end;

procedure TAlumniBook.acAutoDefaultExecute(Sender: TObject);
begin
  dmC.SetAutoOpen(AcAutoDefault.Checked);
end;

procedure TAlumniBook.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  If IsThreadRunning([rkExcel, rkWord], True) then CanClose := IsConfirm
    ('Report thread is running.'#13'Do you really want to quit?');

  acCloseDBExecute(nil);
  If Data.Database.Connected then
     CanClose := False;    
end;

procedure TAlumniBook.acImportExecute(Sender: TObject);
Const
  ConfirmStr = 'You should make a backup before move data!'
               +#13+'Continue  move data?';
begin
  Application.BringToFront;
end;

procedure TAlumniBook.acAlumniExecute(Sender: TObject);
begin
  BrowseAlumni.Show;
end;

procedure TAlumniBook.acOrganizationExecute(Sender: TObject);
begin
  BrowseOrganization.Show;
end;

procedure TAlumniBook.acBrowseMiscExecute(Sender: TObject);
begin
  BrowseMisc.Show;
end;

procedure TAlumniBook.acQuickEntryExecute(Sender: TObject);
begin
//  frmEntryQuick.Show;
end;

procedure TAlumniBook.acCommitExecute(Sender: TObject);
begin
  Data.txEntry.CommitRetaining;
end;

procedure TAlumniBook.acRollbackExecute(Sender: TObject);
begin
  Data.txEntry.RollbackRetaining;
end;

procedure TAlumniBook.acCommitUpdate(Sender: TObject);
begin
  acCommit.Enabled := Data.txEntry.InTransaction;
  acRollback.Enabled := acCommit.Enabled;
end;

procedure TAlumniBook.acMySQLAccept(Sender: TObject);
begin
  SQLJustDoIt(acMySQL.Dialog.FileName, Data.Database.DatabaseName);
end;

end.
