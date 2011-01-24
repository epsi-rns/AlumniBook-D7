object dmLink: TdmLink
  OldCreateOrder = False
  Left = 151
  Top = 182
  Height = 367
  Width = 416
  object dsCursor: TDataSource
    DataSet = BrowseAlumni.qrLookup
    Left = 16
    Top = 8
  end
  object qrAOMap: TIBDataSet
    Database = Data.Database
    Transaction = Data.txEntry
    ForcedRefresh = True
    BeforeClose = qrAOMapBeforeClose
    BufferChunks = 1000
    CachedUpdates = False
    DeleteSQL.Strings = (
      'delete from AOMap'
      'where'
      '  MID = :OLD_MID')
    InsertSQL.Strings = (
      'insert into AOMap'
      
        '  (MID, AID, OID, DEPARTMENT, JOBTYPEID, JOBPOSITIONID, DESCRIPT' +
        'ION, STRUKTURAL, '
      'FUNGSIONAL)'
      'values'
      '  (:MID, :AID, :OID, :DEPARTMENT, :JOBTYPEID, :JOBPOSITIONID, '
      ':DESCRIPTION, :STRUKTURAL, '
      '   :FUNGSIONAL)')
    RefreshSQL.Strings = (
      'Select '
      '  MID,'
      '  AID,'
      '  OID,'
      '  DEPARTMENT,'
      '  JOBTYPEID,'
      '  JOBPOSITIONID,'
      '  DESCRIPTION,'
      '  STRUKTURAL,'
      '  FUNGSIONAL'
      'from AOMap '
      'where'
      '  MID = :MID')
    SelectSQL.Strings = (
      'SELECT * FROM AOMap'
      'WHERE MID = :MID')
    ModifySQL.Strings = (
      'update AOMap'
      'set'
      '  MID = :MID,'
      '  AID = :AID,'
      '  OID = :OID,'
      '  DEPARTMENT = :DEPARTMENT,'
      '  JOBTYPEID = :JOBTYPEID,'
      '  JOBPOSITIONID = :JOBPOSITIONID,'
      '  DESCRIPTION = :DESCRIPTION,'
      '  STRUKTURAL = :STRUKTURAL,'
      '  FUNGSIONAL = :FUNGSIONAL'
      'where'
      '  MID = :OLD_MID')
    DataSource = dsCursor
    Left = 88
    Top = 8
    object qrAOMapMID: TIntegerField
      FieldName = 'MID'
      Origin = 'AOMAP.MID'
      Required = True
    end
    object qrAOMapAID: TIntegerField
      FieldName = 'AID'
      Origin = 'AOMAP.AID'
      Required = True
      Visible = False
    end
    object qrAOMapOID: TIntegerField
      FieldName = 'OID'
      Origin = 'AOMAP.OID'
      Required = True
      Visible = False
    end
    object qrAOMapJOBTYPEID: TIntegerField
      FieldName = 'JOBTYPEID'
      Origin = 'AOMAP.JOBTYPEID'
      Visible = False
    end
    object qrAOMapJOBPOSITIONID: TIntegerField
      FieldName = 'JOBPOSITIONID'
      Origin = 'AOMAP.JOBPOSITIONID'
      Visible = False
    end
    object qrAOMapAlumni: TStringField
      DisplayWidth = 50
      FieldKind = fkLookup
      FieldName = 'Name'
      LookupDataSet = qrAlumni
      LookupKeyFields = 'AID'
      LookupResultField = 'NAME'
      KeyFields = 'AID'
      Size = 50
      Lookup = True
    end
    object qrAOMapOrganization: TStringField
      DisplayWidth = 50
      FieldKind = fkLookup
      FieldName = 'Organization'
      LookupDataSet = qrOrganization
      LookupKeyFields = 'OID'
      LookupResultField = 'ORGANIZATION'
      KeyFields = 'OID'
      Size = 50
      Lookup = True
    end
    object qrAOMapJobType: TStringField
      DisplayWidth = 40
      FieldKind = fkLookup
      FieldName = 'JobType'
      LookupDataSet = qrJobType
      LookupKeyFields = 'JOBTYPEID'
      LookupResultField = 'JOBTYPE'
      KeyFields = 'JOBTYPEID'
      Size = 40
      Lookup = True
    end
    object qrAOMapJobPosition: TStringField
      DisplayWidth = 40
      FieldKind = fkLookup
      FieldName = 'JobPosition'
      LookupDataSet = qrJobPosition
      LookupKeyFields = 'JOBPOSITIONID'
      LookupResultField = 'JOBPOSITION'
      KeyFields = 'JOBPOSITIONID'
      Size = 40
      Lookup = True
    end
    object qrAOMapDEPARTMENT: TIBStringField
      FieldName = 'DEPARTMENT'
      Origin = 'AOMAP.DEPARTMENT'
      Size = 60
    end
    object qrAOMapSTRUKTURAL: TIBStringField
      FieldName = 'STRUKTURAL'
      Origin = 'AOMAP.STRUKTURAL'
      Size = 50
    end
    object qrAOMapFUNGSIONAL: TIBStringField
      DisplayWidth = 50
      FieldName = 'FUNGSIONAL'
      Origin = 'AOMAP.FUNGSIONAL'
      Size = 50
    end
    object qrAOMapDESCRIPTION: TIBStringField
      FieldName = 'DESCRIPTION'
      Origin = 'AOMAP.DESCRIPTION'
      Size = 40
    end
  end
  object dsMap: TDataSource
    DataSet = qrAOMap
    Left = 88
    Top = 56
  end
  object qrMContacts: TIBDataSet
    Database = Data.Database
    Transaction = Data.txEntry
    ForcedRefresh = True
    OnNewRecord = qrMContactsNewRecord
    BufferChunks = 1000
    CachedUpdates = False
    DeleteSQL.Strings = (
      'delete from Contacts'
      'where'
      '  DID = :OLD_DID')
    InsertSQL.Strings = (
      'insert into Contacts'
      '  (DID, LID, LINKTYPE, CTID, CONTACT)'
      'values'
      '  (:DID, :LID, :LINKTYPE, :CTID, :CONTACT)')
    RefreshSQL.Strings = (
      'Select '
      '  DID,'
      '  LID,'
      '  LINKTYPE,'
      '  CTID,'
      '  CONTACT'
      'from Contacts '
      'where'
      '  DID = :DID')
    SelectSQL.Strings = (
      'SELECT * FROM Contacts'
      'WHERE LID = :MID AND LinkType = '#39'M'#39';')
    ModifySQL.Strings = (
      'update Contacts'
      'set'
      '  DID = :DID,'
      '  LID = :LID,'
      '  LINKTYPE = :LINKTYPE,'
      '  CTID = :CTID,'
      '  CONTACT = :CONTACT'
      'where'
      '  DID = :OLD_DID')
    DataSource = dsMap
    Left = 88
    Top = 120
    object IntegerField1: TIntegerField
      FieldName = 'DID'
      Origin = 'CONTACTS.DID'
      Required = True
    end
    object IntegerField2: TIntegerField
      FieldName = 'LID'
      Origin = 'CONTACTS.LID'
      Required = True
    end
    object IBStringField1: TIBStringField
      FieldName = 'LINKTYPE'
      Origin = 'CONTACTS.LINKTYPE'
      Required = True
      FixedChar = True
      Size = 1
    end
    object IntegerField3: TIntegerField
      FieldName = 'CTID'
      Origin = 'ACONTACTS.CTID'
      Required = True
    end
    object IBStringField2: TIBStringField
      DisplayWidth = 50
      FieldName = 'CONTACT'
      Origin = 'ACONTACTS.CONTACT'
      Required = True
      Size = 50
    end
    object StringField1: TStringField
      FieldKind = fkLookup
      FieldName = 'ContactType'
      LookupDataSet = qrContactType
      LookupKeyFields = 'CTID'
      LookupResultField = 'CONTACTTYPE'
      KeyFields = 'CTID'
      Lookup = True
    end
  end
  object dsMContacts: TDataSource
    DataSet = qrMContacts
    Left = 88
    Top = 168
  end
  object qrContactType: TIBQuery
    Database = Data.Database
    Transaction = Data.txEntry
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'SELECT * FROM ContactType')
    Left = 88
    Top = 216
  end
  object dsContactType: TDataSource
    DataSet = qrContactType
    Left = 88
    Top = 264
  end
  object qrAlumni: TIBQuery
    Database = Data.Database
    Transaction = Data.txEntry
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'SELECT AID, Name FROM Alumni')
    Left = 160
    Top = 8
  end
  object dsAlumni: TDataSource
    DataSet = qrAlumni
    Left = 160
    Top = 56
  end
  object qrOrganization: TIBQuery
    Database = Data.Database
    Transaction = Data.txEntry
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'SELECT OID, Organization FROM Organization')
    Left = 216
    Top = 8
  end
  object dsOrganization: TDataSource
    DataSet = qrOrganization
    Left = 216
    Top = 56
  end
  object qrJobType: TIBQuery
    Database = Data.Database
    Transaction = Data.txEntry
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'SELECT * FROM JobType')
    Left = 320
    Top = 8
  end
  object dsJobType: TDataSource
    DataSet = qrJobType
    Left = 320
    Top = 56
  end
  object qrJobPosition: TIBQuery
    Database = Data.Database
    Transaction = Data.txEntry
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'SELECT * FROM JobPosition')
    Left = 272
    Top = 8
  end
  object dsJobPosition: TDataSource
    DataSet = qrJobPosition
    Left = 272
    Top = 56
  end
  object dsNegara: TDataSource
    DataSet = qrNegara
    Left = 272
    Top = 168
  end
  object qrNegara: TIBQuery
    Database = Data.Database
    Transaction = Data.txEntry
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'SELECT * FROM Negara')
    Left = 272
    Top = 120
  end
  object qrPropinsi: TIBQuery
    Database = Data.Database
    Transaction = Data.txEntry
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'SELECT * FROM Propinsi')
    Left = 216
    Top = 120
  end
  object dsPropinsi: TDataSource
    DataSet = qrPropinsi
    OnDataChange = dsPropinsiDataChange
    Left = 216
    Top = 168
  end
  object qrMOffices: TIBDataSet
    Database = Data.Database
    Transaction = Data.txEntry
    ForcedRefresh = True
    OnNewRecord = qrMOfficesNewRecord
    BufferChunks = 1000
    CachedUpdates = False
    DeleteSQL.Strings = (
      'delete from Address'
      'where'
      '  DID = :OLD_DID')
    InsertSQL.Strings = (
      'insert into Address'
      
        '  (DID, LID, LINKTYPE, KAWASAN, GEDUNG, JALAN, POSTALCODE, NEGAR' +
        'AID, PROPINSIID, '
      '   WILAYAHID)'
      'values'
      
        '  (:DID, :LID, :LINKTYPE, :KAWASAN, :GEDUNG, :JALAN, :POSTALCODE' +
        ', :NEGARAID, '
      '   :PROPINSIID, :WILAYAHID)')
    RefreshSQL.Strings = (
      'Select '
      '  DID,'
      '  LID,'
      '  LINKTYPE,'
      '  KAWASAN,'
      '  GEDUNG,'
      '  JALAN,'
      '  POSTALCODE,'
      '  NEGARAID,'
      '  PROPINSIID,'
      '  WILAYAHID'
      'from Address '
      'where'
      '  DID = :DID')
    SelectSQL.Strings = (
      'SELECT * FROM Address'
      'WHERE LID = :MID  AND LinkType = '#39'M'#39';')
    ModifySQL.Strings = (
      'update Address'
      'set'
      '  DID = :DID,'
      '  LID = :LID,'
      '  LINKTYPE = :LINKTYPE,'
      '  KAWASAN = :KAWASAN,'
      '  GEDUNG = :GEDUNG,'
      '  JALAN = :JALAN,'
      '  POSTALCODE = :POSTALCODE,'
      '  NEGARAID = :NEGARAID,'
      '  PROPINSIID = :PROPINSIID,'
      '  WILAYAHID = :WILAYAHID'
      'where'
      '  DID = :OLD_DID')
    DataSource = dsMap
    Left = 160
    Top = 120
    object qrMOfficesDID: TIntegerField
      FieldName = 'DID'
      Origin = 'ADDRESS.DID'
      Required = True
    end
    object qrMOfficesLID: TIntegerField
      FieldName = 'LID'
      Origin = 'ADDRESS.LID'
      Required = True
    end
    object qrMOfficesLINKTYPE: TIBStringField
      FieldName = 'LINKTYPE'
      Origin = 'ADDRESS.LINKTYPE'
      Required = True
      FixedChar = True
      Size = 1
    end
    object qrMOfficesKAWASAN: TIBStringField
      FieldName = 'KAWASAN'
      Origin = 'AHOMES.KAWASAN'
      Size = 50
    end
    object qrMOfficesGEDUNG: TIBStringField
      FieldName = 'GEDUNG'
      Origin = 'ADDRESS.GEDUNG'
      Size = 50
    end
    object qrMOfficesJALAN: TIBStringField
      FieldName = 'JALAN'
      Origin = 'AHOMES.JALAN'
      Size = 50
    end
    object qrMOfficesPOSTALCODE: TIBStringField
      FieldName = 'POSTALCODE'
      Origin = 'AHOMES.POSTALCODE'
      Size = 7
    end
    object qrMOfficesNegara: TStringField
      FieldKind = fkLookup
      FieldName = 'Negara'
      LookupDataSet = qrNegara
      LookupKeyFields = 'NEGARAID'
      LookupResultField = 'NEGARA'
      KeyFields = 'NEGARAID'
      Lookup = True
    end
    object qrMOfficesPropinsi: TStringField
      FieldKind = fkLookup
      FieldName = 'Propinsi'
      LookupDataSet = qrPropinsi
      LookupKeyFields = 'PROPINSIID'
      LookupResultField = 'PROPINSI'
      KeyFields = 'PROPINSIID'
      Lookup = True
    end
    object qrMOfficesWilayah: TStringField
      FieldKind = fkLookup
      FieldName = 'Wilayah'
      LookupDataSet = qrWilayah
      LookupKeyFields = 'WILAYAHID'
      LookupResultField = 'WILAYAH'
      KeyFields = 'WILAYAHID'
      Lookup = True
    end
    object qrMOfficesNEGARAID: TIntegerField
      FieldName = 'NEGARAID'
      Origin = 'AHOMES.NEGARAID'
    end
    object qrMOfficesPROPINSIID: TIntegerField
      FieldName = 'PROPINSIID'
      Origin = 'AHOMES.PROPINSIID'
    end
    object qrMOfficesWILAYAHID: TIntegerField
      FieldName = 'WILAYAHID'
      Origin = 'AHOMES.WILAYAHID'
    end
  end
  object dsMOffices: TDataSource
    DataSet = qrMOffices
    Left = 160
    Top = 168
  end
  object qrWilayah: TIBQuery
    Database = Data.Database
    Transaction = Data.txEntry
    BufferChunks = 1000
    CachedUpdates = False
    DataSource = dsPropinsi
    SQL.Strings = (
      'SELECT * FROM Wilayah'
      'WHERE PropinsiID = :PropinsiID')
    Left = 216
    Top = 216
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PROPINSIID'
        ParamType = ptUnknown
      end>
  end
  object dsWilayah: TDataSource
    DataSet = qrWilayah
    Left = 216
    Top = 264
  end
end
