unit W_Text_Organization;

interface

uses DB, IBQuery, X_Base, X_List, W_Base, Classes;

type
  TWTDOrganization = class(TWriteTextBase)
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
      Sheet: Variant); override;
  end;

implementation

uses SysUtils, ActiveX, Variants, X_Alumni_Report;

{ TWTDOrganization }

procedure TWTDOrganization.DoFooter(GroupStr: String);
begin
//
end;

procedure TWTDOrganization.DoHeader(GroupStr: String);
begin
  TextCursor.ParaStyleName := 'Heading 2';
  TextDoc.insertString( TextCursor, FGroupStr+#13, false );
  TextCursor.ParaStyleName := 'Standard';
end;

procedure TWTDOrganization.DoSingle(Query: TIBQuery; Item: TExportItem;
  Sheet: Variant);
Var
  qrChild1, qrChild2: TIBQuery;
  OID: Integer;
begin
  inherited;
  qrChild1 := TIBQuery.Create(nil);
  qrChild1.Transaction := FQuery.Transaction;
  qrChild1.Database := FQuery.Database;

  qrChild2 := TIBQuery.Create(nil);
  qrChild2.Transaction := FQuery.Transaction;
  qrChild2.Database := FQuery.Database;

  NewDoc;

  while not FQuery.EOF do
  begin // scan the database table
    BandHeader;

    OID := FQuery.Fieldbyname('OID').AsInteger;
    DoReport(FQuery, False, '"<#Organization>\n";"H3"');
    DoReport(nil, False, '"";"Normal"'); // insert space, set to normal
    DoQReport(qrChild1,  0, OID, True, '"Bidang Usaha\t<#Field>\t\n"');
    DoQReport(qrChild1,  1, OID, True, '"Office\t<#Address>\t<#Region>\n"');
    DoQReport(qrChild1,  7, OID, True, '"<#ContactType>\t<#Contacts>\t\n"');
    DoQReport(qrChild1,  3, OID, True, '"<#Name>\t<#Department>\t<#Description>\n\t<#JobType>\t<#JobPosition>\n"');
    TextDoc.insertControlCharacter( TextCursor, 0, false );

    FQuery.Next;
    BandFooter; // After Next !!
  end;

  TextDoc.insertControlCharacter( TextCursor, 0, false );

  qrChild1.Free;
  qrChild2.Free;
end;

procedure TWTDOrganization.PrepareList;
begin
  PrepareListOrganization(FRL);
end;

end.
