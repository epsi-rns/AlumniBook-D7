object dmOr: TdmOr
  OldCreateOrder = False
  Left = 224
  Top = 270
  Height = 463
  Width = 559
  object qrOrganization: TIBDataSet
    Database = Data.Database
    Transaction = Data.txEntry
    ForcedRefresh = True
    AfterScroll = qrOrganizationAfterScroll
    BeforeClose = qrOrganizationBeforeClose
    BeforeDelete = qrOrganizationBeforeDelete
    OnNewRecord = qrOrganizationNewRecord
    BufferChunks = 1000
    CachedUpdates = False
    DeleteSQL.Strings = (
      'delete from Organization'
      'where'
      '  OID = :OLD_OID')
    InsertSQL.Strings = (
      'insert into Organization'
      
        '  (OID, ORGANIZATION, LAST_UPDATE, SOURCEID, UPDATERID, COLLECTO' +
        'RID, HASBRANCH, PARENTID, '
      '   PRODUCT, MEMO)'
      'values'
      
        '  (:OID, :ORGANIZATION, :LAST_UPDATE, :SOURCEID, :UPDATERID, :CO' +
        'LLECTORID, :HASBRANCH, '
      '   :PARENTID, :PRODUCT, :MEMO)')
    RefreshSQL.Strings = (
      'Select '
      '  OID,'
      '  ORGANIZATION,'
      '  LAST_UPDATE,'
      '  SOURCEID,'
      '  UPDATERID,'
      '  COLLECTORID,'
      '  HASBRANCH,'
      '  PARENTID,'
      '  PRODUCT,'
      '  MEMO'
      'from Organization '
      'where'
      '  OID = :OID')
    SelectSQL.Strings = (
      'SELECT * FROM Organization'
      'WHERE OID = :OID')
    ModifySQL.Strings = (
      'update Organization'
      'set'
      '  OID = :OID,'
      '  ORGANIZATION = :ORGANIZATION,'
      '  LAST_UPDATE = :LAST_UPDATE,'
      '  SOURCEID = :SOURCEID,'
      '  UPDATERID = :UPDATERID,'
      '  COLLECTORID = :COLLECTORID,'
      '  HASBRANCH = :HASBRANCH,'
      '  PARENTID = :PARENTID,'
      '  PRODUCT = :PRODUCT,'
      '  MEMO = :MEMO'
      'where'
      '  OID = :OLD_OID')
    DataSource = dsCursor
    Left = 96
    Top = 8
    object qrOrganizationOID: TIntegerField
      FieldName = 'OID'
      Origin = 'ORGANIZATION.OID'
      Required = True
    end
    object qrOrganizationORGANIZATION: TIBStringField
      FieldName = 'ORGANIZATION'
      Origin = 'ORGANIZATION.ORGANIZATION'
      Required = True
      Size = 50
    end
    object qrOrganizationLAST_UPDATE: TDateTimeField
      FieldName = 'LAST_UPDATE'
      Origin = 'ORGANIZATION.LAST_UPDATE'
      Required = True
    end
    object qrOrganizationSOURCEID: TIntegerField
      FieldName = 'SOURCEID'
      Origin = 'ORGANIZATION.SOURCEID'
      Required = True
    end
    object qrOrganizationUPDATERID: TIntegerField
      FieldName = 'UPDATERID'
      Origin = 'ORGANIZATION.UPDATERID'
      Required = True
    end
    object qrOrganizationCOLLECTORID: TIntegerField
      FieldName = 'COLLECTORID'
      Origin = 'ORGANIZATION.COLLECTORID'
      Required = True
    end
    object qrOrganizationHASBRANCH: TIBStringField
      FieldName = 'HASBRANCH'
      Origin = 'ORGANIZATION.HASBRANCH'
      FixedChar = True
      Size = 1
    end
    object qrOrganizationParent: TStringField
      FieldKind = fkLookup
      FieldName = 'Parent'
      LookupDataSet = qrParent
      LookupKeyFields = 'OID'
      LookupResultField = 'ORGANIZATION'
      KeyFields = 'OID'
      Lookup = True
    end
    object qrOrganizationPARENTID: TIntegerField
      FieldName = 'PARENTID'
      Origin = 'ORGANIZATION.PARENTID'
    end
    object qrOrganizationPRODUCT: TIBStringField
      DisplayWidth = 60
      FieldName = 'PRODUCT'
      Origin = 'ORGANIZATION.PRODUCT'
      Size = 60
    end
    object qrOrganizationMEMO: TMemoField
      FieldName = 'MEMO'
      Origin = 'ORGANIZATION.MEMO'
      BlobType = ftMemo
      Size = 8
    end
  end
  object dsOrganization: TDataSource
    DataSet = qrOrganization
    Left = 96
    Top = 56
  end
  object qrParent: TIBQuery
    Database = Data.Database
    Transaction = Data.txEntry
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'SELECT OID, Organization '
      'FROM Organization'
      'WHERE HasBranch = '#39'T'#39)
    Left = 160
    Top = 56
  end
  object dsParent: TDataSource
    DataSet = qrParent
    Left = 160
    Top = 104
  end
  object qrAOMap: TIBDataSet
    Database = Data.Database
    Transaction = Data.txEntry
    ForcedRefresh = True
    BeforeDelete = qrAOMapBeforeDelete
    OnNewRecord = qrAOMapNewRecord
    BufferChunks = 1000
    CachedUpdates = False
    DeleteSQL.Strings = (
      'delete from AOMap'
      'where'
      '  MID = :OLD_MID')
    InsertSQL.Strings = (
      'insert into AOMap'
      
        '  (MID, AID, OID, DEPARTMENT, JOBPOSITIONID, DESCRIPTION, STRUKT' +
        'URAL, '
      'FUNGSIONAL)'
      'values'
      '  (:MID, :AID, :OID, :DEPARTMENT, :JOBPOSITIONID, :DESCRIPTION, '
      ':STRUKTURAL, '
      '   :FUNGSIONAL)')
    RefreshSQL.Strings = (
      'Select '
      '  MID,'
      '  AID,'
      '  OID,'
      '  DEPARTMENT,'
      '  JOBPOSITIONID,'
      '  DESCRIPTION,'
      '  STRUKTURAL,'
      '  FUNGSIONAL'
      'from AOMap '
      'where'
      '  MID = :MID')
    SelectSQL.Strings = (
      'SELECT * FROM AOMap'
      'WHERE OID = :OID')
    ModifySQL.Strings = (
      'update AOMap'
      'set'
      '  MID = :MID,'
      '  AID = :AID,'
      '  OID = :OID,'
      '  DEPARTMENT = :DEPARTMENT,'
      '  JOBPOSITIONID = :JOBPOSITIONID,'
      '  DESCRIPTION = :DESCRIPTION,'
      '  STRUKTURAL = :STRUKTURAL,'
      '  FUNGSIONAL = :FUNGSIONAL'
      'where'
      '  MID = :OLD_MID')
    DataSource = dsOrganization
    Left = 440
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
    object qrAOMapName: TStringField
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
    object qrAOMapCommunity: TStringField
      FieldKind = fkLookup
      FieldName = 'Community'
      LookupDataSet = qrAlumni
      LookupKeyFields = 'AID'
      LookupResultField = 'Community'
      KeyFields = 'AID'
      Lookup = True
    end
  end
  object dsMap: TDataSource
    DataSet = qrAOMap
    Left = 440
    Top = 56
  end
  object qrAlumni: TIBQuery
    Database = Data.Database
    Transaction = Data.txEntry
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'SELECT A.AID, A.Name, C.Community FROM Alumni A'
      '  LEFT JOIN ACommunities C ON (A.AID=C.AID)')
    Left = 496
    Top = 8
  end
  object dsAlumni: TDataSource
    DataSet = qrAlumni
    Left = 496
    Top = 56
  end
  object qrOOffices: TIBDataSet
    Database = Data.Database
    Transaction = Data.txEntry
    ForcedRefresh = True
    OnNewRecord = qrOOfficesNewRecord
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
      'WHERE LID = :OID AND LinkType = '#39'O'#39';')
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
    DataSource = dsOrganization
    Left = 272
    Top = 8
    object qrOOfficesDID: TIntegerField
      FieldName = 'DID'
      Origin = 'ADDRESS.DID'
      Required = True
    end
    object qrOOfficesLID: TIntegerField
      FieldName = 'LID'
      Origin = 'ADDRESS.LID'
      Required = True
    end
    object qrOOfficesLINKTYPE: TIBStringField
      FieldName = 'LINKTYPE'
      Origin = 'ADDRESS.LINKTYPE'
      Required = True
      FixedChar = True
      Size = 1
    end
    object qrOOfficesKAWASAN: TIBStringField
      FieldName = 'KAWASAN'
      Origin = 'AHOMES.KAWASAN'
      Size = 50
    end
    object qrOOfficesGEDUNG: TIBStringField
      FieldName = 'GEDUNG'
      Origin = 'OOFFICES.GEDUNG'
      Size = 50
    end
    object qrOOfficesJALAN: TIBStringField
      FieldName = 'JALAN'
      Origin = 'AHOMES.JALAN'
      Size = 50
    end
    object qrOOfficesPOSTALCODE: TIBStringField
      FieldName = 'POSTALCODE'
      Origin = 'AHOMES.POSTALCODE'
      Size = 7
    end
    object qrOOfficesNegara: TStringField
      FieldKind = fkLookup
      FieldName = 'Negara'
      LookupDataSet = qrNegara
      LookupKeyFields = 'NEGARAID'
      LookupResultField = 'NEGARA'
      KeyFields = 'NEGARAID'
      Lookup = True
    end
    object qrOOfficesPropinsi: TStringField
      FieldKind = fkLookup
      FieldName = 'Propinsi'
      LookupDataSet = qrPropinsi
      LookupKeyFields = 'PROPINSIID'
      LookupResultField = 'PROPINSI'
      KeyFields = 'PROPINSIID'
      Lookup = True
    end
    object qrOOfficesWilayah: TStringField
      FieldKind = fkLookup
      FieldName = 'Wilayah'
      LookupDataSet = qrWilayah
      LookupKeyFields = 'WILAYAHID'
      LookupResultField = 'WILAYAH'
      KeyFields = 'WILAYAHID'
      Lookup = True
    end
    object qrOOfficesNEGARAID: TIntegerField
      FieldName = 'NEGARAID'
      Origin = 'AHOMES.NEGARAID'
    end
    object qrOOfficesPROPINSIID: TIntegerField
      FieldName = 'PROPINSIID'
      Origin = 'AHOMES.PROPINSIID'
    end
    object qrOOfficesWILAYAHID: TIntegerField
      FieldName = 'WILAYAHID'
      Origin = 'AHOMES.WILAYAHID'
    end
  end
  object qrPropinsi: TIBQuery
    Database = Data.Database
    Transaction = Data.txEntry
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'SELECT * FROM Propinsi')
    Left = 328
    Top = 8
  end
  object qrNegara: TIBQuery
    Database = Data.Database
    Transaction = Data.txEntry
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'SELECT * FROM Negara')
    Left = 376
    Top = 8
  end
  object dsNegara: TDataSource
    DataSet = qrNegara
    Left = 376
    Top = 56
  end
  object dsPropinsi: TDataSource
    DataSet = qrPropinsi
    OnDataChange = dsPropinsiDataChange
    Left = 328
    Top = 56
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
    Left = 328
    Top = 104
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PROPINSIID'
        ParamType = ptUnknown
      end>
  end
  object dsWilayah: TDataSource
    DataSet = qrWilayah
    Left = 328
    Top = 152
  end
  object dsOffices: TDataSource
    DataSet = qrOOffices
    Left = 272
    Top = 56
  end
  object qrOContacts: TIBDataSet
    Database = Data.Database
    Transaction = Data.txEntry
    ForcedRefresh = True
    OnNewRecord = qrOContactsNewRecord
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
      'WHERE LID = :OID AND LinkType = '#39'O'#39';')
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
    DataSource = dsOrganization
    Left = 24
    Top = 208
    object qrOContactsDID: TIntegerField
      FieldName = 'DID'
      Origin = 'CONTACTS.DID'
      Required = True
    end
    object qrOContactsLID: TIntegerField
      FieldName = 'LID'
      Origin = 'CONTACTS.LID'
      Required = True
    end
    object qrOContactsLINKTYPE: TIBStringField
      FieldName = 'LINKTYPE'
      Origin = 'CONTACTS.LINKTYPE'
      Required = True
      FixedChar = True
      Size = 1
    end
    object qrOContactsCTID: TIntegerField
      FieldName = 'CTID'
      Origin = 'ACONTACTS.CTID'
      Required = True
    end
    object qrOContactsCONTACT: TIBStringField
      DisplayWidth = 50
      FieldName = 'CONTACT'
      Origin = 'ACONTACTS.CONTACT'
      Required = True
      Size = 50
    end
    object qrOContactsContactType: TStringField
      FieldKind = fkLookup
      FieldName = 'ContactType'
      LookupDataSet = qrContactType1
      LookupKeyFields = 'CTID'
      LookupResultField = 'CONTACTTYPE'
      KeyFields = 'CTID'
      Lookup = True
    end
  end
  object dsOContacts: TDataSource
    DataSet = qrOContacts
    Left = 24
    Top = 256
  end
  object qrContactType1: TIBQuery
    Database = Data.Database
    Transaction = Data.txEntry
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'SELECT * FROM ContactType')
    Left = 24
    Top = 304
  end
  object dsContactType1: TDataSource
    DataSet = qrContactType1
    Left = 24
    Top = 352
  end
  object qrOFields: TIBDataSet
    Database = Data.Database
    Transaction = Data.txEntry
    ForcedRefresh = True
    OnNewRecord = qrOFieldsNewRecord
    BufferChunks = 1000
    CachedUpdates = False
    DeleteSQL.Strings = (
      'delete from OFields'
      'where'
      '  DID = :OLD_DID')
    InsertSQL.Strings = (
      'insert into OFields'
      '  (DID, OID, FIELDID, DESCRIPTION)'
      'values'
      '  (:DID, :OID, :FIELDID, :DESCRIPTION)')
    RefreshSQL.Strings = (
      'Select '
      '  DID,'
      '  OID,'
      '  FIELDID,'
      '  DESCRIPTION'
      'from OFields '
      'where'
      '  DID = :DID')
    SelectSQL.Strings = (
      'SELECT * FROM OFields'
      'WHERE OID = :OID')
    ModifySQL.Strings = (
      'update OFields'
      'set'
      '  DID = :DID,'
      '  OID = :OID,'
      '  FIELDID = :FIELDID,'
      '  DESCRIPTION = :DESCRIPTION'
      'where'
      '  DID = :OLD_DID')
    DataSource = dsOrganization
    Left = 160
    Top = 208
    object qrOFieldsDID: TIntegerField
      FieldName = 'DID'
      Origin = 'OFIELDS.DID'
      Required = True
    end
    object qrOFieldsOID: TIntegerField
      FieldName = 'OID'
      Origin = 'OFIELDS.OID'
      Required = True
    end
    object qrOFieldsField: TStringField
      FieldKind = fkLookup
      FieldName = 'Field'
      LookupDataSet = qrField
      LookupKeyFields = 'FIELDID'
      LookupResultField = 'FIELD'
      KeyFields = 'FIELDID'
      Lookup = True
    end
    object qrOFieldsFIELDID: TIntegerField
      FieldName = 'FIELDID'
      Origin = 'OFIELDS.FIELDID'
      Required = True
    end
    object qrOFieldsDESCRIPTION: TIBStringField
      FieldName = 'DESCRIPTION'
      Origin = 'OFIELDS.DESCRIPTION'
      Size = 35
    end
  end
  object dsFields: TDataSource
    DataSet = qrOFields
    Left = 160
    Top = 256
  end
  object qrField: TIBQuery
    Database = Data.Database
    Transaction = Data.txEntry
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'SELECT * FROM Field')
    Left = 160
    Top = 304
  end
  object dsField: TDataSource
    DataSet = qrField
    Left = 160
    Top = 352
  end
  object dsCursor: TDataSource
    DataSet = BrowseOrganization.qrLookup
    Left = 24
    Top = 8
  end
  object dsBranch: TDataSource
    DataSet = qrBranch
    Left = 440
    Top = 152
  end
  object qrBranch: TIBQuery
    Database = Data.Database
    Transaction = Data.txEntry
    BufferChunks = 1000
    CachedUpdates = False
    DataSource = dsOrganization
    SQL.Strings = (
      'SELECT OID, Organization FROM Organization'
      'WHERE ParentID= :OID')
    Left = 440
    Top = 104
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'OID'
        ParamType = ptUnknown
      end>
  end
  object qrUpdateBranch: TIBSQL
    Database = Data.Database
    ParamCheck = True
    SQL.Strings = (
      'UPDATE Organization')
    Transaction = Data.txEntry
    Left = 440
    Top = 208
  end
end
