{
   Модуль: ProcessDetailInfo

   Описание: Отображение полной информации о процессе, полученной вызовом
             NtQuerySystemInformation.
             (класс SystemProcessesAndThreadsInformation)

   Автор: Игорь Шевченко

   Дата создания: 20.12.2002

   История изменений:
}
unit ProcessDetailInfo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, NtProcessInfo, StdCtrls, ComCtrls, ExtCtrls;

type
  TfProcessDetailInfo = class(TForm)
    PageControl: TPageControl;
    OkButton: TButton;
    CancelButton: TButton;
    TabSheetGeneral: TTabSheet;
    Label1: TLabel;
    LabelThreadCount: TLabel;
    TabSheetVMCounters: TTabSheet;
    Label2: TLabel;
    LabelPeakVirtualSize: TLabel;
    Label3: TLabel;
    LabelVirtualSize: TLabel;
    Label4: TLabel;
    LabelPeakWorkingSetSize: TLabel;
    Label6: TLabel;
    LabelWorkingSetSize: TLabel;
    Label5: TLabel;
    LabelPageFaults: TLabel;
    Label7: TLabel;
    LabelReserved0: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label8: TLabel;
    LabelReserved1: TLabel;
    Label12: TLabel;
    LabelReserved2: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    LabelReserved3: TLabel;
    Label18: TLabel;
    LabelReserved4: TLabel;
    Label20: TLabel;
    LabelReserved5: TLabel;
    Label11: TLabel;
    LabelQuotaPeakPagedPoolUsage: TLabel;
    Label17: TLabel;
    LabelPagedPoolUsage: TLabel;
    Label13: TLabel;
    LabelQuotaPeakNonPagedPoolUsage: TLabel;
    Label21: TLabel;
    LabelNonPagedPoolUsage: TLabel;
    Label19: TLabel;
    LabelPeakPageFileUsage: TLabel;
    Label23: TLabel;
    LabelPageFileUsage: TLabel;
    Label22: TLabel;
    LabelCreateTime: TLabel;
    GroupBoxCPU: TGroupBox;
    Label24: TLabel;
    LabelKernelTime: TLabel;
    Label25: TLabel;
    LabelUserTime: TLabel;
    Label26: TLabel;
    LabelTotalTime: TLabel;
    Bevel1: TBevel;
    Label27: TLabel;
    LabelHandleCount: TLabel;
    Label28: TLabel;
    LabelBasePriority: TLabel;
    Label29: TLabel;
    LabelReserved20: TLabel;
    Label30: TLabel;
    LabelReserved21: TLabel;
    Label31: TLabel;
    LabelProcessId: TLabel;
    Label32: TLabel;
    LabelInheritedFromProcessId: TLabel;
    Label33: TLabel;
    LabelPrivatePageCount: TLabel;
    TabSheetIOCounters: TTabSheet;
    Label34: TLabel;
    LabelReadTransferCount: TLabel;
    LabelReadOperationCount: TLabel;
    Label35: TLabel;
    LabelWriteTransferCount: TLabel;
    LabelWriteOperationCount: TLabel;
    Label38: TLabel;
    LabelOtherTransferCount: TLabel;
    LabelOtherOperationCount: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    FProcess : THSNtProcessInfo;
    procedure DisplayProcessInfo;
  public
    constructor CreateArg (AOwner : TComponent; AProcess : THSNtProcessInfo);
  end;

implementation
uses
  NtUtils;

{$R *.dfm}

constructor TfProcessDetailInfo.CreateArg (AOwner : TComponent;
  AProcess : THSNtProcessInfo);
begin
  FProcess := AProcess;
  inherited Create (AOwner);
end;

procedure TfProcessDetailInfo.DisplayProcessInfo;

  function FormatMemory (Value : ULONG) : String;
  begin
    Result := Format('%-9d (%6d K)', [Value, Value DIV 1024]);
  end;

var
  ProcessName : String;
  TempTime : LARGE_INTEGER;
begin
  if FProcess.Info.ProcessId = 0 then
    ProcessName := 'Idle Process'
  else
    ProcessName := HSUnicodeStringToAnsiString(FProcess.Info.ProcessName);
  Caption := Format('  %s information', [ProcessName]);
  with FProcess.Info do begin
    LabelThreadCount.Caption := Format('%d', [ThreadCount]);
    LabelHandleCount.Caption := Format('%d', [HandleCount]);
    LabelBasePriority.Caption := Format('%d', [BasePriority]);
    LabelProcessId.Caption := Format('%d', [ProcessId]);
    LabelInheritedFromProcessId.Caption :=
        Format('%d', [InheritedFromProcessId]);
    LabelPrivatePageCount.Caption := Format('%d', [PrivatePageCount]);
    LabelReserved0.Caption := Format('%.8x', [Reserved1[0]]);
    LabelReserved1.Caption := Format('%.8x', [Reserved1[1]]);
    LabelReserved2.Caption := Format('%.8x', [Reserved1[2]]);
    LabelReserved3.Caption := Format('%.8x', [Reserved1[3]]);
    LabelReserved4.Caption := Format('%.8x', [Reserved1[4]]);
    LabelReserved5.Caption := Format('%.8x', [Reserved1[5]]);
    LabelReserved20.Caption := Format('%.8x', [Reserved2[0]]);
    LabelReserved21.Caption := Format('%.8x', [Reserved2[1]]);
    //TODO: Значения времени выдаются в виде всемирного времени, без учета
    //      часового пояса. По-хорошему, нужно спрашивать SystemTimeOfDayInfo
    //      и отнимать сдвиг при выводе на экран.
    if CreateTime.QuadPart = 0 then
      LabelCreateTime.Caption := 'n/a'
    else
    //TODO: Убрать non-biased, когда(если) будет выводиться локальное время.
      LabelCreateTime.Caption := HSFormatUTCTime(CreateTime) + ' (non-biased)';
    LabelKernelTime.Caption := HSFormatDateTimeInterval(
         HSTimeIntervalToDateTime(KernelTime));
    LabelUserTime.Caption := HSFormatDateTimeInterval(
         HSTimeIntervalToDateTime(UserTime));
    TempTime.QuadPart := KernelTime.QuadPart + UserTime.QuadPart;
    LabelTotalTime.Caption := HSFormatDateTimeInterval(
         HSTimeIntervalToDateTime(TempTime));
  end;
  with FProcess.Info.VmCounters do begin
    LabelPeakVirtualSize.Caption := FormatMemory(PeakVirtualSize);
    LabelVirtualSize.Caption := FormatMemory(VirtualSize);
    LabelPeakWorkingSetSize.Caption := FormatMemory(PeakWorkingSetSize);
    LabelWorkingSetSize.Caption := FormatMemory(WorkingSetSize);
    LabelPageFaults.Caption := Format ('%-9d', [PageFaultCount]);
    LabelQuotaPeakPagedPoolUsage.Caption :=
                        FormatMemory(QuotaPeakPagedPoolUsage);
    LabelPagedPoolUsage.Caption := FormatMemory(QuotaPagedPoolUsage);
    LabelQuotaPeakNonPagedPoolUsage.Caption :=
                        FormatMemory(QuotaPeakNonPagedPoolUsage);
    LabelNonPagedPoolUsage.Caption := FormatMemory(QuotaNonPagedPoolUsage);
    LabelPeakPageFileUsage.Caption := FormatMemory(PeakPageFileUsage);
    LabelPageFileUsage.Caption := FormatMemory(PageFileUsage);
  end;
  with FProcess.Info.IoCounters do begin
    LabelReadTransferCount.Caption := IntToStr(ReadTransferCount.QuadPart);
    LabelReadOperationCount.Caption := IntToStr(ReadOperationCount.QuadPart) +
                                       ' operation(s)';
    LabelWriteTransferCount.Caption := IntToStr(WriteTransferCount.QuadPart);
    LabelWriteOperationCount.Caption := IntToStr(WriteOperationCount.QuadPart) +
                                       ' operation(s)';
    LabelOtherTransferCount.Caption := IntToStr(OtherTransferCount.QuadPart);
    LabelOtherOperationCount.Caption := IntToStr(OtherOperationCount.QuadPart) +
                                       ' operation(s)';
  end;
end;

procedure TfProcessDetailInfo.FormCreate(Sender: TObject);
begin
  DisplayProcessInfo;
end;

end.
