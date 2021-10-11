{
   Модуль: PerformanceInfoDisplay

   Описание: Отображение информации о производительности системы
             (класс SystemPerformancInformation)

   Автор: Игорь Шевченко

   Дата создания: 21.12.2002

   История изменений:
}
unit PerformanceInfoDisplay;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, AbstractDisplay, StdCtrls, ComCtrls, ExtCtrls;

type
  TfPerformanceInfoDisplay = class(TfAbstractDisplayData)
    FixedInfoPanel: TPanel;
    VarInfoListView: TListView;
    Label1: TLabel;
    LabelIdleTime: TLabel;
    Label2: TLabel;
    LabelPageFaults: TLabel;
    Label3: TLabel;
    LabelAvailabePages: TLabel;
    Label4: TLabel;
    LabelTotalCommitedPages: TLabel;
    Label5: TLabel;
    LabelContextSwitches: TLabel;
    Label6: TLabel;
    LabelSystemCalls: TLabel;
  protected
    procedure DisplayData; override;
  end;

implementation
uses
  NtDll, NtUtils;

{$R *.dfm}

procedure TfPerformanceInfoDisplay.DisplayData;

  procedure AddDataItem (const AName : String; AValue : ULONG;
                         const AFormat : String = '%d');
  var
    LI : TListItem;
  begin
    LI := VarInfoListView.Items.Add();
    LI.Caption := AName;
    LI.SubItems.Add(Format(AFormat, [AValue]));
  end;

  procedure AddLongDataItem (const AName : String; AValue : LARGE_INTEGER);
  var
    LI : TListItem;
  begin
    LI := VarInfoListView.Items.Add();
    LI.Caption := AName;
    LI.SubItems.Add(IntToStr(AValue.QuadPart));
  end;

begin
  VarInfoListView.Items.Clear();
  with SYSTEM_PERFORMANCE_INFORMATION(Data^) do begin
    { Фиксированная информация }
    LabelIdleTime.Caption := HSFormatDateTimeInterval(
         HSTimeIntervalToDateTime(IdleTime));
    LabelPageFaults.Caption := Format('%d', [PageFaults]);
    LabelAvailabePages.Caption := Format('%d pages', [AvailablePages]);
    LabelTotalCommitedPages.Caption := Format('%d pages', [TotalCommittedPages]);
    LabelContextSwitches.Caption := Format('%d', [ContextSwitches]);
    LabelSystemCalls.Caption := Format('%d', [SystemCalls]);
    { Переменная информация }
    AddLongDataItem('Read transfer count', ReadTransferCount);
    AddLongDataItem('Write transfer count', WriteTransferCount);
    AddLongDataItem('Other transfer count', OtherTransferCount);
    AddDataItem('Read operation count', ReadOperationCount);
    AddDataItem('Write operation count', WriteOperationCount);
    AddDataItem('Other operation count', OtherOperationCount);
    AddDataItem('Total commit limit', TotalCommitLimit);
    AddDataItem('Peak commitment', PeakCommitment);
    AddDataItem('Writecopy faults', WriteCopyFaults);
    AddDataItem('Transition faults', TransitionFaults);
    AddDataItem('Demand zero faults', DemandZeroFaults);
    AddDataItem('Pages read', PagesRead);
    AddDataItem('Page read I/Os', PageReadIos);
    AddDataItem('Pagefile pages written', PagefilePagesWritten);
    AddDataItem('Pagefile write I/Os', PagefilePageWriteIos);
    AddDataItem('Mapped file pages written', MappedFilePagesWritten);
    AddDataItem('Mapped file page write I/Os', MappedFilePageWriteIos);
    AddDataItem('Paged pool usage', PagedPoolUsage);
    AddDataItem('Non-paged pool usage', NonPagedPoolUsage);
    AddDataItem('Paged pool allocations', PagedPoolAllocs);
    AddDataItem('Paged pool frees', PagedPoolFrees);
    AddDataItem('Non-paged pool allocations', NonPagedPoolAllocs);
    AddDataItem('Non-paged pool frees', NonPagedPoolFrees);
    AddDataItem('Total free system PTEs', TotalFreeSystemPtes);
    AddDataItem('system code pages', SystemCodePage);
    AddDataItem('Total system driver pages', TotalSystemDriverPages);
    AddDataItem('Total system code pages', TotalSystemCodePages);
    AddDataItem('Small non-paged lookaside list allocate hits',
         SmallNonPagedLookasideListAllocateHits);
    AddDataItem('Small paged lookaside list allocate hits',
         SmallPagedLookasideListAllocateHits);
    AddDataItem('System cache pages', MmSystemCachePage);
    AddDataItem('Paged pool pages', PagedPoolPage);
    AddDataItem('System driver pages', SystemDriverPage);
    AddDataItem('Fast read no wait', FastReadNoWait);
    AddDataItem('Fast read wait', FastReadWait);
    AddDataItem('Fast read resource misses', FastReadResourceMiss);
    AddDataItem('Fast read not possible', FastReadNonPossible);
    AddDataItem('Fast MDL read no wait', FastMdlReadNoWait);
    AddDataItem('Fast MDL read wait', FastMdlReadWait);
    AddDataItem('Fast MDL read resource misses', FastMdlReadResourceMiss);
    AddDataItem('Fast MDL read not possible', FastMdlReadNonPossible);
    AddDataItem('Map data no wait', MapDataNoWait);
    AddDataItem('Map data wait', MapDataWait);
    AddDataItem('Map data no wait misses', MapDataNoWaitMiss);
    AddDataItem('Map data wait misses', MapDataWaitMiss);
    AddDataItem('Pin mapped data count', PinMappedDataCount);
    AddDataItem('Pin read no wait', PinReadNoWait);
    AddDataItem('Pin read wait', PinReadWait);
    AddDataItem('Pin read no wait misses', PinReadNoWaitMiss);
    AddDataItem('Pin read wait misses', PinReadWaitMiss);
    AddDataItem('Copy read no wait', CopyReadNoWait);
    AddDataItem('Copy read wait', CopyReadWait);
    AddDataItem('Copy read no wait misses', CopyReadNoWaitMiss);
    AddDataItem('Copy read wait misses', CopyReadWaitMiss);
    AddDataItem('MDL read no wait', MdlReadNoWait);
    AddDataItem('MDL read wait', MdlReadWait);
    AddDataItem('MDL read no wait misses', MdlReadNoWaitMiss);
    AddDataItem('MDL read wait misses', MdlReadWaitMiss);
    AddDataItem('Read ahead I/Os', ReadAheadIos);
    AddDataItem('Lazy write I/Os', LazyWriteIos);
    AddDataItem('Lazy write pages', LazyWritePages);
    AddDataItem('Data flushes', DataFlushes);
    AddDataItem('Data pages', DataPages);
    AddDataItem('First Level Tb fills', FirstLevelTbFills);
    AddDataItem('Second Level Tb fills', SecondLevelTbFills);
  end;
end;

initialization
  RegisterClass(TfPerformanceInfoDisplay);
end.
