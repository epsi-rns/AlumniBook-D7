unit FormChartOpt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TfrmChartOptions = class(TForm)
    cb3D: TCheckBox;
    Label6: TLabel;
    bkColor: TColorBox;
    Label7: TLabel;
    lgColor: TColorBox;
    cbGradient: TCheckBox;
    stColor: TColorBox;
    Label4: TLabel;
    ndColor: TColorBox;
    Label5: TLabel;
    Label3: TLabel;
    cbPointStyle: TComboBox;
    Label2: TLabel;
    cbBarStyle: TComboBox;
    Label1: TLabel;
    cbMark: TComboBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmChartOptions: TfrmChartOptions;

implementation

uses PieLink;

{$R *.dfm}

procedure TfrmChartOptions.BitBtn2Click(Sender: TObject);
begin
  frmPieLink.SetColors;
  frmPieLink.SetStyle;
end;

end.
