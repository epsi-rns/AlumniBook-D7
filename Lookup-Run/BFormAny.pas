unit BFormAny;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FormLookup, DB, IBCustomDataSet, IBQuery, StdCtrls, Grids,
  DBGrids, DBCtrls, Buttons, ExtCtrls, ComCtrls, ImgList, ToolWin;

type
  TBrowseMisc = class(TfrmLookup)
    sbChart: TSpeedButton;
    procedure sbChartClick(Sender: TObject);
  private
    { Private declarations }
  protected
    { Protected declarations }
    procedure InitQueryNames; override;
    procedure InitSelectedQuery; override;
  public
    { Public declarations }
    XSeries: String;    
  end;

var
  BrowseMisc: TBrowseMisc;

implementation

uses PieLink;

{$R *.dfm}

{ TBrowseAlumni }

procedure TBrowseMisc.InitQueryNames;
begin
  ChooseQuerySet := '"Total Alumni", "Total per Angkatan",'
  + '"Total, each Community", "Total, each Department", "Total, each Program",'
  + '"Simple Community", "Complete Community",'
  + '"Bidang Usaha", "Job Type", "Job Position", Competency, Address';
  DefaultQueryIndex := 0;
end;

procedure TBrowseMisc.InitSelectedQuery;
begin
  XSeries:='';

  With SQLStat, SQLStat.QuerySQL do
  Case QueryIndex of
  0: begin
       Append('SELECT COUNT(AC.AID) as Total,');
       Append('  C.CID, C.Community||'' - ''||AC.Angkatan as ClassOf,');
       Append('  C.Community, AC.Angkatan,');
       Append('  P.Program, D.Department, D.DepartmentID, F.Faculty');
       Append('FROM ACommunities AC');
       Append('  INNER JOIN Community C ON (C.CID=AC.CID)');
       Append('  INNER JOIN Program P ON (C.ProgramID = P.ProgramID)');
       Append('  INNER JOIN Department D ON (C.DepartmentID = D.DepartmentID)');
       Append('  INNER JOIN Faculty F ON (D.FacultyID = F.FacultyID)');

       GroupBy := 'GROUP BY C.CID, C. Community, AC.Angkatan,'
         + '  P.Program, D.Department, D.DepartmentID, F.Faculty';

       { Write Only Protected Properties }
       IDName:='CID';
       FieldNames := 'ClassOf=4, Total=1,'
         + 'Community=3, Angkatan=1, Program=2, Department=2, Faculty=2';
       Orders  := '"Program, No.Department, Angkatan",'
         + 'Entry=C.CID, ClassOf, Total, Community=C., Angkatan=AC.,'
         + 'Program=P., Department=D., "No.Department=D.DepartmentID"';
       DefaultSortIndex := 0; // After SortBy
       XSeries := 'ClassOf';
     end;
  1: begin
       Append('SELECT Angkatan, COUNT(AID) as Total');
       Append('FROM ACommunities');

       GroupBy := 'GROUP BY Angkatan';

       { Write Only Protected Properties }
       IDName:='Angkatan';
       FieldNames := 'Angkatan=2, Total=1';
       Orders  := 'Angkatan, Total';
       DefaultSortIndex := 0; // After SortBy
       XSeries := 'Angkatan';
     end;
  2: begin
       Append('SELECT Community, COUNT(AID) as Total,');
       Append('  CID, Program, Department, DepartmentID');
       Append('FROM ACommunities AC');
       Append('  INNER JOIN Community C ON (C.CID=AC.CID)');
       Append('  INNER JOIN Program P ON (C.ProgramID = P.ProgramID)');
       Append('  INNER JOIN Department D ON (C.DepartmentID = D.DepartmentID)');

       GroupBy := 'GROUP BY CID, Program, Department, DepartmentID, Community';

       { Write Only Protected Properties }
       IDName:='CID';
       FieldNames := 'Community=4, Total=1, Department=3, Program=3';
       Orders  := 'Entry=CID, Community, Total, Department, Program';
       DefaultSortIndex := 0; // After SortBy
       XSeries := 'Community';
     end;
  3: begin
       Append('SELECT Department, DepartmentID, COUNT(AID) as Total');
       Append('FROM ACommunities AC');
       Append('  INNER JOIN Community C ON (C.CID=AC.CID)');
       Append('  INNER JOIN Department D ON (C.DepartmentID = D.DepartmentID)');

       GroupBy := 'GROUP BY Department, DepartmentID';

       { Write Only Protected Properties }
       IDName:='DepartmentID';
       FieldNames := 'Department=4, Total=1';
       Orders  := 'Department, "No.Department=DepartmentID", Total';
       DefaultSortIndex := 1; // After SortBy
       XSeries := 'Department';
     end;
  4: begin
       Append('SELECT Program, ProgramID, COUNT(AID) as Total');
       Append('FROM ACommunities AC');
       Append('  INNER JOIN Community C ON (C.CID=AC.CID)');
       Append('  INNER JOIN Program P ON (C.ProgramID = P.ProgramID)');

       GroupBy := 'GROUP BY Program, ProgramID';

       { Write Only Protected Properties }
       IDName:='ProgramID';
       FieldNames := 'Program=4, Total=1';
       Orders  := 'Program, "No. Program=ProgramID", Total';
       DefaultSortIndex := 0; // After SortBy
       XSeries := 'Program';
     end;
  5: begin
       Append('SELECT C.CID, C.Community FROM Community C');

       { Write Only Protected Properties }
       IDName:='CID';
       FieldNames := 'CID=1, Community=5';
       Orders  := 'Entry=C.CID, Community=C.';
       DefaultSortIndex := 0; // After SortBy
     end;
  6: begin
       Append('SELECT C.CID, C.Community, P.Program, D.Department, F.Faculty');
       Append('FROM Community C');
       Append('INNER JOIN Program P ON (C.ProgramID = P.ProgramID)');
       Append('INNER JOIN Department D ON (C.DepartmentID = D.DepartmentID)');
       Append('INNER JOIN Faculty F ON (D.FacultyID = F.FacultyID)');

       { Write Only Protected Properties }

       IDName:='CID';
       FieldNames := 'Community=2, Program=1, Department=1, Faculty=1';
       Orders  := 'Entry=C.CID, Community=C., Program=P., Department=D., Faculty=F.';
       DefaultSortIndex := 1; // After SortBy
     end;
  7: begin
       Append('SELECT COUNT (*) AS Total, F.Field');
       Append('FROM Organization O');
       Append('  INNER JOIN OFIELDS Fs ON (Fs.OID =  O.OID)');
       Append('  INNER JOIN Field F ON (Fs.FieldID = F.FieldID)');

       GroupBy := 'GROUP BY F.Field';

       { Write Only Protected Properties }
       IDName:='Field';
       FieldNames := 'Field=2, Total=1';
       Orders  := 'Field, Total';
       DefaultSortIndex := 0; // After SortBy
       XSeries := 'Field';
     end;
  8: begin
       Append('SELECT COUNT (*) AS Total, JT.JobType');
       Append('FROM Alumni A');
       Append('  INNER JOIN AOMAP M ON (M.AID=A.AID)');
       Append('  INNER JOIN JobType JT');
       Append('    ON (M.JobTypeID=JT.JobTypeID)');

       GroupBy := 'GROUP BY JT.JobType';

       { Write Only Protected Properties }
       IDName:='JobType';
       FieldNames := 'JobType=2, Total=1';
       Orders  := 'JobType, Total';
       DefaultSortIndex := 0; // After SortBy
       XSeries := 'JobType';
     end;
  9: begin
       Append('SELECT COUNT (*) AS Total, JP.JobPosition');
       Append('FROM Alumni A');
       Append('  INNER JOIN AOMAP M ON (M.AID=A.AID)');
       Append('  INNER JOIN JobPosition JP');
       Append('    ON (M.JobPositionID=JP.JobPositionID)');

       GroupBy := 'GROUP BY JP.JobPosition';

       { Write Only Protected Properties }
       IDName:='JobPosition';
       FieldNames := 'JobPosition=2, Total=1';
       Orders  := 'JobPosition, Total';
       DefaultSortIndex := 0; // After SortBy
       XSeries := 'JobPosition';
     end;
  10: begin
       Append('SELECT COUNT (*) AS Total, Co.Competency');
       Append('FROM ACompetencies ACo');
       Append('  INNER JOIN Alumni A ON (ACo.AID = A.AID)');
       Append('  INNER JOIN Competency Co');
       Append('    ON (Co.CompetencyID = ACo.CompetencyID)');

       GroupBy := 'GROUP BY Co.Competency';

       { Write Only Protected Properties }
       IDName:='Competency';
       FieldNames := 'Competency=2, Total=1';
       Orders  := 'Competency, Total';
       DefaultSortIndex := 0; // After SortBy
       XSeries := 'Competency';
     end;
  11: begin
       Append('SELECT COUNT (*) AS Total, P.Propinsi, W.Wilayah');
       Append('FROM Address D');
       Append('  INNER JOIN Alumni A ON (A.AID=D.LID)  AND (D.LinkType =''A'')');
       Append('  INNER JOIN Wilayah W ON (W.WilayahID = D.WilayahID)');
       Append('  INNER JOIN Propinsi P ON (P.PropinsiID = D.PropinsiID)');

       GroupBy := 'GROUP BY W.Wilayah, P.Propinsi';

       { Write Only Protected Properties }
       IDName:='Wilayah';
       FieldNames := 'Propinsi=2, Wilayah=2, Total=1';
       Orders  := '"Propinsi, Wilayah", Propinsi, Wilayah, Total';
       DefaultSortIndex := 0; // After SortBy
       XSeries := 'Wilayah';
     end;
  end;

  sbChart.enabled := XSeries <> '';
end;

procedure TBrowseMisc.sbChartClick(Sender: TObject);
begin
  frmPieLink.ShowModal;
end;

end.


