unit DateFltr;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls, Buttons, ComCtrls, Spin;

Type
  TDateFilter = class(TForm)
    OkBtn: TBitBtn;
    CancelBtn: TBitBtn;
    GroupBox: TGroupBox;
    Label1: TLabel;
    FromDate: TDateTimePicker;
    Label2: TLabel;
    ToDate: TDateTimePicker;
    GroupBox2: TGroupBox;
    PeriodBox: TComboBox;
    Label3: TLabel;
    Label4: TLabel;
    SpinDay: TSpinEdit;
    Label5: TLabel;
    WithinBox: TComboBox;
    Label6: TLabel;
    Label7: TLabel;
    SpinWeekYear: TSpinEdit;
    Label8: TLabel;
    Label9: TLabel;
    SpinWeekMonth: TSpinEdit;
    Label10: TLabel;
    SpinYear: TSpinEdit;
    procedure FormCreate(Sender: TObject);
    procedure PeriodBoxSelect(Sender: TObject);
    procedure SpinDayChange(Sender: TObject);
    procedure WithinBoxSelect(Sender: TObject);
    procedure SpinWeekYearChange(Sender: TObject);
    procedure SpinWeekMonthChange(Sender: TObject);
    procedure DateCloseUp(Sender: TObject);
  private
    Year, Month, Day: Word;
  end;

Type
  TDateRange = class
  private
    function GetFromDate: String;
    function GetToDate: String;
  public
    FromDate, ToDate: TDate;
    FromChecked, ToChecked: Boolean;
    procedure Update(NewFromDate, NewToDate: TDateTimePicker);
    procedure Copy(DateRange :TDateRange);
    function FilterStr(S: String; AddClause: Boolean = True): String;
    function ReportStr: String;    
    Property FromStr: String read GetFromDate;
    Property ToStr: String read GetToDate;
  end;

var
  DateFilter: TDateFilter;

implementation

{$R *.dfm}

uses DateUtils, dmMain;

{ TDateRange }

procedure TDateRange.Update(NewFromDate, NewToDate: TDateTimePicker);
begin
  FromDate := NewFromDate.Date;
  ToDate   := NewToDate.Date;
  FromChecked := NewFromDate.Checked;
  ToChecked   := NewToDate.Checked;
end;

procedure TDateRange.Copy(DateRange: TDateRange);
begin
  FromDate := DateRange.FromDate;
  ToDate   := DateRange.ToDate;
  FromChecked := DateRange.FromChecked;
  ToChecked   := DateRange.ToChecked;
end;

function TDateRange.GetFromDate: String;
begin
  If FromChecked
    then Result := FmtDate(FromDate)
    else Result := 'NULL';
end;

function TDateRange.GetToDate: String;
begin
  If ToChecked
    then Result := FmtDate(ToDate)
    else Result := 'NULL';
end;

function TDateRange.FilterStr(S: String; AddClause: Boolean): String;
Var D1, D2: String;
begin
  If FromChecked then D1 := Format('(%s >= %s)', [S, FmtDate(FromDate)]);
  If ToChecked then   D2 := Format('(%s <= %s)', [S, FmtDate(ToDate)]);
  Result := AndStr(D1, D2, AddClause);
end;

function TDateRange.ReportStr: String;
Var D1, D2: String;
begin
  D1 := DateToStr(FromDate);
  D2 := DateToStr(ToDate);

  Case Ord(FromChecked) + 2*ord(ToChecked) of
    0: Result := 'All period.';
    1: Result := 'Dated from '+D1+'.';
    2: Result := 'Dated to '+D2+'.';
    3: Result := 'Dated from '+D1+' through '+D2+'.';
  end;
  Result:='Period: '+Result;
end;

{ TDateFilter }

procedure TDateFilter.FormCreate(Sender: TObject);
begin
  GroupBox.Caption := 'Transaction Date ranging:';

  DecodeDate(Date, Year, Month, Day);

  // Initialize Criteria
  WithinBox.ItemIndex := 1;
  PeriodBox.ItemIndex  := Month ;
  SpinYear.Value := Year;
  SpinWeekYear.Value := WeekOfTheYear(Date);
  SpinWeekMonth.Value := WeekOfTheMonth(Date);

  // Default Selection
  FromDate.Date := StartOfAMonth(Year, Month);
  ToDate.Date := EndOfAMonth(Year, Month);
end;

procedure TDateFilter.DateCloseUp(Sender: TObject);
begin
  if (ToDate.Date <> 0) and (ToDate.Date < FromDate.Date) then
  begin
    FromDate.Date := Date;
    ToDate.Date := Date;
    ShowMessage('"TO" date cannot be less than "FROM" date');
  end;
end;

procedure TDateFilter.WithinBoxSelect(Sender: TObject);
begin
  Case WithinBox.ItemIndex of
    0: FromDate.Date := Date;
    1: FromDate.Date := StartOfTheWeek(Date);
    2: FromDate.Date := StartOfAMonth(Year, Month);
    3: FromDate.Date := StartOfAYear(Year);
    4: FromDate.Date := Yesterday;
    5: FromDate.Date := StartOfTheWeek(Date - 7);
    6: FromDate.Date := StartOfTheMonth(IncMonth( Date, -1));
    7: FromDate.Date := StartOfAYear(Year - 1);
  end;

  Case WithinBox.ItemIndex of
    0: ToDate.Date := Date;
    1: ToDate.Date := StartOfTheWeek(Date + 7);
    2: ToDate.Date := EndOfAMonth(Year, Month);
    3: ToDate.Date := EndOfAYear(Year);
    4: ToDate.Date := Yesterday;
    5: ToDate.Date := StartOfTheWeek(Date);
    6: ToDate.Date := EndOfTheMonth(IncMonth( Date, -1));
    7: ToDate.Date := EndOfAYear(Year - 1);
  end;
end;

procedure TDateFilter.SpinDayChange(Sender: TObject);
begin
  FromDate.Date := Date - SpinDay.Value;
  ToDate.Date := Date;
end;

procedure TDateFilter.PeriodBoxSelect(Sender: TObject);
Const
 StartOf: Array[0..16] of integer = (1,  1,2,3,4,5,6,7,8,9,10,11,12, 1,4,7,10);
 EndOf:   Array[0..16] of integer = (12, 1,2,3,4,5,6,7,8,9,10,11,12, 3,6,9,12);

begin
  FromDate.Date := StartOfAMonth(SpinYear.Value, StartOf[PeriodBox.ItemIndex]);
  ToDate.Date   := EndOfAMonth  (SpinYear.Value, EndOf  [PeriodBox.ItemIndex]);

  SpinWeekYear.MaxValue := WeeksInYear(FromDate.Date);
  SpinWeekMonth.Enabled := (PeriodBox.ItemIndex in [1..12]);
  if SpinWeekMonth.Enabled then
    SpinWeekMonth.MaxValue := WeeksBetween(FromDate.Date, ToDate.Date);
end;

procedure TDateFilter.SpinWeekYearChange(Sender: TObject);
begin
  FromDate.Date := StartOfAWeek(SpinYear.Value, SpinWeekYear.Value);
  ToDate.Date := FromDate.Date + 7;
end;

procedure TDateFilter.SpinWeekMonthChange(Sender: TObject);
begin
  FromDate.Date := EncodeDateMonthWeek
    (SpinYear.Value, PeriodBox.ItemIndex, SpinWeekMonth.Value, 1);
  ToDate.Date := FromDate.Date + 7;
end;

end.
