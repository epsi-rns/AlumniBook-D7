unit W_Word_Organization;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses WordXP, DB, IBQuery, X_Base, X_List, W_Base, Classes;

type
  TWWDOrganization = class(TWriteWordBase)
  private
    { Private declarations }
  protected
    { Protected declarations }
    procedure PrepareList; override;
    procedure DoHeader(GroupStr: String); override;
  public
    { Public declarations }
    procedure DoSingle(Query: TIBQuery; Item: TExportItem;
    Word: WordDocument); override;
  end;

implementation

uses SysUtils, ActiveX, Variants, X_Alumni_Report;

{ TWWDOrganization }

procedure TWWDOrganization.PrepareList;
begin
  PrepareListOrganization(FRL);
end;

procedure TWWDOrganization.DoHeader(GroupStr: String);
var ov: OleVariant;
begin
  With WordDoc.Paragraphs.Last.Range do begin
    Text := FGroupStr + #13;
    ov:=wdStyleHeading2;
    Set_Style(ov);
  end;
end;

procedure TWWDOrganization.DoSingle(Query: TIBQuery; Item: TExportItem;
  Word: WordDocument);

Var
  qrChild1, qrChild2: TIBQuery;
  OID: Integer;
  ovStart: OleVariant;
  SubCount, TableCount : Integer;
begin
  inherited;
  qrChild1 := TIBQuery.Create(nil);
  qrChild1.Transaction := FQuery.Transaction;
  qrChild1.Database := FQuery.Database;

  qrChild2 := TIBQuery.Create(nil);
  qrChild2.Transaction := FQuery.Transaction;
  qrChild2.Database := FQuery.Database;

  NewDoc;
  TableCount:=0;
  SubCount:=0;
  AFmt := 35;

  while not FQuery.EOF do
  begin // scan the database table
    BandHeader;

    OID := FQuery.Fieldbyname('OID').AsInteger;
    DoReport(FQuery, False, '"<#Organization>\n";"H3"');
    DoReport(nil, False, '"";"Normal"'); // insert space, set to normal
    ovStart := DocEnd_; // Start of Detail Formatting
    DoQReport(qrChild1,  0, OID, True, '"Bidang Usaha\t<#Field>\t\n"');
    DoQReport(qrChild1,  1, OID, True, '"Office\t<#Address>\t<#Region>\n"');
    DoQReport(qrChild1,  7, OID, True, '"<#ContactType>\t<#Contacts>\t\n"');
    DoQReport(qrChild1,  3, OID, True, '"<#Name>\t<#Department>\t<#Description>\n\t<#JobType>\t<#JobPosition>\n"');

    ConvertToTable // Formatting Table, For Each Row
      (ovStart, DocEnd_, TableCount, SubCount, 3);

    FQuery.Next;
  end;

  qrChild1.Free;
  qrChild2.Free;
end;


end.

