program QuerySystemInformation;

uses
  Forms,
  main in 'main.pas' {fMain},
  Child in 'Child.pas' {fAbstractChild},
  BasicInfoDisplay in 'BasicInfoDisplay.pas' {fBasicInfoDisplay},
  AbstractDisplay in 'AbstractDisplay.pas' {fAbstractDisplayData},
  About in 'About.pas' {fAbout},
  ProcessorInfoDisplay in 'ProcessorInfoDisplay.pas' {fProcessorInfoDisplay},
  TimeOfDayDisplay in 'TimeOfDayDisplay.pas' {fTimeOfDayDisplay},
  PerformanceInfoDisplay in 'PerformanceInfoDisplay.pas' {fPerformanceInfoDisplay},
  NtUtils in 'NtUtils.pas',
  NtProcessInfo in 'NtProcessInfo.pas',
  ProcessesAndThreadsDisplay in 'ProcessesAndThreadsDisplay.pas' {fProcessesAndThreadsDisplay},
  ThreadDetailInfo in 'ThreadDetailInfo.pas' {fThreadDetailInfo},
  HSSystemInformation in 'HSSystemInformation.pas',
  ProcessDetailInfo in 'ProcessDetailInfo.pas' {fProcessDetailInfo},
  ConfigurationDisplay in 'ConfigurationDisplay.pas' {fConfigurationDisplay},
  CacheDisplay in 'CacheDisplay.pas' {fCacheDisplay},
  TimeAdjustmentDisplay in 'TimeAdjustmentDisplay.pas' {fTimeAdjustmentDisplay};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfMain, fMain);
  Application.Run;
end.
