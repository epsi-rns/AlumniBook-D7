object frmEntryMap: TfrmEntryMap
  Left = 518
  Top = 55
  Width = 380
  Height = 535
  Caption = 'Map Data Entry'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PanelTop: TPanel
    Left = 0
    Top = 0
    Width = 372
    Height = 45
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
    object DBTextAID: TDBText
      Left = 20
      Top = 8
      Width = 65
      Height = 17
      DataField = 'AID'
      DataSource = dmLink.dsMap
    end
    object DBTextOID: TDBText
      Left = 20
      Top = 24
      Width = 65
      Height = 17
      DataField = 'OID'
      DataSource = dmLink.dsMap
    end
    object Label1: TLabel
      Left = 8
      Top = 24
      Width = 7
      Height = 13
      Caption = '#'
    end
    object DBTextName: TDBText
      Left = 68
      Top = 8
      Width = 245
      Height = 17
      DataField = 'Name'
      DataSource = dmLink.dsMap
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsUnderline]
      ParentFont = False
    end
    object DBTextOrganization: TDBText
      Left = 68
      Top = 24
      Width = 245
      Height = 17
      DataField = 'Organization'
      DataSource = dmLink.dsMap
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsUnderline]
      ParentFont = False
    end
  end
  object PanelBtm: TPanel
    Left = 0
    Top = 470
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
  end
  object PageControl: TPageControl
    Left = 0
    Top = 45
    Width = 372
    Height = 425
    ActivePage = TabCommon
    Align = alClient
    MultiLine = True
    Style = tsFlatButtons
    TabOrder = 2
    OnChange = PageControlChange
    OnChanging = PageControlChanging
    object TabCommon: TTabSheet
      Caption = 'Detail'
      object Label34: TLabel
        Left = 16
        Top = 144
        Width = 55
        Height = 13
        Caption = 'Department'
      end
      object Label36: TLabel
        Left = 16
        Top = 168
        Width = 37
        Height = 13
        Caption = 'Position'
      end
      object Label33: TLabel
        Left = 16
        Top = 192
        Width = 53
        Height = 13
        Caption = 'Description'
      end
      object Label32: TLabel
        Left = 16
        Top = 216
        Width = 85
        Height = 13
        Caption = 'Structural Position'
      end
      object Label30: TLabel
        Left = 16
        Top = 240
        Width = 89
        Height = 13
        Caption = 'Functional Position'
      end
      object Label2: TLabel
        Left = 16
        Top = 40
        Width = 59
        Height = 13
        Caption = 'Organization'
      end
      object Label3: TLabel
        Left = 16
        Top = 64
        Width = 31
        Height = 13
        Caption = 'Alumni'
      end
      object Label5: TLabel
        Left = 16
        Top = 104
        Width = 55
        Height = 13
        Caption = 'Occupancy'
      end
      object OFunctional: TDBEdit
        Left = 128
        Top = 232
        Width = 225
        Height = 21
        DataField = 'FUNGSIONAL'
        DataSource = dmLink.dsMap
        TabOrder = 0
      end
      object OStructural: TDBEdit
        Left = 128
        Top = 208
        Width = 225
        Height = 21
        DataField = 'STRUKTURAL'
        DataSource = dmLink.dsMap
        TabOrder = 1
      end
      object ODescription: TDBEdit
        Left = 128
        Top = 184
        Width = 225
        Height = 21
        DataField = 'DESCRIPTION'
        DataSource = dmLink.dsMap
        TabOrder = 2
      end
      object OJobPosition: TDBLookupComboBox
        Left = 128
        Top = 160
        Width = 225
        Height = 21
        DataField = 'JOBPOSITIONID'
        DataSource = dmLink.dsMap
        DropDownRows = 10
        KeyField = 'JOBPOSITIONID'
        ListField = 'JOBPOSITION'
        ListSource = dmLink.dsJobPosition
        NullValueKey = 46
        TabOrder = 3
      end
      object ODepartment: TDBEdit
        Left = 128
        Top = 136
        Width = 225
        Height = 21
        DataField = 'DEPARTMENT'
        DataSource = dmLink.dsMap
        TabOrder = 4
      end
      object NavExperiences: TDBNavigator
        Left = 0
        Top = 0
        Width = 364
        Height = 25
        DataSource = dmLink.dsMap
        VisibleButtons = [nbEdit, nbPost, nbCancel, nbRefresh]
        Align = alTop
        Flat = True
        TabOrder = 5
      end
      object MOrganization: TDBEdit
        Left = 128
        Top = 32
        Width = 225
        Height = 21
        DataField = 'Organization'
        DataSource = dmLink.dsMap
        ReadOnly = True
        TabOrder = 6
      end
      object MName: TDBEdit
        Left = 128
        Top = 56
        Width = 225
        Height = 21
        DataField = 'Name'
        DataSource = dmLink.dsMap
        ReadOnly = True
        TabOrder = 7
      end
      object AJobType: TDBLookupComboBox
        Left = 127
        Top = 96
        Width = 225
        Height = 21
        DataField = 'JOBTYPEID'
        DataSource = dmLink.dsMap
        KeyField = 'JOBTYPEID'
        ListField = 'JOBTYPE'
        ListSource = dmLink.dsJobType
        TabOrder = 8
      end
    end
    object TabOffices: TTabSheet
      Caption = 'Offices'
      ImageIndex = 1
      object Label18: TLabel
        Left = 16
        Top = 48
        Width = 44
        Height = 13
        Caption = 'Kawasan'
      end
      object Label4: TLabel
        Left = 16
        Top = 72
        Width = 87
        Height = 13
        Caption = 'Gedung/ Komplek'
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
      object NavHomes: TDBNavigator
        Left = 0
        Top = 0
        Width = 364
        Height = 25
        DataSource = dmLink.dsMOffices
        Align = alTop
        Flat = True
        TabOrder = 0
      end
      object MKawasan: TDBEdit
        Left = 128
        Top = 40
        Width = 225
        Height = 21
        DataField = 'KAWASAN'
        DataSource = dmLink.dsMOffices
        TabOrder = 1
      end
      object MGedung: TDBEdit
        Left = 128
        Top = 64
        Width = 225
        Height = 21
        DataField = 'GEDUNG'
        DataSource = dmLink.dsMOffices
        TabOrder = 2
      end
      object MJalan: TDBEdit
        Left = 127
        Top = 88
        Width = 225
        Height = 21
        DataField = 'JALAN'
        DataSource = dmLink.dsMOffices
        TabOrder = 3
      end
      object MKodePos: TDBEdit
        Left = 127
        Top = 112
        Width = 225
        Height = 21
        DataField = 'POSTALCODE'
        DataSource = dmLink.dsMOffices
        TabOrder = 4
      end
      object MNegara: TDBLookupComboBox
        Left = 128
        Top = 136
        Width = 145
        Height = 21
        DataField = 'NEGARAID'
        DataSource = dmLink.dsMOffices
        DropDownRows = 10
        KeyField = 'NEGARAID'
        ListField = 'NEGARA'
        ListSource = dmLink.dsNegara
        NullValueKey = 46
        TabOrder = 5
      end
      object MPropinsi: TDBLookupComboBox
        Left = 128
        Top = 160
        Width = 145
        Height = 21
        DataField = 'PROPINSIID'
        DataSource = dmLink.dsMOffices
        DropDownRows = 10
        KeyField = 'PROPINSIID'
        ListField = 'PROPINSI'
        ListSource = dmLink.dsPropinsi
        NullValueKey = 46
        TabOrder = 6
      end
      object MWilayah: TDBLookupComboBox
        Left = 128
        Top = 184
        Width = 145
        Height = 21
        DataField = 'WILAYAHID'
        DataSource = dmLink.dsMOffices
        KeyField = 'WILAYAHID'
        ListField = 'WILAYAH'
        ListSource = dmLink.dsWilayah
        NullValueKey = 46
        TabOrder = 7
      end
      object GridHomes: TDBGrid
        Left = 0
        Top = 298
        Width = 364
        Height = 96
        Hint = 'Master Account'
        Align = alBottom
        Color = clCream
        Ctl3D = True
        DataSource = dmLink.dsMOffices
        FixedColor = clMoneyGreen
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 8
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
    end
    object TabContacts: TTabSheet
      Caption = 'Contacts'
      ImageIndex = 2
      object NavContacts: TDBNavigator
        Left = 0
        Top = 0
        Width = 364
        Height = 25
        DataSource = dmLink.dsMContacts
        Align = alTop
        Flat = True
        TabOrder = 0
      end
      object GridContacts: TDBGrid
        Left = 0
        Top = 25
        Width = 364
        Height = 371
        Hint = 'Master Account'
        Align = alClient
        Color = clCream
        Ctl3D = True
        DataSource = dmLink.dsMContacts
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
    end
  end
end
