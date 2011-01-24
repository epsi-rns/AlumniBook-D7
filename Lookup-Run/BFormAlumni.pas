unit BFormAlumni;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FormLookup, DB, IBCustomDataSet, IBQuery, StdCtrls, Grids,
  DBGrids, DBCtrls, Buttons, ExtCtrls, ComCtrls, ToolWin,
  DateFltr, X_List, Mask, Spin;

type
  TBrowseAlumni = class(TfrmLookup)
    sbEdit: TSpeedButton;
    sbDate: TSpeedButton;
    sbCopyID: TSpeedButton;
    cbDeptID: TComboBox;
    Label7: TLabel;
    Label8: TLabel;
    cbProgID: TComboBox;
    qrFilter: TIBQuery;
    SpinYear: TSpinEdit;
    cbAngkatan: TCheckBox;
    Label9: TLabel;
    cbSourceID: TComboBox;
    Label11: TLabel;
    cbFactID: TComboBox;
    { Event Handlers }
    procedure OpenDetailForm(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnDateFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure sbCopyIDClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    DateRange: TDateRange;
    FactPairs, DeptPairs, ProgPairs, SourcePairs: TStrings;
  protected
    { Protected declarations }
    procedure InitQueryNames; override;
    procedure InitSelectedQuery; override;
    procedure SetConstraint; override;    
    procedure DoReport(List: TExportList); override;
    procedure MakeList(List: TExportList); override;
  public
    { Public declarations }

  end;

var
  BrowseAlumni: TBrowseAlumni;

implementation

uses
  EntryAlumni, ClipBrd,
  X_Base, X_AppBase,
  W_Excel_Alumni, W_HTML_Alumni, W_Word_Alumni, W_Calc_Alumni, W_Text_Alumni;

{$R *.dfm}

{ TBrowseAlumni }

procedure TBrowseAlumni.FormCreate(Sender: TObject);
begin
  inherited;
  cbExportKind.Items.Add('Details from this table');
  cbExportKind.Items.Add('Detail for this Alumni');
  cbExportKind.ItemIndex := 3;
  DateRange := TDateRange.Create;
  FactPairs := TStringList.Create;
  DeptPairs := TStringList.Create;
  ProgPairs := TStringList.Create;
  SourcePairs := TStringList.Create;
end;

procedure TBrowseAlumni.FormDestroy(Sender: TObject);
begin
  DateRange.Free;
  FactPairs.Free;  
  DeptPairs.Free;
  ProgPairs.Free;
  SourcePairs.Free;  
  inherited;
end;

procedure TBrowseAlumni.BtnDateFilterClick(Sender: TObject);
begin
  If sbDate.Down then
    DateFilter.ShowModal;
end;

procedure TBrowseAlumni.InitQueryNames;
begin
  UniformID:=True;
  ChooseQuerySet := '"Simple Alumni", "Alumni", "Community", "Birth Day",'
    + '"Simplified Homes", "Simplified Working Address",'
    + '"Personal Contact", "Working Contact",'
    + '"Certification", "Competency", "Occupancy",'
    + '"Multi Job",'
    + '"Complete Homes", "Complete Working Address"';
  DefaultQueryIndex := 0;
end;

procedure TBrowseAlumni.InitSelectedQuery;
var // Filter on Community and Source,
    // with order and AllowedGroupingView (AGV)
  CFCol, CFJoin, CFOrders, CFAGV: string;
  SFCol, SFJoin, SFOrders, SFAGV: string;
begin
  CFCol    := ', C.Community, C.Angkatan, C.FacultyID, C.DepartmentID, C.ProgramID' ;
  CFJoin   := '  LEFT JOIN ACommunities C ON (A.AID=C.AID)' ;
  CFOrders := ', Angkatan=C., FacultyID=C., DepartmentID=C., ProgramID=C.';
  CFAGV    := ', Angkatan, FacultyID, DepartmentID, ProgramID'; // Lookup from pairs above

  SFCol    := ', A.SourceID, So.Source' ;
  SFJoin   := '  INNER JOIN Source So ON (A.SourceID=So.SourceID)' ;
  SFOrders := ', Source=So.';
  SFAGV    := ', Source'; // Lookup from pairs above

  With SQLStat, SQLStat.QuerySQL do
  Case QueryIndex of
  0: begin
       Append('SELECT A.AID, A.Prefix, A.Name, A.Suffix, A.ShowTitle, '
        + 'A.EntryDate');
       Append(CFCol+SFCol);
       Append('FROM Alumni A');
       Append(CFJoin+SFJoin);

       { Write Only Protected Properties }
       IDName:='AID';
       FieldNames := 'AID=1, Community=2, '
       + 'Prefix=2, Name=6, Suffix=2, ShowTitle=1, EntryDate=2';
       Orders  := 'Entry=AID, Community,'
       + 'Name, Prefix, Suffix, ShowTitle, EntryDate';
       DefaultSortIndex := 7; // After Orders
       AnyFmt   := 'EntryDate=DateTime';

       AllowedGroupingView := 'Community';
//      AllowedGroupingView := AllowedGroupingView
//        + ', Angkatan, DepartmentID, ProgramID';
     end;
  1: begin
       Append('SELECT C.*, So.Source ');
       Append('FROM ExtendedAlumni C');
       Append('  INNER JOIN Source So ON (C.SourceID=So.SourceID)');

       { Write Only Protected Properties }
       IDName:='AID';
       FieldNames := 'AID=1, Community=3, FullName=5, Last_Update=2,'
       + 'Religion=2, Angkatan=2, Program=2, Department=2, Faculty=2, '
       + 'Organization=5, JobType=3, JobPosition=3,'
       + 'Certification=3, Institution=3, Competency=3';

       Orders := 'Entry=AID, Name, FullName, Last_Update, Religion, '
       + 'Source=So.,'
       + 'Angkatan, Community, Program, Department, Faculty,'
       + 'Organization, JobType, JobPosition,'
       + 'Certification, Institution, Competency';
       DefaultSortIndex := 1; // After Orders
       AnyFmt   := 'Last_Update=DateTime';
       AllowedGroupingView := 'Angkatan, Faculty, Department, Program, Community,'
       + 'JobType, JobPosition, Competency, Source';
     end;
  2: begin
       Append('SELECT A.AID, A.Name, A.Last_Update,');
       Append('  C.Angkatan, C.Community, C.Program, C.Department, C.Faculty');
       Append(SFCol);
       Append('FROM Alumni A');
       Append('  LEFT JOIN ExtendedCommunity C ON (C.AID=A.AID)');
       Append(SFJoin);

       { Write Only Protected Properties }
       IDName:='AID';
       FieldNames := 'Community=2, Name=3, Angkatan=1,'
         + 'Program=1, Department=1, Faculty=1, Last_Update=2';
       Orders  := 'Entry=C.AID, Name=A., Last_Update=A., Angkatan=C.,'
         + 'Community=C., Program=C., Department=C., Faculty=C., Source=So.';
       DefaultSortIndex := 2; // After Orders
       AnyFmt   := 'Last_Update=DateTime';
       AllowedGroupingView := 'Angkatan, Faculty, Department, Program, Community, Source';
     end;
  3: begin // * //
       Append('SELECT A.* '+CFCol+SFCol+' FROM Lahir A');
       Append(CFJoin+SFJoin);

       { Write Only Protected Properties }
       IDName:='AID';
       FieldNames := 'Community=3, Name=4,'
         + 'BirthDate=3, Tanggal=1, Bulan=1, Tahun=1, Hari=1, Lahir=2';
       Orders  := 'Entry=A.AID, Community=C., Name=A., Source=So., '
         + 'BirthDate=A., Tanggal=A., Bulan=A., Tahun=A., Hari=A., Lahir=A.'; 
       DefaultSortIndex := 3; // After Orders
       AnyFmt   := 'BirthDate=Date';
       AllowedGroupingView :=  'Tanggal, Bulan, Tahun, Hari, Community, Source';
     end;
  4: begin
       Append('SELECT A.AID, A.Name, D.Address, D.Region,');
       Append('  D.NegaraID, D.PropinsiID, D.WilayahID');
       Append(CFCol+SFCol);
       Append('FROM Alumni A'); // Alumni Left Join AHomes is slow!!
       Append('  INNER JOIN Address D');
       Append('  ON (D.LID = A.AID) AND (D.LinkType=''A'')');
       Append(CFJoin+SFJoin);

       { Write Only Protected Properties }
       IDName:='AID';
       FieldNames := 'Community=1, Name=2, Address=5, Region=3';
       Orders  := 'Entry=A.AID, Name=A., Address=D., Region=D.,'
       + 'NegaraID=D., PropinsiID=D., WilayahID=D.';
       DefaultSortIndex := 3; // After Orders
     end;
  5: begin
       Append('SELECT A.AID, A.Name, O.Organization,');
       Append('  D.Address, D.Region, D.NegaraID, D.PropinsiID, D.WilayahID');
       Append(CFCol+SFCol);
       Append('FROM Alumni A');
       Append('  INNER JOIN AOMap M ON (M.AID=A.AID)');
       Append('  INNER JOIN Organization O ON (M.OID=O.OID)');
       Append('  INNER JOIN Address D');
       Append('  ON (D.LID = M.MID) AND (D.LinkType=''M'')');
       Append(CFJoin+SFJoin);

       { Write Only Protected Properties }
       IDName:='AID';
       FieldNames := 'Community=1, Name=2, Organization=2, Address=5, Region=3';
       Orders  := 'Entry=A.AID, Name=A., Organization=O.,'
       + 'Address=D., Region=D., NegaraID=D., PropinsiID=D., WilayahID=D.';
       DefaultSortIndex := 4; // After Orders
     end;
  6: begin
       Append('SELECT A.AID, A.Name, VC.*');
       Append(CFCol+SFCol);
       Append('FROM Alumni A');
       Append('  INNER JOIN ViewContacts VC');
       Append('    ON (A.AID=VC.LID) AND (VC.LinkType=''A'')');
       Append(CFJoin+SFJoin);

       { Write Only Protected Properties }
       IDName:='AID';
       FieldNames := 'Community=1, Name=1, HP=1, Phone=1, Fax=1, email=1, website=1';
       Orders  := 'Entry=AID, Name, HP, Phone, Fax, email, website';
       DefaultSortIndex := 0; // After Orders
     end;
  7: begin
       Append('SELECT A.AID, A.Name, O.Organization, VC.*');
       Append(CFCol+SFCol);
       Append('FROM Organization O');
       Append('  INNER JOIN AOMap M ON (M.OID=O.OID)');
       Append('  INNER JOIN Alumni A ON (M.AID=A.AID)');
       Append('  INNER JOIN ViewContacts VC');
       Append('    ON (M.MID=VC.LID) AND (VC.LinkType=''M'')');
       Append(CFJoin+SFJoin);

       { Write Only Protected Properties }
       IDName:='AID';
       FieldNames := 'Community=1, Name=2, Organization=2,'
         + 'HP=1, Phone=1, Fax=1, email=1, website=1';
       Orders  := 'Entry=AID, Name, Organization,'
         + 'HP, Phone, Fax, email, website';
       DefaultSortIndex := 0; // After Orders
     end;
  8: begin
       Append('SELECT A.AID, A.Name,');
       Append('  ACe.Certification, ACe.Institution');
       Append(CFCol+SFCol);
       Append('FROM Alumni A');
       Append('INNER JOIN ACertifications ACe ON (ACe.AID = A.AID)');
       Append(CFJoin+SFJoin);

       { Write Only Protected Properties }
       IDName:='AID';
       FieldNames := 'Community=1, Name=2, Certification=3, Institution=3';
       Orders  := 'Entry=A.AID, Name=A., Certification=ACe., Institution=Ace.';
       DefaultSortIndex := 2; // After Orders
     end;
  9: begin
       Append('SELECT A.AID, A.Name,');
       Append('  Co.Competency, ACo.Description');
       Append(CFCol+SFCol);
       Append('FROM ACompetencies ACo');
       Append('INNER JOIN Alumni A ON (ACo.AID = A.AID)');
       Append('INNER JOIN Competency Co '
         + 'ON (Co.CompetencyID = ACo.CompetencyID)');
       Append(CFJoin+SFJoin);

       { Write Only Protected Properties }
       IDName:='AID';
       FieldNames := 'Community=1, Name=2, Competency=3, Description=3';
       Orders  := 'Entry=A.AID, Name=A., Competency=Co., Description=ACo.';
       DefaultSortIndex := 2; // After Orders
       AllowedGroupingView := 'Competency';
     end;
  10: begin
       Append('SELECT A.AID, A.Name, O.Organization,');
       Append('  M.Description, JT.JobType, JP.JobPosition, M.Department');
       Append(CFCol+SFCol);
       Append('FROM Alumni A');
       Append('INNER JOIN AOMAP M ON (M.AID=A.AID)');
       Append('INNER JOIN Organization O ON (M.OID=O.OID)');
       Append('LEFT JOIN JobType JT '
         + 'ON (M.JobTypeID=JT.JobTypeID)');
       Append('LEFT JOIN JobPosition JP '
         + 'ON (M.JobPositionID=JP.JobPositionID)');
       Append(CFJoin+SFJoin);

       { Write Only Protected Properties }
       IDName:='AID';
       FieldNames := 'Community=1, Name=2, JobType=2, JobPosition=2, '
         +'Organization=2, Description=2, Department=2';
       Orders  := 'Entry=A.AID, Name=A., Organization=O., '
         +' JobType=JT., JobPosition=JP., Department=M., Description=M.';
       DefaultSortIndex := 3; // After Orders
       AllowedGroupingView := 'JobPosition';
     end;
  11: begin
       Append('SELECT A.AID, O.OID, A.Name, O.Organization');
       Append(CFCol+SFCol);
       Append('FROM Organization O');
       Append('  INNER JOIN AOMap M ON (M.OID=O.OID)');
       Append('  INNER JOIN Alumni A ON (M.AID=A.AID)');
       Append(CFJoin+SFJoin);

       { Write Only Protected Properties }
       IDName:='AID';
       FieldNames := 'AID=1, OID=1, Community=2, Name=5, Organization=5';
       Orders  := 'Name=A., Organization=O., "Entry Alumni=A.AID", "Entry Organization=O.OID"';
       DefaultSortIndex := 0; // After Orders
     end;
  12: begin
       Append('SELECT A.AID, A.Name,');
       Append('  D.Kawasan, D.Gedung, D.Jalan, D.PostalCode,');
       Append('  N.Negara, P.Propinsi, W.Wilayah');
       Append(CFCol+SFCol);
       Append('FROM Address D'); // Alumni Left Join Address is slow!!
       Append('  INNER JOIN Alumni A');
       Append('    ON (A.AID=D.LID) AND (D.LinkType =''A'')');
       Append('  LEFT JOIN Negara N ON (N.NegaraID = D.NegaraID)');
       Append('  LEFT JOIN Propinsi P ON (P.PropinsiID = D.PropinsiID)');
       Append('  LEFT JOIN Wilayah W ON (W.WilayahID = D.WilayahID)');
       Append(CFJoin+SFJoin);

       { Write Only Protected Properties }
       IDName:='AID';
       FieldNames := 'Community=2, Name=3, Kawasan=2, Gedung=2, Jalan=2, PostalCode=1,'
         + 'Negara=2, Propinsi=2, Wilayah=2';
       Orders  := 'Entry=A.AID, Name=A., Negara=N., Propinsi=P., Wilayah=W.,'
         + 'Kawasan=D., Gedung=D., Jalan=D., PostalCode=D.';
       DefaultSortIndex := 0; // After Orders
       AllowedGroupingView := 'Negara, Propinsi, Wilayah';
     end;
  13: begin
       Append('SELECT A.AID, A.Name, O.Organization,');
       Append('  D.Kawasan, D.Gedung, D.Jalan, D.PostalCode,');
       Append('  N.Negara, P.Propinsi, W.Wilayah');
       Append(CFCol+SFCol);
       Append('FROM Alumni A');
       Append('  INNER JOIN AOMap M ON (M.AID=A.AID)');
       Append('  INNER JOIN Address D');
       Append('    ON (M.MID=D.LID) AND (D.LinkType =''M'')');
       Append('    LEFT JOIN Negara N ON (N.NegaraID = D.NegaraID)');
       Append('    LEFT JOIN Propinsi P ON (P.PropinsiID = D.PropinsiID)');
       Append('    LEFT JOIN Wilayah W ON (W.WilayahID = D.WilayahID)');
       Append('  INNER JOIN Organization O ON (M.OID=O.OID)');
       Append(CFJoin+SFJoin);

       { Write Only Protected Properties }
       IDName:='AID';
       FieldNames := 'Community=2, Name=3, Organization=3,'
         + 'Kawasan=2, Gedung=2, Jalan=2, PostalCode=1,'
         + 'Negara=2, Propinsi=2, Wilayah=2';
       Orders  := 'Entry=A.AID, Name=A., Organization=O.,'
         + 'Negara=N., Propinsi=P., Wilayah=W.,'
         + 'Kawasan=D., Gedung=D., Jalan=D., PostalCode=D.';
       DefaultSortIndex := 0; // After Orders
       AllowedGroupingView := 'Negara, Propinsi, Wilayah';
     end;
  end;

  If not (QueryIndex in [1, 2]) then
    with SQLStat do
    begin
      Orders := Orders + CFOrders + SFOrders;
      AllowedGroupingView := AllowedGroupingView + CFAGV + SFAGV;
    end;

  // Update UI
  sbDate.enabled := (QueryIndex in [0,1,2,3]);
end;

procedure TBrowseAlumni.OpenDetailForm(Sender: TObject);
begin
  frmEntryAlumni.Show;
end;

procedure TBrowseAlumni.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  frmEntryAlumni.Close;
  inherited;
end;

procedure TBrowseAlumni.SetConstraint;
var
  Index: Integer;
  Name, Value: String;
begin
  inherited;
  Index := QueryIndex;

  DateRange.Update(DateFilter.FromDate, DateFilter.ToDate);

  With SQLStat.Filters do
  case Index of
    0: If sbDate.Down then
        Append( DateRange.FilterStr('EntryDate', False) );
    1,2: If sbDate.Down then
        Append( DateRange.FilterStr('Last_Update', False) );
    3:  If sbDate.Down then
        Append( DateRange.FilterStr('L.BirthDate', False) );
    11: begin
      Append( 'A.AID IN '
        + '(SELECT M.AID FROM Organization O '
        + 'INNER JOIN AOMap M ON (M.OID=O.OID) '
        + '  GROUP BY M.AID HAVING COUNT(O.OID) > 1)');
    end;
  end;

  if (cbFactID.ItemIndex > -1) then
  begin
    Name  := cbFactID.Items[cbFactID.ItemIndex];
    Value := FactPairs.Values[Name];
    SQLStat.Filters.Append('C.FacultyID=' + Value);
  end;

  if (cbDeptID.ItemIndex > -1) then
  begin
    Name  := cbDeptID.Items[cbDeptID.ItemIndex];
    Value := DeptPairs.Values[Name];
    SQLStat.Filters.Append('C.DepartmentID=' + Value);
  end;

  if (cbProgID.ItemIndex > -1) then
  begin
    Name  := cbProgID.Items[cbProgID.ItemIndex];
    Value := ProgPairs.Values[Name];
    SQLStat.Filters.Append('C.ProgramID=' + Value);
  end;

  if (cbSourceID.ItemIndex > -1) then
  begin
    Name  := cbSourceID.Items[cbSourceID.ItemIndex];
    Value := SourcePairs.Values[Name];
    SQLStat.Filters.Append('So.SourceID=' + Value);
  end;

  if cbAngkatan.Checked then
    SQLStat.Filters.Append(Format('C.Angkatan=%d', [SpinYear.Value]));
end;

procedure TBrowseAlumni.MakeList(List: TExportList);
Var
  SQL : TStrings;
  SID: String;
begin
  inherited;

  // alternate case
  case cbExportKind.ItemIndex of
    2: If GroupViewBox.ItemIndex = -1
       then GetThisItem(List)
       else GetGroupViewItem(List);
    3: If qrLookup.Active then
    begin
      SID := qrLookup.FieldByName('AID').AsString;
      SQL := TStringList.Create;
      SQL.Append ( Format('SELECT * FROM Alumni WHERE AID=%s', [ SID ] ));

      List.AddQuery( SQL, '', '', 'Detail-Alumni-'+SID, 'AID', '');
      SQL.Free;
    end;
  end; // case
end;

procedure TBrowseAlumni.DoReport(List: TExportList);
Var
  CommonExport: TExportBase;
  HTML  : TWHDAlumni;
  Excel : TWEDAlumni;
  Doc   : TWWDAlumni;
  Calc  : TWCDAlumni;
  Text  : TWTDAlumni;
  dbName: String;
begin
  If (cbExportKind.ItemIndex=3) and (not qrLookup.Active) then
  begin
    ShowMessage('Please select alumna...');
    exit;
  end;

  dbName := qrLookup.Database.DatabaseName;
  inherited;

  // launch alternate second process
  If cbExportKind.ItemIndex in [2..3] then
  begin
    Case cbExport.ItemIndex of // launch second process
    0: begin
         HTML := TWHDAlumni.Create;
         CommonExport := TExportHTMLBase.Create (dbName, List, HTML);
       end;
    1: begin
         Excel := TWEDAlumni.Create;
         CommonExport := TExportExcelBase.Create (dbName, List, Excel);
       end;
    2: begin
         Doc := TWWDAlumni.Create;
         CommonExport := TExportWordBase.Create (dbName, List, Doc);
       end;
    3: begin
         Calc := TWCDAlumni.Create;
         CommonExport := TExportCalcBase.Create (dbName, List, Calc);
       end;
    4: begin
         Text := TWTDAlumni.Create;
         CommonExport := TExportTextBase.Create (dbName, List, Text);
       end;

    end; // case

    If cbExport.ItemIndex in [0..4] then
      CommonExport.Resume;   // Thread;
  end; // if
end;

procedure TBrowseAlumni.sbCopyIDClick(Sender: TObject);
Var
  ID : Integer;
  S  : TStrings;
begin
  If not qrLookup.Active then
    ShowMessage('No active query!')
  else
  begin
    S:=TStringList.Create;
    ID := qrLookup[SQLStat.IDName];

    qrLookup.First;
    While not qrLookup.EOF do
    begin
      S.Append(qrLookup.FieldByName(SQLStat.IDName).AsString);
      qrLookup.Next;
    end;

    Clipboard.AsText := S.CommaText;

    qrLookup.Locate(SQLStat.IDName, ID, []);
    S.Free;
  end;
end;

procedure TBrowseAlumni.FormShow(Sender: TObject);
begin
  If (cbFactID.Items.Count=0) then
  with qrFilter do
  begin
    SQL.Clear;
    SQL.Append('SELECT * FROM Faculty');
    Open;
    While not EOF do
    begin
      cbFactID.Items.Add( FieldByName('Faculty').AsString );
      FactPairs.Add( FieldByName('Faculty').AsString
      + '=' +FieldByName('FacultyID').AsString);
      Next;
    end;
    Close;
  end;

  If (cbDeptID.Items.Count=0) then
  with qrFilter do
  begin
    SQL.Clear;
    SQL.Append('SELECT * FROM Department');
    Open;
    While not EOF do
    begin
      cbDeptID.Items.Add( FieldByName('Department').AsString );
      DeptPairs.Add( FieldByName('Department').AsString
      + '=' +FieldByName('DepartmentID').AsString);
      Next;
    end;
    Close;
  end;

  If (cbProgID.Items.Count=0) then
  with qrFilter do
  begin
    SQL.Clear;
    SQL.Append('SELECT * FROM Program');
    Open;
    While not EOF do
    begin
      cbProgID.Items.Add( FieldByName('Program').AsString );
      ProgPairs.Add( FieldByName('Program').AsString
      + '=' +FieldByName('ProgramID').AsString);
      Next;
    end;
    Close;
  end;

  If (cbSourceID.Items.Count=0) then
  with qrFilter do
  begin
    SQL.Clear;
    SQL.Append('SELECT * FROM Source');
    Open;
    While not EOF do
    begin
      cbSourceID.Items.Add( FieldByName('Source').AsString );
      SourcePairs.Add( FieldByName('Source').AsString
      + '=' +FieldByName('SourceID').AsString);
      Next;
    end;
    Close;
  end;

  inherited;
end;

end.


