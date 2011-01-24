unit EntryAlumni;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Mask, DBCtrls, DB, Buttons, ExtCtrls,
  ActnList, ImgList, Grids, DBGrids;

type
  TfrmEntryAlumni = class(TForm)
    dsAlumni: TDataSource;
    PanelBtm: TPanel;
    SelectBtn: TBitBtn;
    PanelTop: TPanel;
    Label12: TLabel;
    DBTextID: TDBText;
    DBTextName: TDBText;
    DBNavFilter: TDBNavigator;
    DBNavAlumni: TDBNavigator;
    PageControl: TPageControl;
    TabPersonal: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label8: TLabel;
    Label7: TLabel;
    Label31: TLabel;
    ANama: TDBEdit;
    APrefix: TDBEdit;
    ABirthPlace: TDBEdit;
    Gender: TDBRadioGroup;
    ABirthDate: TDateTimePicker;
    TabHome: TTabSheet;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    HKawasan: TDBEdit;
    HPropinsi: TDBLookupComboBox;
    HWilayah: TDBLookupComboBox;
    ASuffix: TDBEdit;
    Label4: TLabel;
    Label5: TLabel;
    DBLastUpdate: TDBText;
    Label6: TLabel;
    AReligion: TDBLookupComboBox;
    Bevel1: TBevel;
    AMemo: TDBMemo;
    Label9: TLabel;
    HJalan: TDBEdit;
    Label10: TLabel;
    Label11: TLabel;
    HKodePos: TDBEdit;
    HNegara: TDBLookupComboBox;
    Label13: TLabel;
    TabContacts: TTabSheet;
    GridHomes: TDBGrid;
    GridContacts: TDBGrid;
    NavHomes: TDBNavigator;
    NavContacts: TDBNavigator;
    TabCommunities: TTabSheet;
    NavCommunities: TDBNavigator;
    Label14: TLabel;
    CAngkatan: TDBEdit;
    Label15: TLabel;
    CCommunity: TDBLookupComboBox;
    GridCommunities: TDBGrid;
    Label16: TLabel;
    CKhusus: TDBEdit;
    BtnCommunity: TBitBtn;
    TabDegrees: TTabSheet;
    TabExperiences: TTabSheet;
    TabCompetencies: TTabSheet;
    TabCertifications: TTabSheet;
    GridDegrees: TDBGrid;
    NavDegrees: TDBNavigator;
    NavCompetencies: TDBNavigator;
    GridCompetencies: TDBGrid;
    NavCertifications: TDBNavigator;
    GridCertifications: TDBGrid;
    TabOrganizations: TTabSheet;
    DStrata: TDBLookupComboBox;
    Label17: TLabel;
    DDegree: TDBEdit;
    Label21: TLabel;
    Label22: TLabel;
    Label24: TLabel;
    DInstitution: TDBEdit;
    Label26: TLabel;
    DMajor: TDBEdit;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    DMinor: TDBEdit;
    DConcentration: TDBEdit;
    NavExperiences: TDBNavigator;
    GridExperiences: TDBGrid;
    DBNavMap: TDBNavigator;
    GridOrganization: TDBGrid;
    Label35: TLabel;
    DAdmitted: TDBEdit;
    DGraduated: TDBEdit;
    HKomplek: TDBEdit;
    Label23: TLabel;
    XPJobPosition: TDBEdit;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    XPOrganization: TDBEdit;
    XPDescription: TDBEdit;
    Label40: TLabel;
    XPYearIn: TDBEdit;
    Label41: TLabel;
    XPYearOut: TDBEdit;
    Label42: TLabel;
    BtnOrganization: TBitBtn;
    BitBtn1: TBitBtn;
    OOrganization: TDBLookupComboBox;
    AShowTitle: TDBCheckBox;
    Bevel2: TBevel;
    Label25: TLabel;
    ASource: TDBLookupComboBox;
    procedure BtnCommunityClick(Sender: TObject);
    procedure acCreateHomeExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dsAlumniDataChange(Sender: TObject; Field: TField);
    procedure dsAlumniUpdateData(Sender: TObject);
    procedure ABirthDateChange(Sender: TObject);
    procedure GridCommunitiesEditButtonClick(Sender: TObject);
    procedure PageControlChanging(Sender: TObject;
      var AllowChange: Boolean);
    procedure BtnOrganizationClick(Sender: TObject);
    procedure MapDetailClick(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmEntryAlumni: TfrmEntryAlumni;

implementation

uses
  dmAlumni, 
  LFormCommunity, LFormOrganization, EntryMap;

{$R *.dfm}

procedure TfrmEntryAlumni.FormCreate(Sender: TObject);
begin
  PageControl.ActivePage := TabPersonal;
end;

procedure TfrmEntryAlumni.FormShow(Sender: TObject);
begin
  dmAl.qrAlumni.Open;
end;

procedure TfrmEntryAlumni.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  dmAl.qrAlumni.Close;
end;

procedure TfrmEntryAlumni.PageControlChanging(Sender: TObject;
  var AllowChange: Boolean);
begin // automatic post, prevent entry without alumni
  If dmAl.dsAlumni.State in [dsEdit, dsInsert] then
    dmAl.qrAlumni.Post;
end;

procedure TfrmEntryAlumni.PageControlChange(Sender: TObject);
begin
  with dmAl do
  case PageControl.ActivePageIndex of
    1: ActiveQuery := qrAOMap;
    2: ActiveQuery := qrAHomes;
    3: ActiveQuery := qrAContacts;
    4: ActiveQuery := qrACommunities;
    5: ActiveQuery := qrADegrees;
    6: ActiveQuery := qrAExperiences;
    7: ActiveQuery := qrACompetencies;
    8: ActiveQuery := qrACertifications;
    else ActiveQuery:=nil
  end;

  If PageControl.ActivePageIndex>0 then   // Detail table
    If not dmAl.ActiveQuery.Active then dmAl.ActiveQuery.Open;
end;

procedure TfrmEntryAlumni.BtnCommunityClick(Sender: TObject);
Var CID: Integer;
begin
  dmAl.qrACommunities.Edit;
  CID := dmAl.qrACommunitiesCID.Value;
  If lookupCommunity.GetFieldID(CID) then dmAl.qrACommunitiesCID.Value := CID;
end;

procedure TfrmEntryAlumni.BtnOrganizationClick(Sender: TObject);
Var OID: Integer;
begin
  dmAl.qrAOMap.Edit;
  OID := dmAl.qrAOMapOID.Value;
  If lookupOrganization.GetField(OID, False) then dmAl.qrAOMapOID.Value := OID;
end;

procedure TfrmEntryAlumni.GridCommunitiesEditButtonClick(Sender: TObject);
begin
  If GridCommunities.SelectedField = dmAl.qrACommunitiesCommunity
  then BtnCommunityClick(Sender);
end;

procedure TfrmEntryAlumni.acCreateHomeExecute(Sender: TObject);
begin
 dmAl.qrAHomes.Open;
 dmAl.qrAHomes.Append;
end;

procedure TfrmEntryAlumni.dsAlumniDataChange(Sender: TObject; Field: TField);
begin
  If dmAl.qrAlumni.FieldbyName('BirthDate').IsNull then
  begin
    ABirthDate.Date := 0;
    ABirthDate.Checked := False;
  end
  else
  begin
    ABirthDate.Checked := True;
    ABirthDate.Date := dmAl.qrAlumni['BirthDate'];
  end;
end;

procedure TfrmEntryAlumni.dsAlumniUpdateData(Sender: TObject);
begin
  If ABirthDate.Checked then
    dmAl.qrAlumni['BirthDate'] := ABirthDate.Date
  else dmAl.qrAlumni.FieldbyName('BirthDate').Clear;
end;

procedure TfrmEntryAlumni.ABirthDateChange(Sender: TObject);
begin
  // set table in edit mode
  dmAl.qrAlumni.Edit;
end;

procedure TfrmEntryAlumni.MapDetailClick(Sender: TObject);
begin
  frmEntryMap.OpenEntry(dmAl.qrAOMap);
end;



end.
