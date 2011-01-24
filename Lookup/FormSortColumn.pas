unit FormSortColumn;

interface

uses 
  Windows, Messages, SysUtils, Classes, Graphics, Forms, Dialogs, Controls, StdCtrls, 
  Buttons;

type
  TfrmSortColumn = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    SrcList: TListBox;
    DstList: TListBox;
    SrcLabel: TLabel;
    DstLabel: TLabel;
    IncludeBtn: TSpeedButton;
    IncAllBtn: TSpeedButton;
    ExcludeBtn: TSpeedButton;
    ExAllBtn: TSpeedButton;
    procedure IncludeBtnClick(Sender: TObject);
    procedure ExcludeBtnClick(Sender: TObject);
    procedure IncAllBtnClick(Sender: TObject);
    procedure ExcAllBtnClick(Sender: TObject);
  private
    function GetTitles: TStrings;
    procedure SetTitles(const Value: TStrings);
    { Private declarations }
  public
    { Public declarations }
    procedure MoveSelected(List: TCustomListBox; Items: TStrings);
    procedure SetItem(List: TListBox; Index: Integer);
    function GetFirstSelection(List: TCustomListBox): Integer;
    procedure SetButtons;
    property Titles: TStrings read GetTitles write SetTitles;    
  end;

var
  frmSortColumn: TfrmSortColumn;

implementation

{$R *.dfm}

procedure TfrmSortColumn.IncludeBtnClick(Sender: TObject);
var
  I, Index: Integer;
begin
  Index := GetFirstSelection(SrcList);

  for I := SrcList.Items.Count - 1 downto 0 do
  begin
    if (SrcList.Count <= 1) then break; // at least one item left
    if SrcList.Selected[I] then
    begin
      DstList.Items.AddObject(SrcList.Items[I], SrcList.Items.Objects[I]);
      SrcList.Items.Delete(I);
    end;
  end;

  SetItem(SrcList, Index);
end;

procedure TfrmSortColumn.ExcludeBtnClick(Sender: TObject);
var
  Index: Integer;
begin
  Index := GetFirstSelection(DstList);
  MoveSelected(DstList, SrcList.Items);
  SetItem(DstList, Index);
end;

procedure TfrmSortColumn.IncAllBtnClick(Sender: TObject);
var
  I: Integer;
begin
  for I := SrcList.Items.Count - 1 downto 1 do // at least one item left
  begin
    DstList.Items.AddObject(SrcList.Items[I],
      SrcList.Items.Objects[I]);
    SrcList.Items.Delete(I);
  end;
  SetItem(SrcList, 1);
end;

procedure TfrmSortColumn.ExcAllBtnClick(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to DstList.Items.Count - 1 do
    SrcList.Items.AddObject(DstList.Items[I], DstList.Items.Objects[I]);
  DstList.Items.Clear;
  SetItem(DstList, 0);
end;

procedure TfrmSortColumn.MoveSelected(List: TCustomListBox; Items: TStrings);
var
  I: Integer;
begin
  for I := List.Items.Count - 1 downto 0 do
    if List.Selected[I] then
    begin
      Items.AddObject(List.Items[I], List.Items.Objects[I]);
      List.Items.Delete(I);
    end;
end;

procedure TfrmSortColumn.SetButtons;
var
  SrcEmpty, DstEmpty: Boolean;
begin
  SrcEmpty := SrcList.Items.Count = 0;
  DstEmpty := DstList.Items.Count = 0;
  IncludeBtn.Enabled := not SrcEmpty;
  IncAllBtn.Enabled := not SrcEmpty;
  ExcludeBtn.Enabled := not DstEmpty;
  ExAllBtn.Enabled := not DstEmpty;
end;

function TfrmSortColumn.GetFirstSelection(List: TCustomListBox): Integer;
begin
  for Result := 0 to List.Items.Count - 1 do
    if List.Selected[Result] then Exit;
  Result := LB_ERR;
end;

procedure TfrmSortColumn.SetItem(List: TListBox; Index: Integer);
var
  MaxIndex: Integer;
begin
  with List do
  begin
    SetFocus;
    MaxIndex := List.Items.Count - 1;
    if Index = LB_ERR then Index := 0
    else if Index > MaxIndex then Index := MaxIndex;
    Selected[Index] := True;
  end;
  SetButtons;
end;

function TfrmSortColumn.GetTitles: TStrings;
begin
  Result :=  SrcList.Items;
end;

procedure TfrmSortColumn.SetTitles(const Value: TStrings);
begin
  DstList.Items.Clear;
  SrcList.Items.Clear;

  SrcList.Items.AddStrings(Value);
end;

end.
