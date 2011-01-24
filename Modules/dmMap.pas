unit dmMap;

interface

uses
  SysUtils, Classes, IBQuery, IBCustomDataSet, DB;

type
  TdmLink = class(TDataModule)
    dsCursor: TDataSource;
    qrAOMap: TIBDataSet;
    qrAOMapMID: TIntegerField;
    qrAOMapAID: TIntegerField;
    qrAOMapOID: TIntegerField;
    qrAOMapJOBTYPEID: TIntegerField;
    qrAOMapJOBPOSITIONID: TIntegerField;
    qrAOMapOrganization: TStringField;
    qrAOMapJobType: TStringField;
    qrAOMapJobPosition: TStringField;
    qrAOMapDEPARTMENT: TIBStringField;
    qrAOMapSTRUKTURAL: TIBStringField;
    qrAOMapFUNGSIONAL: TIBStringField;
    qrAOMapDESCRIPTION: TIBStringField;
    dsMap: TDataSource;
    qrMContacts: TIBDataSet;
    IntegerField1: TIntegerField;
    IntegerField2: TIntegerField;
    IBStringField1: TIBStringField;
    IntegerField3: TIntegerField;
    IBStringField2: TIBStringField;
    StringField1: TStringField;
    dsMContacts: TDataSource;
    qrContactType: TIBQuery;
    dsContactType: TDataSource;
    qrOrganization: TIBQuery;
    dsOrganization: TDataSource;
    qrJobType: TIBQuery;
    dsJobType: TDataSource;
    qrJobPosition: TIBQuery;
    dsJobPosition: TDataSource;
    dsNegara: TDataSource;
    qrNegara: TIBQuery;
    qrPropinsi: TIBQuery;
    dsPropinsi: TDataSource;
    qrMOffices: TIBDataSet;
    qrMOfficesDID: TIntegerField;
    qrMOfficesLID: TIntegerField;
    qrMOfficesLINKTYPE: TIBStringField;
    qrMOfficesKAWASAN: TIBStringField;
    qrMOfficesGEDUNG: TIBStringField;
    qrMOfficesJALAN: TIBStringField;
    qrMOfficesPOSTALCODE: TIBStringField;
    qrMOfficesNegara: TStringField;
    qrMOfficesPropinsi: TStringField;
    qrMOfficesWilayah: TStringField;
    qrMOfficesNEGARAID: TIntegerField;
    qrMOfficesPROPINSIID: TIntegerField;
    qrMOfficesWILAYAHID: TIntegerField;
    dsMOffices: TDataSource;
    qrWilayah: TIBQuery;
    dsWilayah: TDataSource;
    procedure qrAOMapBeforeClose(DataSet: TDataSet);
    procedure qrMContactsNewRecord(DataSet: TDataSet);
    procedure dsPropinsiDataChange(Sender: TObject; Field: TField);
    procedure qrMOfficesNewRecord(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure OpenMap(DS: TDataSet);
    procedure CloseMap;
  end;


var
  dmLink: TdmLink;

implementation

uses dmMain;

{$R *.dfm}

{ TdmLink }

procedure TdmLink.OpenMap(DS: TDataSet);
begin
  dsCursor.DataSet := DS;
  qrAOMap.Open;
end;

procedure TdmLink.CloseMap;
begin
  qrAOMap.Close;
  dsCursor := nil;
end;            

procedure TdmLink.qrAOMapBeforeClose(DataSet: TDataSet);
begin
  qrMContacts.Close;
  qrMOffices.Close;
end;

procedure TdmLink.qrMContactsNewRecord(DataSet: TDataSet);
begin
  qrMContacts['DID'] := Data.NextDID;         // Detail generator
  qrMContacts['LID'] := qrAOMap['MID'];
  qrMContacts['LinkType'] := 'M';
end;

procedure TdmLink.qrMOfficesNewRecord(DataSet: TDataSet);
begin
  qrMOffices['DID'] := Data.NextDID;         // Detail generator
  qrMOffices['LID'] := qrAOMap['MID'];
  qrMOffices['LinkType'] := 'M';
  qrMOffices['NegaraID'] := 99;   // Indonesia...
end;

procedure TdmLink.dsPropinsiDataChange(Sender: TObject; Field: TField);
begin
  // Lookup table
  qrWilayah.Close;
  qrWilayah.Open;
  qrWilayah.Last;
end;

end.
