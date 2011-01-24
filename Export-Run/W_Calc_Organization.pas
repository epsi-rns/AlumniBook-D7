unit W_Calc_Organization;

interface

uses ExcelXP, DB, IBQuery, X_Base, X_List, W_Base, Classes;

type
  TWCDOrganization = class(TWriteCalcBase)
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

{ TWCDOrganization }

procedure TWCDOrganization.PrepareList;
begin
  PrepareListOrganization(FRL);
end;

procedure TWCDOrganization.DoHeader(GroupStr: String);
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

procedure TWCDOrganization.DoFooter(GroupStr: String);
begin
  GroupRow(StartRow, Row);
  Inc (Row);
end;

procedure TWCDOrganization.DoSingle(Query: TIBQuery; Item: TExportItem;
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

  CC:=8;
  OpenSheet(CC);

  Row:=4; // StartRow

  while not FQuery.EOF do
  begin // scan the database table
    BandHeader;

    OID := FQuery.FieldByName('OID').AsInteger;
    StMRow := Row; // Start Master

    SetExR(0, Row).SetFormula(FQuery.RecNo);

    DoReport(FQuery, False,
      '"B:D, Field, Organization, H1"');

    DoQReport(qrChild1, 10, OID, True,
      '"B, Text, Product"; "C, Field, Product"');
    DoQReport(qrChild1, 0, OID, True,
      '"B, Text, Bidang~Usaha"; "C, Field, Field"');
    DoQReport(qrChild1, 11, OID, True,
      '"B, Text, Branch"; "C, Field, Organization"');
    DoQReport(qrChild1, 1, OID, True,
      '"C, Text, Office"; "D, Field, Address"; "E, Field, Region"');
    DoQReport(qrChild1, 7, OID, True,
      '"C, Field, ContactType"; "D:E, Field, Contacts"');
//    Sheet.getCellRangeByPosition(1,SDRow,4,Row-1)
//       .autoFormat( AFmt );                     // per organization

    // Organization
    MakeSQL(qrChild1, 3, OID);
    qrChild1.Open;
    while not qrChild1.EOF do
    begin
      Inc (Row);
      StDRow := Row; // Start Detail
      DoReport(qrChild1, False, '"C, Field, Name, H2"; "E, Field, Department";'
        + '"F, Field, AID"');
      DoReport(qrChild1, False, '"D, Field, JobPosition"; "E, Field, Description"');
      DoReport(qrChild1, False, '"D, Field, JobType"');
      AID := qrChild1.Fieldbyname('AID').AsInteger;
      MID := qrChild1.Fieldbyname('MID').AsInteger;

      // Do Child
      DoQReport(qrChild2, 4, AID, True,
        '"C, Text, Community"; "D:E, Field, Community"');
      DoQReport(qrChild2, 8, AID, True,
        '"C, Text, Personal"; "D, Field, ContactType"; "E, Field, Contacts"');
      DoQReport(qrChild2, 12, MID, True,
        '"C, Text, Working~Office"; "D, Field, Address"; "E, Field, Region"');
      DoQReport(qrChild2, 9, MID, True,
        '"C, Text, Contact"; "D, Field, ContactType"; "E, Field, Contacts"');
//    Sheet.getCellRangeByPosition(2,SDRow,5,Row-1)
//       .autoFormat( AFmt );                       // per alumni

      GroupRow(StDRow+1, Row+1);
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
