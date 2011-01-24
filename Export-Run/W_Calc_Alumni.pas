unit W_Calc_Alumni;

interface

uses DB, IBQuery, X_Base, X_List, W_Base, Classes;

type
  TWCDAlumni = class(TWriteCalcBase)
  private
    { Private declarations }
  protected
    { Protected declarations }
    procedure PrepareList; override;
    procedure DoHeader(GroupStr: String); override;
    procedure DoFooter(GroupStr: String); override;
  public
    { Public declarations }
    procedure DoSingle(Query: TIBQuery; Item: TExportItem;
      ooInstance, NewSheet: Variant); override;
  end;

implementation

uses SysUtils, ActiveX, Variants, X_Alumni_Report;

{ TWCDAlumni }

procedure TWCDAlumni.PrepareList;
begin
  PrepareListAlumni(FRL);
end;

procedure TWCDAlumni.DoHeader(GroupStr: String);
Var Cell: Variant;
begin
  Sheet.getCellRangeByPosition(0,Row,3,Row).merge(True);
  Cell := Sheet.getCellByPosition(0, Row);
  Cell.SetFormula( FGroupStr );
  Cell.CharHeight := 14;
  Cell.CharWeight := 150;  // 150%
  Cell.CharColor := $003399;
  Cell.CellBackColor := $ffff80;
  Inc (Row);
  StartRow := Row;
end;

procedure TWCDAlumni.DoFooter(GroupStr: String);
begin
  GroupRow(StartRow, Row);
  Inc (Row);
end;

procedure TWCDAlumni.DoSingle(Query: TIBQuery; Item: TExportItem;
  ooInstance, NewSheet: Variant);
Var
  CC: Integer;
  qrChild1, qrChild2: TIBQuery;
  StMRow, StDRow: Integer;
  AID, OID, MID: Integer;
begin
  inherited;

  qrChild1 := TIBQuery.Create(nil);
  qrChild1.Transaction := FQuery.Transaction;
  qrChild1.Database := FQuery.Database;

  qrChild2 := TIBQuery.Create(nil);
  qrChild2.Transaction := FQuery.Transaction;
  qrChild2.Database := FQuery.Database;

  CC:=5;
  OpenSheet(CC);

  Row:=4; // StartRow

  while not FQuery.EOF do
  begin // scan the database table
    BandHeader;

    AID := FQuery.Fieldbyname('AID').AsInteger;
    StMRow := Row; // Start Master

    SetExR(0, Row).setFormula(FQuery.RecNo);

    DoQReport(qrChild1, 9, AID, False,
      '"B:D, Field, FullName, H1"');
    DoQReport(qrChild1, 0, AID, True,
      '"C, Text, Community"; "D, Field, Community"');
    DoQReport(qrChild1, 1, AID, True,
      '"C, Text, Certification"; "D, Field, Certification"; "E, Field, Institution"');
    DoQReport(qrChild1, 2, AID, True,
      '"C, Text, Competency"; "D, Field, Competency"; "E, Field, Description"');
    DoQReport(qrChild1, 14, AID, True,
      '"C, Text, Experience"; "D, Field, Organization"');
    DoQReport(qrChild1, 3, AID, True,
      '"C, Text, Home"; "D, Field, Address"; "D\n, Field, Region"');
    DoQReport(qrChild1, 10, AID, True,
      '"C, Field, ContactType"; "D:E, Field, Contacts"');
//    Sheet.getCellRangeByPosition(1,SDRow,4,Row-1)
//       .autoFormat( AFmt );                         // per alumni

    // Organization
    MakeSQL(qrChild1, 5, AID);
    qrChild1.Open;
    while not qrChild1.EOF do
    begin
      Inc (Row);
      StDRow := Row; // Start Detail
      DoReport(qrChild1, False, '"C, Text, Organization, H2";'
        + '"D, Field, Organization, H2"; "F, Field, OID"');
      DoReport(qrChild1, False, '"C, Field, JobPosition";'
        + '"D, Field, Description";  "E, Field, Department"');
      DoReport(qrChild1, False, '"C, Field, JobType"');
      OID := qrChild1.Fieldbyname('OID').AsInteger;
      MID := qrChild1.Fieldbyname('MID').AsInteger;

      // Do Child
      DoQReport(qrChild2, 6, OID, True,
        '"C, Text, Bidang~Usaha"; "D, Field, Field"');
      DoQReport(qrChild2, 7, OID, True,
        '"C, Text, Office~(Address)"; "D, Field, Address"; "D\n, Field, Region"');
      DoQReport(qrChild2, 11, OID, True,
        '"C, Text, Office"; "D, Field, ContactType"; "E, Field, Contacts"');
      DoQReport(qrChild2, 13, MID, True,
        '"C, Text, Contact~(Address)"; "D, Field, Address"; "D\n, Field, Region"');
      DoQReport(qrChild2, 12, MID, True,
        '"C, Text, Contact"; "D, Field, ContactType"; "E, Field, Contacts"');
//      Sheet.getCellRangeByPosition(2,SDRow,5,Row-1)
//         .autoFormat( AFmt );                         // per organization

      GroupRow(StDRow+1, Row);
      Inc (Row);
      qrChild1.Next;
    end;
    qrChild1.Close;

    GroupRow(StMRow+1, Row);
    Inc (Row);
    FQuery.Next;

    BandFooter; // After Next !!
  end;

  Tidy(CC);

  qrChild1.Free;
  qrChild2.Free;
end;

end.
