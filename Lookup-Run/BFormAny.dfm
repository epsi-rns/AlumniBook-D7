inherited BrowseMisc: TBrowseMisc
  Left = 195
  Top = 272
  Caption = 'Browse Miscellanous'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited PanelBtm: TPanel
    inherited DBNav: TDBNavigator
      Hints.Strings = ()
    end
  end
  inherited DBGrid: TDBGrid
    Hint = 'Browse Miscellanous'
  end
  inherited CoolBar: TCoolBar
    inherited PanelFilter: TPanel [0]
    end
    inherited PanelFind: TPanel [1]
    end
    inherited PanelExport: TPanel [3]
    end
    inherited PanelSelect: TPanel [4]
      object sbChart: TSpeedButton [1]
        Left = 264
        Top = 0
        Width = 73
        Height = 25
        Caption = 'Chart'
        Flat = True
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          1800000000000003000000000000000000000000000000000000FF00FF000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000FF00FF000000EFCE8CA5635AA5635AA5635A000000F0
          FBFF9B8B6C9B8B6C9B8B6C000000FFF7DE007B7B007B7B007B7BFF00FF000000
          EFCE8CCEA58CCEA58CA5635A000000FFF7DEF7EFD6F7EFD69B8B6C000000F0FB
          FF00FFFF00FFFF007B7BFF00FF000000EFCE8CCEA58CCEA58CA5635A000000F0
          FBFFF7EFD6F7EFD69B8B6C000000FFF7DE00FFFF00FFFF007B7BFF00FF000000
          EFCE8CCEA58CCEA58CA5635A000000FFF7DEF0FBFFFFF7DE9B8B6C000000F0FB
          FF00FFFF00FFFF007B7BFF00FF000000EFCE8CCEA58CCEA58CA5635A00000000
          0000000000000109000109000109FFF7DE00FFFF00FFFF007B7BFF00FF000000
          EFCE8CCEA58CCEA58CA5635A000000FF00FFFF00FF00010973A1BD000109F0FB
          FF00FFFF00FFFF007B7BFF00FF000000EFCE8CCEA58CCEA58CA5635A000000FF
          00FFFF00FF00010973A1BD000109FFFFFFFFF7DEFFFFFF007B7BFF00FF000000
          EFCE8CCEA58CCEA58CA5635A000000FF00FFFF00FF00010973A1BD0001090001
          09000109000000000000FF00FF000000EFCE8CCEA58CCEA58CA5635A000000FF
          00FFFF00FF00010973A1BD0000FF0000FF363A38000109FF00FFFF00FF000000
          EFCE8CCEA58CCEA58CA5635A000000FF00FFFF00FF000109C0C0C00000FF0000
          FF0000BF000000FF00FFFF00FF000000EFCE8CCEA58CCEA58CA5635A000000FF
          00FFFF00FF00000073A1BD73A1BDC0C0C00000BF000000FF00FFFF00FF000000
          EFCE8CCEA58CCEA58CA5635A000000FF00FFFF00FF0000000000000000000000
          00000000000000FF00FFFF00FF000000EFCE8CEFCE8CEFCE8CA5635A000000FF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000
          000000000000000000000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        OnClick = sbChartClick
      end
      inherited ChooseQueryBox: TComboBox
        DropDownCount = 12
      end
    end
  end
end