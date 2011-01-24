unit dmCommon;

interface

uses
  SysUtils, Classes, ImgList, Controls, Forms, Dialogs, AppEvnts;

type
  TdmC = class(TDataModule)
    ActionImages: TImageList;
    PrintSetupDialog: TPrinterSetupDialog;
    PrintDialog: TPrintDialog;
    SaveDialog: TSaveDialog;
    AppEvents: TApplicationEvents;
    procedure AppEventsException(Sender: TObject; E: Exception);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure RegGDBIcon;
    procedure PutDefaultDB(DBName: String);
    procedure SetAutoOpen(IsAuto: Boolean);    
    function GetDefaultDB: String;
    function IsAutoOpen: Boolean;

  end;

var
  dmC: TdmC;

implementation

{$R *.dfm}
uses Registry, Windows;

Const SaveKey = 'Software\CitraJaya\AlumniBook\';

procedure TdmC.AppEventsException(Sender: TObject; E: Exception);
var
  Filename: string;
  LogFile: TextFile;
begin
  // prepares log file
  Filename := ChangeFileExt (Application.Exename, '.log');
  AssignFile (LogFile, Filename);
  if FileExists (FileName)
    then Append (LogFile)     // open existing file
    else Rewrite (LogFile);   // create a new one

  // write to the file and show error
  Writeln (LogFile, DateTimeToStr (Now) + ':' + E.Message);
  Application.ShowException (E);

  CloseFile (LogFile);       // close the file
end;

function TdmC.IsAutoOpen: Boolean;
Var Reg : TRegistry;
begin
 Result := not (GetDefaultDB='');
 If Result then
 begin
   Reg:= TRegistry.Create;
   Try
     Reg.RootKey := HKEY_CURRENT_USER;
     Reg.OpenKey (SaveKey, True);
     if Reg.ValueExists('DefaultAutoOpen')
     then Result := Reg.ReadBool('DefaultAutoOpen')
     else begin
       Reg.WriteBool('DefaultAutoOpen', False);
       Result:=False;
     end;
     Reg.CloseKey;
   Finally
     Reg.Free;
   End;
 end;
end;

procedure TdmC.SetAutoOpen(IsAuto: Boolean);
Var Reg : TRegistry;
begin
 Reg:= TRegistry.Create;
 Try
  Reg.RootKey := HKEY_CURRENT_USER;
  Reg.OpenKey (SaveKey, True);
  Reg.WriteBool('DefaultAutoOpen', IsAuto);
  Reg.CloseKey;
 Finally
   Reg.Free;
 End;
end;

function TdmC.GetDefaultDB: String;
Var Reg : TRegistry;
begin
 Reg:= TRegistry.Create;
 Try
  Reg.RootKey := HKEY_CURRENT_USER;
  Reg.OpenKey (SaveKey, True);
  Result := Reg.ReadString('DefaultDB');
  Reg.CloseKey;
 Finally
   Reg.Free;
 End;
end;

procedure TdmC.PutDefaultDB(DBName: String);
Var Reg : TRegistry;
begin
 Reg:= TRegistry.Create;
 Try
  Reg.RootKey := HKEY_CURRENT_USER;
  Reg.OpenKey (SaveKey, True);
  Reg.WriteString('DefaultDB', DBName);
  Reg.CloseKey;
 Finally
   Reg.Free;
 End;
end;

procedure TdmC.RegGDBIcon;
Var
  Reg : TRegistry;
  FBIconSource, IBIconSource: String;
begin
 Reg:= TRegistry.Create;
 Try
  Reg.RootKey := HKEY_LOCAL_MACHINE;
  // InterBase 6 Bin + Sample database path
  Reg.OpenKey('\Software\Borland\InterBase\CurrentVersion', False);
  IBIconSource := Reg.ReadString('ServerDirectory') + 'ibserver.exe';
  Reg.CloseKey;

  Reg.RootKey := HKEY_LOCAL_MACHINE;
  // Firebird 2 Bin
  Reg.OpenKey('\Software\Firebird Project\Firebird Server\Instances', False);
  FBIconSource := Reg.ReadString('DefaultInstance') + 'bin\fbserver.exe';
  Reg.CloseKey;

  Reg.RootKey:= HKEY_CLASSES_ROOT;
  Reg.OpenKey('', True);
  if not Reg.KeyExists('.gdb') then
  begin
    Reg.CreateKey('.gdb');
    Reg.OpenKey('.gdb', True);
    Reg.WriteString('', 'Interbase');
  end;
  Reg.CloseKey;

  Reg.RootKey:= HKEY_CLASSES_ROOT;
  Reg.OpenKey('', True);
  if not Reg.KeyExists('.fdb') then
  begin
    Reg.CreateKey('.fdb');
    Reg.OpenKey('.fdb', True);
    Reg.WriteString('', 'Firebird');
  end;
  Reg.CloseKey;

  Reg.RootKey:= HKEY_CLASSES_ROOT;
  Reg.OpenKey('', True);
  if not Reg.KeyExists('Interbase') then
  begin
    Reg.CreateKey('Interbase');
    Reg.OpenKey('Interbase', True);
    Reg.WriteString('', 'Interbase');
    if not Reg.KeyExists('DefaultIcon') then
    begin
      Reg.CreateKey('DefaultIcon');
      Reg.OpenKey('DefaultIcon', True);
      Reg.WriteString('', IBIconSource);
    end;
  end;
  Reg.CloseKey;

  Reg.RootKey:= HKEY_CLASSES_ROOT;
  Reg.OpenKey('', True);
  if not Reg.KeyExists('Firebird') then
  begin
    Reg.CreateKey('Firebird');
    Reg.OpenKey('Firebird', True);
    Reg.WriteString('', 'Firebird');
    if not Reg.KeyExists('DefaultIcon') then
    begin
      Reg.CreateKey('DefaultIcon');
      Reg.OpenKey('DefaultIcon', True);
      Reg.WriteString('', FBIconSource);
    end;
  end;
  Reg.CloseKey;
 Finally
   Reg.Free;
 End;
end;

end.
