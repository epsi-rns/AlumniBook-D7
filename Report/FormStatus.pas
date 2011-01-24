unit FormStatus;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, Buttons, StdCtrls;

type
  TfrmStatus = class(TForm)
    StatusBar: TStatusBar;
    Label1: TLabel;
    ProgressBar: TProgressBar;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmStatus: TfrmStatus;

implementation

{$R *.dfm}

{ TfrmStatus }

end.
