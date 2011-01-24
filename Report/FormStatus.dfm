object frmStatus: TfrmStatus
  Left = 265
  Top = 243
  Cursor = crHourGlass
  BorderIcons = [biMinimize, biMaximize]
  BorderStyle = bsToolWindow
  Caption = 'Report Status'
  ClientHeight = 45
  ClientWidth = 292
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 91
    Height = 13
    Caption = 'Please be patient...'
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 26
    Width = 292
    Height = 19
    Panels = <>
  end
  object ProgressBar: TProgressBar
    Left = 0
    Top = 8
    Width = 289
    Height = 16
    Step = 1
    TabOrder = 1
  end
end
