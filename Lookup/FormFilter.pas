unit FormFilter;
// not reverted yet

interface

uses
  Classes, Controls, Forms, SysUtils, StdCtrls, Buttons,
  SQLStatement;

type
  TfrmFilter = class(TForm)
    OkBtn: TBitBtn;
    FLabel1: TLabel;
    FieldBox1: TComboBox;
    FieldBox2: TComboBox;
    FilterBox2: TComboBox;
    FilterBox1: TComboBox;
    Field1: TEdit;
    Field2: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FClause: TStrings;
    procedure SetColumns(const Value: TStrings);
    function GetClause: TStrings;
  public
    { Public declarations }
    SQLStat: TSQLStat;
    property Clause: TStrings read GetClause;
    property Columns: TStrings write SetColumns;
  end;

var
  frmFilter: TfrmFilter;

implementation

{$R *.dfm}

Const
  FieldClause: array[0..12] of string = ('IS NULL', 'IS NOT NULL',
  'LIKE', 'NOT LIKE', 'CONTAINING', 'NOT CONTAINING',
  'STARTING WITH', 'NOT STARTING WITH', '=', '>', '<', '>=', '<=');

procedure TfrmFilter.FormCreate(Sender: TObject);
begin
  FClause := TStringList.Create;
end;

procedure TfrmFilter.FormDestroy(Sender: TObject);
begin
  FClause.Free;
end;

function TfrmFilter.GetClause: TStrings;
Var S1, S2, Str: String;
begin  // Set Filters Routine
  FClause.Clear;

  // Field
  If (FieldBox1.ItemIndex > -1) and (FilterBox1.ItemIndex > -1) then
  begin
    S1 := FieldBox1.Items[FieldBox1.ItemIndex];
    S1 := SQLStat.ParseTitleToField(S1);
    S2 := FieldClause[FilterBox1.ItemIndex];
    case FilterBox1.ItemIndex of
    0..1: Str := Format('%s %s', [S1, S2]);
    2..12: Str := Format('%s %s ''%s''', [S1, S2, Field1.Text]);
    end;
    FClause.Append(Str);
  end;

  If (FieldBox2.ItemIndex > -1) and (FilterBox2.ItemIndex > -1) then
  begin
    S1 := FieldBox2.Items[FieldBox2.ItemIndex];
    S1 := SQLStat.ParseTitleToField(S1);    
    S2 := FieldClause[FilterBox2.ItemIndex];
    case FilterBox2.ItemIndex of
    0..1: Str := Format('%s %s', [S1, S2]);
    2..12: Str := Format('%s %s ''%s''', [S1, S2, Field2.Text]);
    end;
    FClause.Append(Str);
  end;

  Result:=FClause;
end;

procedure TfrmFilter.SetColumns(const Value: TStrings);
begin
  FieldBox1.Items.Clear;
  FieldBox1.Text := '';
  FieldBox1.Items.AddStrings(Value);

  FieldBox2.Items.Clear;
  FieldBox2.Text := '';  
  FieldBox2.Items.AddStrings(Value);

  // Clear, keep values
  FilterBox1.ItemIndex := -1;
  FilterBox2.ItemIndex := -1;
end;

end.
