unit dmOrganization;

interface

uses
  SysUtils, Classes, DB, IBCustomDataSet, IBQuery, IBSQL, IBDatabase;

type
  TdmOr = class(TDataModule)
    qrOrganization: TIBDataSet;
    dsOrganization: TDataSource;
    qrParent: TIBQuery;
    dsParent: TDataSource;
    qrOrganizationOID: TIntegerField;
    qrOrganizationORGANIZATION: TIBStringField;
    qrOrganizationLAST_UPDATE: TDateTimeField;
    qrOrganizationSOURCEID: TIntegerField;    
    qrOrganizationUPDATERID: TIntegerField;
    qrOrganizationCOLLECTORID: TIntegerField;
    qrOrganizationPARENTID: TIntegerField;
    qrOrganizationPRODUCT: TIBStringField;
    qrOrganizationMEMO: TMemoField;
    qrAOMap: TIBDataSet;
    qrAOMapAID: TIntegerField;
    qrAOMapOID: TIntegerField;
    dsMap: TDataSource;
    qrAlumni: TIBQuery;
    dsAlumni: TDataSource;
    qrAOMapName: TStringField;
    qrOOffices: TIBDataSet;
    qrOOfficesKAWASAN: TIBStringField;
    qrOOfficesJALAN: TIBStringField;
    qrOOfficesPOSTALCODE: TIBStringField;
    qrOOfficesNegara: TStringField;
    qrOOfficesPropinsi: TStringField;
    qrOOfficesWilayah: TStringField;
    qrOOfficesNEGARAID: TIntegerField;
    qrOOfficesPROPINSIID: TIntegerField;
    qrOOfficesWILAYAHID: TIntegerField;
    qrPropinsi: TIBQuery;
    qrNegara: TIBQuery;
    dsNegara: TDataSource;
    dsPropinsi: TDataSource;
    qrWilayah: TIBQuery;
    dsWilayah: TDataSource;
    qrOOfficesGEDUNG: TIBStringField;
    dsOffices: TDataSource;
    qrOContacts: TIBDataSet;
    qrOContactsCTID: TIntegerField;
    qrOContactsCONTACT: TIBStringField;
    qrOContactsContactType: TStringField;
    dsOContacts: TDataSource;
    qrContactType1: TIBQuery;
    dsContactType1: TDataSource;
    qrOFields: TIBDataSet;
    dsFields: TDataSource;
    qrField: TIBQuery;
    dsField: TDataSource;
    qrOFieldsOID: TIntegerField;
    qrOFieldsFIELDID: TIntegerField;
    qrOFieldsDESCRIPTION: TIBStringField;
    qrOFieldsField: TStringField;
    qrOOfficesDID: TIntegerField;
    qrOOfficesLID: TIntegerField;
    qrOOfficesLINKTYPE: TIBStringField;
    qrOContactsDID: TIntegerField;
    qrOContactsLID: TIntegerField;
    qrOContactsLINKTYPE: TIBStringField;
    qrOrganizationHASBRANCH: TIBStringField;
    qrOrganizationParent: TStringField;
    qrOFieldsDID: TIntegerField;
    qrAOMapMID: TIntegerField;
    dsCursor: TDataSource;
    dsBranch: TDataSource;
    qrBranch: TIBQuery;
    qrUpdateBranch: TIBSQL;
    qrAOMapCommunity: TStringField;
    procedure qrOrganizationNewRecord(DataSet: TDataSet);
    procedure qrOOfficesNewRecord(DataSet: TDataSet);
    procedure qrAOMapNewRecord(DataSet: TDataSet);
    procedure dsPropinsiDataChange(Sender: TObject; Field: TField);
    procedure qrOContactsNewRecord(DataSet: TDataSet);
    procedure qrOFieldsNewRecord(DataSet: TDataSet);
    procedure qrOrganizationBeforeClose(DataSet: TDataSet);
    procedure qrOrganizationAfterScroll(DataSet: TDataSet);
    procedure qrOrganizationBeforeDelete(DataSet: TDataSet);
    procedure qrAOMapBeforeDelete(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    ActiveQuery: TDataSet;
    ApplyFilter: Boolean;
  end;

var
  dmOr: TdmOr;

implementation

uses Controls, dmMain, BFormOrganization;

{$R *.dfm}

{ TdmOr }

procedure TdmOr.qrOrganizationAfterScroll(DataSet: TDataSet);
begin // Detail table
  if ActiveQuery<>nil then ActiveQuery.Open;
end;

procedure TdmOr.qrOrganizationBeforeClose(DataSet: TDataSet);
begin
  // Detail table
  qrAOMap.Close;
  qrOOffices.Close;
  qrOContacts.Close;
  qrOFields.Close;
  qrBranch.Close;
end;

procedure TdmOr.dsPropinsiDataChange(Sender: TObject; Field: TField);
begin
  // Lookup table
  qrWilayah.Close;
  qrWilayah.Open;
  qrWilayah.Last;
end;


procedure TdmOr.qrOrganizationNewRecord(DataSet: TDataSet);
begin
  qrOrganization['OID'] := Data.NextID;    // generator
  qrOrganization['LAST_UPDATE'] := Now;    // no date baby...
  qrOrganization['HasBranch'] := 'F';
  qrOrganization['SourceID'] := 11;        // default Value
  qrOrganization['UpdaterID'] := 25;       // default Value for pre development
  qrOrganization['CollectorID'] := 21;     // default Value for pre development
end;

procedure TdmOr.qrAOMapNewRecord(DataSet: TDataSet);
begin
  qrAOMap['MID'] := Data.NextID;       // generator
  qrAOMap['OID'] := qrOrganization['OID'];
end;

procedure TdmOr.qrOOfficesNewRecord(DataSet: TDataSet);
begin
  qrOOffices['DID'] := Data.NextDID;           // Detail generator
  qrOOffices['LID'] := qrOrganization['OID'];
  qrOOffices['LinkType'] := 'O';
  qrOOffices['NegaraID'] := 99;   // Indonesia...
end;

procedure TdmOr.qrOContactsNewRecord(DataSet: TDataSet);
begin
  qrOContacts['DID'] := Data.NextDID;           // Detail generator
  qrOContacts['LID'] := qrOrganization['OID'];
  qrOContacts['LinkType'] := 'O';
end;

procedure TdmOr.qrOFieldsNewRecord(DataSet: TDataSet);
begin
  qrOFields['DID'] := Data.NextDID;           // Detail generator
  qrOFields['OID'] := qrOrganization['OID'];
end;

procedure TdmOr.qrOrganizationBeforeDelete(DataSet: TDataSet);
begin
  If Confirm ('This will also delete all offices and contacts.'
     + #10#13'Proceed?') <> mrYes then Abort;
end;

procedure TdmOr.qrAOMapBeforeDelete(DataSet: TDataSet);
begin
  If Confirm ('This will also delete all offices and contacts.'
     + #10#13'Proceed?') <> mrYes then Abort;
end;

end.
