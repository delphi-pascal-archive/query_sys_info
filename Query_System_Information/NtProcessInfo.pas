{
   Модуль: NtProcessInfo

   Описание: Класс для удобного представления информации о списке процессов
             и потоков, возвращаемом функцией NtQuerySystemInformation
             с информационным классом SystemProcessesAndThreadsInformation

   Автор: Игорь Шевченко

   Дата создания: 20.12.2002

   История изменений:
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
    Информация о процессе, приведенная к единому виду для операционных систем
    Windows NT4 и Windows 2000 (и выше). В информации о процессе для Windows NT4
    структура IoCounters заполнена нулевыми значениями.
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

{ Преобразование списка процессов и потоков в виде сплошного потока данных
  в наш класс}
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
    { Создать объекты потоков в количестве ProcessItem.Info.ThreadCount }
    for I:=0 to Pred(ProcessItem.Info.ThreadCount) do
      ProcessItem.Threads.Add(THSNtThreadInfo.Create(PThreads^[I]));
    Add(ProcessItem);
    NextOffset := PProcess^.NextEntryDelta;
    { Перейти на следующий в списке процесс }
    PProcess := PSYSTEM_PROCESSES_NT2000(DWORD(PProcess) + NextOffset);
  until NextOffset = 0;
end;

function THSNtProcessInfoList.GetItems (I : Integer) : THSNtProcessInfo;
begin
  Result := THSNtProcessInfo(inherited Items[I]);
end;

end.
