{
   Модуль: ProcessesAndThreadsDisplay

   Описание: Отображение информации о процессах и потоках
             (класс SystemProcessesAndThreadsInformation)

   Автор: Игорь Шевченко

   Дата создания: 20.12.2002

   История изменений:
}
unit ProcessesAndThreadsDisplay;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, AbstractDisplay, ComCtrls, NtProcessInfo, StdCtrls, ExtCtrls;

type
  TfProcessesAndThreadsDisplay = class(TfAbstractDisplayData)
    ListViewProcesses: TListView;
    Splitter1: TSplitter;
    PanelClient: TPanel;
    ListViewThread: TListView;
    Panel1: TPanel;
    procedure ListViewProcessesDblClick(Sender: TObject);
    procedure ListViewProcessesChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure ListViewThreadDblClick(Sender: TObject);
  private
    procedure DisplayProcessData (const AProcess : THSNtProcessInfo);
    procedure DisplayFullProcessData (const AProcess : THSNtProcessInfo);
    procedure DisplayFullThreadData (const AThread : THSNtThreadInfo);
    procedure DisplayProcessThreads (const AProcess : THSNtProcessInfo);
    procedure DisplayThreadData (const AThread : THSNtThreadInfo);
  protected
    procedure DisplayData; override;
  end;

implementation
uses
  NtDll, NtUtils, ProcessDetailInfo, ThreadDetailInfo;

{$R *.dfm}

procedure TfProcessesAndThreadsDisplay.DisplayProcessData (
  const AProcess : THSNtProcessInfo);
var
  LI : TListItem;
begin
  LI := ListViewProcesses.Items.Add();
  with AProcess.Info do begin
    if ProcessId = 0 then
      LI.Caption := 'Idle Process'
    else
      LI.Caption := HSUnicodeStringToAnsiString(ProcessName);
    LI.SubItems.Add(Format('%d', [ProcessId]));
    LI.SubItems.Add(Format('%d', [BasePriority]));
    LI.SubItems.Add(Format('%d', [PrivatePageCount]));
    LI.SubItems.Add(Format('%d', [HandleCount]));
    LI.SubItems.Add(Format('%d', [InheritedFromProcessId]));
    LI.SubItems.Add(Format('%d', [VmCounters.WorkingSetSize]));
    LI.SubItems.Add(Format('%d', [VmCounters.PageFileUsage]));
    LI.SubItems.Add(Format('%d', [ThreadCount]));
    LI.Data := AProcess;
  end;
end;

procedure TfProcessesAndThreadsDisplay.DisplayData;
var
  I : Integer;
begin
  ListViewProcesses.Items.Clear();
  with THSNtProcessInfoList(Data) do
    for I:=0 to Pred(Count) do
      DisplayProcessData(Items[I]);
  with ListViewProcesses do
    if (Items.Count > 0) and (Selected = nil) then
      Items[0].Selected := true;
end;

procedure TfProcessesAndThreadsDisplay.DisplayFullProcessData (
  const AProcess : THSNtProcessInfo);
begin
  with TfProcessDetailInfo.CreateArg(Application, AProcess) do
    try
      ShowModal();
    finally
      Free();
    end;
end;

procedure TfProcessesAndThreadsDisplay.DisplayFullThreadData (
  const AThread : THSNtThreadInfo);
begin
  with TfThreadDetailInfo.CreateArg(Application, AThread) do
    try
      ShowModal();
    finally
      Free();
    end;
end;

procedure TfProcessesAndThreadsDisplay.DisplayThreadData (
  const AThread : THSNtThreadInfo);
var
  LI : TListItem;
const ThreadStates : array[MIN_THREAD_STATE..MAX_THREAD_STATE] of String = (
  'Init', 'Ready', 'Running', 'Standby', 'Term', 'Wait', 'Trans', 'Unknown'
);
const WaitReasons : array[MIN_WAIT_REASON..MAX_WAIT_REASON] of String = (
  'Executive', 'FreePage', 'PageIn', 'PoolAlloc', 'DelayExec', 'Suspend',
  'UserRequest', 'WrExecutive', 'WrFreePage', 'WrPageIn', 'WrPoolAlloc',
  'WrDelayExec', 'WrSuspend', 'WrUserRequest', 'WrEventPair', 'WrQueue',
  'LpcReceive', 'WrLpcReply', 'WrVirtualMem', 'WrPageOut', 'WrRendezvous',
  'Spare2', 'Spare3', 'Spare4', 'Spare5', 'Spare6', 'WrKernel'
);
begin
  LI := ListViewThread.Items.Add();
  with AThread.Info do begin
    LI.Caption := Format('%d', [ClientID.UniqueThread]);
    LI.SubItems.Add (Format('%d', [ClientID.UniqueProcess]));
    LI.SubItems.Add (Format('%d', [ContextSwitchCount]));
    LI.SubItems.Add (Format('%d', [Priority]));
    LI.SubItems.Add (Format('%d', [BasePriority]));
    LI.SubItems.Add (Format('%.8x', [Integer(StartAddress)]));
    if (State < MIN_THREAD_STATE) or (State > MAX_THREAD_STATE) then
      LI.SubItems.Add (Format('***=>%d', [State]))
    else
      LI.SubItems.Add (ThreadStates[State]);
    if State = THREAD_STATE_WAIT then
      if (WaitReason < MIN_WAIT_REASON) or (WaitReason > MAX_WAIT_REASON) then
        LI.SubItems.Add (Format('***=>%d', [WaitReason]))
      else
        LI.SubItems.Add (WaitReasons[WaitReason]);
    LI.Data := AThread;
  end;
end;

procedure TfProcessesAndThreadsDisplay.DisplayProcessThreads (
  const AProcess : THSNtProcessInfo);
var
  I : Integer;
begin
  ListViewThread.Items.Clear();
  if Assigned(AProcess) then //TODO: Если проверка окажется лишней - убрать.
    for I:=0 to Pred(AProcess.Threads.Count) do
      DisplayThreadData (AProcess.Threads[I]);
end;

procedure TfProcessesAndThreadsDisplay.ListViewProcessesDblClick(
  Sender: TObject);
begin
  if ListViewProcesses.Selected.Data <> nil then
    DisplayFullProcessData(THSNtProcessInfo(ListViewProcesses.Selected.Data));
end;

procedure TfProcessesAndThreadsDisplay.ListViewProcessesChange(
  Sender: TObject; Item: TListItem; Change: TItemChange);
begin
  if (Change = ctState) and Item.Selected then
    DisplayProcessThreads(THSNtProcessInfo(Item.Data));
end;

procedure TfProcessesAndThreadsDisplay.ListViewThreadDblClick(
  Sender: TObject);
begin
  if ListViewThread.Selected.Data <> nil then
    DisplayFullThreadData(THSNtThreadInfo(ListViewThread.Selected.Data));
end;

initialization
  RegisterClass(TfProcessesAndThreadsDisplay);
end.
