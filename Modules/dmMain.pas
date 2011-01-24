unit dmMain;

interface

uses
  SysUtils, Classes, Forms, Controls, Dialogs,
  Graphics, Types, Windows, // DrawOnCanvas
  IBStoredProc, IBSQL, IBQuery, DB, IBCustomDataSet, IBTable, IBDatabase;

type
  TData = class(TDataModule)
    Database: TIBDatabase;
    Transaction: TIBTransaction;
    qrNextID: TIBSQL;
    qrAnyExist: TIBSQL;
    spMaxLevel: TIBStoredProc;
    txEntry: TIBTransaction;
    procedure DatabaseBeforeConnect(Sender: TObject);
    procedure DatabaseAfterConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function NextID: Integer;
    function NextDID: Integer;    
    function IsExist(txAny: TIBTransaction; Const HalfSQL: String): Boolean;
    function MaxLevel: Integer;
  end;

procedure DrawOnCanvas (Const Canvas: TCanvas; Rect:TRect; Amount: Currency);
{ Sign Related Functions }
function Sign(Code: string): Integer;
function SignStr(Code: string): String;
{ Utility Functions (ShortCut) }
function Confirm(Msg: string): Integer;
function IsConfirm(Msg: string): Boolean;
function AndStr(S1, S2: String; AddClause: Boolean = True): String;
function FmtDate(Date: TDateTime): String;

var
  Data: TData;

implementation

{$R *.dfm}

procedure DrawOnCanvas (Const Canvas: TCanvas; Rect:TRect; Amount: Currency);
Var S: String;
begin
  with Canvas do
  begin
    FillRect(Rect);
    InflateRect(Rect, -2, -2);     // leave small border
    If (Amount=0)
    then begin
      S:='---';
      Rect.Left:=(Rect.Right+Rect.Left-TextWidth(S)) div 2;  // alCenter
      TextOut(Rect.Left, Rect.Top, S);
    end
    else begin
      TextOut(Rect.Left, Rect.Top, 'Rp.');
      // Rect.Left := PenPos.X;
      S:=Format('%9.2n', [Amount]);
      Rect.Left:=Rect.Right-TextWidth(S)-2; // alRight
      TextOut(Rect.Left, Rect.Top, S);
    end;
  end;
end;

{ Sign Related Functions }
function Sign(Code: string): Integer;
begin
  If (Length(Code)=0) then Result:=0
  else if Code[1] in ['1','5','6','9'] then Result:=1 else Result:=-1;
end;

function SignStr(Code: string): String;
begin
  Case Sign(Code) of
  -1:  Result := 'Cr';
  1 :  Result := 'Db';
  else Result := '';
  end;
end;

{ Utility Functions }

function Confirm(Msg: string): Integer;
begin
  Result := MessageDlg(Msg, mtConfirmation, mbYesNoCancel, 0);
end;

function IsConfirm(Msg: string): Boolean;
begin
  Result := MessageDlg(Msg, mtConfirmation, mbYesNoCancel, 0) = mrYes;
end;

function AndStr(S1, S2: String; AddClause: Boolean = True): String;
begin
  Case Ord(S1<>'') + 2*ord(s2<>'') of
    0: Result := '';
    1: Result := S1;
    2: Result := S2;
    3: Result := S1 + ' AND ' + S2;
  end;

  If AddClause and (Result<>'') then Result := 'WHERE ('+Result+')';
end;

function FmtDate(Date: TDateTime): String;
begin
  Result := QuotedStr(FormatDateTime('mm/dd/yyyy', Date));
end;

{ Data Module }

function TData.NextID: Integer;
begin                 // fetch next order value from Common_ID generator
  qrNextID.SQL[0]:='SELECT New_ID FROM Next_ID';
  qrNextID.ExecQuery; // no need to call first method at first;
  try Result := qrNextID.Fields[0].AsInteger;
  finally qrNextID.Close; end;
end;

function TData.NextDID: Integer;
begin                 // fetch next order value from Common_ID generator
  qrNextID.SQL[0]:='SELECT New_ID FROM Next_DID';
  qrNextID.ExecQuery; // no need to call first method at first;
  try Result := qrNextID.Fields[0].AsInteger;
  finally qrNextID.Close; end;
end;

function TData.MaxLevel: Integer;
begin
  spMaxLevel.ExecProc;
  Result := spMaxLevel.ParamByName('Result').AsInteger;
end;

function TData.IsExist(txAny: TIBTransaction; Const HalfSQL: String): Boolean;
begin // Combining IsEmpty with SELECT DISTINCT is much more simpler
  With qrAnyExist do
  begin
    Transaction := txAny;
    SQL.Clear;    
    SQL.Add('SELECT COUNT(*)');
    SQL.Add('FROM ' + HalfSQL);
    ExecQuery;
    Result := not (Fields[0].AsInteger = 0);
    Close;
  end;
end;

procedure TData.DatabaseBeforeConnect(Sender: TObject);
begin
  Application.Hint := 'Connecting to Database ';
end;

procedure TData.DatabaseAfterConnect(Sender: TObject);
begin
  Transaction.StartTransaction; // Always Starting Open;
end;

end.
