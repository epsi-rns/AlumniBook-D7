unit SQLStatement;

// all in just one init query

interface

uses Classes;

type
  TSQLStat = class
  private
    FIDName: String;
    FGroupBy: String;
    FGroupView: TStrings;
    FOrderBy, FSortBy, FOrderPairs: TStrings;
    FFieldNames: TStrings;
    FTitleNames: TStrings;
    // watchout
    FDSI: Integer;
    procedure SetIDName(const Value: String);
    procedure SetGroupBy(const Value: String);
    procedure SetAnyFormat(const Value: String);
    procedure SetFieldNames(const Value: String);
    procedure SetDSI(const Value: Integer);
    procedure SetOrders(const Value: String);
    function GetTitleNames: TStrings;
    function GetDSI: Integer;
    function GetIDName: String;
    function GetFieldNames: String;
    function GetGroupBy: String;
    function GetOrders: String;
    function GetSortBy: TStrings;
    function GetGroupView: String;
    procedure SetGroupView(const Value: String);
    function GetGroupingView: TStrings;
  protected
    function WhereClause: String;
    function OrderClause: String;
  public
    QuerySQL, Filters, Ordering: TStrings;
    FAnyFormat: TStrings;
    constructor Create; virtual;
    destructor Destroy; override;
    procedure Reset;
    function GetFieldPairs: TStrings;
    function IsCurrencyFormat(FieldName: String): Boolean;
//  function GetOrdersVal(S: String):string;
    function MakeSQL: TStrings;
    function ParseTitleToField(Name: String):String;
    function GetFormatsByHeaders(Headers: String):String;
    property TitleNames: TStrings read GetTitleNames;
    property SortBy: TStrings read GetSortBy;  // GUI related
    property GroupingView: TStrings read GetGroupingView;  // GUI related
  published
    property IDName: String read GetIDName write SetIDName;
    property GroupBy: String read GetGroupBy write SetGroupBy;
    property AllowedGroupingView: String read GetGroupView write SetGroupView;
    property AnyFmt: String write SetAnyFormat;
    property FieldNames: String read GetFieldNames write SetFieldNames;
    property Orders: String read GetOrders write SetOrders;
    property DefaultSortIndex: Integer read GetDSI write SetDSI;
  end;

procedure ExtractNames(Strings: TStrings; Var Names: TStrings);
procedure ExtractValues(Strings: TStrings; Var Values: TStrings);
procedure ExtractLazyValues(Strings: TStrings; Var Values: TStrings);

implementation

procedure ExtractNames(Strings: TStrings; var Names: TStrings);
Var
  I: Integer;
  N: String;
begin  // Extract names whether name-value pair or just a string
  Names.Clear;
  For I := 0 to Strings.Count-1 do
  begin
    N := Strings.Names[I];
    If N='' then N := Strings[I];
    Names.Append(N);
  end;
end;

procedure ExtractValues(Strings: TStrings; var Values: TStrings);
Var
  I: Integer;
  N, V: String;
begin    // has not been tested, see code below
  Values.Clear;
  For I := 0 to Strings.Count-1 do
  begin
    N := Strings.Names[I];
    If N='' then V := '' // is not pair
    else V := Strings.ValueFromIndex[I];
    Values.Append(V);
  end;
end;

procedure ExtractLazyValues(Strings: TStrings; var Values: TStrings);
Var
  I: Integer;
  N, V: String;
begin
  // Rule when I too lazy to write.
  // 1. When empty (not pair), Value is same as name
  // 2. When ended with dot, Value is 'value.name'
  Values.Clear;
  For I := 0 to Strings.Count-1 do
  begin
    N := Strings.Names[I];
    If N='' then V := Strings[I]         // is not pair
    else begin
      V := Strings.ValueFromIndex[I];
      if V[Length(V)]='.' then V := V + N;
    end;
    Values.Append(V)
  end;
end;


{ TSQLStat }

constructor TSQLStat.Create;
begin
  QuerySQL    := TStringList.Create;

  Filters     := TStringList.Create;
  Ordering    := TStringList.Create;

  FOrderBy    := TStringList.Create;
  FSortBy     := TStringList.Create;
  FOrderPairs := TStringList.Create;
  FFieldNames := TStringList.Create;
  FTitleNames := TStringList.Create;
  FGroupView  := TStringList.Create;
  FAnyFormat  := TStringList.Create;
end;

destructor TSQLStat.Destroy;
begin
  // Clean up
  FOrderBy.Free;
  FSortBy.Free;
  FOrderPairs.Free;

  FFieldNames.Free;
  FTitleNames.Free;
  FAnyFormat.Free;
  FGroupView.Free;

  Filters.Free;
  Ordering.Free;

  QuerySQL.Free;

  inherited destroy;
end;

procedure TSQLStat.Reset;
begin
  QuerySQL.Clear;
  Filters.Clear;
  Ordering.Clear;

  // Published Properties
  IDName:='';
  GroupBy := '';
  AllowedGroupingView := '';
  AnyFmt := '';
  FieldNames := '';
  Orders  := '';
  DefaultSortIndex := -1;
end;

function TSQLStat.GetDSI: Integer;
begin
  Result := FDSI;
end;

function TSQLStat.GetFieldNames: String;
begin
  Result := FFieldNames.CommaText;
end;

function TSQLStat.GetFieldPairs: TStrings;
begin
  Result:= FFieldNames;
end;

function TSQLStat.GetGroupBy: String;
begin
  Result := FGroupBy;
end;

function TSQLStat.GetGroupingView: TStrings;
begin
  Result := FGroupView;
end;

function TSQLStat.GetGroupView: String;
begin
  Result := FGroupView.CommaText;
end;

function TSQLStat.GetIDName: String;
begin
  Result := FIDName;
end;

function TSQLStat.GetOrders: String;
begin
  Result := FOrderPairs.CommaText;
end;

{function TSQLStat.GetOrdersVal(S: String): string;
begin
  Result := FOrderBy[FSortBy.IndexOf(S)];
end;}

function TSQLStat.GetSortBy: TStrings;
begin
  Result := FSortBy;
end;

function TSQLStat.GetTitleNames: TStrings;
begin
  ExtractNames(FFieldNames, FTitleNames);
  Result := FTitleNames;
end;

function TSQLStat.IsCurrencyFormat(FieldName: String): Boolean;
begin
  Result := FAnyFormat.Values[FieldName] ='Rp';
end;

function TSQLStat.MakeSQL: TStrings;
begin
  Result := TStringList.Create;

  With Result do
  begin
    AddStrings(QuerySQL);

    If (Filters.Count > 0) then
      Append('WHERE '+WhereClause);

    If (FGroupBy<>'') then
      Append(FGroupBy);

    If (Ordering.Count>0) then
      Append('ORDER BY '+OrderClause);
  end;
end;

function TSQLStat.ParseTitleToField(Name: String):String;
var PI: Integer;
begin // Using Pair Index (PI) of FSortBy:FOrderBy
  PI := FSortBy.IndexOf(Name);
  Result := FOrderBy[PI]
end;

function TSQLStat.OrderClause: String;
var I: Integer;
begin
  Result := '';

  // Using Pair Index (PI) of FSortBy:FOrderBy
  for I := 0 to Ordering.Count - 1  do
  begin
    If I > 0 Then Result := Result + ', ';
    Result := Result + ParseTitleToField( Ordering.Names[I] )
              + ' '  + Ordering.ValueFromIndex[I];
  end;
end;

function TSQLStat.WhereClause: String;
var I: Integer;
begin
  // Putting them all together when Filters.Count > 0
  Result := Filters[0];

  If Filters.Count>1 then
    For I:=1 to Filters.Count-1 do
      Result:= Result + ' AND ' + Filters[I];
end;

procedure TSQLStat.SetAnyFormat(const Value: String);
begin
  FAnyFormat.CommaText := Value;   // Field with Currency Format
end;

procedure TSQLStat.SetDSI(const Value: Integer);
begin
  FDSI := Value;
end;

procedure TSQLStat.SetFieldNames(const Value: String);
begin
  FFieldNames.CommaText := Value;   // Pair Title and object ratio
end;

procedure TSQLStat.SetGroupBy(const Value: String);
begin
  FGroupBy := Value;
end;

procedure TSQLStat.SetGroupView(const Value: String);
begin
  FGroupView.CommaText := Value;
end;

procedure TSQLStat.SetIDName(const Value: String);
begin
  FIDName:=Value;
end;

procedure TSQLStat.SetOrders(const Value: String);
begin // SQL Order Clause's Choices
  FOrderPairs.CommaText := Value;
  ExtractNames(FOrderPairs, FSortBy);
  ExtractLazyValues(FOrderPairs, FOrderBy);
end;

function TSQLStat.GetFormatsByHeaders(Headers: String): String;
var
  I: Integer;
  Hdr, Fmt: TStrings;
begin
  Hdr := TStringList.Create;
  Fmt := TStringList.Create;

  Hdr.CommaText := Headers;
  For I:=0 to Hdr.Count-1 do
    Fmt.Add( FAnyFormat.Values[ Hdr[I] ] );
  Result := Fmt.CommaText;

  Hdr.Free;
  Fmt.Free;
end;

end.
