unit W_Excel_Organization;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses ExcelXP, DB, IBQuery, X_Base, X_List, W_Base, Classes;

type
  TWEDOrganization = class(TWriteExcelBase)
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
      Sheet: _WorksheetDisp); override;
  end;

implementation

uses SysUtils, ActiveX, Variants, X_Alumni_Report;

{ TExportDetailExcel }

procedure TWEDOrganization.PrepareList;
begin
  PrepareListOrganization(FRL);
end;

procedure TWEDOrganization.DoHeader(GroupStr: String);
begin
  ExR := SetExR ('A','D',Row,Row);
  ExR.MergeCells := True;
  ExR.Value2 := FGroupStr;
  With ExR.Font do begin Size:=14; Bold:=1; end;
  Inc (Row);
end;

procedure TWEDOrganization.DoFooter(GroupStr: String);
begin
  Inc (Row);
end;

procedure TWEDOrganization.DoSingle(Query: TIBQuery; Item: TExportItem;
  Sheet: _WorksheetDisp);
Var
  qrChild1, qrChild2: TIBQuery;
  SDRow: Integer;
  AID, OID, MID: Integer;
begin
  inherited;

  qrChild1 := TIBQuery.Create(nil);
  qrChild1.Transaction := FQuery.Transaction;
  qrChild1.Database := FQuery.Database;

  qrChild2 := TIBQuery.Create(nil);
  qrChild2.Transaction := FQuery.Transaction;
  qrChild2.Database := FQuery.Database;

  AFmt := 6;
  OpenSheet('I');

  StartRow:=4; Row:=StartRow;

  while not FQuery.EOF do
  begin // scan the database table
    BandHeader;

    OID := FQuery.Fieldbyname('OID').AsInteger;
    SetExR('A', Row).Value2 := FQuery.RecNo;
    DoReport(FQuery, False,
      '"B:D, Field, Organization, H1"');
    SDRow := Row; // Start Detail

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
    AutoFormat ('B', 'E', SDRow, Row-1, False);   // per organization

    // Organization
    MakeSQL(qrChild1, 3, OID);
    qrChild1.Open;
    while not qrChild1.EOF do
    begin
      Inc (Row);
      SDRow := Row; // Start Detail
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
      AutoFormat ('C', 'F', SDRow, Row-1, False);   // per alumni
      Inc (Row);
      qrChild1.Next;
    end;
    qrChild1.Close;

    Inc (Row);
    FQuery.Next;

    BandFooter; // After Next !!
  end;

  Tidy;

  qrChild1.Free;
  qrChild2.Free;
end;

end.
