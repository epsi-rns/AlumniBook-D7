unit W_HTML_Alumni;

interface

uses DB, IBQuery, X_List, W_Base, Classes;

type
  TWHDAlumni = class(TWriteHTMLBase)
  private
    { Private declarations }
  protected
    { Protected declarations }
    procedure PrepareList; override;
    procedure DoHeader(GroupStr: String); override;
    procedure DoFooter(GroupStr: String); override;
  public
    { Public declarations }
    procedure DoSingle(Query: TIBQuery; Item: TExportItem); override;
  end;

implementation

uses SysUtils, X_Alumni_Report;

{ TEHDAlumni }

procedure TWHDAlumni.PrepareList;
begin
  PrepareListAlumni(FRL);
end;

procedure TWHDAlumni.DoHeader(GroupStr: String);
begin
  Lines.Append('<h2>'+FGroupStr+'</h2>');
end;

procedure TWHDAlumni.DoFooter(GroupStr: String);
begin
  Lines.Append('');
end;

procedure TWHDAlumni.DoSingle(Query: TIBQuery; Item: TExportItem);
Var
  qrChild1, qrChild2: TIBQuery;
  AID, OID, MID: Integer;
  S: String;
begin
  inherited;

  qrChild1 := TIBQuery.Create(nil);
  qrChild1.Transaction := FQuery.Transaction;
  qrChild1.Database := FQuery.Database;

  qrChild2 := TIBQuery.Create(nil);
  qrChild2.Transaction := FQuery.Transaction;
  qrChild2.Database := FQuery.Database;

  try    // use the string list
    while not FQuery.EOF do // scan the database table
    begin
      BandHeader;

      AID := FQuery.Fieldbyname('AID').AsInteger;

      makeSQL(qrChild1, 9, AID);
      qrChild1.Open;
      Lines.Append('<h3>'+qrChild1.FieldByName('FullName').AsString+'</h3>');
      qrChild1.Close;

      Lines.Append('<table class="master">');
      DoQReport(qrChild1,  0, AID, True,
      '"Text, Community, head"; "Field, Community, , 2"');
      DoQReport(qrChild1,  1, AID, True,
      '"Text, Certification, head"; "Field, Certification"; "Field, Institution"');
      DoQReport(qrChild1,  2, AID, True,
      '"Text, Competency, head"; "Field, Competency"; "Field, Description"');
      DoQReport(qrChild1,  14, AID, True,
      '"Text, Experience, head"; "Field, Organization"');
      DoQReport(qrChild1,  3, AID, True,
      '"Text, Home, head, 1, 2"; "Field, Address, , 2"; "Field, Region, , 2, cr"');
      DoQReport(qrChild1, 10, AID, True,
      '"Field, ContactType, head"; "Field, Contacts, , 2"');

      // Organization
      MakeSQL(qrChild1, 5, AID);
      qrChild1.Open;
      while not qrChild1.EOF do
      begin
        OID := qrChild1.Fieldbyname('OID').AsInteger;
        MID := qrChild1.Fieldbyname('MID').AsInteger;
        Lines.Append('  <tr><td></td>');
        Lines.Append('    <td colspan="2">');

        Lines.Append('<h4>'+qrChild1.FieldByName('Organization').AsString+'</h4>');
        S := qrChild1.FieldByName('JobType').AsString;
        If S<>'' then Lines.Append('Occupancy: '+S+'<br/>');
        S := qrChild1.FieldByName('JobPosition').AsString;
        If S<>'' then Lines.Append('Job Position: '+S+'<br/>');
        S := qrChild1.FieldByName('Description').AsString;
        If S<>'' then Lines.Append('Description: '+S+'<br/>');
        S := qrChild1.FieldByName('Department').AsString;
        If S<>'' then Lines.Append('Department: '+S+'<br/>');

        Lines.Append('      <table class="detail">');
        // Do Child
        DoQReport(qrChild2,  6, OID, True,
        '"Text, Bidang~Usaha, head, 1"; "Field, Field, , 2"');
        DoQReport(qrChild2, 7, OID, True,
        '"Text, Office, head, 1, 2"; "Field, Address, , 2"; "Field, Region, , 2, cr"');
        DoQReport(qrChild2, 11, OID, True,
        '"Field, ContactType, head"; "Field, Contacts, , 2"');
        Lines.Append('        <tr><td colspan="3"><hr></td></tr>');
        DoQReport(qrChild2, 13, MID, True,
        '"Text, Office, head, 1, 2"; "Field, Address, , 2"; "Field, Region, , 2, cr"');
        DoQReport(qrChild2, 12, MID, True,
        '"Field, ContactType, head"; "Field, Contacts, , 2"');

        Lines.Append('        <tr><td><div id="namewidth"></div></td>');
        Lines.Append('          <td colspan="2"><div id="dvalwidth"></div></td></tr>');
        Lines.Append('      </table>');

        Lines.Append('  </td></tr>');
      qrChild1.Next;
      end;

      Lines.Append('<tr><td><div id="namewidth"></div></td>');
      Lines.Append('    <td colspan="2"><div id="mvalwidth"></div></td></tr>');
      Lines.Append('</table>');

      FQuery.Next;
    end;
  finally
    // clean up, destroy the list object
    qrChild1.Free;
    qrChild2.Free;
  end;

end;

{
  procedure Dummy
  begin
    Add('<#Band DataSet=qrAlumni>');
    Add('  <#Group Field=Community>');
    Add(#13+'<h2><#Field=Community></h2>');
    Add('  </Group>');
    Add('<table class="master">');
    Add('<tr><td colspan="2"><h3><#Field=Name></h3></td></tr>');

    Add('  <#Band DataSet=qrAHomes>');
    Add('<tr>');
    Add('  <td class="head" rowspan="2" vAlign="top">Address</td>');
    Add('  <td><#Field=Address></td>');
    Add('</tr><tr>');
    Add('  <td><#Field=Region></td>');
    Add('</tr>');
    Add('  </Band>');

    Add('  <#Band DataSet=qrAContacts>');
    Add('<tr>');
    Add('  <td class="head"><#Field=ContactType></td>');
    Add('  <td><#Field=Contacts></td>');
    Add('</tr>');
    Add('  </Band>');

    Add('  <#Band DataSet=qrAMap>');
    Add('<tr>');
    Add('  <td class="head" rowspan="2" vAlign="top">Office</td>');
    Add('  <td><#Field=Organization></td>');
    Add('</tr><tr>');
    Add('  <td><ul><li><#Field=Organization></li></ul></td>');
    Add('</tr>');
    Add('  </Band>');

    Add('</table>');
    Add('<br>');

    Add('  <#Group Field=Community>');
    Add('<hr>');
    Add('  </Group>');
    Add('</Band>');
  end;
}

end.
