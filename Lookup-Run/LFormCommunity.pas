unit LFormCommunity;

interface

uses
  SysUtils, Forms, Classes, Controls, StdCtrls, ExtCtrls, Buttons, Grids,
  DBGrids, DBCtrls, DB, IBCustomDataSet, IBQuery, FormLookup, ComCtrls,
  ToolWin;

type
  TLookupCommunity = class(TfrmLookup)
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
  LookupCommunity: TLookupCommunity;

implementation

{$R *.dfm}

procedure TLookupCommunity.InitQueryNames;
begin
  ChooseQuerySet := '"Simple Community", "Complete Community"';
  DefaultQueryIndex := 1;
end;

procedure TLookupCommunity.InitSelectedQuery;
begin
  With SQLStat, SQLStat.QuerySQL do
  Case QueryIndex of
  0: begin
       Append('SELECT C.CID, C.Community FROM Community C');

       { Write Only Protected Properties }
       IDName:='CID';
       FieldNames := 'CID=1, Community=5';
       Orders  := 'Entry=C.CID, Community=C.';
       DefaultSortIndex := 0; // After Orders
     end;
  1: begin
       Append('SELECT C.CID, C.Community, P.Program, D.Department, F.Faculty');
       Append('FROM Community C');
       Append('INNER JOIN Program P ON (C.ProgramID = P.ProgramID)');
       Append('INNER JOIN Department D ON (C.DepartmentID = D.DepartmentID)');
       Append('INNER JOIN Faculty F ON (D.FacultyID = F.FacultyID)');

       { Write Only Protected Properties }

       IDName:='CID';
       FieldNames := 'Community=2, Program=1, Department=1, Faculty=1';
       Orders  := 'Entry=C.CID, Community=C., Program=P., Department=D., Faculty=D.';
       DefaultSortIndex := 1; // After Orders
     end;
  end;

end;

end.
