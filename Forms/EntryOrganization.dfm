object frmEntryOrganization: TfrmEntryOrganization
  Left = 540
  Top = 60
  Width = 380
  Height = 535
  Caption = 'Organization Data Entry'
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
  object PanelTop: TPanel
    Left = 0
    Top = 0
    Width = 372
    Height = 31
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
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
      DataField = 'OID'
      DataSource = dmOr.dsOrganization
    end
    object DBTextOrganization: TDBText
      Left = 76
      Top = 8
      Width = 189
      Height = 17
      DataField = 'ORGANIZATION'
      DataSource = dmOr.dsOrganization
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
      DataSource = dmOr.dsOrganization
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
  end
  object PanelBtm: TPanel
    Left = 0
    Top = 477
    Width = 372
    Height = 31
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      372
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
    object DBNav: TDBNavigator
      Left = 88
      Top = 3
      Width = 112
      Height = 25
      DataSource = dmOr.dsCursor
      VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
      Anchors = [akLeft, akTop, akRight]
      Flat = True
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object DBNavOrg: TDBNavigator
      Left = 200
      Top = 3
      Width = 168
      Height = 25
      DataSource = dmOr.dsOrganization
      VisibleButtons = [nbInsert, nbDelete, nbEdit, nbPost, nbCancel, nbRefresh]
      Anchors = [akLeft, akTop, akRight]
      Flat = True
      ParentShowHint = False
      ConfirmDelete = False
      ShowHint = True
      TabOrder = 2
    end
  end
  object PageControl: TPageControl
    Left = 0
    Top = 31
    Width = 372
    Height = 446
    ActivePage = TabContacts
    Align = alClient
    MultiLine = True
    Style = tsFlatButtons
    TabOrder = 2
    OnChange = PageControlChange
    OnChanging = PageControlChanging
    OnEnter = PageControlChange
    object TabCompany: TTabSheet
      Caption = 'Organization'
      object Label1: TLabel
        Left = 16
        Top = 24
        Width = 90
        Height = 13
        Caption = 'Organization Name'
      end
      object Label7: TLabel
        Left = 16
        Top = 168
        Width = 37
        Height = 13
        Caption = 'Product'
      end
      object Label3: TLabel
        Left = 16
        Top = 48
        Width = 93
        Height = 13
        Caption = 'Parent Organization'
      end
      object Bevel1: TBevel
        Left = 16
        Top = 152
        Width = 337
        Height = 2
      end
      object Label9: TLabel
        Left = 16
        Top = 192
        Width = 29
        Height = 13
        Caption = 'Memo'
      end
      object OOrganization: TDBEdit
        Left = 128
        Top = 16
        Width = 225
        Height = 21
        DataField = 'ORGANIZATION'
        DataSource = dmOr.dsOrganization
        TabOrder = 0
      end
      object OProduct: TDBEdit
        Left = 128
        Top = 160
        Width = 225
        Height = 21
        DataField = 'PRODUCT'
        DataSource = dmOr.dsOrganization
        TabOrder = 1
      end
      object OParent: TDBLookupComboBox
        Left = 128
        Top = 40
        Width = 186
        Height = 21
        DataField = 'PARENTID'
        DataSource = dmOr.dsOrganization
        KeyField = 'OID'
        ListField = 'ORGANIZATION'
        ListSource = dmOr.dsParent
        NullValueKey = 46
        TabOrder = 2
      end
      object OMemo: TDBMemo
        Left = 128
        Top = 192
        Width = 225
        Height = 137
        DataField = 'MEMO'
        DataSource = dmOr.dsOrganization
        TabOrder = 3
      end
      object BtnParent: TBitBtn
        Left = 328
        Top = 40
        Width = 25
        Height = 25
        TabOrder = 4
        OnClick = BtnParentClick
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
      object OHasBranch: TDBCheckBox
        Left = 16
        Top = 72
        Width = 97
        Height = 17
        Caption = 'Have Branch'
        DataField = 'HASBRANCH'
        DataSource = dmOr.dsOrganization
        TabOrder = 5
        ValueChecked = 'T'
        ValueUnchecked = 'F'
      end
    end
    object TabAlumni: TTabSheet
      Caption = 'Alumnus'
      ImageIndex = 8
      object Label35: TLabel
        Left = 16
        Top = 48
        Width = 31
        Height = 13
        Caption = 'Alumni'
      end
      object GridOrganization: TDBGrid
        Left = 0
        Top = 165
        Width = 364
        Height = 250
        Hint = 'Master Account'
        Align = alBottom
        Color = clCream
        Ctl3D = True
        DataSource = dmOr.dsMap
        FixedColor = clMoneyGreen
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        ParentCtl3D = False
        ParentFont = False
        ReadOnly = True
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
            FieldName = 'OID'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'Community'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Name'
            Width = 230
            Visible = True
          end>
      end
      object DBNavMap: TDBNavigator
        Left = 0
        Top = 0
        Width = 364
        Height = 25
        DataSource = dmOr.dsMap
        Align = alTop
        Flat = True
        ConfirmDelete = False
        TabOrder = 1
      end
      object BtnAlumni: TBitBtn
        Left = 328
        Top = 32
        Width = 25
        Height = 25
        TabOrder = 2
        OnClick = BtnAlumniClick
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
      object AAlumni: TDBLookupComboBox
        Left = 128
        Top = 40
        Width = 193
        Height = 21
        DataField = 'AID'
        DataSource = dmOr.dsMap
        DropDownRows = 10
        KeyField = 'AID'
        ListField = 'NAME'
        ListSource = dmOr.dsAlumni
        NullValueKey = 46
        TabOrder = 4
      end
    end
    object TabOffices: TTabSheet
      Caption = 'Offices'
      ImageIndex = 3
      object Label20: TLabel
        Left = 16
        Top = 192
        Width = 82
        Height = 13
        Caption = 'Kota/ Kabupaten'
      end
      object Label19: TLabel
        Left = 16
        Top = 168
        Width = 37
        Height = 13
        Caption = 'Propinsi'
      end
      object Label13: TLabel
        Left = 16
        Top = 144
        Width = 35
        Height = 13
        Caption = 'Negara'
      end
      object Label11: TLabel
        Left = 16
        Top = 120
        Width = 46
        Height = 13
        Caption = 'Kode Pos'
      end
      object Label10: TLabel
        Left = 16
        Top = 96
        Width = 25
        Height = 13
        Caption = 'Jalan'
      end
      object Label18: TLabel
        Left = 16
        Top = 48
        Width = 44
        Height = 13
        Caption = 'Kawasan'
      end
      object Label2: TLabel
        Left = 16
        Top = 72
        Width = 87
        Height = 13
        Caption = 'Gedung/ Komplek'
      end
      object NavHomes: TDBNavigator
        Left = 0
        Top = 0
        Width = 364
        Height = 25
        DataSource = dmOr.dsOffices
        Align = alTop
        Flat = True
        TabOrder = 0
      end
      object GridHomes: TDBGrid
        Left = 0
        Top = 319
        Width = 364
        Height = 96
        Hint = 'Master Account'
        Align = alBottom
        Color = clCream
        Ctl3D = True
        DataSource = dmOr.dsOffices
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
            FieldName = 'LID'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'KAWASAN'
            Width = 86
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'GEDUNG'
            Width = 96
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
            Width = 53
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Wilayah'
            Width = 58
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
      object OKawasan: TDBEdit
        Left = 128
        Top = 40
        Width = 225
        Height = 21
        DataField = 'KAWASAN'
        DataSource = dmOr.dsOffices
        TabOrder = 2
      end
      object OJalan: TDBEdit
        Left = 127
        Top = 88
        Width = 225
        Height = 21
        DataField = 'JALAN'
        DataSource = dmOr.dsOffices
        TabOrder = 3
      end
      object OKodePos: TDBEdit
        Left = 127
        Top = 112
        Width = 225
        Height = 21
        DataField = 'POSTALCODE'
        DataSource = dmOr.dsOffices
        TabOrder = 4
      end
      object ONegara: TDBLookupComboBox
        Left = 128
        Top = 136
        Width = 145
        Height = 21
        DataField = 'NEGARAID'
        DataSource = dmOr.dsOffices
        DropDownRows = 10
        KeyField = 'NEGARAID'
        ListField = 'NEGARA'
        ListSource = dmOr.dsNegara
        NullValueKey = 46
        TabOrder = 5
      end
      object OPropinsi: TDBLookupComboBox
        Left = 128
        Top = 160
        Width = 145
        Height = 21
        DataField = 'PROPINSIID'
        DataSource = dmOr.dsOffices
        DropDownRows = 10
        KeyField = 'PROPINSIID'
        ListField = 'PROPINSI'
        ListSource = dmOr.dsPropinsi
        NullValueKey = 46
        TabOrder = 6
      end
      object OWilayah: TDBLookupComboBox
        Left = 128
        Top = 184
        Width = 145
        Height = 21
        DataField = 'WILAYAHID'
        DataSource = dmOr.dsOffices
        KeyField = 'WILAYAHID'
        ListField = 'WILAYAH'
        ListSource = dmOr.dsWilayah
        NullValueKey = 46
        TabOrder = 7
      end
      object OGedung: TDBEdit
        Left = 128
        Top = 64
        Width = 225
        Height = 21
        DataField = 'GEDUNG'
        DataSource = dmOr.dsOffices
        TabOrder = 8
      end
    end
    object TabContacts: TTabSheet
      Caption = 'Contacts'
      ImageIndex = 2
      object GridContacts: TDBGrid
        Left = 0
        Top = 25
        Width = 364
        Height = 390
        Hint = 'Master Account'
        Align = alClient
        Color = clCream
        Ctl3D = True
        DataSource = dmOr.dsOContacts
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
            Width = 64
            Visible = True
          end>
      end
      object NavContacts: TDBNavigator
        Left = 0
        Top = 0
        Width = 364
        Height = 25
        DataSource = dmOr.dsOContacts
        Align = alTop
        Flat = True
        TabOrder = 1
      end
    end
    object TabFields: TTabSheet
      Caption = 'Fields'
      ImageIndex = 4
      object GridCompetencies: TDBGrid
        Left = 0
        Top = 25
        Width = 364
        Height = 390
        Hint = 'Master Account'
        Align = alClient
        Color = clCream
        Ctl3D = True
        DataSource = dmOr.dsFields
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
            FieldName = 'OID'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'Field'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'FIELDID'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'DESCRIPTION'
            Width = 64
            Visible = True
          end>
      end
      object NavCompetencies: TDBNavigator
        Left = 0
        Top = 0
        Width = 364
        Height = 25
        DataSource = dmOr.dsFields
        Align = alTop
        Flat = True
        TabOrder = 1
      end
    end
    object TabBranch: TTabSheet
      Caption = 'Branch'
      ImageIndex = 5
      object DBGrid1: TDBGrid
        Left = 0
        Top = 80
        Width = 364
        Height = 335
        Hint = 'Master Account'
        Align = alBottom
        Color = clCream
        Ctl3D = True
        DataSource = dmOr.dsBranch
        FixedColor = clMoneyGreen
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        ParentCtl3D = False
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = [fsBold]
        Columns = <
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
      object NavBranches: TDBNavigator
        Left = 0
        Top = 0
        Width = 364
        Height = 25
        DataSource = dmOr.dsBranch
        VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
        Align = alTop
        Flat = True
        TabOrder = 1
      end
      object BtnExcludeBranch: TBitBtn
        Left = 0
        Top = 32
        Width = 81
        Height = 25
        Caption = 'Exclude'
        TabOrder = 2
        OnClick = BtnExcludeBranchClick
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00E7D6AD00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00E7D6AD00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF009B8B6C00A59C7B009B8B6C00FF00FF00FF00FF00FF00
          FF00E7D6AD009B8B6C009B8B6C00E7D6AD00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00A59C7B000001090000000000B4906E009B8B6C00FF00FF00FF00
          FF009B8B6C0000000000000000009B8B6C00E7D6AD00FF00FF00FF00FF00FF00
          FF00FF00FF000001090073A1BD000000BF00000000009B8B6C009B8B6C00B490
          6E00000000000000BF000000BF00000000009B8B6C00E7D6AD00FF00FF00FF00
          FF00FF00FF000000000073A1BD000000FF000000BF0000000000B4906E000000
          00000000BF000000FF000000BF00000000009B8B6C00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF000000000073A1BD000000FF000000BF00000000000000
          BF000000FF000809D700000000009B8B6C00E7D6AD00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF000000000073A1BD000000FF000809D7000000
          FF000000BF00000000009B8B6C00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00F0CAA600000000000000FF000000FF000000
          FF00000000009B8B6C009B8B6C00E7D6AD00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00F0CAA600000000000809D7000000FF00C0C0C0000000
          FF000000BF00000000009B8B6C009B8B6C00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00DECEBD00000109000809D7000000FF000000BF000000000073A1
          BD000000FF000000BF00000000009B8B6C00A59C7B00FF00FF00FF00FF00FF00
          FF00FF00FF000001090073A1BD000000FF000809D70000000000FF00FF000000
          000073A1BD000000FF000000BF00000000009B8B6C00E7D6B500FF00FF00FF00
          FF00FF00FF000000000073A1BD0073A1BD0000010900FF00FF00FF00FF00FF00
          FF000000000073A1BD0073A1BD00000109009B8B6C00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF000000000000000000FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF0000000000000000009B8B6C00E7D6AD00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      end
      object BtnIncludeBranch: TBitBtn
        Left = 80
        Top = 32
        Width = 81
        Height = 25
        Caption = 'Include'
        TabOrder = 3
        OnClick = BtnIncludeBranchClick
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
  end
end
