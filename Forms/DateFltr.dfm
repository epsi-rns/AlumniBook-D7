object DateFilter: TDateFilter
  Left = 177
  Top = 134
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Specify Filter'
  ClientHeight = 287
  ClientWidth = 270
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object OkBtn: TBitBtn
    Left = 8
    Top = 256
    Width = 75
    Height = 25
    Caption = '&OK'
    TabOrder = 0
    Kind = bkOK
  end
  object CancelBtn: TBitBtn
    Left = 88
    Top = 256
    Width = 75
    Height = 25
    Caption = '&Cancel'
    TabOrder = 1
    Kind = bkCancel
  end
  object GroupBox: TGroupBox
    Left = 8
    Top = 8
    Width = 257
    Height = 89
    Caption = 'Date ranging '
    TabOrder = 2
    object Label1: TLabel
      Left = 12
      Top = 23
      Width = 23
      Height = 13
      Caption = '&From'
    end
    object Label2: TLabel
      Left = 12
      Top = 55
      Width = 13
      Height = 13
      Caption = '&To'
    end
    object FromDate: TDateTimePicker
      Left = 38
      Top = 20
      Width = 211
      Height = 21
      Date = 0.500000000000000000
      Time = 0.500000000000000000
      ShowCheckbox = True
      DateFormat = dfLong
      TabOrder = 0
      OnCloseUp = DateCloseUp
    end
    object ToDate: TDateTimePicker
      Left = 38
      Top = 52
      Width = 211
      Height = 21
      Date = 0.500000000000000000
      Time = 0.500000000000000000
      ShowCheckbox = True
      DateFormat = dfLong
      TabOrder = 1
      OnCloseUp = DateCloseUp
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 104
    Width = 257
    Height = 145
    Caption = 'Use Criteria '
    TabOrder = 3
    object Label3: TLabel
      Left = 8
      Top = 72
      Width = 62
      Height = 13
      Caption = 'Select period'
    end
    object Label4: TLabel
      Left = 8
      Top = 48
      Width = 65
      Height = 13
      Caption = 'Between past'
    end
    object Label5: TLabel
      Left = 136
      Top = 48
      Width = 22
      Height = 13
      Caption = 'days'
    end
    object Label6: TLabel
      Left = 8
      Top = 24
      Width = 30
      Height = 13
      Caption = 'Within'
    end
    object Label7: TLabel
      Left = 8
      Top = 120
      Width = 29
      Height = 13
      Caption = 'Week'
    end
    object Label8: TLabel
      Left = 136
      Top = 120
      Width = 75
      Height = 13
      Caption = 'of selected year'
    end
    object Label9: TLabel
      Left = 8
      Top = 96
      Width = 29
      Height = 13
      Caption = 'Week'
    end
    object Label10: TLabel
      Left = 136
      Top = 96
      Width = 84
      Height = 13
      Caption = 'of selected month'
    end
    object PeriodBox: TComboBox
      Left = 80
      Top = 64
      Width = 113
      Height = 21
      AutoDropDown = True
      AutoCloseUp = True
      Style = csDropDownList
      DropDownCount = 12
      ItemHeight = 13
      TabOrder = 0
      OnSelect = PeriodBoxSelect
      Items.Strings = (
        'The whole year'
        'January'
        'February'
        'March'
        'April'
        'May'
        'June'
        'July'
        'August'
        'September'
        'October'
        'November'
        'December'
        'Q1 (First Quarter)'
        'Q2 (Second Quarter)'
        'Q3 (Third Quarter)'
        'Q4 (Fourth Quarter)')
    end
    object SpinDay: TSpinEdit
      Left = 80
      Top = 40
      Width = 49
      Height = 22
      MaxLength = 3
      MaxValue = 365
      MinValue = 1
      TabOrder = 1
      Value = 7
      OnChange = SpinDayChange
    end
    object WithinBox: TComboBox
      Left = 80
      Top = 16
      Width = 169
      Height = 21
      AutoDropDown = True
      AutoCloseUp = True
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 2
      OnSelect = WithinBoxSelect
      Items.Strings = (
        'Today'
        'Current Week'
        'Current Month'
        'Current Year'
        'Yesterday'
        'Last Week'
        'Last Month'
        'Last Year')
    end
    object SpinWeekYear: TSpinEdit
      Left = 80
      Top = 112
      Width = 49
      Height = 22
      MaxLength = 2
      MaxValue = 52
      MinValue = 1
      TabOrder = 3
      Value = 1
      OnChange = SpinWeekYearChange
    end
    object SpinWeekMonth: TSpinEdit
      Left = 80
      Top = 88
      Width = 49
      Height = 22
      MaxLength = 2
      MaxValue = 4
      MinValue = 1
      TabOrder = 4
      Value = 1
      OnChange = SpinWeekMonthChange
    end
    object SpinYear: TSpinEdit
      Left = 200
      Top = 64
      Width = 49
      Height = 22
      MaxLength = 4
      MaxValue = 2100
      MinValue = 1980
      TabOrder = 5
      Value = 2005
      OnChange = PeriodBoxSelect
    end
  end
end
