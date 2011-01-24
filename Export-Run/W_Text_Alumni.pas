unit W_Text_Alumni;

interface

uses DB, IBQuery, X_Base, X_List, W_Base, Classes;

type
  TWTDAlumni = class(TWriteTextBase)
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

{ TWTDAlumni }

procedure TWTDAlumni.DoFooter(GroupStr: String);
begin
//
end;

procedure TWTDAlumni.DoHeader(GroupStr: String);
begin
  TextCursor.ParaStyleName := 'Heading 2';
  TextDoc.insertString( TextCursor, FGroupStr+#13, false );
  TextCursor.ParaStyleName := 'Standard';
end;

procedure TWTDAlumni.DoSingle(Query: TIBQuery; Item: TExportItem;
  Sheet: Variant);
Var
  qrChild1, qrChild2: TIBQuery;
  AID: Integer;
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

    AID := FQuery.Fieldbyname('AID').AsInteger;
    DoQReport(qrChild1, 9, AID, False, '"<#FullName>\n";"H3"');
    DoReport(nil, False, '"";"Normal"'); // insert space, set to normal
     DoQReport(qrChild1,  0, AID, True, '"Community\t<#Community>\t\n"');
    DoQReport(qrChild1,  1, AID, True, '"Certification\t<#Certification>\t<#Institution>\n"');
    DoQReport(qrChild1,  2, AID, True, '"Competency\t<#Competency>\t<#Description>\n"');
    DoQReport(qrChild1,  3, AID, True, '"Home\t<#Address>\t<#Region>\n"');
    DoQReport(qrChild1, 10, AID, True, '"<#ContactType>\t<#Contacts>\t\n"');
    DoQReport(qrChild1,  5, AID, True, '"<#Organization>\t<#Department>\t<#Description>\n\t<#JobType>\t<#JobPosition>\n"');
    TextDoc.insertControlCharacter( TextCursor, 0, false );

    FQuery.Next;
    BandFooter; // After Next !!
  end;

  TextDoc.insertControlCharacter( TextCursor, 0, false );

  qrChild1.Free;
  qrChild2.Free;
end;

procedure TWTDAlumni.PrepareList;
begin
  PrepareListAlumni(FRL);
end;

end.
