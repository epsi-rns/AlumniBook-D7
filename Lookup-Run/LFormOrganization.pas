unit LFormOrganization;

interface

uses
  SysUtils, Forms, Classes, Controls, StdCtrls, ExtCtrls, Buttons, Grids,
  DBGrids, DBCtrls, DB, IBCustomDataSet, IBQuery, FormLookup, ComCtrls,
  ToolWin;

type
  TLookupOrganization = class(TfrmLookup)
  private
    { Private declarations }
    ShowHasBranchOnly : Boolean;
  protected
    { Protected declarations }
    procedure InitQueryNames; override;
    procedure InitSelectedQuery; override;
    procedure SetConstraint; override;
  public
    { Public declarations }
     function GetField(Var OID: Integer; HasBranchOnly: Boolean): Boolean;
  end;

var
  LookupOrganization: TLookupOrganization;

implementation

{$R *.dfm}

procedure TLookupOrganization.InitQueryNames;
begin
  ChooseQuerySet := 'Simple-Organization';
  DefaultQueryIndex := 0;
end;

procedure TLookupOrganization.InitSelectedQuery;
begin
  With SQLStat, SQLStat.QuerySQL do
  begin
    Append('SELECT O.OID, O.Organization, O.Product, Fs.FieldID, F.Field');
    Append('FROM Organization O');
    Append('LEFT JOIN OFIELDS Fs ON (Fs.OID =  O.OID)');
    Append('LEFT JOIN Field F ON (Fs.FieldID = F.FieldID)');

    { Write Only Protected Properties }

    IDName:='OID';
    FieldNames := 'Organization=3, Field=2, Product=2';
    Orders  := 'Entry=O.OID, Organization=O., Field=F., Product=O.';
    DefaultSortIndex := 1; // After Orders
  end;
end;

Function TLookupOrganization.GetField(var OID: Integer;
  HasBranchOnly: Boolean): Boolean;
begin
  ShowHasBranchOnly:=HasBranchOnly;
  Result := Inherited GetFieldID(OID);
end;

procedure TLookupOrganization.SetConstraint;
begin
  inherited;

  If ShowHasBranchOnly then
    SQLStat.Filters.Add('HasBranch = ''T''');
end;

end.
