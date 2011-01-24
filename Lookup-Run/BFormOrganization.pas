unit BFormOrganization;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FormLookup, DB, IBCustomDataSet, IBQuery, StdCtrls, Grids,
  DBGrids, DBCtrls, Buttons, ExtCtrls, ComCtrls, ToolWin,
  DateFltr, X_List;

type
  TBrowseOrganization = class(TfrmLookup)
    sbEdit: TSpeedButton;
    sbDate: TSpeedButton;
    sbCopyID: TSpeedButton;
    { Event Handlers }
    procedure OpenDetailForm(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnDateFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure sbCopyIDClick(Sender: TObject);
  private
    { Private declarations }
    DateRange: TDateRange;
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
  BrowseOrganization: TBrowseOrganization;

implementation

uses
  EntryOrganization, ClipBrd,
  X_Base, X_AppBase,
  W_HTML_Organization, W_Excel_Organization, W_Word_Organization,
  W_Calc_Organization, W_Text_Organization;

{$R *.dfm}

{ TBrowseAlumni }

procedure TBrowseOrganization.FormCreate(Sender: TObject);
begin
  inherited;
  cbExportKind.Items.Add('Details from this table');
  cbExportKind.Items.Add('Detail for this Organization');
  cbExportKind.ItemIndex := 3;
  DateRange := TDateRange.Create;
end;

procedure TBrowseOrganization.FormDestroy(Sender: TObject);
begin
  DateRange.Free;
  inherited;
end;

procedure TBrowseOrganization.BtnDateFilterClick(Sender: TObject);
begin
  If sbDate.Down then
    DateFilter.ShowModal;
end;

procedure TBrowseOrganization.InitQueryNames;
begin
  UniformID:=True;
  ChooseQuerySet := '"Simple Organization", "Organization",'
    + '"Field", "Job position",'
    + '"Simplified Address", "Simplified Working Address",'
    + '"Organization Contact", "Personal Contact",'
    + '"Multi Alumni",'
    + '"Complete Address", "Complete Working Address"';
  DefaultQueryIndex := 0;
end;

procedure TBrowseOrganization.InitSelectedQuery;
begin
  With SQLStat, SQLStat.QuerySQL do
  Case QueryIndex of
  0: begin
       Append('SELECT * FROM Organization');

       { Write Only Protected Properties }
       IDName:='OID';
       FieldNames := 'OID=1, Organization=5, Product=3, EntryDate=2';
       Orders  := 'Entry=OID, Organization, Product, EntryDate';
       DefaultSortIndex := 3; // After Orders
       AnyFmt   := 'EntryDate=DateTime';
     end;
  1: begin
       Append('SELECT EA.*, PO.Organization AS HeadOrganization');
       Append('FROM ExtendedOrganization EA');
       Append('  LEFT JOIN Organization PO ON (EA.ParentID=PO.OID)');

       { Write Only Protected Properties }
       IDName:='OID';
       FieldNames := 'OID=1, Organization=5, Last_Update=2, Field=3, Product=3,'
       + 'Name=5, JobPosition=3, Description=3, Department=3,'
       + 'HasBranch=1, HeadOrganization=5';
       Orders := 'Entry=EA.OID, Organization=EA., Last_Update=EA., Product=EA.,'
       + 'Field=EA., Name=EA., JobPosition=EA., Description=EA., Department=EA.,'
       + 'HasBranch=EA., HeadOrganization=PO.Organization';
       DefaultSortIndex := 1; // After Orders
       AllowedGroupingView := 'Field, JobPosition';
     end;
  2: begin
       Append('SELECT O.OID, O.Organization, '
         + 'O.Product, Fs.FieldID, F.Field');
       Append('FROM Organization O');
       Append('LEFT JOIN OFIELDS Fs ON (Fs.OID =  O.OID)');
       Append('LEFT JOIN Field F ON (Fs.FieldID = F.FieldID)');

       { Write Only Protected Properties }
       IDName:='OID';
       FieldNames := 'OID=1, Organization=5, Field=3, Product=3';
       Orders  := 'Entry=O.OID, Organization=O., Field=F., Product=O.';
       DefaultSortIndex := 2; // After Orders
       AllowedGroupingView := 'Field';
    end;
  3: begin
       Append('SELECT O.OID, A.Name, O.Organization,');
       Append('  M.Description, JP.JobPosition, M.Department,');
       Append('  M.Fungsional, M.Struktural');
       Append('FROM Organization O');
       Append('INNER JOIN AOMAP M ON (M.OID=O.OID)');
       Append('INNER JOIN Alumni A ON (M.AID=A.AID)');
       Append('LEFT JOIN JobPosition JP '
         + 'ON (M.JobPositionID=JP.JobPositionID)');

       { Write Only Protected Properties }
       IDName:='OID';
       FieldNames := 'Name=2, Organization=3, Description=2, JobPosition=2,'
         +'Department=2, Fungsional=2, Struktural=2';
       Orders  := '"Organization, JobPosition=O.Organization, JP.JobPosition",'
         +'Entry=O.OID, Name=A., Organization=O., JobPosition=JP.,'
         +'Department=M., Description=M., Fungsional=M., Struktural=M.';
       DefaultSortIndex := 4; // After Orders
       AllowedGroupingView := 'JobPosition';
     end;
  4: begin
       Append('SELECT O.OID, O.Organization, D.Address, D.Region,');
       Append('  D.NegaraID, D.PropinsiID, D.WilayahID');
       Append('FROM Organization O');
       Append('  INNER JOIN Address D');
       Append('  ON (D.LID = O.OID) AND (D.LinkType=''O'')');

       { Write Only Protected Properties }
       IDName:='OID';
       FieldNames := 'Organization=2, Address=5, Region=3';
       Orders  := 'Entry=O.OID, Organization=O., Address=D., Region=D.,'
       + 'NegaraID=D., PropinsiID=D., WilayahID=D.';
       DefaultSortIndex := 3; // After Orders
     end;
  5: begin
       Append('SELECT O.OID, O.Organization, A.Name, D.Address, D.Region,');
       Append('  D.NegaraID, D.PropinsiID, D.WilayahID');
       Append('FROM Organization O');
       Append('  INNER JOIN AOMap M ON (M.OID=O.OID)');
       Append('  INNER JOIN Alumni A ON (M.AID=A.AID)');
       Append('  INNER JOIN Address D');
       Append('  ON (D.LID = M.MID) AND (D.LinkType=''M'')');

       { Write Only Protected Properties }
       IDName:='OID';
       FieldNames := 'Organization=2, Name=2, Address=5, Region=3';
       Orders  := 'Entry=O.OID, Organization=O., Name=A.,'
       + 'Address=D., Region=D., NegaraID=D., PropinsiID=D., WilayahID=D.';
       DefaultSortIndex := 3; // After Orders
     end;
  6: begin
       Append('SELECT O.OID, O.Organization, VC.* FROM Organization O');
       Append('  INNER JOIN ViewContacts VC');
       Append('    ON (O.OID=VC.LID) AND (VC.LinkType=''O'')');

       { Write Only Protected Properties }
       IDName:='OID';
       FieldNames := 'Organization=2, HP=1, Phone=1, Fax=1, email=1, website=1';
       Orders  := 'Entry=OID, Organization, HP, Phone, Fax, email, website';
       DefaultSortIndex := 0; // After Orders
     end;
  7: begin
       Append('SELECT O.OID, A.Name, O.Organization, VC.*');
       Append('FROM Organization O');
       Append('  INNER JOIN AOMap M ON (M.OID=O.OID)');
       Append('  INNER JOIN Alumni A ON (M.AID=A.AID)');
       Append('  INNER JOIN ViewContacts VC');
       Append('    ON (M.MID=VC.LID) AND (VC.LinkType=''M'')');

       { Write Only Protected Properties }
       IDName:='OID';
       FieldNames := 'Organization=2, Name=2,'
         + 'HP=1, Phone=1, Fax=1, email=1, website=1';
       Orders  := 'Entry=OID, Organization, Name, HP, Phone, Fax, email, website';
       DefaultSortIndex := 0; // After Orders
     end;
  8: begin
       Append('SELECT O.OID, O.Organization, COUNT(M.OID) AS Alumnus,');
       Append('  CASE O.HasBranch WHEN "T" THEN "Ya"  WHEN "F" THEN "Tidak Ada"');
       Append('  ELSE NULL END AS Cabang');
       Append('FROM Organization O');
       Append('  INNER JOIN AOMap M ON (M.OID=O.OID)');
       Append('  INNER JOIN Alumni A ON (M.AID=A.AID)');

       GroupBy := 'GROUP BY O.OID, O.Organization, O.HasBranch'
         + '  HAVING COUNT(M.OID) > 1';

       { Write Only Protected Properties }
       IDName:='OID';
       FieldNames := 'Organization=5, Alumnus=2, Cabang=3';
       Orders  := 'Entry=O.OID, Organization=O., Alumnus, Cabang';
       DefaultSortIndex := 0; // After Orders
     end;
  9: begin
       Append('SELECT O.OID, O.Organization,');
       Append('  D.Kawasan, D.Gedung, D.Jalan, D.PostalCode,');
       Append('  N.Negara, P.Propinsi, W.Wilayah');
       Append('FROM Address D');  // Organization Left Join OOffices is slow
       Append('  INNER JOIN Organization O');
       Append('  ON (D.LID = O.OID) AND (D.LinkType=''O'')');
       Append('  LEFT JOIN Negara N ON (N.NegaraID = D.NegaraID)');
       Append('  LEFT JOIN Propinsi P ON (P.PropinsiID = D.PropinsiID)');
       Append('  LEFT JOIN Wilayah W ON (W.WilayahID = D.WilayahID)');

       { Write Only Protected Properties }
       IDName:='OID';
       FieldNames := 'Organization=3, Kawasan=2, Gedung=2, Jalan=2, PostalCode=1,'
         + 'Negara=2, Propinsi=2, Wilayah=2';
       Orders  := 'Entry=O.OID, Organization=O., Kawasan=D., Gedung=D., Jalan=D.,'
         + 'PostalCode=D., Negara=N., Propinsi=P., Wilayah=W.';
       DefaultSortIndex := 0; // After Orders
       AllowedGroupingView := 'Negara, Propinsi, Wilayah';
     end;
  10: begin
       Append('SELECT O.OID, O.Organization, A.Name,');
       Append('  D.Kawasan, D.Gedung, D.Jalan, D.PostalCode,');
       Append('  N.Negara, P.Propinsi, W.Wilayah');
       Append('FROM Organization O');
       Append('  INNER JOIN AOMap M ON (M.OID=O.OID)');
       Append('  INNER JOIN Address D');
       Append('  ON (D.LID = M.MID) AND (D.LinkType=''M'')');
       Append('    LEFT JOIN Negara N ON (N.NegaraID = D.NegaraID)');
       Append('    LEFT JOIN Propinsi P ON (P.PropinsiID = D.PropinsiID)');
       Append('    LEFT JOIN Wilayah W ON (W.WilayahID = D.WilayahID)');
       Append('  INNER JOIN Alumni A ON (M.AID=A.AID)');

       { Write Only Protected Properties }
       IDName:='OID';
       FieldNames := 'Organization=3, Name=3,'
         + 'Kawasan=2, Gedung=2, Jalan=2, PostalCode=1,'
         + 'Negara=2, Propinsi=2, Wilayah=2';
       Orders  := 'Entry=O.OID, Organization=O., Name=A.,'
         + 'Kawasan=D., Gedung=D., Jalan=D.,'
         + 'PostalCode=D., Negara=N., Propinsi=P., Wilayah=W.';
       DefaultSortIndex := 0; // After Orders
       AllowedGroupingView := 'Negara, Propinsi, Wilayah';
     end;
  end;

  // Update UI
  sbDate.enabled := (QueryIndex in [0,1]);
end;

procedure TBrowseOrganization.OpenDetailForm(Sender: TObject);
begin
  frmEntryOrganization.Show;
end;

procedure TBrowseOrganization.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  frmEntryOrganization.Close;
  inherited;
end;

procedure TBrowseOrganization.SetConstraint;
var Index: Integer;
begin
  inherited;
  Index := QueryIndex;

  DateRange.Update(DateFilter.FromDate, DateFilter.ToDate);

  With SQLStat.Filters do
  case Index of
    0 : If sbDate.Down then
        Append( DateRange.FilterStr('EntryDate', False) );
    1 : If sbDate.Down then
        Append( DateRange.FilterStr('EA.Last_Update', False) );
  end;

end;

procedure TBrowseOrganization.MakeList(List: TExportList);
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
      SID := qrLookup.FieldByName('OID').AsString;
      SQL := TStringList.Create;
      SQL.Append ( Format( 'SELECT * FROM Organization WHERE OID=%s', [SID]));

      List.AddQuery( SQL, '', '', 'Detail-Org-'+SID, 'OID', '');
      SQL.Free;
    end;
  end; // case
end;

procedure TBrowseOrganization.DoReport(List: TExportList);
Var
  CommonExport: TExportBase;
  HTML  : TWHDOrganization;
  Excel : TWEDOrganization;
  Doc   : TWWDOrganization;
  Calc  : TWCDOrganization;
  Text  : TWTDOrganization;
  dbName: String;
begin
  If (cbExportKind.ItemIndex=3) and (not qrLookup.Active) then
  begin
    ShowMessage('Please select organization...');
    exit;
  end;

  dbName := qrLookup.Database.DatabaseName;
  inherited;

  // launch alternate second process
  If cbExportKind.ItemIndex in [2..3] then
  begin
    Case cbExport.ItemIndex of // launch second process
    0: begin
         HTML := TWHDOrganization.Create;
         CommonExport := TExportHTMLBase.Create (dbName, List, HTML);
       end;
    1: begin
         Excel := TWEDOrganization.Create;
         CommonExport := TExportExcelBase.Create (dbName, List, Excel);
       end;
    2: begin
         Doc := TWWDOrganization.Create;
         CommonExport := TExportWordBase.Create (dbName, List, Doc);
       end;
    3: begin
         Calc := TWCDOrganization.Create;
         CommonExport := TExportCalcBase.Create (dbName, List, Calc);
       end;
    4: begin
         Text := TWTDOrganization.Create;
         CommonExport := TExportTextBase.Create (dbName, List, Text);
       end;
    end; // case

    If cbExport.ItemIndex in [0..4] then
      CommonExport.Resume;   // Thread;
  end; // if
end;

procedure TBrowseOrganization.sbCopyIDClick(Sender: TObject);
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




end.


