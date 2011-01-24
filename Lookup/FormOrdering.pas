unit FormOrdering;

interface

uses 
  Windows, Messages, SysUtils, Classes, Graphics, Forms, Dialogs, Controls, StdCtrls, 
  Buttons;

type
  TfrmOrdering = class(TForm)
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
    procedure IncludeAscBtnClick(Sender: TObject);
    procedure IncludeDescBtnClick(Sender: TObject);
    procedure ExcludeBtnClick(Sender: TObject);
    procedure IncAllBtnClick(Sender: TObject);
    procedure ExcAllBtnClick(Sender: TObject);
  private
    function GetSortBy: TStrings;
    procedure SetSortBy(const Value: TStrings);
    { Private declarations }
  public
    { Public declarations }
    procedure MoveSelected(List: TCustomListBox; Items: TStrings);
    procedure SetItem(List: TListBox; Index: Integer);
    function GetFirstSelection(List: TCustomListBox): Integer;
    function IsEmpty: Boolean;
    procedure SetButtons;
    property SortBy: TStrings read GetSortBy write SetSortBy;
  end;

var
  frmOrdering: TfrmOrdering;

implementation

{$R *.dfm}



function TfrmOrdering.IsEmpty: Boolean;
begin
  Result := DstList.Items.Count = 0;
end;

procedure TfrmOrdering.IncludeAscBtnClick(Sender: TObject);
var
  I, Index: Integer;
begin
  Index := GetFirstSelection(SrcList);

  for I := SrcList.Items.Count - 1 downto 0 do
    if SrcList.Selected[I] then
    begin
      DstList.Items.Append(SrcList.Items.Strings[I]+'=Asc');
      SrcList.Items.Delete(I);
    end;

  SetItem(SrcList, Index);
end;

procedure TfrmOrdering.IncludeDescBtnClick(Sender: TObject);
var
  I, Index: Integer;
begin
  Index := GetFirstSelection(SrcList);

  for I := SrcList.Items.Count - 1 downto 0 do
    if SrcList.Selected[I] then
    begin
      DstList.Items.Append(SrcList.Items.Strings[I]+'=Desc');
      SrcList.Items.Delete(I);
    end;

  SetItem(SrcList, Index);
end;

procedure TfrmOrdering.IncAllBtnClick(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to SrcList.Items.Count - 1 do
    DstList.Items.AddObject(SrcList.Items[I], 
      SrcList.Items.Objects[I]);
  SrcList.Items.Clear;
  SetItem(SrcList, 0);
end;

procedure TfrmOrdering.ExcludeBtnClick(Sender: TObject);
var
  I, Index: Integer;
begin
  Index := GetFirstSelection(DstList);

  for I := DstList.Items.Count - 1 downto 0 do
    if DstList.Selected[I] then
    begin
      SrcList.Items.Append(DstList.Items.Names[I]);
      DstList.Items.Delete(I);
    end;

  SetItem(DstList, Index);
end;

procedure TfrmOrdering.ExcAllBtnClick(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to DstList.Items.Count - 1 do
    SrcList.Items.Append(DstList.Items.Names[I]);

  DstList.Items.Clear;
  SetItem(DstList, 0);
end;

procedure TfrmOrdering.MoveSelected(List: TCustomListBox; Items: TStrings);
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

procedure TfrmOrdering.SetButtons;
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

function TfrmOrdering.GetFirstSelection(List: TCustomListBox): Integer;
begin
  for Result := 0 to List.Items.Count - 1 do
    if List.Selected[Result] then Exit;
  Result := LB_ERR;
end;

procedure TfrmOrdering.SetItem(List: TListBox; Index: Integer);
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

function TfrmOrdering.GetSortBy: TStrings;
begin
  Result := DstList.Items;
end;

procedure TfrmOrdering.SetSortBy(const Value: TStrings);
var
  I: Integer;
begin
  DstList.Items.Clear;
  SrcList.Items.Clear;
  SrcList.Items.AddStrings(Value);

  // Delete all item with comma (more than one ordering)
  for I := SrcList.Items.Count - 1 downto 0 do
    if Pos(',', SrcList.Items[I]) > 0 then
      SrcList.Items.Delete(I);
end;

end.
