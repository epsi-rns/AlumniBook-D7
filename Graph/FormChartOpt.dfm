object frmChartOptions: TfrmChartOptions
  Left = 395
  Top = 416
  BorderStyle = bsDialog
  Caption = 'Chart Options'
  ClientHeight = 174
  ClientWidth = 384
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label6: TLabel
    Left = 208
    Top = 40
    Width = 25
    Height = 13
    Caption = 'Back'
  end
  object Label7: TLabel
    Left = 208
    Top = 64
    Width = 36
    Height = 13
    Caption = 'Legend'
  end
  object Label4: TLabel
    Left = 208
    Top = 144
    Width = 13
    Height = 13
    Caption = 'To'
  end
  object Label5: TLabel
    Left = 208
    Top = 120
    Width = 23
    Height = 13
    Caption = 'From'
  end
  object Label3: TLabel
    Left = 8
    Top = 48
    Width = 33
    Height = 13
    Caption = 'Pointer'
  end
  object Label2: TLabel
    Left = 8
    Top = 80
    Width = 42
    Height = 13
    Caption = 'Bar Style'
  end
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 24
    Height = 13
    Caption = 'Mark'
  end
  object cb3D: TCheckBox
    Left = 208
    Top = 13
    Width = 65
    Height = 13
    Caption = '3D View'
    Checked = True
    State = cbChecked
    TabOrder = 0
  end
  object bkColor: TColorBox
    Left = 256
    Top = 33
    Width = 120
    Height = 22
    DefaultColorColor = clWindow
    Selected = clCream
    ItemHeight = 16
    TabOrder = 1
  end
  object lgColor: TColorBox
    Left = 255
    Top = 57
    Width = 120
    Height = 22
    DefaultColorColor = clWindow
    Selected = clMoneyGreen
    ItemHeight = 16
    TabOrder = 2
  end
  object cbGradient: TCheckBox
    Left = 207
    Top = 93
    Width = 65
    Height = 13
    Caption = 'Gradient'
    Checked = True
    State = cbChecked
    TabOrder = 3
  end
  object stColor: TColorBox
    Left = 255
    Top = 112
    Width = 120
    Height = 22
    DefaultColorColor = clWindow
    Selected = clInactiveCaption
    ItemHeight = 16
    TabOrder = 4
  end
  object ndColor: TColorBox
    Left = 255
    Top = 137
    Width = 120
    Height = 22
    DefaultColorColor = clWindow
    Selected = clGradientInactiveCaption
    ItemHeight = 16
    TabOrder = 5
  end
  object cbPointStyle: TComboBox
    Left = 56
    Top = 41
    Width = 132
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 2
    TabOrder = 6
    Text = 'Triangle'
    Items.Strings = (
      'Rectangle'
      'Circle'
      'Triangle'
      'DownTriangle'
      'Cross'
      'DiagCross'
      'Star')
  end
  object cbBarStyle: TComboBox
    Left = 55
    Top = 73
    Width = 132
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 1
    TabOrder = 7
    Text = 'Pyramid'
    Items.Strings = (
      'Rectangle'
      'Pyramid'
      'Invert Pyramid'
      'Cylinder'
      'Ellipse'
      'Arrow')
  end
  object cbMark: TComboBox
    Left = 56
    Top = 9
    Width = 132
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 3
    TabOrder = 8
    Text = 'Label'
    Items.Strings = (
      'None'
      'Value'
      'Percent'
      'Label'
      'Label and Percent'
      'Label and Value'
      'Legend'
      'Percent Total'
      'Label and Percent Total'
      'XValue')
  end
  object BitBtn1: TBitBtn
    Left = 96
    Top = 136
    Width = 75
    Height = 25
    TabOrder = 9
    Kind = bkClose
  end
  object BitBtn2: TBitBtn
    Left = 8
    Top = 136
    Width = 75
    Height = 25
    Caption = '&Apply'
    TabOrder = 10
    OnClick = BitBtn2Click
    Kind = bkYes
  end
end
