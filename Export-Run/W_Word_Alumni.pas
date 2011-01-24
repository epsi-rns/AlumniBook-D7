unit W_Word_Alumni;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses WordXP, DB, IBQuery, X_Base, X_List, W_Base, Classes;

type
  TWWDAlumni = class(TWriteWordBase)
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

{ TWWDAlumni }

procedure TWWDAlumni.PrepareList;
begin
  PrepareListAlumni(FRL);
end;

procedure TWWDAlumni.DoHeader(GroupStr: String);
var ov: OleVariant;
begin
  With WordDoc.Paragraphs.Last.Range do begin
    Text := FGroupStr + #13;
    ov:=wdStyleHeading2;
    Set_Style(ov);
  end;
end;

procedure TWWDAlumni.DoSingle(Query: TIBQuery; Item: TExportItem;
  Word: WordDocument);
Var
  qrChild1, qrChild2: TIBQuery;
  AID: Integer;
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

    AID := FQuery.Fieldbyname('AID').AsInteger;
    DoQReport(qrChild1, 9, AID, False, '"<#FullName>\n";"H3"');
    DoReport(nil, False, '"";"Normal"'); // insert space, set to normal
    ovStart := DocEnd_; // Start of Detail Formatting
    DoQReport(qrChild1,  0, AID, True, '"Community\t<#Community>\t\n"');
    DoQReport(qrChild1,  1, AID, True, '"Certification\t<#Certification>\t<#Institution>\n"');
    DoQReport(qrChild1,  2, AID, True, '"Competency\t<#Competency>\t<#Description>\n"');
    DoQReport(qrChild1,  3, AID, True, '"Home\t<#Address>\t<#Region>\n"');
    DoQReport(qrChild1, 10, AID, True, '"<#ContactType>\t<#Contacts>\t\n"');
    DoQReport(qrChild1,  5, AID, True, '"<#Organization>\t<#Department>\t<#Description>\n\t<#JobType>\t<#JobPosition>\n"');

    ConvertToTable // Formatting Table, For Each Row
      (ovStart, DocEnd_, TableCount, SubCount, 3);

    FQuery.Next;
  end;

  qrChild1.Free;
  qrChild2.Free;
end;

end.
