program Alumni;

uses
  Forms,
  FormSplash in 'Forms\FormSplash.pas' {Splash},
  dmCommon in 'Modules\dmCommon.pas' {dmC: TDataModule},
  dmMain in 'Modules\dmMain.pas' {Data: TDataModule},
  Main in 'Forms\Main.pas' {AlumniBook},
  DateFltr in 'Forms\DateFltr.pas' {DateFilter},
  frmMonitorU in 'IBXMonitor\frmMonitorU.pas' {frmMonitor},
  frmTraceFlagsU in 'IBXMonitor\frmTraceFlagsU.pas' {frmTraceFlags},
  EntryAlumni in 'Forms\EntryAlumni.pas' {frmEntryAlumni},
  EntryOrganization in 'Forms\EntryOrganization.pas' {frmEntryOrganization},
  EntryMap in 'Forms\EntryMap.pas' {frmEntryMap},
  dmAlumni in 'Modules\dmAlumni.pas' {dmAl: TDataModule},
  dmOrganization in 'Modules\dmOrganization.pas' {dmOr: TDataModule},
  dmMap in 'Modules\dmMap.pas' {dmLink: TDataModule},
  PieLink in 'Graph\PieLink.pas' {frmPieLink},
  FormChartOpt in 'Graph\FormChartOpt.pas' {frmChartOptions},
  FormStatus in 'Report\FormStatus.pas' {frmStatus},
  FormFilter in 'Lookup\FormFilter.pas' {frmFilter},
  FormLookup in 'Lookup\FormLookup.pas' {frmLookup},
  LFormAlumni in 'Lookup-Run\LFormAlumni.pas' {LookupAlumni},
  BFormAlumni in 'Lookup-Run\BFormAlumni.pas' {BrowseAlumni},
  LFormOrganization in 'Lookup-Run\LFormOrganization.pas' {LookupOrganization},
  BFormOrganization in 'Lookup-Run\BFormOrganization.pas' {BrowseOrganization},
  LFormCommunity in 'Lookup-Run\LFormCommunity.pas' {LookupCommunity},
  BFormAny in 'Lookup-Run\BFormAny.pas' {BrowseMisc},
  FormOrdering in 'Lookup\FormOrdering.pas' {frmOrdering},
  FormSortColumn in 'Lookup\FormSortColumn.pas' {frmSortColumn},
  SQLStatement in 'Lookup\SQLStatement.pas',
  X_List in 'Export\X_List.pas',
  X_Base in 'Export\X_Base.pas',
  X_AppBase in 'Export\X_AppBase.pas',
  W_Base in 'Export\W_Base.pas',
  W_Plain in 'Export\W_Plain.pas',
  X_Alumni_Report in 'Export-Run\X_Alumni_Report.pas',
  W_HTML_Alumni in 'Export-Run\W_HTML_Alumni.pas',
  W_HTML_Organization in 'Export-Run\W_HTML_Organization.pas',
  W_Excel_Alumni in 'Export-Run\W_Excel_Alumni.pas',
  W_Excel_Organization in 'Export-Run\W_Excel_Organization.pas',
  W_Word_Alumni in 'Export-Run\W_Word_Alumni.pas',
  W_Word_Organization in 'Export-Run\W_Word_Organization.pas',
  W_Calc_Alumni in 'Export-Run\W_Calc_Alumni.pas',
  W_Calc_Organization in 'Export-Run\W_Calc_Organization.pas',
  W_Text_Alumni in 'Export-Run\W_Text_Alumni.pas',
  W_Text_Organization in 'Export-Run\W_Text_Organization.pas';

{$R *.RES}

begin
// To Do: gimana user tahu kalo dah commit? pakai monitor di from depan.
// last update
// uncheck hasbranch ref integrity
// delete contact dan map kalau organisasi/map dihapus

  Application.Initialize;
//  Application.CreateForm(TForm1, Form1);

// create and show the splash form
  Splash := TSplash.Create (Application);
  With Application do
  try
    Splash.Show;
    Hint := 'Initialization';
    Splash.Update; // Force Form Painting

    Hint := 'Database Module';
    Splash.StepBy; CreateForm(TData, Data);

    Hint := 'Main Form';
    Splash.StepBy; CreateForm(TAlumniBook, AlumniBook);
    Splash.StepBy; CreateForm(TdmC, dmC);

//    Hint := 'Quick Entry';
//    Splash.StepBy; CreateForm(TdmQc, dmQc);
//    Splash.StepBy; CreateForm(TfrmEntryQuick, frmEntryQuick);

    Hint := 'Alumni Entry';
    Splash.StepBy; CreateForm(TdmAl, dmAl);
    Splash.StepBy; CreateForm(TBrowseAlumni, BrowseAlumni);
    Splash.StepBy; CreateForm(TfrmEntryAlumni, frmEntryAlumni);

    Hint := 'Organization Entry';
    Splash.StepBy; CreateForm(TdmOr, dmOr);
    Splash.StepBy; CreateForm(TBrowseOrganization, BrowseOrganization);
    Splash.StepBy; CreateForm(TfrmEntryOrganization, frmEntryOrganization);

    Hint := 'Mapping Entry';
    Splash.StepBy; CreateForm(TdmLink, dmLink);
    Splash.StepBy; CreateForm(TfrmEntryMap, frmEntryMap);

    Hint := 'Lookup Form';
    Splash.StepBy; CreateForm(TBrowseMisc, BrowseMisc);
    Splash.StepBy; CreateForm(TlookupCommunity, lookupCommunity);
    Splash.StepBy; CreateForm(TlookupOrganization, lookupOrganization);
    Splash.StepBy; CreateForm(TlookupAlumni, lookupAlumni);

    Hint := 'Report Module';
    Splash.StepBy; CreateForm(TfrmPieLink, frmPieLink);

    Hint := 'Thread Status';
    Splash.StepBy; CreateForm(TfrmStatus, frmStatus);

    Hint := 'Additional Form';
    Splash.StepBy; CreateForm(TDateFilter, DateFilter);

    Splash.StepBy;
    Hint := 'Starting Yellow Book';    
    AlumniBook.Show;

    Splash.Close;
  finally
    Splash.Release;
  end;

  Application.Run;
end.

