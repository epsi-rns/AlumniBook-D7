unit W_Excel_Alumni;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses ExcelXP, DB, IBQuery, X_Base, X_List, W_Base, Classes;

type
  TWEDAlumni = class(TWriteExcelBase)
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

procedure TWEDAlumni.PrepareList;
begin
  PrepareListAlumni(FRL);
end;

procedure TWEDAlumni.DoHeader(GroupStr: String);
begin
  ExR := SetExR ('A','D',Row,Row);
  ExR.MergeCells := True;
  ExR.Value2 := FGroupStr;
  With ExR.Font do begin Size:=14; Bold:=1; end;
  Inc (Row);
end;

procedure TWEDAlumni.DoFooter(GroupStr: String);
begin
  Inc (Row);
end;

procedure TWEDAlumni.DoSingle(Query: TIBQuery; Item: TExportItem;
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
  OpenSheet('F');

  StartRow:=4; Row:=StartRow;

  while not FQuery.EOF do
  begin // scan the database table
    BandHeader;

    AID := FQuery.Fieldbyname('AID').AsInteger;
    SDRow := Row; // Start Detail

    SetExR('A', Row).Value2 := FQuery.RecNo;

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
    AutoFormat ('B', 'E', SDRow, Row-1, False);   // per alumni

    // Organization
    MakeSQL(qrChild1, 5, AID);
    qrChild1.Open;
    while not qrChild1.EOF do
    begin
      Inc (Row);
      SDRow := Row; // Start Detail
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
      AutoFormat ('C', 'F', SDRow, Row-1, False);   // per organization

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
