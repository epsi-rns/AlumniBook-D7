unit PieLink;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, Buttons, ExtCtrls, ComCtrls, ToolWin, Grids, DBGrids,
  TeEngine, Series, TeeProcs, Chart, DbChart, StdCtrls, DB, ExtDlgs;

type
  TfrmPieLink = class(TForm)
    CoolBar: TCoolBar;
    tbStandard: TToolBar;
    CloseBtn: TToolButton;
    ToolbarImages: TImageList;
    DBChart: TDBChart;
    SaveBtn: TToolButton;
    ImageSave: TSavePictureDialog;
    CopyPanel: TPanel;
    cbCopyClip: TComboBox;
    CopyBtn: TSpeedButton;
    ChartOptionsPanel: TPanel;
    imChart: TImageList;
    cbChartType: TComboBoxEx;
    PrintBtn: TToolButton;
    MoreOptionsBtn: TSpeedButton;
    cbLegend: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SaveBtnClick(Sender: TObject);
    procedure CopyBtnClick(Sender: TObject);
    procedure cbChartTypeSelect(Sender: TObject);
    procedure PrintBtnClick(Sender: TObject);
    procedure SetOptions(Sender: TObject);
    procedure MoreOptionsBtnClick(Sender: TObject);
    procedure CloseBtnClick(Sender: TObject);
    procedure cbLegendClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure GetColors;
    procedure SetColors;
    procedure GetStyle;
    procedure SetStyle;
  end;

var
  frmPieLink: TfrmPieLink;

implementation

{$R *.dfm}

uses
  DateUtils, dmMain, DateFltr, FormChartOpt, FormStatus,
  BFormAny;
{
ColorPalette : Array[1..MaxDefaultColors] of TColor =
  (clRed, clGreen, clYellow, clBlue, clWhite, clGray,
   clFuchsia, clTeal, clNavy, clMaroon, clLime, clOlive,
   clPurple, clSilver, clAqua, clBlack);
}

procedure TfrmPieLink.CloseBtnClick(Sender: TObject);
begin
  close;
end;

procedure TfrmPieLink.FormShow(Sender: TObject);
begin
  frmChartOptions := TfrmChartOptions.Create(self);
  cbChartType.ItemIndex := 0;
  cbChartTypeSelect(nil);

  with BrowseMisc.ChooseQueryBox do
    If not BrowseMisc.qrLookup.IsEmpty
      then DBChart.Title.Text [0] := Items[ItemIndex]
      else DBChart.Title.Text [0] := '';

  DBChart.RefreshData;
end;

procedure TfrmPieLink.cbLegendClick(Sender: TObject);
begin
  DBChart.Legend.Visible := cbLegend.Checked;
end;

procedure TfrmPieLink.FormClose(Sender: TObject; var Action: TCloseAction);
Var mySeries: TChartSeries;
begin
  frmChartOptions.Close;
  frmChartOptions.Free;

  // Remove All Series;
  While DBChart.SeriesList.Count>0 do
  begin
    mySeries := DBChart.Series[0];
    mySeries.ParentChart := nil ;
    mySeries.Free;
  end;
end;

procedure TfrmPieLink.MoreOptionsBtnClick(Sender: TObject);
begin
  GetColors;
  GetStyle;
  frmChartOptions.Show;
end;

procedure TfrmPieLink.PrintBtnClick(Sender: TObject);
begin
  DBChart.Print;
end;

procedure TfrmPieLink.SetOptions(Sender: TObject);
Var mySeries: TChartSeries;
begin
  mySeries := DBChart.GetASeries;
  mySeries.XLabelsSource := BrowseMisc.XSeries;
  mySeries.YValues.ValueSource := 'Total';

  If (mySeries is TBarSeries) then with TBarSeries(mySeries) do
     ColorEachPoint := True;

  SetColors;
  SetStyle;
end;

procedure TfrmPieLink.SaveBtnClick(Sender: TObject);
begin
  With ImageSave do
  begin
    FileName:= DBChart.Title.Text [0];
    if Execute then
    case FilterIndex of
      1: DBChart.SaveToMetafile(FileName);
      2: DBChart.SaveToMetafileEnh(Filename);
      3: DBChart.SaveToBitmapFile(FileName);
    end
  end;
end;

procedure TfrmPieLink.CopyBtnClick(Sender: TObject);
begin
  Case cbCopyClip.ItemIndex of
    0: DBChart.CopyToClipboardBitmap;
    1: DBChart.CopyToClipboardMetafile(true);
    2: DBChart.CopyToClipboardMetafile(False);
  end;
end;

procedure TfrmPieLink.cbChartTypeSelect(Sender: TObject);
Var mySeries: TChartSeries;
begin
  // Remove All Series;
  While DBChart.SeriesList.Count>0 do
  begin
    mySeries := DBChart.Series[0];
    mySeries.ParentChart := nil ;
    mySeries.Free;
  end;

  Case cbChartType.ItemIndex of
    1: mySeries := TBarSeries.Create(DBChart);
    2: mySeries := TLineSeries.Create(DBChart);
    3: mySeries := TPointSeries.Create(DBChart);
  else mySeries := TPieSeries.Create(DBChart);
  end;

  mySeries.ParentChart := DBChart;
  mySeries.DataSource := BrowseMisc.qrLookup;
  mySeries.Active := True;

  setOptions(nil);
end;

procedure TfrmPieLink.SetColors;
begin
  With DBChart, frmChartOptions do
  begin
    View3D := cb3D.Checked;
    BackWall.Color := bkColor.Selected;
    Legend.Color := lgColor.Selected;
    Gradient.StartColor := stColor.Selected;
    Gradient.EndColor   := ndColor.Selected;
    Gradient.Visible := (cbGradient.Checked);
  end;
end;

procedure TfrmPieLink.GetColors;
begin
  With DBChart, frmChartOptions do
  begin
    cb3D.Checked := View3D;
    bkColor.Selected := BackWall.Color;
    lgColor.Selected := Legend.Color;
    stColor.Selected := Gradient.StartColor;
    ndColor.Selected := Gradient.EndColor;
    Gradient.Visible := (cbGradient.Checked);
  end;
end;

procedure TfrmPieLink.GetStyle;
Var
  mySeries: TChartSeries;
begin
  mySeries := DBChart.GetASeries;

  With frmChartOptions do
  begin
    If not mySeries.Marks.Visible
    then cbMark.ItemIndex := 0
    else cbMark.ItemIndex := ord(mySeries.Marks.Style) + 1;

    If (mySeries is TLineSeries) then
      cbPointStyle.ItemIndex := ord (TLineSeries(mySeries).Pointer.Style);
    If (mySeries is TPointSeries) then
      cbPointStyle.ItemIndex := ord (TPointSeries(mySeries).Pointer.Style);
    If (mySeries is TBarSeries) then
      cbBarStyle.ItemIndex := ord(TBarSeries(mySeries).BarStyle);
  end;
end;

procedure TfrmPieLink.SetStyle;
Var
  mySeries: TChartSeries;
  ps: TSeriesPointerStyle;
begin
  mySeries := DBChart.GetASeries;

  With frmChartOptions do
  begin
    mySeries.Marks.Visible := (cbMark.ItemIndex>0);
    If cbMark.ItemIndex>0 then
      mySeries.Marks.Style := TSeriesMarksStyle(cbMark.ItemIndex-1);

    ps := TSeriesPointerStyle(cbPointStyle.ItemIndex);
    If (mySeries is TLineSeries) then
       TLineSeries(mySeries).Pointer.Style:=ps;
    If (mySeries is TPointSeries) then
       TPointSeries(mySeries).Pointer.Style:=ps;
    If (mySeries is TBarSeries) then
        TBarSeries(mySeries).BarStyle := TBarStyle(cbBarStyle.ItemIndex);
  end;
end;



end.
