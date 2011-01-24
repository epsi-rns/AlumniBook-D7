object frmEntryAlumni: TfrmEntryAlumni
  Left = 159
  Top = 61
  BorderStyle = bsDialog
  Caption = 'Alumni Detail Entry'
  ClientHeight = 508
  ClientWidth = 376
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PanelBtm: TPanel
    Left = 0
    Top = 477
    Width = 376
    Height = 31
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      376
      31)
    object SelectBtn: TBitBtn
      Left = 8
      Top = 3
      Width = 75
      Height = 25
      Anchors = [akLeft, akBottom]
      TabOrder = 0
      Kind = bkClose
    end
    object DBNavFilter: TDBNavigator
      Left = 88
      Top = 3
      Width = 112
      Height = 25
      DataSource = dmAl.dsCursor
      VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
      Anchors = [akLeft, akTop, akRight]
      Flat = True
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object DBNavAlumni: TDBNavigator
      Left = 200
      Top = 3
      Width = 168
      Height = 25
      DataSource = dsAlumni
      VisibleButtons = [nbInsert, nbDelete, nbEdit, nbPost, nbCancel, nbRefresh]
      Anchors = [akLeft, akTop, akRight]
      Flat = True
      ParentShowHint = False
      ConfirmDelete = False
      ShowHint = True
      TabOrder = 2
    end
  end
  object PanelTop: TPanel
    Left = 0
    Top = 0
    Width = 376
    Height = 31
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object Label12: TLabel
      Left = 8
      Top = 8
      Width = 7
      Height = 13
      Caption = '#'
    end
    object DBTextID: TDBText
      Left = 20
      Top = 8
      Width = 65
      Height = 17
      DataField = 'AID'
      DataSource = dsAlumni
    end
    object DBTextName: TDBText
      Left = 76
      Top = 8
      Width = 189
      Height = 17
      DataField = 'NAME'
      DataSource = dsAlumni
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsUnderline]
      ParentFont = False
    end
    object DBLastUpdate: TDBText
      Left = 256
      Top = 8
      Width = 113
      Height = 17
      DataField = 'LAST_UPDATE'
      DataSource = dsAlumni
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
  end
  object PageControl: TPageControl
    Left = 0
    Top = 31
    Width = 376
    Height = 446
    ActivePage = TabPersonal
    Align = alClient
    MultiLine = True
    Style = tsFlatButtons
    TabOrder = 2
    OnChange = PageControlChange
    OnChanging = PageControlChanging
    OnEnter = PageControlChange
    object TabPersonal: TTabSheet
      Caption = 'Alumni'
      object Label1: TLabel
        Left = 16
        Top = 24
        Width = 47
        Height = 13
        Caption = 'Full Name'
      end
      object Label2: TLabel
        Left = 16
        Top = 48
        Width = 20
        Height = 13
        Caption = 'Title'
      end
      object Label8: TLabel
        Left = 16
        Top = 96
        Width = 47
        Height = 13
        Caption = 'Birth Date'
      end
      object Label7: TLabel
        Left = 16
        Top = 120
        Width = 51
        Height = 13
        Caption = 'Birth Place'
      end
      object Label31: TLabel
        Left = 296
        Top = 96
        Width = 54
        Height = 13
        Caption = '(mm/dd/yy)'
      end
      object Label4: TLabel
        Left = 128
        Top = 48
        Width = 26
        Height = 13
        Caption = 'Prefix'
      end
      object Label5: TLabel
        Left = 240
        Top = 48
        Width = 26
        Height = 13
        Caption = 'Suffix'
      end
      object Label6: TLabel
        Left = 16
        Top = 144
        Width = 38
        Height = 13
        Caption = 'Religion'
      end
      object Bevel1: TBevel
        Left = 16
        Top = 168
        Width = 337
        Height = 2
      end
      object Label9: TLabel
        Left = 16
        Top = 176
        Width = 29
        Height = 13
        Caption = 'Memo'
      end
      object Bevel2: TBevel
        Left = 16
        Top = 352
        Width = 337
        Height = 2
      end
      object Label25: TLabel
        Left = 16
        Top = 368
        Width = 34
        Height = 13
        Caption = 'Source'
      end
      object ANama: TDBEdit
        Left = 128
        Top = 16
        Width = 225
        Height = 21
        DataField = 'NAME'
        DataSource = dsAlumni
        TabOrder = 0
      end
      object APrefix: TDBEdit
        Left = 160
        Top = 40
        Width = 73
        Height = 21
        DataField = 'PREFIX'
        DataSource = dsAlumni
        TabOrder = 1
      end
      object ABirthPlace: TDBEdit
        Left = 128
        Top = 112
        Width = 97
        Height = 21
        DataField = 'BIRTHPLACE'
        DataSource = dsAlumni
        TabOrder = 3
      end
      object Gender: TDBRadioGroup
        Left = 232
        Top = 112
        Width = 121
        Height = 41
        Hint = 'Tekan Escape bila tidak tahu.'
        Caption = 'Gender'
        Columns = 2
        DataField = 'GENDER'
        DataSource = dsAlumni
        Items.Strings = (
          'Male'
          'Female')
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        Values.Strings = (
          'M'
          'F'
          '')
      end
      object ABirthDate: TDateTimePicker
        Left = 128
        Top = 88
        Width = 161
        Height = 21
        Date = 38754.000000000000000000
        Time = 38754.000000000000000000
        ShowCheckbox = True
        TabOrder = 2
        OnChange = ABirthDateChange
        OnExit = dsAlumniUpdateData
      end
      object ASuffix: TDBEdit
        Left = 280
        Top = 40
        Width = 73
        Height = 21
        DataField = 'SUFFIX'
        DataSource = dsAlumni
        TabOrder = 5
      end
      object AReligion: TDBLookupComboBox
        Left = 128
        Top = 136
        Width = 97
        Height = 21
        DataField = 'RELIGIONID'
        DataSource = dsAlumni
        KeyField = 'RELIGIONID'
        ListField = 'RELIGION'
        ListSource = dmAl.dsReligion
        TabOrder = 6
      end
      object AMemo: TDBMemo
        Left = 128
        Top = 176
        Width = 225
        Height = 169
        DataField = 'MEMO'
        DataSource = dsAlumni
        TabOrder = 7
      end
      object AShowTitle: TDBCheckBox
        Left = 16
        Top = 64
        Width = 121
        Height = 17
        Caption = 'Show Title on Output'
        DataField = 'SHOWTITLE'
        DataSource = dsAlumni
        TabOrder = 8
        ValueChecked = 'T'
        ValueUnchecked = 'F'
      end
      object ASource: TDBLookupComboBox
        Left = 127
        Top = 360
        Width = 225
        Height = 21
        DataField = 'SourceID'
        DataSource = dsAlumni
        KeyField = 'SourceID'
        ListField = 'Source'
        ListSource = dmAl.dsSource
        TabOrder = 9
      end
    end
    object TabOrganizations: TTabSheet
      Caption = 'Organizations'
      ImageIndex = 8
      object Label35: TLabel
        Left = 16
        Top = 48
        Width = 59
        Height = 13
        Caption = 'Organization'
      end
      object DBNavMap: TDBNavigator
        Left = 0
        Top = 0
        Width = 368
        Height = 25
        DataSource = dmAl.dsMap
        Align = alTop
        Flat = True
        ConfirmDelete = False
        TabOrder = 0
      end
      object GridOrganization: TDBGrid
        Left = 0
        Top = 141
        Width = 368
        Height = 250
        Hint = 'Master Account'
        Align = alBottom
        Color = clCream
        Ctl3D = True
        DataSource = dmAl.dsMap
        FixedColor = clMoneyGreen
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = [fsBold]
        Columns = <
          item
            Expanded = False
            FieldName = 'AID'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'OID'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'Organization'
            Width = 330
            Visible = True
          end>
      end
      object BtnOrganization: TBitBtn
        Left = 328
        Top = 32
        Width = 25
        Height = 25
        TabOrder = 2
        OnClick = BtnOrganizationClick
        Glyph.Data = {
          66010000424D6601000000000000760000002800000014000000140000000100
          040000000000F000000000000000000000001000000010000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333300003333333333333333333300003333373333333333333300003333
          07733333333333330000333000773333333333330000330F0007733333333333
          00003330F000777777733333000033330F000000007733330000333330F00788
          87077333000033333300788FF870773300003333330788888F87073300003333
          3308888888F80733000033333307888888F807330000333333078FF888880733
          0000333333777FF8888773330000333333307788887033330000333333330777
          7703333300003333333337000733333300003333333333333333333300003333
          33333333333333330000}
      end
      object BitBtn1: TBitBtn
        Left = 16
        Top = 72
        Width = 105
        Height = 25
        Caption = 'Edit Detail'
        TabOrder = 3
        OnClick = MapDetailClick
        Glyph.Data = {
          9A050000424D9A05000000000000320400002800000013000000120000000100
          08000000000068010000120B0000120B0000FF000000FF000000000000000000
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
          FF0000FF000000FFFF00FF000000FF00FF00FFFF000007070707070707070707
          0707070707070707070007070707A0A0A0A0A0A0070707A0A0A0A0A0A0000707
          07000000000000A00707000000000000A000070707000EA0A0E6F5A0A0A0000E
          A0A0DA00A00007070700F6A0A0DFF500000000F6A0A0E6F5A000070707000EA0
          A0DB00A0A0DA000EA0A0DFF5A00007070700F6A0A0DA00A0A0E600F6A0A0DB00
          A000070707000EA0A0E6F5A0A0DA000EA0A0DA00A00007070700F6A0A0DA0000
          0000000AA0A0E6F5A000070707000EA0A0A0A0A0A0A0A0A0A0A0DFF5A0000707
          0700F6A0A0A0A0A0A0A0A0A0A0A0DB00A000070707000EA0A0A00000000000A0
          A0A0DA00A0000707070000F6A0E600A0070700F6A0E60000070007070707000E
          A0DA00A00707000EA0DA00A007000707070700F6A0E600A0070700F6A0E600A0
          070007070707000EA0DA00A00707000EA0DA00A0070007070707000000000007
          070700000000000707000707070707070707070707070707070707070700}
      end
      object OOrganization: TDBLookupComboBox
        Left = 128
        Top = 40
        Width = 193
        Height = 21
        DataField = 'OID'
        DataSource = dmAl.dsMap
        DropDownRows = 10
        KeyField = 'OID'
        ListField = 'ORGANIZATION'
        ListSource = dmAl.dsOrganization
        NullValueKey = 46
        TabOrder = 4
      end
    end
    object TabHome: TTabSheet
      Caption = 'Homes'
      ImageIndex = 1
      object Label18: TLabel
        Left = 16
        Top = 48
        Width = 44
        Height = 13
        Caption = 'Kawasan'
      end
      object Label19: TLabel
        Left = 16
        Top = 168
        Width = 37
        Height = 13
        Caption = 'Propinsi'
      end
      object Label20: TLabel
        Left = 16
        Top = 192
        Width = 82
        Height = 13
        Caption = 'Kota/ Kabupaten'
      end
      object Label10: TLabel
        Left = 16
        Top = 96
        Width = 25
        Height = 13
        Caption = 'Jalan'
      end
      object Label11: TLabel
        Left = 16
        Top = 120
        Width = 46
        Height = 13
        Caption = 'Kode Pos'
      end
      object Label13: TLabel
        Left = 16
        Top = 144
        Width = 35
        Height = 13
        Caption = 'Negara'
      end
      object Label23: TLabel
        Left = 16
        Top = 72
        Width = 87
        Height = 13
        Caption = 'Gedung/ Komplek'
      end
      object HKawasan: TDBEdit
        Left = 128
        Top = 40
        Width = 225
        Height = 21
        DataField = 'KAWASAN'
        DataSource = dmAl.dsHomes
        TabOrder = 0
      end
      object HPropinsi: TDBLookupComboBox
        Left = 128
        Top = 160
        Width = 145
        Height = 21
        DataField = 'PROPINSIID'
        DataSource = dmAl.dsHomes
        DropDownRows = 10
        KeyField = 'PROPINSIID'
        ListField = 'PROPINSI'
        ListSource = dmAl.dsPropinsi
        NullValueKey = 46
        TabOrder = 1
      end
      object HWilayah: TDBLookupComboBox
        Left = 128
        Top = 184
        Width = 145
        Height = 21
        DataField = 'WILAYAHID'
        DataSource = dmAl.dsHomes
        KeyField = 'WILAYAHID'
        ListField = 'WILAYAH'
        ListSource = dmAl.dsWilayah
        NullValueKey = 46
        TabOrder = 2
      end
      object HJalan: TDBEdit
        Left = 127
        Top = 88
        Width = 225
        Height = 21
        DataField = 'JALAN'
        DataSource = dmAl.dsHomes
        TabOrder = 3
      end
      object HKodePos: TDBEdit
        Left = 127
        Top = 112
        Width = 225
        Height = 21
        DataField = 'POSTALCODE'
        DataSource = dmAl.dsHomes
        TabOrder = 4
      end
      object HNegara: TDBLookupComboBox
        Left = 128
        Top = 136
        Width = 145
        Height = 21
        DataField = 'NEGARAID'
        DataSource = dmAl.dsHomes
        DropDownRows = 10
        KeyField = 'NEGARAID'
        ListField = 'NEGARA'
        ListSource = dmAl.dsNegara
        NullValueKey = 46
        TabOrder = 5
      end
      object GridHomes: TDBGrid
        Left = 0
        Top = 295
        Width = 368
        Height = 96
        Hint = 'Master Account'
        Align = alBottom
        Color = clCream
        Ctl3D = True
        DataSource = dmAl.dsHomes
        FixedColor = clMoneyGreen
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 6
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = [fsBold]
        Columns = <
          item
            Expanded = False
            FieldName = 'LID'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'KAWASAN'
            Width = 103
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'GEDUNG'
            Title.Caption = 'KOMPLEKS'
            Width = 75
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'JALAN'
            Width = 68
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'POSTALCODE'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Negara'
            Width = 61
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Propinsi'
            Width = 76
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Wilayah'
            Width = 66
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NEGARAID'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'PROPINSIID'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'WILAYAHID'
            Visible = False
          end>
      end
      object NavHomes: TDBNavigator
        Left = 0
        Top = 0
        Width = 368
        Height = 25
        DataSource = dmAl.dsHomes
        Align = alTop
        Flat = True
        TabOrder = 7
      end
      object HKomplek: TDBEdit
        Left = 128
        Top = 64
        Width = 225
        Height = 21
        DataField = 'GEDUNG'
        DataSource = dmAl.dsHomes
        TabOrder = 8
      end
    end
    object TabContacts: TTabSheet
      Caption = 'Contacts'
      ImageIndex = 2
      object GridContacts: TDBGrid
        Left = 0
        Top = 25
        Width = 368
        Height = 366
        Hint = 'Master Account'
        Align = alClient
        Color = clCream
        Ctl3D = True
        DataSource = dmAl.dsContacts
        FixedColor = clMoneyGreen
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = [fsBold]
        Columns = <
          item
            Expanded = False
            FieldName = 'LID'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'CTID'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'ContactType'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CONTACT'
            Visible = True
          end>
      end
      object NavContacts: TDBNavigator
        Left = 0
        Top = 0
        Width = 368
        Height = 25
        DataSource = dmAl.dsContacts
        Align = alTop
        Flat = True
        TabOrder = 1
      end
    end
    object TabCommunities: TTabSheet
      Caption = 'Communities'
      ImageIndex = 3
      object Label14: TLabel
        Left = 16
        Top = 72
        Width = 46
        Height = 13
        Caption = 'Angkatan'
      end
      object Label15: TLabel
        Left = 16
        Top = 48
        Width = 51
        Height = 13
        Caption = 'Community'
      end
      object Label16: TLabel
        Left = 16
        Top = 96
        Width = 84
        Height = 13
        Caption = 'Angkatan Khusus'
      end
      object NavCommunities: TDBNavigator
        Left = 0
        Top = 0
        Width = 368
        Height = 25
        DataSource = dmAl.dsCommunities
        Align = alTop
        Flat = True
        TabOrder = 0
      end
      object CAngkatan: TDBEdit
        Left = 128
        Top = 64
        Width = 89
        Height = 21
        DataField = 'ANGKATAN'
        DataSource = dmAl.dsCommunities
        TabOrder = 1
      end
      object CCommunity: TDBLookupComboBox
        Left = 128
        Top = 40
        Width = 193
        Height = 21
        DataField = 'CID'
        DataSource = dmAl.dsCommunities
        DropDownRows = 10
        KeyField = 'CID'
        ListField = 'COMMUNITY'
        ListSource = dmAl.dsCommunity
        NullValueKey = 46
        TabOrder = 2
      end
      object GridCommunities: TDBGrid
        Left = 0
        Top = 177
        Width = 368
        Height = 214
        Hint = 'Master Account'
        Align = alBottom
        Color = clCream
        Ctl3D = True
        DataSource = dmAl.dsCommunities
        FixedColor = clMoneyGreen
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 3
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = [fsBold]
        OnEditButtonClick = GridCommunitiesEditButtonClick
        Columns = <
          item
            Expanded = False
            FieldName = 'AID'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'CID'
            Visible = False
          end
          item
            ButtonStyle = cbsEllipsis
            Expanded = False
            FieldName = 'Community'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ANGKATAN'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'KHUSUS'
            Visible = True
          end>
      end
      object CKhusus: TDBEdit
        Left = 127
        Top = 88
        Width = 90
        Height = 21
        DataField = 'KHUSUS'
        DataSource = dmAl.dsCommunities
        TabOrder = 4
      end
      object BtnCommunity: TBitBtn
        Left = 328
        Top = 32
        Width = 25
        Height = 25
        TabOrder = 5
        OnClick = BtnCommunityClick
        Glyph.Data = {
          66010000424D6601000000000000760000002800000014000000140000000100
          040000000000F000000000000000000000001000000010000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333300003333333333333333333300003333373333333333333300003333
          07733333333333330000333000773333333333330000330F0007733333333333
          00003330F000777777733333000033330F000000007733330000333330F00788
          87077333000033333300788FF870773300003333330788888F87073300003333
          3308888888F80733000033333307888888F807330000333333078FF888880733
          0000333333777FF8888773330000333333307788887033330000333333330777
          7703333300003333333337000733333300003333333333333333333300003333
          33333333333333330000}
      end
    end
    object TabDegrees: TTabSheet
      Caption = 'Degrees'
      ImageIndex = 4
      object Label17: TLabel
        Left = 16
        Top = 48
        Width = 28
        Height = 13
        Caption = 'Strata'
      end
      object Label21: TLabel
        Left = 16
        Top = 72
        Width = 35
        Height = 13
        Caption = 'Degree'
      end
      object Label22: TLabel
        Left = 16
        Top = 120
        Width = 50
        Height = 13
        Caption = 'Graduated'
      end
      object Label24: TLabel
        Left = 16
        Top = 96
        Width = 41
        Height = 13
        Caption = 'Admitted'
      end
      object Label26: TLabel
        Left = 16
        Top = 144
        Width = 45
        Height = 13
        Caption = 'Institution'
      end
      object Label27: TLabel
        Left = 16
        Top = 168
        Width = 26
        Height = 13
        Caption = 'Major'
      end
      object Label28: TLabel
        Left = 16
        Top = 192
        Width = 26
        Height = 13
        Caption = 'Minor'
      end
      object Label29: TLabel
        Left = 16
        Top = 216
        Width = 66
        Height = 13
        Caption = 'Concentration'
      end
      object GridDegrees: TDBGrid
        Left = 0
        Top = 297
        Width = 368
        Height = 94
        Hint = 'Master Account'
        Align = alBottom
        Color = clCream
        Ctl3D = True
        DataSource = dmAl.dsDegrees
        FixedColor = clMoneyGreen
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = [fsBold]
        Columns = <
          item
            Expanded = False
            FieldName = 'AID'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'STRATAID'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'Strata'
            Width = 43
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ADMITTED'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'GRADUATED'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DEGREE'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'INSTITUTION'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'MAJOR'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'MINOR'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CONCENTRATION'
            Visible = True
          end>
      end
      object NavDegrees: TDBNavigator
        Left = 0
        Top = 0
        Width = 368
        Height = 25
        DataSource = dmAl.dsDegrees
        Align = alTop
        Flat = True
        TabOrder = 1
      end
      object DStrata: TDBLookupComboBox
        Left = 128
        Top = 40
        Width = 89
        Height = 21
        DataField = 'STRATAID'
        DataSource = dmAl.dsDegrees
        DropDownRows = 10
        KeyField = 'STRATAID'
        ListField = 'STRATA'
        ListSource = dmAl.dsStrata
        NullValueKey = 46
        TabOrder = 2
      end
      object DDegree: TDBEdit
        Left = 128
        Top = 64
        Width = 162
        Height = 21
        DataField = 'DEGREE'
        DataSource = dmAl.dsDegrees
        TabOrder = 3
      end
      object DInstitution: TDBEdit
        Left = 128
        Top = 136
        Width = 226
        Height = 21
        DataField = 'INSTITUTION'
        DataSource = dmAl.dsDegrees
        TabOrder = 4
      end
      object DMajor: TDBEdit
        Left = 128
        Top = 160
        Width = 226
        Height = 21
        DataField = 'MAJOR'
        DataSource = dmAl.dsDegrees
        TabOrder = 5
      end
      object DMinor: TDBEdit
        Left = 128
        Top = 184
        Width = 226
        Height = 21
        DataField = 'MINOR'
        DataSource = dmAl.dsDegrees
        TabOrder = 6
      end
      object DConcentration: TDBEdit
        Left = 128
        Top = 208
        Width = 226
        Height = 21
        DataField = 'CONCENTRATION'
        DataSource = dmAl.dsDegrees
        TabOrder = 7
      end
      object DAdmitted: TDBEdit
        Left = 128
        Top = 88
        Width = 89
        Height = 21
        DataField = 'ADMITTED'
        DataSource = dmAl.dsDegrees
        TabOrder = 8
      end
      object DGraduated: TDBEdit
        Left = 128
        Top = 112
        Width = 89
        Height = 21
        DataField = 'GRADUATED'
        DataSource = dmAl.dsDegrees
        TabOrder = 9
      end
    end
    object TabExperiences: TTabSheet
      Caption = 'Experiences'
      ImageIndex = 5
      object Label37: TLabel
        Left = 16
        Top = 96
        Width = 57
        Height = 13
        Caption = 'Job Position'
      end
      object Label38: TLabel
        Left = 16
        Top = 72
        Width = 53
        Height = 13
        Caption = 'Description'
      end
      object Label39: TLabel
        Left = 16
        Top = 48
        Width = 59
        Height = 13
        Caption = 'Organization'
      end
      object Label40: TLabel
        Left = 128
        Top = 120
        Width = 34
        Height = 13
        Caption = 'Year In'
      end
      object Label41: TLabel
        Left = 240
        Top = 120
        Width = 42
        Height = 13
        Caption = 'Year Out'
      end
      object Label42: TLabel
        Left = 16
        Top = 120
        Width = 22
        Height = 13
        Caption = 'Year'
      end
      object NavExperiences: TDBNavigator
        Left = 0
        Top = 0
        Width = 368
        Height = 25
        DataSource = dmAl.dsExperiences
        Align = alTop
        Flat = True
        TabOrder = 0
      end
      object GridExperiences: TDBGrid
        Left = 0
        Top = 144
        Width = 368
        Height = 247
        Hint = 'Master Account'
        Align = alBottom
        Color = clCream
        Ctl3D = True
        DataSource = dmAl.dsExperiences
        FixedColor = clMoneyGreen
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = [fsBold]
        Columns = <
          item
            Expanded = False
            FieldName = 'AID'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'ORGANIZATION'
            Width = 98
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DESCRIPTION'
            Width = 89
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'JOBPOSITION'
            Width = 89
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'YEARIN'
            Width = 53
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'YEAROUT'
            Visible = True
          end>
      end
      object XPJobPosition: TDBEdit
        Left = 127
        Top = 88
        Width = 225
        Height = 21
        DataField = 'JOBPOSITION'
        DataSource = dmAl.dsExperiences
        TabOrder = 2
      end
      object XPOrganization: TDBEdit
        Left = 128
        Top = 40
        Width = 225
        Height = 21
        DataField = 'ORGANIZATION'
        DataSource = dmAl.dsExperiences
        TabOrder = 3
      end
      object XPDescription: TDBEdit
        Left = 128
        Top = 64
        Width = 225
        Height = 21
        DataField = 'DESCRIPTION'
        DataSource = dmAl.dsExperiences
        TabOrder = 4
      end
      object XPYearIn: TDBEdit
        Left = 168
        Top = 112
        Width = 65
        Height = 21
        DataField = 'YEARIN'
        DataSource = dmAl.dsExperiences
        TabOrder = 5
      end
      object XPYearOut: TDBEdit
        Left = 288
        Top = 112
        Width = 65
        Height = 21
        DataField = 'YEAROUT'
        DataSource = dmAl.dsExperiences
        TabOrder = 6
      end
    end
    object TabCompetencies: TTabSheet
      Caption = 'Competencies'
      ImageIndex = 6
      object NavCompetencies: TDBNavigator
        Left = 0
        Top = 0
        Width = 368
        Height = 25
        DataSource = dmAl.dsCompetencies
        Align = alTop
        Flat = True
        TabOrder = 0
      end
      object GridCompetencies: TDBGrid
        Left = 0
        Top = 25
        Width = 368
        Height = 366
        Hint = 'Master Account'
        Align = alClient
        Color = clCream
        Ctl3D = True
        DataSource = dmAl.dsCompetencies
        FixedColor = clMoneyGreen
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = [fsBold]
        Columns = <
          item
            Expanded = False
            FieldName = 'AID'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'Competency'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'COMPETENCYID'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'DESCRIPTION'
            Visible = True
          end>
      end
    end
    object TabCertifications: TTabSheet
      Caption = 'Certifications'
      ImageIndex = 7
      object NavCertifications: TDBNavigator
        Left = 0
        Top = 0
        Width = 368
        Height = 25
        DataSource = dmAl.dsCertificatons
        Align = alTop
        Flat = True
        TabOrder = 0
      end
      object GridCertifications: TDBGrid
        Left = 0
        Top = 25
        Width = 368
        Height = 366
        Hint = 'Master Account'
        Align = alClient
        Color = clCream
        Ctl3D = True
        DataSource = dmAl.dsCertificatons
        FixedColor = clMoneyGreen
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = [fsBold]
        Columns = <
          item
            Expanded = False
            FieldName = 'AID'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'CERTIFICATION'
            Width = 193
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'INSTITUTION'
            Visible = True
          end>
      end
    end
  end
  object dsAlumni: TDataSource
    DataSet = dmAl.qrAlumni
    OnDataChange = dsAlumniDataChange
    OnUpdateData = dsAlumniUpdateData
    Left = 232
    Top = 16
  end
end
