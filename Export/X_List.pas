unit X_List;

interface

uses classes;

Type
  TExportItem = class  // TStrings wrapper
  private
    { Private-Deklarationen }
  protected
    { Protected-Deklarationen }
  public
    { Public-Deklarationen }
    ID: Integer;
    Headers, FmtID, SQL: TStrings;
    Name, IDName, GroupField : String;
    constructor create(NewSQL: TStrings;
      NewHeaders, NewName, NewIDName, NewGroupField: String); overload;
    constructor create(NewSQL: TStrings;
      NewHeaders, NewFmtID, NewName,
      NewIDName, NewGroupField: String); overload;
    destructor destroy; override;
  end;

  TExportList = class(TList)
    procedure AddQuery(SQL: TStrings;
      Headers, FmtID, Name, IDName, GroupField: String); overload;
    procedure AddQuery(Item: TExportItem;
      ID: Integer = -1; FmtID: String = ''); overload;
    destructor destroy; override;
  end;

  TReportItem = class  // TStrings wrapper
  private
    FSQL: TStrings;
  public
    SQL: TStrings;
    WhereClause: String;
    AddSimpleWhereClause: Boolean;
    constructor create;
    destructor destroy; override;
    function Make(ID: Integer): TStrings;
  end;

implementation

uses sysutils;

{ TExportData }

constructor TExportItem.create(NewSQL: TStrings; NewHeaders, NewName,
  NewIDName, NewGroupField: String);
begin
  SQL     := TStringList.Create;
  SQL.AddStrings(NewSQL);
  Headers := TStringList.Create;
  Headers.CommaText := NewHeaders;
  Name    := NewName;
  IDName  := NewIDName;
  GroupField := NewGroupField;
end;

constructor TExportItem.create(NewSQL: TStrings;
  NewHeaders, NewFmtID, NewName, NewIDName, NewGroupField: String);
begin
  Create(NewSQL, NewHeaders, NewName, NewIDName, NewGroupField);
  FmtID := TStringList.Create;
  FmtID.CommaText := NewFmtID;
end;

destructor TExportItem.destroy;
begin
  SQL.Free;
  Headers.Free;
  FmtID.Free;
end;

{ TExportList }

procedure TExportList.AddQuery(SQL: TStrings;
  Headers, FmtID, Name, IDName, GroupField: String);
var Item: TExportItem;
begin
  Item := TExportItem.create(SQL, Headers, FmtID, Name, IDName, GroupField);
  Add(Item);
end;

procedure TExportList.AddQuery(Item: TExportItem;
  ID: Integer = -1; FmtID: String = '');
begin
  Item.ID := ID;
  Item.FmtID := TStringList.Create;
  Item.FmtID.CommaText := FmtID;
  Add(Item);
end;

destructor TExportList.destroy;
var
  I: Integer;
  Item: TExportItem;
begin
  for I:=Count - 1 downto 0 do
  begin
    Item := Items[I];
    Item.Free;
  end;
end;

{ TReportItem }

constructor TReportItem.create;
begin
  SQL := TStringList.Create;
  FSQL := TStringList.Create;
  AddSimpleWhereClause := True;
end;

destructor TReportItem.destroy;
begin
  SQL.Free;
  FSQL.Free;
  inherited;
end;

function TReportItem.Make(ID: Integer): TStrings;
var WC : String;
begin
  If AddSimpleWhereClause then
  begin
    If SQL.Count>0 then
      WC := Format ('WHERE '+WhereClause, [ID])
    else // special query with stored procedure
      WC := Format (WhereClause, [ID]);

    If FSQL.Count = 0 then
    begin  // First Time Called
      FSQL.AddStrings(SQL);
      FSQL.Append(WC);
    end
    else   // Next time, change the last string
      FSQL[FSQL.Count-1] := WC;

    Result := FSQL;
  end
  else Result := SQL;
end;

end.
