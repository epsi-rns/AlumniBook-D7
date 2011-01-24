unit EntryOrganization;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBCtrls, StdCtrls, Buttons, ExtCtrls, Grids, DBGrids, Mask,
  ComCtrls, DB;

type
  TfrmEntryOrganization = class(TForm)
    PanelTop: TPanel;
    Label12: TLabel;
    DBTextID: TDBText;
    DBTextOrganization: TDBText;
    DBLastUpdate: TDBText;
    PanelBtm: TPanel;
    SelectBtn: TBitBtn;
    DBNav: TDBNavigator;
    DBNavOrg: TDBNavigator;
    PageControl: TPageControl;
    TabCompany: TTabSheet;
    Label1: TLabel;
    Label7: TLabel;
    Label3: TLabel;
    Bevel1: TBevel;
    Label9: TLabel;
    OOrganization: TDBEdit;
    OProduct: TDBEdit;
    OParent: TDBLookupComboBox;
    OMemo: TDBMemo;
    TabAlumni: TTabSheet;
    Label35: TLabel;
    GridOrganization: TDBGrid;
    TabContacts: TTabSheet;
    GridContacts: TDBGrid;
    NavContacts: TDBNavigator;
    BtnParent: TBitBtn;
    TabOffices: TTabSheet;
    NavHomes: TDBNavigator;
    GridHomes: TDBGrid;
    Label20: TLabel;
    Label19: TLabel;
    Label13: TLabel;
    Label11: TLabel;
    Label10: TLabel;
    Label18: TLabel;
    OKawasan: TDBEdit;
    OJalan: TDBEdit;
    OKodePos: TDBEdit;
    ONegara: TDBLookupComboBox;
    OPropinsi: TDBLookupComboBox;
    OWilayah: TDBLookupComboBox;
    Label2: TLabel;
    OGedung: TDBEdit;
    TabFields: TTabSheet;
    GridCompetencies: TDBGrid;
    NavCompetencies: TDBNavigator;
    OHasBranch: TDBCheckBox;
    DBNavMap: TDBNavigator;
    BtnAlumni: TBitBtn;
    BitBtn1: TBitBtn;
    AAlumni: TDBLookupComboBox;
    TabBranch: TTabSheet;
    DBGrid1: TDBGrid;
    NavBranches: TDBNavigator;
    BtnExcludeBranch: TBitBtn;
    BtnIncludeBranch: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PageControlChanging(Sender: TObject;
      var AllowChange: Boolean);
    procedure BtnParentClick(Sender: TObject);
    procedure BtnAlumniClick(Sender: TObject);
    procedure MapDetailClick(Sender: TObject);
    procedure BtnExcludeBranchClick(Sender: TObject);
    procedure BtnIncludeBranchClick(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmEntryOrganization: TfrmEntryOrganization;

implementation

uses
  dmOrganization, 
  LFormOrganization, LFormAlumni, EntryMap;

{$R *.dfm}

procedure TfrmEntryOrganization.FormCreate(Sender: TObject);
begin
  PageControl.ActivePage := TabCompany;
end;

procedure TfrmEntryOrganization.FormShow(Sender: TObject);
begin
  dmOr.qrOrganization.Open;
end;

procedure TfrmEntryOrganization.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  dmOr.qrOrganization.Close;
end;

procedure TfrmEntryOrganization.PageControlChanging(Sender: TObject;
  var AllowChange: Boolean);
begin // automatic post, prevent entry without organization
  If dmOr.dsOrganization.State in [dsEdit, dsInsert] then
    dmOr.qrOrganization.Post;
end;

procedure TfrmEntryOrganization.PageControlChange(Sender: TObject);
begin
  with dmOr do
  case PageControl.ActivePageIndex of
    1: ActiveQuery := qrAOMap;
    2: ActiveQuery := qrOOffices;
    3: ActiveQuery := qrOContacts;
    4: ActiveQuery := qrOFields;
    5: ActiveQuery := qrBranch;
    else ActiveQuery := nil;
  end;

  If PageControl.ActivePageIndex>0 then   // Detail table
    If not dmOr.ActiveQuery.Active then dmOr.ActiveQuery.Open;
end;

procedure TfrmEntryOrganization.BtnParentClick(Sender: TObject);
Var OID: Integer;
begin
  dmOr.qrOrganization.Edit;
  OID := dmOr.qrOrganizationParentID.Value;
  If lookupOrganization.GetField(OID, True) then
     dmOr.qrOrganizationParentID.Value := OID;

  // avoid recursive tree
  If dmOr.qrOrganizationParentID.Value=dmOr.qrOrganizationOID.Value then
     dmOr.qrOrganizationParentID.Clear;
end;

procedure TfrmEntryOrganization.BtnAlumniClick(Sender: TObject);
Var AID: Integer;
begin
  dmOr.qrAOMap.Edit;
  AID := dmOr.qrAOMapAID.Value;
  If lookupAlumni.GetFieldID(AID) then
     dmOr.qrAOMapAID.Value := AID;
end;

procedure TfrmEntryOrganization.MapDetailClick(Sender: TObject);
begin
  frmEntryMap.OpenEntry(dmOr.qrAOMap);
end;

procedure TfrmEntryOrganization.BtnExcludeBranchClick(Sender: TObject);
Var OID: Integer;
begin
  OID := dmOR.qrBranch.FieldByName('OID').AsInteger;
  dmOr.qrUpdateBranch.SQL[0] := Format(
  'UPDATE Organization SET ParentID = NULL WHERE OID = %d', [OID]);
  dmOr.qrUpdateBranch.ExecQuery;
  dmOr.qrBranch.Close;
  dmOr.qrBranch.Open;
end;

procedure TfrmEntryOrganization.BtnIncludeBranchClick(Sender: TObject);
Var ParentID, OID: Integer;
begin
  OID := 0;

  If lookupOrganization.GetFieldID(OID) then
  begin
    ParentID := dmOR.qrOrganization.FieldByName('OID').AsInteger;
    dmOr.qrUpdateBranch.SQL[0] := Format(
    'UPDATE Organization SET ParentID = %d WHERE OID = %d', [ParentID, OID]);
    dmOr.qrUpdateBranch.ExecQuery;
    dmOr.qrBranch.Close;
    dmOr.qrBranch.Open;
  end;
end;

end.
