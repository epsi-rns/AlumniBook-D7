object frmLookup: TfrmLookup
  Left = 209
  Top = 124
  Width = 658
  Height = 450
  Caption = 'Lookup'
  Color = clBtnFace
  Constraints.MinHeight = 200
  Constraints.MinWidth = 450
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PanelBtm: TPanel
    Left = 0
    Top = 366
    Width = 650
    Height = 31
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      650
      31)
    object BtnSelect: TBitBtn
      Left = 8
      Top = 3
      Width = 75
      Height = 25
      Anchors = [akLeft, akBottom]
      TabOrder = 0
      OnClick = BtnSelectClick
      Kind = bkClose
    end
    object BtnCancel: TBitBtn
      Left = 88
      Top = 3
      Width = 75
      Height = 25
      Anchors = [akLeft, akBottom]
      TabOrder = 1
      Kind = bkHelp
    end
    object DBNav: TDBNavigator
      Left = 168
      Top = 3
      Width = 468
      Height = 25
      DataSource = dsLookup
      VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
      Anchors = [akLeft, akTop, akRight]
      Flat = True
      TabOrder = 2
    end
  end
  object DBGrid: TDBGrid
    Left = 0
    Top = 152
    Width = 650
    Height = 214
    Hint = 'Query Browser'
    Align = alClient
    Color = clCream
    Ctl3D = True
    DataSource = dsLookup
    FixedColor = clMoneyGreen
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = [fsBold]
    OnDrawColumnCell = DBGridDrawColumnCell
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 397
    Width = 650
    Height = 19
    Panels = <>
  end
  object CoolBar: TCoolBar
    Left = 0
    Top = 0
    Width = 650
    Height = 152
    Bands = <
      item
        Control = PanelSelect
        ImageIndex = -1
        Text = 'Select Query'
        Width = 646
      end
      item
        Control = PanelExport
        ImageIndex = -1
        MinHeight = 40
        Text = 'Export'
        Width = 646
      end
      item
        Control = PanelContent
        ImageIndex = -1
        Text = 'Content'
        Width = 646
      end
      item
        Control = PanelFind
        ImageIndex = -1
        Text = 'Search'
        Width = 646
      end
      item
        Control = PanelFilter
        ImageIndex = -1
        Text = 'Filter'
        Width = 646
      end>
    object PanelSelect: TPanel
      Left = 74
      Top = 0
      Width = 568
      Height = 25
      BevelOuter = bvNone
      TabOrder = 0
      object sbApply: TSpeedButton
        Left = 184
        Top = 0
        Width = 73
        Height = 25
        Caption = 'Apply'
        Flat = True
        Glyph.Data = {
          76050000424D7605000000000000360400002800000011000000100000000100
          08000000000040010000220B0000220B00000001000000010000000000000000
          BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000C0DCC000F0CA
          A600FFFFFF00DFFFFF00B5FFFF00FFFFD500FFF7DE00F7EFD600E7E7E700F7EF
          CE009AEBF700FFEFC600EFE7CE0059EFF500FFE9BD00DEDEDE00FBE2C800FFEB
          AF0000F1FF00D6DADA00EFDEC600E7DEC600FCDEBD00EFDEBD00FFDEB500E7DE
          BD00DED6CE00F7DFB200FFDEAD00C7D7CF00F7D6BD00E7D6BD00FFDF9F00FFD6
          AD00E7D6B500F7D6AD00E7D6AD00FCD6A500DECEBD0029CEFF00F0CEB500D6D6
          AD00FED69C00D6D6A500F7CEA500C6C6C600DECEAD00D6CEAD00EFD69400FFCE
          9C00F7CE9C00E5C1BB00FFCE9400F7CE9400B5CCAE00D6C6AD00EFCE9400FFCE
          8C00CECE9C00F7C69C00F7CE8C00EFC69C00D6C6A500EFCE8C00E7C79C00F7C6
          9400EFC69400FFC68C00CEBDAD00F7C68C00D6BDA500FFC68400BDBDAD00E7BD
          9C00F7C68400F7BD9400DEBD9800CEB5AD00E7BD9400CEBD9C00F7C67B00EFBD
          8C00B5B5AD00E7BC8C00F7BD8400DEBD8C00EFBD8400D6B59C00E7BD8400CEB5
          9C00F7BD7B00C6B59C00BDADAD00EFBD7B00E7BD7B00DEB58C00C6B59400EFB5
          8400D6B58B00FFC65A00E7B58400DEB58400EFB57B00E7B57B00C6AD9400DEB5
          7B00EFB57300BDAD9400E7B57300B5AD9400D6AD8700DEAD8400C6A59C00F0AD
          7B00A5A5A500CEAD8600BDAD8C0073A1BD00DEAD7B00D6AD7B00E9AD7300CEA5
          8C00CE9C9C00DEAD7300D6AD7200E7AD6B00B5A58C00DEAD6B00D6A57B00E7AD
          6300E7A57200CEA57B0030D45800DEA57400D6A57300DEA56B00C6A57300CEA5
          7000D6A56B00C69D7C00CE9C7B00DFA56200D6A56300D69C7200CE9C7300B59C
          7B00C69C7300AD9C7B00A59C7B00CE9C6B00068ECE00C69C6B00BD8C8C00D69C
          6300CE9C6300C6947300C69C6300B58E8100D49C5A00CE946B008D8D9000C694
          6B00C69C5A00CE946300C6946300B4906E00CE945A008B8B8400C68C6B00C694
          5A00BD945A00CC945200C68C6300D68C5A00BD8C6300CE8C5A00B58C63009B8B
          6C00C68C5A00BD8C5A00CE8C5200B58C5A00C68C5200C68C4A00BD845A00B584
          5A00AD845A00BD855200B58652007B7B7B00C6844C009C7B6B00A57B6100AD7A
          5F00BD8443008C7B6300B57B5200A87B5200BD7B4A00987B5300AD7B4A00F976
          2D00007B7B00AD734A00AE764200A5734A00A56363009C636300A5635A009A6C
          4A007B6C5500447256009C6B4200AD6B36009469420073634A009C6339009463
          3900736342008D6E1B008D593400845A29004A4A52008C522900845229006E4C
          3B00A05807000809D700363A3800843C07004A3921006B2110007B0039006B0A
          0000380F05008D0000007B00000000010900F0FBFF00A4A0A000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00360000F5F5F5
          000000000000000000000000000036009ED29ED2030EB9B9B9B90EB9B9B90000
          00003600121A1A1A9E0E0F0F0FB9F60F0FB9000000003600121A1A1AD20A0F0F
          0FB90E0F0FB9000000003600121A1A1A9E0E0F0F0FB9F60F0FB9000000003600
          121A1A1AD20A0F0F0FB90E0F0FB9000000003600121A1A1A9E0F0F0F0FB9F60F
          0FB9000000003600121A1A1A030E0F0F0FB90E0F0FB9000000003600121A1A1A
          D20A0F0F0FB9F60F0FB9000000003600121212129E0E0E0A0EB90E0A0EB90000
          00003600EAEAEAEAEA44EAEAEAEA44EAEAEA00000000360047C3C3C3EA47C3C3
          C3EA47C3C3EA00000000360047C3C3C3EA44C3C3C3EA44C3C3EA000000003600
          4747474747474747474747474747000000003600000000000000000000000000
          0000000000003636363636363636363636363636363636000000}
        OnClick = BtnApplyClick
      end
      object ChooseQueryBox: TComboBox
        Left = 8
        Top = 2
        Width = 169
        Height = 21
        ItemHeight = 13
        TabOrder = 0
        OnChange = ChooseQueryBoxChange
      end
    end
    object PanelExport: TPanel
      Left = 43
      Top = 27
      Width = 599
      Height = 40
      BevelOuter = bvNone
      TabOrder = 1
      object Label3: TLabel
        Left = 8
        Top = 4
        Width = 53
        Height = 13
        Caption = 'Destination'
      end
      object sbExport: TSpeedButton
        Left = 464
        Top = 8
        Width = 73
        Height = 25
        Caption = 'Export'
        Flat = True
        Glyph.Data = {
          76050000424D7605000000000000360400002800000011000000100000000100
          08000000000040010000220B0000220B00000001000000010000000000000000
          BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000C0DCC000F0CA
          A600FFFFFF00DFFFFF00B5FFFF00FFFFD500FFF7DE00F7EFD600E7E7E700F7EF
          CE009AEBF700FFEFC600EFE7CE0059EFF500FFE9BD00DEDEDE00FBE2C800FFEB
          AF0000F1FF00D6DADA00EFDEC600E7DEC600FCDEBD00EFDEBD00FFDEB500E7DE
          BD00DED6CE00F7DFB200FFDEAD00C7D7CF00F7D6BD00E7D6BD00FFDF9F00FFD6
          AD00E7D6B500F7D6AD00E7D6AD00FCD6A500DECEBD0029CEFF00F0CEB500D6D6
          AD00FED69C00D6D6A500F7CEA500C6C6C600DECEAD00D6CEAD00EFD69400FFCE
          9C00F7CE9C00E5C1BB00FFCE9400F7CE9400B5CCAE00D6C6AD00EFCE9400FFCE
          8C00CECE9C00F7C69C00F7CE8C00EFC69C00D6C6A500EFCE8C00E7C79C00F7C6
          9400EFC69400FFC68C00CEBDAD00F7C68C00D6BDA500FFC68400BDBDAD00E7BD
          9C00F7C68400F7BD9400DEBD9800CEB5AD00E7BD9400CEBD9C00F7C67B00EFBD
          8C00B5B5AD00E7BC8C00F7BD8400DEBD8C00EFBD8400D6B59C00E7BD8400CEB5
          9C00F7BD7B00C6B59C00BDADAD00EFBD7B00E7BD7B00DEB58C00C6B59400EFB5
          8400D6B58B00FFC65A00E7B58400DEB58400EFB57B00E7B57B00C6AD9400DEB5
          7B00EFB57300BDAD9400E7B57300B5AD9400D6AD8700DEAD8400C6A59C00F0AD
          7B00A5A5A500CEAD8600BDAD8C0073A1BD00DEAD7B00D6AD7B00E9AD7300CEA5
          8C00CE9C9C00DEAD7300D6AD7200E7AD6B00B5A58C00DEAD6B00D6A57B00E7AD
          6300E7A57200CEA57B0030D45800DEA57400D6A57300DEA56B00C6A57300CEA5
          7000D6A56B00C69D7C00CE9C7B00DFA56200D6A56300D69C7200CE9C7300B59C
          7B00C69C7300AD9C7B00A59C7B00CE9C6B00068ECE00C69C6B00BD8C8C00D69C
          6300CE9C6300C6947300C69C6300B58E8100D49C5A00CE946B008D8D9000C694
          6B00C69C5A00CE946300C6946300B4906E00CE945A008B8B8400C68C6B00C694
          5A00BD945A00CC945200C68C6300D68C5A00BD8C6300CE8C5A00B58C63009B8B
          6C00C68C5A00BD8C5A00CE8C5200B58C5A00C68C5200C68C4A00BD845A00B584
          5A00AD845A00BD855200B58652007B7B7B00C6844C009C7B6B00A57B6100AD7A
          5F00BD8443008C7B6300B57B5200A87B5200BD7B4A00987B5300AD7B4A00F976
          2D00007B7B00AD734A00AE764200A5734A00A56363009C636300A5635A009A6C
          4A007B6C5500447256009C6B4200AD6B36009469420073634A009C6339009463
          3900736342008D6E1B008D593400845A29004A4A52008C522900845229006E4C
          3B00A05807000809D700363A3800843C07004A3921006B2110007B0039006B0A
          0000380F05008D0000007B00000000010900F0FBFF00A4A0A000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0036362AB90000
          B9362C362CB90000B92C360000003636B9000E8200ADB9B9B900F68100B9B900
          000036F5F5F5F60E0000000000000EF600000000000036F57DF2F5F200EBF9F9
          F900F200F2EB0000000036F57DEBEBEBEBF9F9F9F9EBEBEBEBEB000000003600
          7D7D7D7D7D7D7D7D7D7D7D7D7D7DF50000003600000000000000000000000000
          00003600000036000B0C120B1212127D0082810E00363600000036000B120B12
          1212127D00810EF600363600000036000B0B120B1212127D0000000036363600
          000036000B120B121212127D00B92C3636363600000036000B0C120B1212127D
          00B9363636363600000036000B120C121212127D00B92C363636360000003600
          0B0B0B0B0B0B0B0B003636363636360000003636000000000000000036363636
          3636360000003636363636363636363636363636363636000000}
        OnClick = BtnExportClick
      end
      object Label4: TLabel
        Left = 96
        Top = 4
        Width = 31
        Height = 13
        Caption = 'Which'
      end
      object Label5: TLabel
        Left = 224
        Top = 4
        Width = 67
        Height = 13
        Caption = 'Split output by'
      end
      object Label6: TLabel
        Left = 344
        Top = 4
        Width = 101
        Height = 13
        Caption = 'Group row by (sorted)'
      end
      object cbExport: TComboBox
        Left = 8
        Top = 18
        Width = 81
        Height = 21
        ItemHeight = 13
        ItemIndex = 3
        TabOrder = 0
        Text = 'Calc'
        Items.Strings = (
          'HTML'
          'Excel'
          'Word'
          'Calc'
          'Writer')
      end
      object cbExportKind: TComboBox
        Left = 96
        Top = 18
        Width = 121
        Height = 21
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 1
        Text = 'This PlainTable'
        Items.Strings = (
          'This PlainTable'
          'All Tables')
      end
      object GroupViewBox: TComboBox
        Left = 224
        Top = 18
        Width = 113
        Height = 21
        ItemHeight = 13
        TabOrder = 2
      end
      object GroupRowBox: TComboBox
        Left = 344
        Top = 18
        Width = 113
        Height = 21
        ItemHeight = 13
        TabOrder = 3
      end
    end
    object PanelContent: TPanel
      Left = 50
      Top = 69
      Width = 592
      Height = 25
      BevelOuter = bvNone
      TabOrder = 2
      object sbOrdering: TSpeedButton
        Left = 337
        Top = 0
        Width = 73
        Height = 25
        Caption = 'Ordering'
        Flat = True
        Glyph.Data = {
          42010000424D4201000000000000760000002800000011000000110000000100
          040000000000CC00000000000000000000001000000010000000000000000000
          BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
          7777700000007770077770878787000000007777777770777777000000007770
          077770000000000000007770077770FFFFFF000000007770007770FFFFFF0000
          00007777700770FFFFFF000000007007700770000000000000007000000770FF
          FFFF000000007700007770FFFFFF000000007777777770FFFFFF000000007777
          747770000000000000007777744770FFFFFF000000007744444470FFFFFF0000
          00007777744770FFFFFF00000000777774777000000000000000777777777777
          777770000000}
        OnClick = BtnOrderingClick
      end
      object sbHeader: TSpeedButton
        Left = 0
        Top = 0
        Width = 73
        Height = 25
        Caption = 'Column'
        Flat = True
        Glyph.Data = {
          42010000424D4201000000000000760000002800000011000000110000000100
          040000000000CC00000000000000000000001000000010000000000000000000
          BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
          7777700000007777777747777777700000007777777444777777700000007777
          7744444777777000000077777777477777777000000077777777477777777000
          00007777770000077777700000007777770EFE077777700000007777770FEF07
          7777700000007777770EFE077777700000007777770FEF077777700000007700
          000EFE00000770000000770FFF0FEF0FFF0770000000770FFF0EFE0FFF077000
          0000770FFF0FEF0FFF0770000000777777777777777770000000777777777777
          777770000000}
        OnClick = BtnHeaderClick
      end
      object Label1: TLabel
        Left = 88
        Top = 6
        Width = 34
        Height = 13
        Caption = 'Sort By'
      end
      object SortbyBox: TComboBox
        Left = 128
        Top = 2
        Width = 113
        Height = 21
        ItemHeight = 13
        TabOrder = 0
      end
      object cbDesc: TCheckBox
        Left = 248
        Top = 6
        Width = 81
        Height = 17
        Caption = 'Descending'
        TabOrder = 1
      end
    end
    object PanelFilter: TPanel
      Left = 35
      Top = 123
      Width = 607
      Height = 25
      BevelOuter = bvNone
      TabOrder = 3
      object sbFilter: TSpeedButton
        Left = 16
        Top = 0
        Width = 73
        Height = 25
        Caption = 'Set Filter'
        Flat = True
        Glyph.Data = {
          36050000424D3605000000000000360400002800000010000000100000000100
          08000000000000010000220B0000220B00000001000000010000000000000000
          BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000C0DCC000F0CA
          A600FFFFFF00DFFFFF00B5FFFF00FFFFD500FFF7DE00F7EFD600E7E7E700F7EF
          CE009AEBF700FFEFC600EFE7CE0059EFF500FFE9BD00DEDEDE00FBE2C800FFEB
          AF0000F1FF00D6DADA00EFDEC600E7DEC600FCDEBD00EFDEBD00FFDEB500E7DE
          BD00DED6CE00F7DFB200FFDEAD00C7D7CF00F7D6BD00E7D6BD00FFDF9F00FFD6
          AD00E7D6B500F7D6AD00E7D6AD00FCD6A500DECEBD0029CEFF00F0CEB500D6D6
          AD00FED69C00D6D6A500F7CEA500C6C6C600DECEAD00D6CEAD00EFD69400FFCE
          9C00F7CE9C00E5C1BB00FFCE9400F7CE9400B5CCAE00D6C6AD00EFCE9400FFCE
          8C00CECE9C00F7C69C00F7CE8C00EFC69C00D6C6A500EFCE8C00E7C79C00F7C6
          9400EFC69400FFC68C00CEBDAD00F7C68C00D6BDA500FFC68400BDBDAD00E7BD
          9C00F7C68400F7BD9400DEBD9800CEB5AD00E7BD9400CEBD9C00F7C67B00EFBD
          8C00B5B5AD00E7BC8C00F7BD8400DEBD8C00EFBD8400D6B59C00E7BD8400CEB5
          9C00F7BD7B00C6B59C00BDADAD00EFBD7B00E7BD7B00DEB58C00C6B59400EFB5
          8400D6B58B00FFC65A00E7B58400DEB58400EFB57B00E7B57B00C6AD9400DEB5
          7B00EFB57300BDAD9400E7B57300B5AD9400D6AD8700DEAD8400C6A59C00F0AD
          7B00A5A5A500CEAD8600BDAD8C0073A1BD00DEAD7B00D6AD7B00E9AD7300CEA5
          8C00CE9C9C00DEAD7300D6AD7200E7AD6B00B5A58C00DEAD6B00D6A57B00E7AD
          6300E7A57200CEA57B0030D45800DEA57400D6A57300DEA56B00C6A57300CEA5
          7000D6A56B00C69D7C00CE9C7B00DFA56200D6A56300D69C7200CE9C7300B59C
          7B00C69C7300AD9C7B00A59C7B00CE9C6B00068ECE00C69C6B00BD8C8C00D69C
          6300CE9C6300C6947300C69C6300B58E8100D49C5A00CE946B008D8D9000C694
          6B00C69C5A00CE946300C6946300B4906E00CE945A008B8B8400C68C6B00C694
          5A00BD945A00CC945200C68C6300D68C5A00BD8C6300CE8C5A00B58C63009B8B
          6C00C68C5A00BD8C5A00CE8C5200B58C5A00C68C5200C68C4A00BD845A00B584
          5A00AD845A00BD855200B58652007B7B7B00C6844C009C7B6B00A57B6100AD7A
          5F00BD8443008C7B6300B57B5200A87B5200BD7B4A00987B5300AD7B4A00F976
          2D00007B7B00AD734A00AE764200A5734A00A56363009C636300A5635A009A6C
          4A007B6C5500447256009C6B4200AD6B36009469420073634A009C6339009463
          3900736342008D6E1B008D593400845A29004A4A52008C522900845229006E4C
          3B00A05807000809D700363A3800843C07004A3921006B2110007B0039006B0A
          0000380F05008D0000007B00000000010900F0FBFF00A4A0A000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00363636363636
          36B9B9B9B9363636363636363636363600000000B93636363636363636363636
          000EB900B93636363636363636363636000AB900B9B9B9B93636363636363636
          000EB900000000B9B936363636363636000AB900B9363600B936363636363636
          000EB900B9363600B936363636363636000AB900B9B9B9003636363636363600
          B90EB9B90000003636363636363600B90781B9DAB900B936363636363600B907
          8181B9B9DBB900B93636363600B90781818181B9B9DAF800B9363600B9078181
          818181B9B9B9DAB900B936000EF60EF60E0F0F070707070700B9360000000000
          0000000000000000003636363636363636363636363636363636}
        OnClick = BtnFilterClick
      end
    end
    object PanelFind: TPanel
      Left = 47
      Top = 96
      Width = 595
      Height = 25
      BevelOuter = bvNone
      TabOrder = 4
      object LocateBtn: TSpeedButton
        Left = 392
        Top = 0
        Width = 73
        Height = 25
        Caption = 'Locate'
        Flat = True
        Glyph.Data = {
          2E060000424D2E06000000000000360400002800000016000000150000000100
          080000000000F8010000890B0000890B00000001000000010000000000000000
          7F00007F0000007F7F007F0000007F007F007F7F0000BFBFBF007F7F7F000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00C0DCC000F0CA
          A600C6947300BD8B6A00B6866B00B5845B00A57B6300AD735A00A46C4A009C6B
          5A009C6249009B644200945A4900945A38008C5342008C5239008C533100844A
          39007B4239007B3928006B3221006B3118006329210063221800EFEFEF00DFDF
          DF00D3D3D300C3C3C300B7B7B700ABABAB009B9B9B008F8F8F007F7F7F007373
          730067676700575757004B4B4B003B3B3B002F2F2F00232323004F7FCA004A7A
          BF004570B500406AAA003F65A0003A609F00355F9000305A8A002F5080002A4F
          7500254A6F0020405F001F3F55001A3A4A001A304000152F3A00479DFC003895
          FC00278CFC001784FB000479FB000471E8000368D8000361C9000359B8000254
          AE000249970000408600003877000030640000275300001F4200DFEAFF00DFEA
          FF00D0E0FF00C5DAFF00BFD5FF00B0CFFF00A5C5FF009FBFFF0090BAFF0080B0
          FF0070A5FF00609FFF005F95F0005A8FEA00558ADF005080D000D8FCFC00B8FC
          FC009CFCFC007CFCFC005CF8FC0040F4FC0020F4FC0000F4FC0000D8E40000C4
          CC0000ACB400009C9C0000848400006C70000054580000404000D9ECF000ADD6
          DE0095CECE008CBDBD007BBDB50074A5A500499C94004A847B0031847300177B
          6C00316A590018635200295A4A00104938000718100005100B0000FF000000EF
          000000E3000000D7000000CB070000BF070000B3070000A70700009B0700008B
          0700007F07000073070000670700005B0700004F070000400400FFFFDA00FCFC
          B800FCFC9C00F8FC7C00FCFC5C00FCFC4000FCFC2000FCFC0000E4E40000CCCC
          0000B4B400009C9C000084840000707000005858000040400000F7D6B500EFCE
          A500EFC69400E8B68400E7A56300DEA46300DE944900CE7B3100BD743100BC73
          2900AC7B3900B66B21008B642100735117005242180042351300FFDAF000FFBA
          E500FF9FDA00FF7FD000FF5FCA00FF40BF00FF20B500FF00AA00E5009A00CF00
          8000B50075009F00600085005000700045005A00350040002A00E500E000CF00
          CA00B500B5009F009F008500850070006F005A005A00400040008A8AFF006666
          FF004040FF002020FF000000FF000000DF000000BF000000A70000009B000000
          8B0000007F00000073000000670000005B0000004F0000004000E7EFF700BDDE
          F700A5C6EF006BA5DE007BA5CE006394CE005284BD004273BD00315AAD004A63
          8C00315A94002942840029396300213163001829520021314A00F7E1B000EFC6
          6500CF981600A97B120079580D0059420B00F0FBFF00A4A0A000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF000000000000070707070707
          0707070707070707070707070707070700000707070707070707070707070707
          0707070707070707000007070707070707070707070707070707070707070707
          0000070707070707070707070707070707070707070707070000070707070000
          0707070707070707070707070707070700000707070700000007070707070707
          0707070707070707000007070707070000000707070707070707070707070707
          000007070707070700000007F800000000F80707070707070000070707070707
          0700000000F80707F8000007070707070000070707070707070700F807070707
          0707F80007070707000007070707070707F800070707070707070700F8070707
          00000707070707070700F80707070707070707F8000707070000070707070707
          070007070F070F070707070700070707000007070707070707000707070F070F
          070707070007070700000707070707070700F8070F0F0F070F0707F800070707
          000007070707070707F800070F0F0F0F07070700F80707070000070707070707
          070700F807070F070707F8000707070700000707070707070707070000F80707
          F800000707070707000007070707070707070707F800000000F8070707070707
          0000070707070707070707070707070707070707070707070000070707070707
          070707070707070707070707070707070000}
        OnClick = LocateBtnClick
      end
      object Label2: TLabel
        Left = 128
        Top = 6
        Width = 20
        Height = 13
        Caption = 'Find'
      end
      object FindEdit: TEdit
        Left = 152
        Top = 2
        Width = 121
        Height = 21
        TabOrder = 0
      end
      object FindFilter: TCheckBox
        Left = 288
        Top = 4
        Width = 97
        Height = 17
        Caption = 'Filter by Search'
        TabOrder = 1
        OnClick = FindFilterClick
      end
      object SearchByBox: TComboBox
        Left = 0
        Top = 2
        Width = 113
        Height = 21
        ItemHeight = 13
        TabOrder = 2
      end
    end
  end
  object qrLookup: TIBQuery
    Database = Data.Database
    Transaction = Data.txEntry
    BeforeOpen = qrLookupBeforeOpen
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      '')
    OnFilterRecord = qrLookupFilterRecord
    Left = 176
    Top = 152
  end
  object dsLookup: TDataSource
    DataSet = qrLookup
    Left = 176
    Top = 184
  end
end