{
   ������: NtProcessInfo

   ��������: ����� ��� �������� ������������� ���������� � ������ ���������
             � �������, ������������ �������� NtQuerySystemInformation
             � �������������� ������� SystemProcessesAndThreadsInformation

   �����: ����� ��������

   ���� ��������: 20.12.2002

   ������� ���������:
}
unit NtProcessInfo;

interface
uses
  NtDll, HSObjectList;

type
  THSNtThreadInfo = class
  public
    Info : SYSTEM_THREADS;
    constructor Create (AInfo : SYSTEM_THREADS);
  end;

  THSNtThreadInfoList = class(THSObjectList)
  private
    function GetItems (I : Integer) : THSNtThreadInfo;
  public
    property Items[I : Integer] : THSNtThreadInfo read GetItems; default;
  end;

  {
    ���������� � ��������, ����������� � ������� ���� ��� ������������ ������
    Windows NT4 � Windows 2000 (� ����). � ���������� � �������� ��� Windows NT4
    ��������� IoCounters ��������� �������� ����������.
  }
  THSNtProcessInfo = class
  public
    Info : SYSTEM_PROCESSES_NT2000;
    Threads : THSNtThreadInfoList;

    constructor Create (AInfo : SYSTEM_PROCESSES_NT2000);
    constructor CreateNt4 (AInfo : SYSTEM_PROCESSES_NT4);
    destructor Destroy; override;
  end;

  THSNtProcessInfoList = class(THSObjectList)
  private
    function GetItems (I : Integer) : THSNtProcessInfo;
  public
    constructor Create (AData : Pointer);
    property Items[I : Integer] : THSNtProcessInfo read GetItems; default;
  end;

implementation
uses
  Windows, SysUtils;

{ THSNtThreadInfo }

constructor THSNtThreadInfo.Create (AInfo : SYSTEM_THREADS);
begin
  inherited Create();
  Info := AInfo;
end;

{ THSNtThreadInfoList }

function THSNtThreadInfoList.GetItems (I : Integer) : THSNtThreadInfo;
begin
  Result := THSNtThreadInfo(inherited Items[I]);
end;

{ THSNtProcessInfo }

constructor THSNtProcessInfo.Create (AInfo : SYSTEM_PROCESSES_NT2000);
begin
  inherited Create();
  Info := AInfo;
  Threads := THSNtThreadInfoList.Create();
end;

constructor THSNtProcessInfo.CreateNt4 (AInfo : SYSTEM_PROCESSES_NT4);
begin
  inherited Create();
  Move (AInfo, Info, SizeOf(AInfo));
  FillChar(Info.IoCounters, SizeOf(IO_COUNTERS), 0);
  Threads := THSNtThreadInfoList.Create();
end;

destructor THSNtProcessInfo.Destroy;
begin
  Threads.Free();
  inherited;
end;

{ THSNtProcessInfoList }

{ �������������� ������ ��������� � ������� � ���� ��������� ������ ������
  � ��� �����}
constructor THSNtProcessInfoList.Create (AData : Pointer);
var
  NextOffset : ULONG;
  PProcess : PSYSTEM_PROCESSES_NT2000;
  ProcessItem : THSNtProcessInfo;
  PThreads : PSYSTEM_THREADS_ARRAY;
  I : Integer;
begin
  inherited Create();
  PProcess := PSYSTEM_PROCESSES_NT2000(AData);
  repeat
    if Win32MajorVersion <= 4 then begin
      ProcessItem := THSNtProcessInfo.CreateNt4(
             PSYSTEM_PROCESSES_NT4(PProcess)^);
      PThreads := PSYSTEM_THREADS_ARRAY(DWORD(PProcess) +
                                        SizeOf(SYSTEM_PROCESSES_NT4));
    end else begin
      ProcessItem := THSNtProcessInfo.Create(PProcess^);
      PThreads := PSYSTEM_THREADS_ARRAY(DWORD(PProcess) +
                                        SizeOf(SYSTEM_PROCESSES_NT2000));
    end;
    { ������� ������� ������� � ���������� ProcessItem.Info.ThreadCount }
    for I:=0 to Pred(ProcessItem.Info.ThreadCount) do
      ProcessItem.Threads.Add(THSNtThreadInfo.Create(PThreads^[I]));
    Add(ProcessItem);
    NextOffset := PProcess^.NextEntryDelta;
    { ������� �� ��������� � ������ ������� }
    PProcess := PSYSTEM_PROCESSES_NT2000(DWORD(PProcess) + NextOffset);
  until NextOffset = 0;
end;

function THSNtProcessInfoList.GetItems (I : Integer) : THSNtProcessInfo;
begin
  Result := THSNtProcessInfo(inherited Items[I]);
end;

end.
