unit LFormAlumni;

interface

uses
  SysUtils, Forms, Classes, Controls, StdCtrls, ExtCtrls, Buttons, Grids,
  DBGrids, DBCtrls, DB, IBCustomDataSet, IBQuery, FormLookup, ComCtrls,
  ToolWin;

type
  TLookupAlumni = class(TfrmLookup)
  private
    { Private declarations }
  protected
    { Protected declarations }
    procedure InitQueryNames; override;
    procedure InitSelectedQuery; override;
  public
    { Public declarations }
  end;

var
  LookupAlumni: TLookupAlumni;

implementation

{$R *.dfm}

procedure TLookupAlumni.InitQueryNames;
begin
  ChooseQuerySet := '"Simple Alumni"';
  DefaultQueryIndex := 0;
end;

procedure TLookupAlumni.InitSelectedQuery;
begin
  With SQLStat, SQLStat.QuerySQL do
  begin
    Append('SELECT * FROM ExtendedAlumni');

    { Write Only Protected Properties }
    IDName:='AID';
    FieldNames := 'AID=1, Name=5, Religion=2, JobType=3,'
      + 'Updater=2, Collector=2, Last_Update=2';
    Orders  := 'Entry=AID, Name,'
      + 'Religion, JobType, Updater, Collector, Last_Update';
    DefaultSortIndex := 0; // After Orders
  end;
end;

end.
