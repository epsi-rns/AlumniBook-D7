unit EntryMap;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBCtrls, StdCtrls, Buttons, ExtCtrls, ComCtrls, DB, Mask, Grids,
  DBGrids;

type
  TfrmEntryMap = class(TForm)
    PanelTop: TPanel;
    Label12: TLabel;
    DBTextAID: TDBText;
    DBTextName: TDBText;
    PanelBtm: TPanel;
    SelectBtn: TBitBtn;
    DBTextOrganization: TDBText;
    DBTextOID: TDBText;
    Label1: TLabel;
    PageControl: TPageControl;
    TabCommon: TTabSheet;
    TabOffices: TTabSheet;
    TabContacts: TTabSheet;
    Label34: TLabel;
    Label36: TLabel;
    Label33: TLabel;
    Label32: TLabel;
    Label30: TLabel;
    OFunctional: TDBEdit;
    OStructural: TDBEdit;
    ODescription: TDBEdit;
    OJobPosition: TDBLookupComboBox;
    ODepartment: TDBEdit;
    NavExperiences: TDBNavigator;
    NavContacts: TDBNavigator;
    GridContacts: TDBGrid;
    Label2: TLabel;
    MOrganization: TDBEdit;
    Label3: TLabel;
    MName: TDBEdit;
    NavHomes: TDBNavigator;
    Label18: TLabel;
    MKawasan: TDBEdit;
    Label4: TLabel;
    MGedung: TDBEdit;
    Label10: TLabel;
    MJalan: TDBEdit;
    Label11: TLabel;
    MKodePos: TDBEdit;
    Label13: TLabel;
    MNegara: TDBLookupComboBox;
    Label19: TLabel;
    MPropinsi: TDBLookupComboBox;
    Label20: TLabel;
    MWilayah: TDBLookupComboBox;
    GridHomes: TDBGrid;
    Label5: TLabel;
    AJobType: TDBLookupComboBox;
    procedure FormCreate(Sender: TObject);
    procedure PageControlChanging(Sender: TObject;
      var AllowChange: Boolean);
    procedure PageControlChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function OpenEntry(DS: TDataSet): Integer;
  end;

var
  frmEntryMap: TfrmEntryMap;

implementation

{$R *.dfm}

uses dmMap;

{ TfrmEntryMap }

procedure TfrmEntryMap.FormCreate(Sender: TObject);
begin
  PageControl.ActivePage := TabCommon;
end;

function TfrmEntryMap.OpenEntry(DS: TDataSet): Integer;
begin
  dmLink.OpenMap(DS);
  Result := ShowModal;
end;   

procedure TfrmEntryMap.PageControlChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  If dmLink.dsMap.State in [dsEdit, dsInsert] then
    dmLink.qrAOMap.Post;
end;

procedure TfrmEntryMap.PageControlChange(Sender: TObject);
Var Query: TDataSet;
begin
  with dmLink do
  case PageControl.ActivePageIndex of
    1: Query := qrMOffices;
    2: Query := qrMContacts;
  end;

  If PageControl.ActivePageIndex>0 then   // Detail table
    If not Query.Active then Query.Open;
end;

end.
