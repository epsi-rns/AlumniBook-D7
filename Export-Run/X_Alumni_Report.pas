unit X_Alumni_Report;

interface

uses classes;

procedure SQLJustDoIt(Filename, dbName :string);
procedure PrepareListAlumni(Var List: TList);
procedure PrepareListOrganization(Var List: TList);

implementation

uses
  SysUtils,
  X_List, X_Base, X_AppBase, W_Base;

procedure SQLJustDoIt(Filename, dbName :string);
var SavePath, SaveName: String;

  function fn(s: String):string;
  begin
    result := Savepath+'my.'+SaveName+'.'+s+'.sql';
  end;

Var
  List   : TExportList;
  CommonExport: TExportBase;
  SQL    : TWriteSQL;
  SQLTemp: TStrings;
  Headers: string;
  Prefix : String;

begin
  Prefix := 'iDB_';

  SavePath := ExtractFilePath(Filename);
  SaveName := ChangeFileExt ( ExtractFileName(Filename), '');

  SQLTemp:=TStringList.Create;
  SQLTemp.Append('');

  //-------------------------//
  List := TExportList.Create;

  SQLTemp[0] := 'SELECT * FROM Religion ORDER BY ReligionID';
  Headers:='ReligionID=int, Religion=text';
  List.AddQuery(SQLTemp, Headers, '', 'Religion', '', '');

  SQLTemp[0] := 'SELECT * FROM Program ORDER BY ProgramID';
  Headers:='ProgramID=int, Program=text';
  List.AddQuery(SQLTemp, Headers, '', 'Program', '', '');

  SQLTemp[0] := 'SELECT * FROM Department ORDER BY DepartmentID';
  Headers:='DepartmentID=int, Department=text';
  List.AddQuery(SQLTemp, Headers, '', 'Department', '', '');

  SQLTemp[0] := 'SELECT * FROM Community ORDER BY CID';
  Headers:='CID=int, Community=text, DepartmentID=int, ProgramID=int';
  List.AddQuery(SQLTemp, Headers, '', 'Community', '', '');

  SQLTemp[0] := 'SELECT * FROM ContactType ORDER BY CTID';
  Headers:='CTID=int, ContactType=text';
  List.AddQuery(SQLTemp, Headers, '', 'ContactType', '', '');

  SQLTemp[0] := 'SELECT * FROM JobType ORDER BY JobTypeID';
  Headers:='JobTypeID=int, JobType=text';
  List.AddQuery(SQLTemp, Headers, '', 'JobType', '', '');

  SQLTemp[0] := 'SELECT * FROM JobPosition ORDER BY JobPositionID';
  Headers:='JobPositionID=int, JobPosition=text';
  List.AddQuery(SQLTemp, Headers, '', 'JobPosition', '', '');

  SQLTemp[0] := 'SELECT * FROM Competency ORDER BY CompetencyID';
  Headers:='CompetencyID=int, Competency=text';
  List.AddQuery(SQLTemp, Headers, '', 'Competency', '', '');

  SQLTemp[0] := 'SELECT * FROM Field ORDER BY FieldID';
  Headers:='FieldID=int, Field=text';
  List.AddQuery(SQLTemp, Headers, '', 'Field', '', '');

  SQLTemp[0] := 'SELECT * FROM Propinsi ORDER BY PropinsiID';
  Headers:='PropinsiID=int, Propinsi=text';
  List.AddQuery(SQLTemp, Headers, '', 'Propinsi', '', '');

  SQLTemp[0] := 'SELECT * FROM Wilayah ORDER BY WilayahID';
  Headers:='WilayahID=int, PropinsiID=int, Wilayah=text';
  List.AddQuery(SQLTemp, Headers, '', 'Wilayah', '', '');

  SQLTemp[0] := 'SELECT * FROM Negara ORDER BY NegaraID';
  Headers:='NegaraID=int, Negara=text';
  List.AddQuery(SQLTemp, Headers, '', 'Negara', '', '');

  SQL := TWriteSQL.Create;
  CommonExport := TExportSQL.Create (dbName, fn('1.base'), Prefix, List, SQL);
  CommonExport.Resume;

  //-------------------------//
  List := TExportList.Create;

  SQLTemp[0] := 'SELECT * FROM Alumni ORDER BY AID';
  Headers:='AID=int, Name=text, Prefix=text, Suffix=text, ShowTitle=text,'
    + 'Last_Update=datetime, EntryDate=datetime, '
  + 'BirthPlace=text, BirthDate=date, '
  + 'Gender=text, ReligionID=int, JobTypeID=int';
  List.AddQuery(SQLTemp, Headers, '', 'Alumni', '', '');

  SQLTemp[0] := 'SELECT * FROM Organization ORDER BY OID';
  Headers:='OID=int, Organization=text, '
  + 'Last_Update=datetime, EntryDate=datetime, '
  + 'ParentID=int, Product=text, HasBranch=text';
  List.AddQuery(SQLTemp, Headers, '', 'Organization', '', '');

  SQLTemp[0] := 'SELECT * FROM AOMap ORDER BY MID';
  Headers:='MID=int, AID=int, OID=int, Department=text,'
  + 'JobPositionID=int, Description=text, Struktural=text, Fungsional=text';
  List.AddQuery(SQLTemp, Headers, '', 'AOMap', '', '');

  SQL := TWriteSQL.Create;
  CommonExport := TExportSQL.Create (dbName, fn('2.master'), Prefix, List, SQL);
  CommonExport.Resume;

  //-------------------------//
  List := TExportList.Create;

  SQLTemp[0] := 'SELECT * FROM OFields ORDER BY DID';
  Headers:='DID=int, OID=int, FieldID=int, Description=text';
  List.AddQuery(SQLTemp, Headers, '', 'OFields', '', '');

  SQLTemp[0] := 'SELECT * FROM ACommunities ORDER BY DID';
  Headers:='DID=int, AID=int, CID=int, Angkatan=int, Khusus=text,'
  + 'Community=text, ProgramID=int, DepartmentID=int';
  List.AddQuery(SQLTemp, Headers, '', 'ACommunities', '', '');

  SQLTemp[0] := 'SELECT * FROM ACompetencies ORDER BY DID';
  Headers:='DID=int, AID=int, CompetencyID=int, Description=text';
  List.AddQuery(SQLTemp, Headers, '', 'ACompetencies', '', '');

  SQLTemp[0] := 'SELECT * FROM ACertifications ORDER BY DID';
  Headers:='DID=int, AID=int, Certification=text, Institution=text';
  List.AddQuery(SQLTemp, Headers, '', 'ACertifications', '', '');

  SQLTemp[0] := 'SELECT * FROM AExperiences ORDER BY DID';
  Headers:='DID=int, AID=int, Organization=text';
  List.AddQuery(SQLTemp, Headers, '', 'AExperiences', '', '');

  SQL := TWriteSQL.Create;
  CommonExport := TExportSQL.Create (dbName, fn('3.details'), Prefix, List, SQL);
  CommonExport.Resume;

  //-------------------------//
  List := TExportList.Create;

  SQLTemp[0] := 'SELECT * FROM Address ORDER BY DID';
  Headers:='DID=int, LID=int, LinkType=Text,'
  + 'Kawasan=text, Gedung=text, Jalan=text, PostalCode=text,'
  + 'NegaraID=int, PropinsiID=int, WilayahID=int,'
  + 'Address=text, Region=text';
  List.AddQuery(SQLTemp, Headers, '', 'Address', '', '');

  SQL := TWriteSQL.Create;
  CommonExport := TExportSQL.Create (dbName, fn('3.address'), Prefix, List, SQL);
  CommonExport.Resume;

  //-------------------------//
  List := TExportList.Create;

  SQLTemp[0] := 'SELECT * FROM Contacts ORDER BY DID';
  Headers:='DID=int, LID=int, LinkType=Text, CTID=int, Contact=text';
  List.AddQuery(SQLTemp, Headers, '', 'Contacts', '', '');

  SQL := TWriteSQL.Create;
  CommonExport := TExportSQL.Create (dbName, fn('3.contacts'), Prefix, List, SQL);
  CommonExport.Resume;

  //-------------------------//
  List := TExportList.Create;

  SQLTemp[0] := 'SELECT * FROM ViewContacts ORDER BY DID';
  Headers:='DID=int, LID=int, LinkType=Text, '
  + 'HP=text, Phone=text, Fax=text, email=text, website=text';
  List.AddQuery(SQLTemp, Headers, '', 'ViewContacts', '', '');

  SQL := TWriteSQL.Create;
  CommonExport := TExportSQL.Create (dbName, fn('3.viewcontacts'), Prefix, List, SQL);
  CommonExport.Resume;

end;

procedure PrepareListAlumni(Var List: TList);
var RI: TReportItem;
begin
  // 0 :: Community
  RI := TReportItem.Create;
  RI.SQL.Append ('SELECT Community FROM FullCommunityName');
  RI.WhereClause := 'AID = %d';
  List.Add(RI);

  // 1 :: Certification
  RI := TReportItem.Create;
  RI.SQL.Append ('SELECT A.AID, A.Name, ACe.Certification, ACe.Institution');
  RI.SQL.Append ('FROM Alumni A');
  RI.SQL.Append ('INNER JOIN ACertifications ACe ON (ACe.AID = A.AID)');
  RI.WhereClause := 'A.AID = %d';
  List.Add(RI);

  // 2 :: Competency
  RI := TReportItem.Create;
  RI.SQL.Append('SELECT A.AID, A.Name, Co.Competency, ACo.Description');
  RI.SQL.Append('FROM ACompetencies ACo');
  RI.SQL.Append('INNER JOIN Alumni A ON (ACo.AID = A.AID)');
  RI.SQL.Append('INNER JOIN Competency Co');
  RI.SQL.Append('ON (Co.CompetencyID = ACo.CompetencyID)');
  RI.WhereClause := 'A.AID = %d';
  List.Add(RI);

  // 3 :: Address
  RI := TReportItem.Create;
  RI.SQL.Append('SELECT Address, Region FROM Address');
  RI.WhereClause := '(LID = %d) AND (LinkType=''A'')';
  List.Add(RI);

  // 4 :: Contact
  RI := TReportItem.Create;
  RI.SQL.Append('SELECT C.LID, C.CTID, CT.ContactType, C.Contact');
  RI.SQL.Append('FROM Contacts C');
  RI.SQL.Append('INNER JOIN ContactType CT ON (C.CTID = CT.CTID)');
  RI.WhereClause := 'LinkType= ''A'' AND LID = %d';
  List.Add(RI);

  // 5 :: Organization
  RI := TReportItem.Create;
  RI.SQL.Append('SELECT M.AID, M.MID, O.OID, O.Organization,');
  RI.SQL.Append('  M.Description, M.Department, JT.JobType, JP.JobPosition');
  RI.SQL.Append('FROM Organization O');
  RI.SQL.Append('  INNER JOIN AOMAP M ON (M.OID=O.OID)');
  RI.SQL.Append('  LEFT JOIN JobType JT ON (M.JobTypeID=JT.JobTypeID)');
  RI.SQL.Append('  LEFT JOIN JobPosition JP ON (M.JobPositionID=JP.JobPositionID)');
  RI.WhereClause := 'M.AID = %d';
  List.Add(RI);

  // 6
  RI := TReportItem.Create;
  RI.SQL.Append('SELECT Field FROM OFields OFs');
  RI.SQL.Append('INNER JOIN Field F ON (F.FieldID = OFs.FieldID)');
  RI.WhereClause := 'OID = %d';
  List.Add(RI);

  // 7 :: Address
  RI := TReportItem.Create;
  RI.SQL.Append('SELECT Address, Region FROM Address');
  RI.WhereClause := '(LID = %d) AND (LinkType=''O'')';
  List.Add(RI);

  // 8 :: Contacts
  RI := TReportItem.Create;
  RI.SQL.Append('SELECT C.LID, C.CTID, CT.ContactType, C.Contact');
  RI.SQL.Append('FROM Contacts C');
  RI.SQL.Append('INNER JOIN ContactType CT ON (C.CTID = CT.CTID)');
  RI.WhereClause := 'LinkType= ''O'' AND LID = %d';
  List.Add(RI);

  // 9 :: FullName
  RI := TReportItem.Create;
  RI.SQL.Append('SELECT * FROM FullName');
  RI.WhereClause := 'AID = %d';
  List.Add(RI);

  // 10 :: Alumni Contacts :: This is a special query
  RI := TReportItem.Create;
  RI.WhereClause := 'SELECT * FROM RefContactList(%d, ''A'')';
  List.Add(RI);

  // 11 :: Organization Contacts :: This is a special query
  RI := TReportItem.Create;
  RI.WhereClause := 'SELECT * FROM RefContactList(%d, ''O'')';
  List.Add(RI);

  // 12 :: Map Contacts :: This is a special query
  RI := TReportItem.Create;
  RI.WhereClause := 'SELECT * FROM RefContactList(%d, ''M'')';
  List.Add(RI);

  // 13 :: Map's Offices
  RI := TReportItem.Create;
  RI.SQL.Append('SELECT Address, Region FROM Address');
  RI.WhereClause := '(LID = %d) AND (LinkType=''M'')';
  List.Add(RI);

  // 14 :: Experience
  RI := TReportItem.Create;
  RI.SQL.Append ('SELECT A.AID, AEx.Organization');
  RI.SQL.Append ('FROM Alumni A');
  RI.SQL.Append ('INNER JOIN AExperiences AEx ON (AEx.AID = A.AID)');
   RI.WhereClause := 'A.AID = %d';
  List.Add(RI);
end;

procedure PrepareListOrganization(Var List: TList);
var RI: TReportItem;
begin
  // 0 :: Org' Fields
  RI := TReportItem.Create;
  RI.SQL.Append('SELECT Field FROM OFields OFs');
  RI.SQL.Append('INNER JOIN Field F ON (F.FieldID = OFs.FieldID)');
  RI.WhereClause := 'OID = %d';
  List.Add(RI);

  // 1 :: Address
  RI := TReportItem.Create;
  RI.SQL.Append('SELECT Address, Region FROM Address');
  RI.WhereClause := '(LID = %d) AND (LinkType=''O'')';
  List.Add(RI);

  // 2 :: Contacts
  RI := TReportItem.Create;
  RI.SQL.Append('SELECT C.LID, C.CTID, CT.ContactType, C.Contact');
  RI.SQL.Append('FROM Contacts C');
  RI.SQL.Append('INNER JOIN ContactType CT ON (C.CTID = CT.CTID)');
  RI.WhereClause := 'LinkType= ''O'' AND LID = %d';
  List.Add(RI);

  // 3 :: Alumni
  RI := TReportItem.Create;
  RI.SQL.Append('SELECT M.OID, M.MID, A.AID, FN.FullName AS Name,');
  RI.SQL.Append('  M.Description, M.Department, JT.JobType, JP.JobPosition');
  RI.SQL.Append('FROM Alumni A');
  RI.SQL.Append('  INNER JOIN AOMAP M ON (M.AID=A.AID)');
  RI.SQL.Append('  LEFT JOIN JobType JT ON (M.JobTypeID=JT.JobTypeID)');
  RI.SQL.Append('  LEFT JOIN JobPosition JP ON (M.JobPositionID=JP.JobPositionID)');
  RI.SQL.Append('  INNER JOIN FullName FN ON (FN.AID=A.AID)');
  RI.WhereClause := 'M.OID = %d ORDER BY A.Name';
  List.Add(RI);

  // 4 :: Community
  RI := TReportItem.Create;
  RI.SQL.Append ('SELECT Community FROM FullCommunityName');
  RI.WhereClause := 'AID = %d';
  List.Add(RI);

   // 5 :: Contact
  RI := TReportItem.Create;
  RI.SQL.Append('SELECT C.LID, C.CTID, CT.ContactType, C.Contact');
  RI.SQL.Append('FROM Contacts C');
  RI.SQL.Append('INNER JOIN ContactType CT ON (C.CTID = CT.CTID)');
  RI.WhereClause := 'LinkType= ''A'' AND LID = %d';
  List.Add(RI);

  // 6 :: Address
  RI := TReportItem.Create;
  RI.SQL.Append('SELECT Address, Region FROM Address');
  RI.WhereClause := '(LID = %d) AND (LinkType=''A'')';
  List.Add(RI);

  // 7 :: Organization Contacts :: This is a special query
  RI := TReportItem.Create;
  RI.WhereClause := 'SELECT * FROM RefContactList(%d, ''O'')';
  List.Add(RI);

  // 8 :: Alumni Contacts :: This is a special query
  RI := TReportItem.Create;
  RI.WhereClause := 'SELECT * FROM RefContactList(%d, ''A'')';
  List.Add(RI);

  // 9 :: Map Contacts :: This is a special query
  RI := TReportItem.Create;
  RI.WhereClause := 'SELECT * FROM RefContactList(%d, ''M'')';
  List.Add(RI);

  // 10 :: Job Type
  RI := TReportItem.Create;
  RI.SQL.Append('SELECT Product FROM Organization');
  RI.WhereClause := '(OID = %d) AND (Product IS NOT NULL)';
  List.Add(RI);

  // 11 :: Branch Organization
  RI := TReportItem.Create;
  RI.SQL.Append('SELECT Organization FROM Organization');
  RI.WhereClause := 'ParentID = %d';
  List.Add(RI);

  // 12 :: Map's Offices
  RI := TReportItem.Create;
  RI.SQL.Append('SELECT Address, Region FROM Address');
  RI.WhereClause := '(LID = %d) AND (LinkType=''M'')';
  List.Add(RI);
end;

end.
