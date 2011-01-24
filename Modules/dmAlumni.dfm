object dmAl: TdmAl
  OldCreateOrder = False
  Left = 377
  Top = 198
  Height = 458
  Width = 597
  object qrAHomes: TIBDataSet
    Database = Data.Database
    Transaction = Data.txEntry
    ForcedRefresh = True
    OnNewRecord = qrAHomesNewRecord
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
      'WHERE LID = :AID  AND LinkType = '#39'A'#39';')
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
    DataSource = dsAlumni
    Left = 312
    Top = 8
    object qrAHomesDID: TIntegerField
      FieldName = 'DID'
      Origin = 'ADDRESS.DID'
      Required = True
    end
    object qrAHomesLID: TIntegerField
      FieldName = 'LID'
      Origin = 'ADDRESS.LID'
      Required = True
    end
    object qrAHomesLINKTYPE: TIBStringField
      FieldName = 'LINKTYPE'
      Origin = 'ADDRESS.LINKTYPE'
      Required = True
      FixedChar = True
      Size = 1
    end
    object qrAHomesKAWASAN: TIBStringField
      FieldName = 'KAWASAN'
      Origin = 'AHOMES.KAWASAN'
      Size = 50
    end
    object qrAHomesGEDUNG: TIBStringField
      FieldName = 'GEDUNG'
      Origin = 'ADDRESS.GEDUNG'
      Size = 50
    end
    object qrAHomesJALAN: TIBStringField
      FieldName = 'JALAN'
      Origin = 'AHOMES.JALAN'
      Size = 50
    end
    object qrAHomesPOSTALCODE: TIBStringField
      FieldName = 'POSTALCODE'
      Origin = 'AHOMES.POSTALCODE'
      Size = 7
    end
    object qrAHomesNegara: TStringField
      FieldKind = fkLookup
      FieldName = 'Negara'
      LookupDataSet = qrNegara
      LookupKeyFields = 'NEGARAID'
      LookupResultField = 'NEGARA'
      KeyFields = 'NEGARAID'
      Lookup = True
    end
    object qrAHomesPropinsi: TStringField
      FieldKind = fkLookup
      FieldName = 'Propinsi'
      LookupDataSet = qrPropinsi
      LookupKeyFields = 'PROPINSIID'
      LookupResultField = 'PROPINSI'
      KeyFields = 'PROPINSIID'
      Lookup = True
    end
    object qrAHomesWilayah: TStringField
      FieldKind = fkLookup
      FieldName = 'Wilayah'
      LookupDataSet = qrWilayah
      LookupKeyFields = 'WILAYAHID'
      LookupResultField = 'WILAYAH'
      KeyFields = 'WILAYAHID'
      Lookup = True
    end
    object qrAHomesNEGARAID: TIntegerField
      FieldName = 'NEGARAID'
      Origin = 'AHOMES.NEGARAID'
    end
    object qrAHomesPROPINSIID: TIntegerField
      FieldName = 'PROPINSIID'
      Origin = 'AHOMES.PROPINSIID'
    end
    object qrAHomesWILAYAHID: TIntegerField
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
    Left = 360
    Top = 8
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
    Left = 360
    Top = 104
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PROPINSIID'
        ParamType = ptUnknown
      end>
  end
  object dsPropinsi: TDataSource
    DataSet = qrPropinsi
    OnDataChange = dsPropinsiDataChange
    Left = 360
    Top = 56
  end
  object qrAlumni: TIBDataSet
    Database = Data.Database
    Transaction = Data.txEntry
    ForcedRefresh = True
    AfterScroll = qrAlumniAfterScroll
    BeforeClose = qrAlumniBeforeClose
    BeforeDelete = qrAlumniBeforeDelete
    OnNewRecord = qrAlumniNewRecord
    BufferChunks = 1000
    CachedUpdates = False
    DeleteSQL.Strings = (
      'delete from Alumni'
      'where'
      '  AID = :OLD_AID')
    InsertSQL.Strings = (
      'insert into Alumni'
      
        '  (AID, NAME, PREFIX, SUFFIX, LAST_UPDATE, UPDATERID, COLLECTORI' +
        'D, SOURCEID, '
      '   BIRTHPLACE, BIRTHDATE, GENDER, RELIGIONID, MEMO, SHOWTITLE)'
      'values'
      
        '  (:AID, :NAME, :PREFIX, :SUFFIX, :LAST_UPDATE, :UPDATERID, :COL' +
        'LECTORID, :SOURCEID,'
      '   :BIRTHPLACE, :BIRTHDATE, :GENDER, :RELIGIONID, :MEMO, '
      ':SHOWTITLE)')
    RefreshSQL.Strings = (
      'Select '
      '  AID,'
      '  NAME,'
      '  PREFIX,'
      '  SUFFIX,'
      '  LAST_UPDATE,'
      '  SOURCEID,'
      '  UPDATERID,'
      '  COLLECTORID,'
      '  BIRTHPLACE,'
      '  BIRTHDATE,'
      '  GENDER,'
      '  RELIGIONID,'
      '  MEMO,'
      '  ENTRYDATE,'
      '  SHOWTITLE'
      'from Alumni '
      'where'
      '  AID = :AID')
    SelectSQL.Strings = (
      'SELECT * FROM Alumni'
      'WHERE AID = :AID')
    ModifySQL.Strings = (
      'update Alumni'
      'set'
      '  AID = :AID,'
      '  NAME = :NAME,'
      '  PREFIX = :PREFIX,'
      '  SUFFIX = :SUFFIX,'
      '  LAST_UPDATE = :LAST_UPDATE,'
      '  SOURCEID = :SOURCEID,'
      '  UPDATERID = :UPDATERID,'
      '  COLLECTORID = :COLLECTORID,'
      '  BIRTHPLACE = :BIRTHPLACE,'
      '  BIRTHDATE = :BIRTHDATE,'
      '  GENDER = :GENDER,'
      '  RELIGIONID = :RELIGIONID,'
      '  MEMO = :MEMO,'
      '  SHOWTITLE = :SHOWTITLE'
      'where'
      '  AID = :OLD_AID')
    DataSource = dsCursor
    Left = 80
    Top = 8
    object qrAlumniAID: TIntegerField
      FieldName = 'AID'
      Origin = 'ALUMNI.AID'
      Required = True
    end
    object qrAlumniNAME: TIBStringField
      FieldName = 'NAME'
      Origin = 'ALUMNI.NAME'
      Required = True
      OnGetText = qrAlumniGetText
      OnSetText = qrAlumniSetText
      Size = 50
    end
    object qrAlumniPREFIX: TIBStringField
      FieldName = 'PREFIX'
      Origin = 'ALUMNI.PREFIX'
      OnGetText = qrAlumniGetText
      OnSetText = qrAlumniSetText
      Size = 15
    end
    object qrAlumniSUFFIX: TIBStringField
      FieldName = 'SUFFIX'
      Origin = 'ALUMNI.SUFFIX'
      OnGetText = qrAlumniGetText
      OnSetText = qrAlumniSetText
      Size = 10
    end
    object qrAlumniLAST_UPDATE: TDateTimeField
      FieldName = 'LAST_UPDATE'
      Origin = 'ALUMNI.LAST_UPDATE'
      Required = True
    end
    object qrAlumniSOURCEID: TIntegerField
      FieldName = 'SourceID'
      Origin = 'ALUMNI.SOURCEID'
      Required = True
    end
    object qrAlumniUPDATERID: TIntegerField
      FieldName = 'UPDATERID'
      Origin = 'ALUMNI.UPDATERID'
      Required = True
    end
    object qrAlumniCOLLECTORID: TIntegerField
      FieldName = 'COLLECTORID'
      Origin = 'ALUMNI.COLLECTORID'
      Required = True
    end
    object qrAlumniReligion: TStringField
      FieldKind = fkLookup
      FieldName = 'Religion'
      LookupDataSet = qrReligion
      LookupKeyFields = 'RELIGIONID'
      LookupResultField = 'RELIGION'
      KeyFields = 'RELIGIONID'
      Lookup = True
    end
    object qrAlumniSource: TStringField
      FieldKind = fkLookup
      FieldName = 'Source'
      LookupDataSet = qrSource
      LookupKeyFields = 'SourceID'
      LookupResultField = 'Source'
      KeyFields = 'SourceID'
      Size = 25
      Lookup = True
    end
    object qrAlumniBIRTHPLACE: TIBStringField
      FieldName = 'BIRTHPLACE'
      Origin = 'ALUMNI.BIRTHPLACE'
      OnGetText = qrAlumniGetText
      OnSetText = qrAlumniSetText
      Size = 15
    end
    object qrAlumniBIRTHDATE: TDateTimeField
      FieldName = 'BIRTHDATE'
      Origin = 'ALUMNI.BIRTHDATE'
    end
    object qrAlumniGENDER: TIBStringField
      FieldName = 'GENDER'
      Origin = 'ALUMNI.GENDER'
      FixedChar = True
      Size = 1
    end
    object qrAlumniRELIGIONID: TIntegerField
      FieldName = 'ReligionID'
      Origin = 'ALUMNI.RELIGIONID'
    end
    object qrAlumniMEMO: TMemoField
      FieldName = 'MEMO'
      Origin = 'ALUMNI.MEMO'
      BlobType = ftMemo
      Size = 8
    end
    object qrAlumniSHOWTITLE: TIBStringField
      FieldName = 'SHOWTITLE'
      Origin = 'ALUMNI.SHOWTITLE'
      FixedChar = True
      Size = 1
    end
  end
  object qrReligion: TIBQuery
    Database = Data.Database
    Transaction = Data.txEntry
    AfterOpen = LookupAfterOpen
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'SELECT * FROM Religion')
    Left = 136
    Top = 56
  end
  object dsReligion: TDataSource
    DataSet = qrReligion
    Left = 136
    Top = 104
  end
  object dsWilayah: TDataSource
    DataSet = qrWilayah
    Left = 360
    Top = 152
  end
  object qrNegara: TIBQuery
    Database = Data.Database
    Transaction = Data.txEntry
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'SELECT * FROM Negara')
    Left = 408
    Top = 8
  end
  object dsNegara: TDataSource
    DataSet = qrNegara
    Left = 408
    Top = 56
  end
  object dsHomes: TDataSource
    DataSet = qrAHomes
    Left = 312
    Top = 56
  end
  object qrAContacts: TIBDataSet
    Database = Data.Database
    Transaction = Data.txEntry
    ForcedRefresh = True
    OnNewRecord = qrAContactsNewRecord
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
      'WHERE LID = :AID  AND LinkType = '#39'A'#39';')
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
    DataSource = dsAlumni
    Left = 24
    Top = 208
    object qrAContactsDID: TIntegerField
      FieldName = 'DID'
      Origin = 'CONTACTS.DID'
      Required = True
    end
    object qrAContactsLID: TIntegerField
      FieldName = 'LID'
      Origin = 'CONTACTS.LID'
      Required = True
    end
    object qrAContactsLINKTYPE: TIBStringField
      FieldName = 'LINKTYPE'
      Origin = 'CONTACTS.LINKTYPE'
      Required = True
      FixedChar = True
      Size = 1
    end
    object qrAContactsCTID: TIntegerField
      FieldName = 'CTID'
      Origin = 'ACONTACTS.CTID'
      Required = True
    end
    object qrAContactsCONTACT: TIBStringField
      DisplayWidth = 50
      FieldName = 'CONTACT'
      Origin = 'ACONTACTS.CONTACT'
      Required = True
      Size = 50
    end
    object qrAContactsContactType: TStringField
      FieldKind = fkLookup
      FieldName = 'ContactType'
      LookupDataSet = qrContactType1
      LookupKeyFields = 'CTID'
      LookupResultField = 'CONTACTTYPE'
      KeyFields = 'CTID'
      Lookup = True
    end
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
  object dsContacts: TDataSource
    DataSet = qrAContacts
    Left = 24
    Top = 256
  end
  object dsContactType1: TDataSource
    DataSet = qrContactType1
    Left = 24
    Top = 352
  end
  object qrACommunities: TIBDataSet
    Database = Data.Database
    Transaction = Data.txEntry
    ForcedRefresh = True
    OnNewRecord = qrACommunitiesNewRecord
    BufferChunks = 1000
    CachedUpdates = False
    DeleteSQL.Strings = (
      'delete from ACommunities'
      'where'
      '  DID = :OLD_DID')
    InsertSQL.Strings = (
      'insert into ACommunities'
      '  (DID, AID, CID, ANGKATAN, KHUSUS)'
      'values'
      '  (:DID, :AID, :CID, :ANGKATAN, :KHUSUS)')
    RefreshSQL.Strings = (
      'Select '
      '  DID,'
      '  AID,'
      '  CID,'
      '  ANGKATAN,'
      '  KHUSUS'
      'from ACommunities '
      'where'
      '  DID = :DID')
    SelectSQL.Strings = (
      'SELECT * FROM ACommunities'
      'WHERE AID = :AID')
    ModifySQL.Strings = (
      'update ACommunities'
      'set'
      '  DID = :DID,'
      '  AID = :AID,'
      '  CID = :CID,'
      '  ANGKATAN = :ANGKATAN,'
      '  KHUSUS = :KHUSUS'
      'where'
      '  DID = :OLD_DID')
    DataSource = dsAlumni
    Left = 88
    Top = 208
    object qrACommunitiesDID: TIntegerField
      FieldName = 'DID'
      Origin = 'ACOMMUNITIES.DID'
      Required = True
    end
    object qrACommunitiesAID: TIntegerField
      FieldName = 'AID'
      Origin = 'ACOMMUNITIES.AID'
      Required = True
    end
    object qrACommunitiesCID: TIntegerField
      FieldName = 'CID'
      Origin = 'ACOMMUNITIES.CID'
      Required = True
    end
    object qrACommunitiesCommunity: TStringField
      FieldKind = fkLookup
      FieldName = 'Community'
      LookupDataSet = qrCommunity
      LookupKeyFields = 'CID'
      LookupResultField = 'COMMUNITY'
      KeyFields = 'CID'
      Lookup = True
    end
    object qrACommunitiesANGKATAN: TIntegerField
      FieldName = 'ANGKATAN'
      Origin = 'ACOMMUNITIES.ANGKATAN'
    end
    object qrACommunitiesKHUSUS: TIBStringField
      FieldName = 'KHUSUS'
      Origin = 'ACOMMUNITIES.KHUSUS'
      Size = 15
    end
  end
  object dsCommunities: TDataSource
    DataSet = qrACommunities
    Left = 88
    Top = 256
  end
  object qrCommunity: TIBQuery
    Database = Data.Database
    Transaction = Data.txEntry
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'SELECT * FROM Community')
    Left = 88
    Top = 304
  end
  object dsCommunity: TDataSource
    DataSet = qrCommunity
    Left = 88
    Top = 352
  end
  object qrADegrees: TIBDataSet
    Database = Data.Database
    Transaction = Data.txEntry
    ForcedRefresh = True
    OnNewRecord = qrADegreesNewRecord
    BufferChunks = 1000
    CachedUpdates = False
    DeleteSQL.Strings = (
      'delete from ADegrees'
      'where'
      '  DID = :OLD_DID')
    InsertSQL.Strings = (
      'insert into ADegrees'
      
        '  (DID, AID, STRATAID, ADMITTED, GRADUATED, DEGREE, INSTITUTION,' +
        ' MAJOR, '
      '   MINOR, CONCENTRATION)'
      'values'
      
        '  (:DID, :AID, :STRATAID, :ADMITTED, :GRADUATED, :DEGREE, :INSTI' +
        'TUTION, '
      '   :MAJOR, :MINOR, :CONCENTRATION)')
    RefreshSQL.Strings = (
      'Select '
      '  DID,'
      '  AID,'
      '  STRATAID,'
      '  ADMITTED,'
      '  GRADUATED,'
      '  DEGREE,'
      '  INSTITUTION,'
      '  MAJOR,'
      '  MINOR,'
      '  CONCENTRATION'
      'from ADegrees '
      'where'
      '  DID = :DID')
    SelectSQL.Strings = (
      'SELECT * FROM ADegrees'
      'WHERE AID = :AID')
    ModifySQL.Strings = (
      'update ADegrees'
      'set'
      '  DID = :DID,'
      '  AID = :AID,'
      '  STRATAID = :STRATAID,'
      '  ADMITTED = :ADMITTED,'
      '  GRADUATED = :GRADUATED,'
      '  DEGREE = :DEGREE,'
      '  INSTITUTION = :INSTITUTION,'
      '  MAJOR = :MAJOR,'
      '  MINOR = :MINOR,'
      '  CONCENTRATION = :CONCENTRATION'
      'where'
      '  DID = :OLD_DID')
    DataSource = dsAlumni
    Left = 168
    Top = 208
    object qrADegreesDID: TIntegerField
      FieldName = 'DID'
      Origin = 'ADEGREES.DID'
      Required = True
    end
    object qrADegreesAID: TIntegerField
      FieldName = 'AID'
      Origin = 'ADEGREES.AID'
      Required = True
    end
    object qrADegreesSTRATAID: TIntegerField
      FieldName = 'STRATAID'
      Origin = 'ADEGREES.STRATAID'
      Required = True
    end
    object qrADegreesStrata: TStringField
      FieldKind = fkLookup
      FieldName = 'Strata'
      LookupDataSet = qrStrata
      LookupKeyFields = 'STRATAID'
      LookupResultField = 'STRATA'
      KeyFields = 'STRATAID'
      Lookup = True
    end
    object qrADegreesADMITTED: TIntegerField
      FieldName = 'ADMITTED'
      Origin = 'ADEGREES.ADMITTED'
    end
    object qrADegreesGRADUATED: TIntegerField
      FieldName = 'GRADUATED'
      Origin = 'ADEGREES.GRADUATED'
    end
    object qrADegreesDEGREE: TIBStringField
      FieldName = 'DEGREE'
      Origin = 'ADEGREES.DEGREE'
    end
    object qrADegreesINSTITUTION: TIBStringField
      FieldName = 'INSTITUTION'
      Origin = 'ADEGREES.INSTITUTION'
      Size = 40
    end
    object qrADegreesMAJOR: TIBStringField
      FieldName = 'MAJOR'
      Origin = 'ADEGREES.MAJOR'
      Size = 40
    end
    object qrADegreesMINOR: TIBStringField
      FieldName = 'MINOR'
      Origin = 'ADEGREES.MINOR'
      Size = 40
    end
    object qrADegreesCONCENTRATION: TIBStringField
      FieldName = 'CONCENTRATION'
      Origin = 'ADEGREES.CONCENTRATION'
      Size = 40
    end
  end
  object dsDegrees: TDataSource
    DataSet = qrADegrees
    Left = 168
    Top = 256
  end
  object qrStrata: TIBQuery
    Database = Data.Database
    Transaction = Data.txEntry
    AfterOpen = LookupAfterOpen
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'SELECT * FROM Strata')
    Left = 168
    Top = 304
  end
  object dsStrata: TDataSource
    DataSet = qrStrata
    Left = 168
    Top = 352
  end
  object qrAExperiences: TIBDataSet
    Database = Data.Database
    Transaction = Data.txEntry
    ForcedRefresh = True
    OnNewRecord = qrAExperiencesNewRecord
    BufferChunks = 1000
    CachedUpdates = False
    DeleteSQL.Strings = (
      'delete from AExperiences'
      'where'
      '  DID = :OLD_DID')
    InsertSQL.Strings = (
      'insert into AExperiences'
      
        '  (DID, AID, ORGANIZATION, JOBPOSITION, YEARIN, YEAROUT, DESCRIP' +
        'TION)'
      'values'
      
        '  (:DID, :AID, :ORGANIZATION, :JOBPOSITION, :YEARIN, :YEAROUT, :' +
        'DESCRIPTION)')
    RefreshSQL.Strings = (
      'Select '
      '  DID,'
      '  AID,'
      '  ORGANIZATION,'
      '  JOBPOSITION,'
      '  YEARIN,'
      '  YEAROUT,'
      '  DESCRIPTION'
      'from AExperiences '
      'where'
      '  DID = :DID')
    SelectSQL.Strings = (
      'SELECT * FROM AExperiences'
      'WHERE AID = :AID')
    ModifySQL.Strings = (
      'update AExperiences'
      'set'
      '  DID = :DID,'
      '  AID = :AID,'
      '  ORGANIZATION = :ORGANIZATION,'
      '  JOBPOSITION = :JOBPOSITION,'
      '  YEARIN = :YEARIN,'
      '  YEAROUT = :YEAROUT,'
      '  DESCRIPTION = :DESCRIPTION'
      'where'
      '  DID = :OLD_DID')
    DataSource = dsAlumni
    Left = 240
    Top = 208
    object qrAExperiencesDID: TIntegerField
      FieldName = 'DID'
      Origin = 'AEXPERIENCES.DID'
      Required = True
    end
    object qrAExperiencesAID: TIntegerField
      FieldName = 'AID'
      Origin = 'AEXPERIENCES.AID'
      Required = True
    end
    object qrAExperiencesORGANIZATION: TIBStringField
      FieldName = 'ORGANIZATION'
      Origin = 'AEXPERIENCES.ORGANIZATION'
      Required = True
      Size = 50
    end
    object qrAExperiencesDESCRIPTION: TIBStringField
      FieldName = 'DESCRIPTION'
      Origin = 'AEXPERIENCES.DESCRIPTION'
      Size = 50
    end
    object qrAExperiencesJOBPOSITION: TIBStringField
      FieldName = 'JOBPOSITION'
      Origin = 'AEXPERIENCES.JOBPOSITION'
      Size = 35
    end
    object qrAExperiencesYEARIN: TIntegerField
      FieldName = 'YEARIN'
      Origin = 'AEXPERIENCES.YEARIN'
    end
    object qrAExperiencesYEAROUT: TIntegerField
      FieldName = 'YEAROUT'
      Origin = 'AEXPERIENCES.YEAROUT'
    end
  end
  object dsExperiences: TDataSource
    DataSet = qrAExperiences
    Left = 240
    Top = 256
  end
  object qrACompetencies: TIBDataSet
    Database = Data.Database
    Transaction = Data.txEntry
    ForcedRefresh = True
    OnNewRecord = qrACompetenciesNewRecord
    BufferChunks = 1000
    CachedUpdates = False
    DeleteSQL.Strings = (
      'delete from ACompetencies'
      'where'
      '  DID = :OLD_DID')
    InsertSQL.Strings = (
      'insert into ACompetencies'
      '  (DID, AID, COMPETENCYID, DESCRIPTION)'
      'values'
      '  (:DID, :AID, :COMPETENCYID, :DESCRIPTION)')
    RefreshSQL.Strings = (
      'Select '
      '  DID,'
      '  AID,'
      '  COMPETENCYID,'
      '  DESCRIPTION'
      'from ACompetencies '
      'where'
      '  DID = :DID')
    SelectSQL.Strings = (
      'SELECT * FROM ACompetencies'
      'WHERE AID = :AID')
    ModifySQL.Strings = (
      'update ACompetencies'
      'set'
      '  DID = :DID,'
      '  AID = :AID,'
      '  COMPETENCYID = :COMPETENCYID,'
      '  DESCRIPTION = :DESCRIPTION'
      'where'
      '  DID = :OLD_DID')
    DataSource = dsAlumni
    Left = 408
    Top = 208
    object qrACompetenciesDID: TIntegerField
      FieldName = 'DID'
      Origin = 'ACOMPETENCIES.DID'
      Required = True
    end
    object qrACompetenciesAID: TIntegerField
      FieldName = 'AID'
      Origin = 'ACOMPETENCIES.AID'
      Required = True
    end
    object qrACompetenciesCompetency: TStringField
      FieldKind = fkLookup
      FieldName = 'Competency'
      LookupDataSet = qrCompetency
      LookupKeyFields = 'COMPETENCYID'
      LookupResultField = 'COMPETENCY'
      KeyFields = 'COMPETENCYID'
      Lookup = True
    end
    object qrACompetenciesCOMPETENCYID: TIntegerField
      FieldName = 'COMPETENCYID'
      Origin = 'ACOMPETENCIES.COMPETENCYID'
      Required = True
    end
    object qrACompetenciesDESCRIPTION: TIBStringField
      FieldName = 'DESCRIPTION'
      Origin = 'ACOMPETENCIES.DESCRIPTION'
      Size = 35
    end
  end
  object dsCompetencies: TDataSource
    DataSet = qrACompetencies
    Left = 408
    Top = 256
  end
  object qrCompetency: TIBQuery
    Database = Data.Database
    Transaction = Data.txEntry
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'SELECT * FROM Competency')
    Left = 408
    Top = 304
  end
  object dsCompetency: TDataSource
    DataSet = qrCompetency
    Left = 408
    Top = 352
  end
  object qrACertifications: TIBDataSet
    Database = Data.Database
    Transaction = Data.txEntry
    ForcedRefresh = True
    OnNewRecord = qrACertificationsNewRecord
    BufferChunks = 1000
    CachedUpdates = False
    DeleteSQL.Strings = (
      'delete from ACertifications'
      'where'
      '  DID = :OLD_DID')
    InsertSQL.Strings = (
      'insert into ACertifications'
      '  (DID, AID, CERTIFICATION, INSTITUTION)'
      'values'
      '  (:DID, :AID, :CERTIFICATION, :INSTITUTION)')
    RefreshSQL.Strings = (
      'Select '
      '  DID,'
      '  AID,'
      '  CERTIFICATION,'
      '  INSTITUTION'
      'from ACertifications '
      'where'
      '  DID = :DID')
    SelectSQL.Strings = (
      'SELECT * FROM ACertifications'
      'WHERE AID = :AID')
    ModifySQL.Strings = (
      'update ACertifications'
      'set'
      '  DID = :DID,'
      '  AID = :AID,'
      '  CERTIFICATION = :CERTIFICATION,'
      '  INSTITUTION = :INSTITUTION'
      'where'
      '  DID = :OLD_DID')
    DataSource = dsAlumni
    Left = 320
    Top = 208
    object qrACertificationsDID: TIntegerField
      FieldName = 'DID'
      Origin = 'ACERTIFICATIONS.DID'
      Required = True
    end
    object qrACertificationsAID: TIntegerField
      FieldName = 'AID'
      Origin = 'ACERTIFICATIONS.AID'
      Required = True
    end
    object qrACertificationsCERTIFICATION: TIBStringField
      FieldName = 'CERTIFICATION'
      Origin = 'ACERTIFICATIONS.CERTIFICATION'
      Required = True
      Size = 50
    end
    object qrACertificationsINSTITUTION: TIBStringField
      FieldName = 'INSTITUTION'
      Origin = 'ACERTIFICATIONS.INSTITUTION'
    end
  end
  object dsCertificatons: TDataSource
    DataSet = qrACertifications
    Left = 320
    Top = 256
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
      'WHERE AID = :AID')
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
    DataSource = dsAlumni
    Left = 472
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
  end
  object dsMap: TDataSource
    DataSet = qrAOMap
    Left = 472
    Top = 56
  end
  object qrOrganization: TIBQuery
    Database = Data.Database
    Transaction = Data.txEntry
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'SELECT OID, Organization FROM Organization')
    Left = 536
    Top = 8
  end
  object dsOrganization: TDataSource
    DataSet = qrOrganization
    Left = 536
    Top = 56
  end
  object dsAlumni: TDataSource
    DataSet = qrAlumni
    Left = 80
    Top = 56
  end
  object dsCursor: TDataSource
    DataSet = BrowseAlumni.qrLookup
    Left = 16
    Top = 8
  end
  object qrSource: TIBQuery
    Database = Data.Database
    Transaction = Data.txEntry
    AfterOpen = LookupAfterOpen
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'SELECT * FROM Source')
    Left = 192
    Top = 56
  end
  object dsSource: TDataSource
    DataSet = qrSource
    Left = 192
    Top = 104
  end
end
