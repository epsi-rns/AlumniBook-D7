{ Since the splash screen is displayed before the main screen is created,
  it must be created before the main screen.
}

unit FormSplash;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, ComCtrls;

type
  TSplash = class(TForm)
    HintLabel: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    Bevel1: TBevel;
    AllBevel: TBevel;
    ProgressBar: TProgressBar;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    Save_Cursor:TCursor;
  public
    { Public declarations }
    procedure ShowHint(Sender: TObject);
    procedure StepBy(Step : Integer = 1);
  end;

Var Splash: TSplash;

implementation

{$R *.DFM}


procedure TSplash.FormShow(Sender: TObject);
Begin
  Save_Cursor := Screen.Cursor;
  Screen.Cursor := crAppStart;    { Show hourglass cursor }
  Application.OnHint := ShowHint;  // Take over the splash
end;

procedure TSplash.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Screen.Cursor := Save_Cursor;  { Always restore to normal }
//  Application.OnHint := nil;
end;

procedure TSplash.ShowHint(Sender: TObject);
begin
  HintLabel.Caption := Application.Hint;
  HintLabel.Update; // Force Label Painting
end;

procedure TSplash.StepBy(Step : Integer = 1);
begin
  ProgressBar.StepBy(Step);
end;





end.



