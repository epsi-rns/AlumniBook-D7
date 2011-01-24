object frmOrdering: TfrmOrdering
  Left = 501
  Top = 101
  BorderStyle = bsDialog
  Caption = 'Specify Ordering'
  ClientHeight = 255
  ClientWidth = 345
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object SrcLabel: TLabel
    Left = 8
    Top = 8
    Width = 145
    Height = 16
    AutoSize = False
    Caption = 'Source List:'
  end
  object DstLabel: TLabel
    Left = 192
    Top = 8
    Width = 145
    Height = 16
    AutoSize = False
    Caption = 'Destination List:'
  end
  object IncludeBtn: TSpeedButton
    Left = 152
    Top = 32
    Width = 41
    Height = 24
    Caption = 'Asc >'
    OnClick = IncludeAscBtnClick
  end
  object IncAllBtn: TSpeedButton
    Left = 152
    Top = 64
    Width = 41
    Height = 24
    Caption = 'Desc >'
    OnClick = IncludeDescBtnClick
  end
  object ExcludeBtn: TSpeedButton
    Left = 152
    Top = 96
    Width = 41
    Height = 24
    Caption = '<'
    Enabled = False
    OnClick = ExcludeBtnClick
  end
  object ExAllBtn: TSpeedButton
    Left = 152
    Top = 128
    Width = 41
    Height = 24
    Caption = '<<'
    Enabled = False
    OnClick = ExcAllBtnClick
  end
  object OKBtn: TButton
    Left = 13
    Top = 220
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object CancelBtn: TButton
    Left = 93
    Top = 220
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
    Visible = False
  end
  object SrcList: TListBox
    Left = 8
    Top = 24
    Width = 137
    Height = 185
    ItemHeight = 13
    Items.Strings = (
      'Item1'
      'Item2'
      'Item3'
      'Item4'
      'Item5')
    MultiSelect = True
    TabOrder = 0
  end
  object DstList: TListBox
    Left = 200
    Top = 24
    Width = 136
    Height = 185
    ItemHeight = 13
    MultiSelect = True
    TabOrder = 1
  end
end
