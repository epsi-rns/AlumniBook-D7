unit dmAlumni;

interface

uses
  SysUtils, Classes,
  IBDatabase, DB, IBCustomDataSet, IBTable, IBQuery, IBSQL;

type
  TdmAl = class(TDataModule)
    qrAHomes: TIBDataSet;
    qrPropinsi: TIBQuery;
    qrWilayah: TIBQuery;
    dsPropinsi: TDataSource;
    qrAlumni: TIBDataSet;
    qrReligion: TIBQuery;
    qrAlumniAID: TIntegerField;
    qrAlumniNAME: TIBStringField;
    qrAlumniPREFIX: TIBStringField;
    qrAlumniSUFFIX: TIBStringField;
    qrAlumniLAST_UPDATE: TDateTimeField;
    qrAlumniSOURCEID: TIntegerField;    
    qrAlumniUPDATERID: TIntegerField;
    qrAlumniCOLLECTORID: TIntegerField;
    qrAlumniBIRTHPLACE: TIBStringField;
    qrAlumniBIRTHDATE: TDateTimeField;
    qrAlumniGENDER: TIBStringField;
    qrAlumniRELIGIONID: TIntegerField;
    qrAlumniMEMO: TMemoField;
    dsReligion: TDataSource;
    dsWilayah: TDataSource;
    qrNegara: TIBQuery;
    dsNegara: TDataSource;
    qrAHomesKAWASAN: TIBStringField;
    qrAHomesJALAN: TIBStringField;
    qrAHomesPOSTALCODE: TIBStringField;
    qrAHomesNEGARAID: TIntegerField;
    qrAHomesPROPINSIID: TIntegerField;
    qrAHomesWILAYAHID: TIntegerField;
    qrAHomesNegara: TStringField;
    qrAHomesWilayah: TStringField;
    qrAHomesPropinsi: TStringField;
    dsHomes: TDataSource;
    qrAContacts: TIBDataSet;
    qrContactType1: TIBQuery;
    dsContacts: TDataSource;
    dsContactType1: TDataSource;
    qrAContactsCTID: TIntegerField;
    qrAContactsCONTACT: TIBStringField;
    qrAContactsContactType: TStringField;
    qrACommunities: TIBDataSet;
    dsCommunities: TDataSource;
    qrCommunity: TIBQuery;
    dsCommunity: TDataSource;
    qrACommunitiesAID: TIntegerField;
    qrACommunitiesCID: TIntegerField;
    qrACommunitiesANGKATAN: TIntegerField;
    qrACommunitiesKHUSUS: TIBStringField;
    qrACommunitiesCommunity: TStringField;
    qrADegrees: TIBDataSet;
    dsDegrees: TDataSource;
    qrStrata: TIBQuery;
    dsStrata: TDataSource;
    qrAExperiences: TIBDataSet;
    dsExperiences: TDataSource;
    qrACompetencies: TIBDataSet;
    dsCompetencies: TDataSource;
    qrCompetency: TIBQuery;
    dsCompetency: TDataSource;
    qrACertifications: TIBDataSet;
    dsCertificatons: TDataSource;
    qrADegreesAID: TIntegerField;
    qrADegreesSTRATAID: TIntegerField;
    qrADegreesADMITTED: TIntegerField;
    qrADegreesGRADUATED: TIntegerField;
    qrADegreesDEGREE: TIBStringField;
    qrADegreesINSTITUTION: TIBStringField;
    qrADegreesMAJOR: TIBStringField;
    qrADegreesMINOR: TIBStringField;
    qrADegreesCONCENTRATION: TIBStringField;
    qrADegreesStrata: TStringField;
    qrACompetenciesAID: TIntegerField;
    qrACompetenciesCOMPETENCYID: TIntegerField;
    qrACompetenciesDESCRIPTION: TIBStringField;
    qrACompetenciesCompetency: TStringField;
    qrAExperiencesAID: TIntegerField;
    qrAExperiencesORGANIZATION: TIBStringField;
    qrAExperiencesJOBPOSITION: TIBStringField;
    qrACertificationsAID: TIntegerField;
    qrACertificationsCERTIFICATION: TIBStringField;
    qrACertificationsINSTITUTION: TIBStringField;
    qrAOMap: TIBDataSet;
    dsMap: TDataSource;
    qrOrganization: TIBQuery;
    dsOrganization: TDataSource;
    qrAOMapAID: TIntegerField;
    qrAOMapOID: TIntegerField;
    qrAOMapOrganization: TStringField;
    qrAExperiencesYEARIN: TIntegerField;
    qrAExperiencesYEAROUT: TIntegerField;
    dsAlumni: TDataSource;
    qrAHomesDID: TIntegerField;
    qrAHomesLID: TIntegerField;
    qrAHomesLINKTYPE: TIBStringField;
    qrAHomesGEDUNG: TIBStringField;
    qrAContactsDID: TIntegerField;
    qrAContactsLID: TIntegerField;
    qrAContactsLINKTYPE: TIBStringField;
    qrAOMapMID: TIntegerField;
    qrACommunitiesDID: TIntegerField;
    qrADegreesDID: TIntegerField;
    qrAExperiencesDID: TIntegerField;
    qrACompetenciesDID: TIntegerField;
    qrACertificationsDID: TIntegerField;
    qrAlumniReligion: TStringField;
    qrAExperiencesDESCRIPTION: TIBStringField;
    dsCursor: TDataSource;
    qrAlumniSHOWTITLE: TIBStringField;
    qrSource: TIBQuery;
    dsSource: TDataSource;
    qrAlumniSource: TStringField;
    procedure qrAlumniSetText(Sender: TField;
      const Text: String);
    procedure qrAlumniGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure qrAlumniGENDERSetText(Sender: TField; const Text: String);
    procedure qrAHomesNewRecord(DataSet: TDataSet);
    procedure dsPropinsiDataChange(Sender: TObject; Field: TField);
    procedure qrAlumniNewRecord(DataSet: TDataSet);
    procedure qrAContactsNewRecord(DataSet: TDataSet);
    procedure qrACommunitiesNewRecord(DataSet: TDataSet);
    procedure qrADegreesNewRecord(DataSet: TDataSet);
    procedure qrAExperiencesNewRecord(DataSet: TDataSet);
    procedure qrACompetenciesNewRecord(DataSet: TDataSet);
    procedure qrACertificationsNewRecord(DataSet: TDataSet);
    procedure qrAOMapNewRecord(DataSet: TDataSet);
    procedure qrAlumniBeforeClose(DataSet: TDataSet);
    procedure LookupAfterOpen(DataSet: TDataSet);
    procedure qrAlumniAfterScroll(DataSet: TDataSet);
    procedure qrAlumniBeforeDelete(DataSet: TDataSet);
    procedure qrAOMapBeforeDelete(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    ActiveQuery: TDataSet;    
    ApplyFilter: Boolean;
  end;

var
  dmAl: TdmAl;

implementation

uses Controls, dmMain, BFormAlumni;

{$R *.dfm}

procedure TdmAl.qrAlumniAfterScroll(DataSet: TDataSet);
begin // Detail table
  if ActiveQuery<>nil then ActiveQuery.Open;
end;

procedure TdmAl.qrAlumniBeforeClose(DataSet: TDataSet);
begin
  // Detail table
  qrAOMap.Close;
  qrAHomes.Close;
  qrAContacts.Close;
  qrACommunities.Close;
  qrADegrees.Close;
  qrAExperiences.Close;
  qrACompetencies.Close;
  qrACertifications.Close;
end;

procedure TdmAl.dsPropinsiDataChange(Sender: TObject; Field: TField);
begin
  // Lookup table
  qrWilayah.Close;
  qrWilayah.Open;
  qrWilayah.Last;
end;

procedure TdmAl.qrAlumniNewRecord(DataSet: TDataSet);
begin
  qrAlumni['AID'] := Data.NextID;    // generator
  qrAlumni['LAST_UPDATE'] := Now;    // no date baby...
  qrAlumni['SourceID'] := 11;        // default Value
  qrAlumni['UpdaterID'] := 25;       // default Value for pre development
  qrAlumni['CollectorID'] := 21;     // default Value for pre development
  qrAlumni['ShowTitle'] := 'F';
end;

procedure TdmAl.qrAOMapNewRecord(DataSet: TDataSet);
begin
  qrAOMap['MID'] := Data.NextID;       // generator
  qrAOMap['AID'] := qrAlumni['AID'];
end;

procedure TdmAl.qrAHomesNewRecord(DataSet: TDataSet);
begin
  qrAHomes['DID'] := Data.NextDID;         // Detail generator
  qrAHomes['LID'] := qrAlumni['AID'];
  qrAHomes['LinkType'] := 'A';
  qrAHomes['NegaraID'] := 99;   // Indonesia...  
end;

procedure TdmAl.qrAContactsNewRecord(DataSet: TDataSet);
begin
  qrAContacts['DID'] := Data.NextDID;         // Detail generator
  qrAContacts['LID'] := qrAlumni['AID'];
  qrAContacts['LinkType'] := 'A';
end;

procedure TdmAl.qrACommunitiesNewRecord(DataSet: TDataSet);
begin
  qrACommunities['DID'] := Data.NextDID;         // Detail generator
  qrACommunities['AID'] := qrAlumni['AID'];
end;

procedure TdmAl.qrADegreesNewRecord(DataSet: TDataSet);
begin
  qrADegrees['DID'] := Data.NextDID;         // Detail generator
  qrADegrees['AID'] := qrAlumni['AID'];
  qrADegrees['StrataID'] := 10;              // S1
  qrADegrees['Degree'] := 'Ir.';  
  qrADegrees['Institution'] := 'University of Indonesia';
  qrADegrees['Major'] := 'Engineering';
end;

procedure TdmAl.qrAExperiencesNewRecord(DataSet: TDataSet);
begin
  qrAExperiences['DID'] := Data.NextDID;         // Detail generator
  qrAExperiences['AID'] := qrAlumni['AID'];
end;

procedure TdmAl.qrACompetenciesNewRecord(DataSet: TDataSet);
begin
  qrACompetencies['DID'] := Data.NextDID;         // Detail generator
  qrACompetencies['AID'] := qrAlumni['AID'];
end;

procedure TdmAl.qrACertificationsNewRecord(DataSet: TDataSet);
begin
  qrACertifications['DID'] := Data.NextDID;         // Detail generator
  qrACertifications['AID'] := qrAlumni['AID'];
end;

procedure TdmAl.qrAlumniSetText(Sender: TField;
  const Text: String);
begin
  if Text = ''
  then Sender.Clear
  else Sender.AsString := Text;
end;

procedure TdmAl.qrAlumniGetText(Sender: TField; var Text: String;
  DisplayText: Boolean);
begin
  if Sender.IsNull
  then Text := '<undefined>'
  else Text := Sender.AsString;
end;

procedure TdmAl.qrAlumniGENDERSetText(Sender: TField; const Text: String);
Var ch: char;
begin
  Ch := Upcase(Text[1]);
  if not (Ch in ['F', 'M']) then
    Sender.Clear
  else Sender.AsString := Ch;
end;

procedure TdmAl.LookupAfterOpen(DataSet: TDataSet);
begin
  DataSet.Last;     // Lookup Cosmetics
end;

procedure TdmAl.qrAlumniBeforeDelete(DataSet: TDataSet);
begin
  If Confirm ('This will also delete all homes and contacts.'
     + #10#13'Proceed?') <> mrYes then Abort;
end;

procedure TdmAl.qrAOMapBeforeDelete(DataSet: TDataSet);
begin
  If Confirm ('This will also delete all offices and contacts.'
     + #10#13'Proceed?') <> mrYes then Abort;
end;

end.
