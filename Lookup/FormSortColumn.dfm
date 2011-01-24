object frmSortColumn: TfrmSortColumn
  Left = 250
  Top = 108
  BorderStyle = bsDialog
  Caption = 'Include/ Exclude Columns'
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
    Caption = 'Include Column:'
  end
  object DstLabel: TLabel
    Left = 192
    Top = 8
    Width = 145
    Height = 16
    AutoSize = False
    Caption = 'Exclude Column:'
  end
  object IncludeBtn: TSpeedButton
    Left = 160
    Top = 32
    Width = 24
    Height = 24
    Caption = '>'
    OnClick = IncludeBtnClick
  end
  object IncAllBtn: TSpeedButton
    Left = 160
    Top = 64
    Width = 24
    Height = 24
    Caption = '>>'
    OnClick = IncAllBtnClick
  end
  object ExcludeBtn: TSpeedButton
    Left = 160
    Top = 96
    Width = 24
    Height = 24
    Caption = '<'
    Enabled = False
    OnClick = ExcludeBtnClick
  end
  object ExAllBtn: TSpeedButton
    Left = 160
    Top = 128
    Width = 24
    Height = 24
    Caption = '<<'
    Enabled = False
    OnClick = ExcAllBtnClick
  end
  object OKBtn: TButton
    Left = 5
    Top = 220
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object CancelBtn: TButton
    Left = 85
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
    Width = 144
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
    Left = 192
    Top = 24
    Width = 144
    Height = 185
    ItemHeight = 13
    MultiSelect = True
    TabOrder = 1
  end
end
