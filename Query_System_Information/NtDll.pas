{
   Модуль: NtDll

   Описание: Интерфейс к динамической библиотеке NTDLL.DLL.
             Описание структур и прототипов функций приведено на основе
             информации из книги Гэри Неббета "Справочник по базовым функциям
             API Windows NT/2000",
             исходных текстов программы NTINFO Свена Шрайбера (спасибо Digitman)
             MSDN (http://msdn.microsoft.com)
             и собственных исследований.

   Автор: Игорь Шевченко

   Дата создания: 31.08.2002

   История изменений:
   03.09.2002 Добавлена функция RtlGetCurrentPEB
   15.12.2002 Добавлены дополнения из разных мест (HsUserNt, CsrTest)
   18.12.2002 Добавлены запись TIME_FIELDS и функция RtlTimeToTimeFields;
   23.12.2002 Добавлена функция NtSetSystemInformation
}
unit NtDll;

interface
uses
  HsNtDef,
  Windows;

type
  USHORT = Word;
  PLARGE_INTEGER = ^LARGE_INTEGER;
  PVOID = Pointer;

{ Базовая информация об объекте }
  TOBJECT_BASIC_INFORMATION = packed record
    Attributes : ULONG;
    GrantedAccess : ACCESS_MASK;
    HandleCount : ULONG;
    PointerCount : ULONG;
    PagedPoolUsage : ULONG;
    NonPagedPoolUsage : ULONG;
    Reserved1 : ULONG;
    Reserved2 : ULONG;
    Reserved3 : ULONG;
    NameInformationLength : ULONG;
    TypeInformationLength : ULONG;
    SecurityDescriptorLength : ULONG;
    CreateTime : TLargeInteger;
  end;
  POBJECT_BASIC_INFORMATION = ^TOBJECT_BASIC_INFORMATION;
{ Информация о типе объекта - переменной длины }
  TOBJECT_TYPE_INFORMATION = packed record
    Name : TUNICODE_STRING;
    ObjectCount : ULONG;
    HandleCount : ULONG;
    Reserved1 : array[1..4] of ULONG;
    PeakObjectCount : ULONG;
    PeakHandleCount : ULONG;
    Reserved2 : array[1..4] of ULONG;
    InvalidAttributes : ULONG;
    GenericMapping : GENERIC_MAPPING;
    ValidAccess : ULONG;
    Unknown : Byte;
    MaintainHandleDatabase : ByteBool;
    PoolType : Word;
    PagedPoolUsage : ULONG;
    NonpagedPoolUsage : ULONG;
  end;
  POBJECT_TYPE_INFORMATION = ^TOBJECT_TYPE_INFORMATION;
{ Информация об имени объекта - переменной длины }
  TOBJECT_NAME_INFORMATION = packed record
    Name : TUNICODE_STRING;
  end;
  POBJECT_NAME_INFORMATION = ^TOBJECT_NAME_INFORMATION;
{ Базовая информация о системе }
  SYSTEM_BASIC_INFORMATION = packed record
    AlwaysZero : ULONG;
    MaximumIncrement : ULONG;
    PhysicalPageSize : ULONG;
    NumberOfPhysicalPages : ULONG;
    LowestPhysicalPage : ULONG;
    HighestPhysicalPage : ULONG;
    AllocationGranularity : ULONG;
    LowestUserAddress : ULONG;
    HighestUserAddress : ULONG;
    ActiveProcessors : ULONG;
    NumberProcessors : UCHAR;
    Filler : array[0..2] of char;
  end;
  PSYSTEM_BASIC_INFORMATION = ^SYSTEM_BASIC_INFORMATION;
{ Информация о процессоре }
  SYSTEM_PROCESSOR_INFORMATION = packed record
    ProcessorArchitecture : USHORT;
    ProcessorLevel : USHORT;
    ProcessorRevision : USHORT;
    Unknown : USHORT;
    FeatureBits : ULONG;
  end;
  PSYSTEM_PROCESSOR_INFORMATION = ^SYSTEM_PROCESSOR_INFORMATION;
{ Биты информации о процессоре }
const
  PFB_VME = 1;
  PFB_TCS = 2;
  PFB_CR4 = 4;
  PFB_CMOV = 8;
  PFB_PGE = $10;
  PFB_PSE = $20;
  PFB_MTRR = $40;
  PFB_CXS = $80;
  PFB_MMX = $100;
  PFB_PAT = $400;
  PFB_FXSR = $800;
  PFB_SIMD = $2000;
type
{ Формат времени (структура аналогична SYSTEMTIME в Win32 API }
  TIME_FIELDS = packed record
    Year : WORD;
    Month : WORD;
    Day : WORD;
    Hour : WORD;
    Minute : WORD;
    Second : WORD;
    Milliseconds : WORD;
    Weekday : WORD;
  end;
  PTIME_FIELDS = ^TIME_FIELDS;
type
{ Информация о производительности системы }
  SYSTEM_PERFORMANCE_INFORMATION = packed record
    IdleTime : LARGE_INTEGER;
    ReadTransferCount : LARGE_INTEGER;
    WriteTransferCount : LARGE_INTEGER;
    OtherTransferCount : LARGE_INTEGER;
    ReadOperationCount : ULONG;
    WriteOperationCount : ULONG;
    OtherOperationCount : ULONG;
    AvailablePages : ULONG;
    TotalCommittedPages : ULONG;
    TotalCommitLimit : ULONG;
    PeakCommitment : ULONG;
    PageFaults : ULONG;
    WriteCopyFaults : ULONG;
    TransitionFaults : ULONG;
    Reserved1 : ULONG;
    DemandZeroFaults : ULONG;
    PagesRead : ULONG;
    PageReadIos : ULONG;
    Reserved2 : array[0..1] of ULONG;
    PageFilePagesWritten : ULONG;
    PageFilePageWriteIos : ULONG;
    MappedFilePagesWritten : ULONG;
    MappedFilePageWriteIos : ULONG;
    PagedPoolUsage : ULONG;
    NonPagedPoolUsage : ULONG;
    PagedPoolAllocs : ULONG;
    PagedPoolFrees : ULONG;
    NonPagedPoolAllocs : ULONG;
    NonPagedPoolFrees : ULONG;
    TotalFreeSystemPtes : ULONG;
    SystemCodePage : ULONG;
    TotalSystemDriverPages : ULONG;
    TotalSystemCodePages : ULONG;
    SmallNonPagedLookasideListAllocateHits : ULONG;
    SmallPagedLookasideListAllocateHits : ULONG;
    Reserved3 : ULONG;
    MMSystemCachePage : ULONG;
    PagedPoolPage : ULONG;
    SystemDriverPage : ULONG;
    FastReadNoWait : ULONG;
    FastReadWait : ULONG;
    FastReadResourceMiss : ULONG;
    FastReadNonPossible : ULONG;
    FastMdlReadNoWait : ULONG;
    FastMdlReadWait : ULONG;
    FastMdlReadResourceMiss : ULONG;
    FastMdlReadNonPossible : ULONG;
    MapDataNoWait : ULONG;
    MapDataWait : ULONG;
    MapDataNoWaitMiss : ULONG;
    MapDataWaitMiss : ULONG;
    PinMappedDataCount : ULONG;
    PinReadNoWait : ULONG;
    PinReadWait : ULONG;
    PinReadNoWaitMiss : ULONG;
    PinReadWaitMiss : ULONG;
    CopyReadNoWait : ULONG;
    CopyReadWait : ULONG;
    CopyReadNoWaitMiss : ULONG;
    CopyReadWaitMiss : ULONG;
    MdlReadNoWait : ULONG;
    MdlReadWait : ULONG;
    MdlReadNoWaitMiss : ULONG;
    MdlReadWaitMiss : ULONG;
    ReadAheadIos : ULONG;
    LazyWriteIos : ULONG;
    LazyWritePages : ULONG;
    DataFlushes : ULONG;
    DataPages : ULONG;
    ContextSwitches : ULONG;
    FirstLevelTbFills : ULONG;
    SecondlevelTbFills : ULONG;
    SystemCalls : ULONG;
  end;
  PSYSTEM_PERFORMANCE_INFORMATION = ^SYSTEM_PERFORMANCE_INFORMATION;
{ Информация о текущем времени и часовом поясе }
  SYSTEM_TIME_OF_DAY_INFORMATION = packed record
    BootTime : LARGE_INTEGER;
    CurrentTime : LARGE_INTEGER;
    TimeZoneBias : LARGE_INTEGER;
    CurrentTimeZoneId : ULONG;
    Reserved : ULONG;
  end;
  PSYSTEM_TIME_OF_DAY_INFORMATION = ^SYSTEM_TIME_OF_DAY_INFORMATION;
{ Информация о процессах и потоках }
  THREAD_STATE = Integer;

  KWAIT_REASON = Integer;

  KPRIORITY = Integer;

  POOL_TYPE = Integer;

  { Описание потока }
  SYSTEM_THREADS = packed record
    KernelTime : LARGE_INTEGER;
    UserTime : LARGE_INTEGER;
    CreateTime : LARGE_INTEGER;
    WaitTime : ULONG;
    StartAddress : PVOID;
    ClientId : CLIENT_ID;
    Priority : KPRIORITY;
    BasePriority : KPRIORITY;
    ContextSwitchCount : ULONG;
    State : THREAD_STATE;
    WaitReason : KWAIT_REASON;
    Reserved : ULONG;
  end;

  SYSTEM_THREADS_ARRAY = array[0..1024] of SYSTEM_THREADS;
  PSYSTEM_THREADS_ARRAY = ^SYSTEM_THREADS_ARRAY;

  { Счетчики виртуальной памяти }
  VM_COUNTERS = packed record
    PeakVirtualSize : ULONG;
    VirtualSize : ULONG;
    PageFaultCount : ULONG;
    PeakWorkingSetSize : ULONG;
    WorkingSetSize : ULONG;
    QuotaPeakPagedPoolUsage : ULONG;
    QuotaPagedPoolUsage : ULONG;
    QuotaPeakNonPagedPoolUsage : ULONG;
    QuotaNonPagedPoolUsage : ULONG;
    PageFileUsage : ULONG;
    PeakPageFileUsage : ULONG;
  end;

  {Счетчики ввода-вывода. Эта структура существует только в Windows 2000 и выше}
  IO_COUNTERS = packed record
    ReadOperationCount : LARGE_INTEGER;
    WriteOperationCount : LARGE_INTEGER;
    OtherOperationCount : LARGE_INTEGER;
    ReadTransferCount : LARGE_INTEGER;
    WriteTransferCount : LARGE_INTEGER;
    OtherTransferCount : LARGE_INTEGER;
  end;

  { Информация о процессе для Windows 2000 и выше }
  SYSTEM_PROCESSES_NT2000 = packed record
    NextEntryDelta : ULONG;
    ThreadCount : ULONG;
    Reserved1 : array[0..5] of ULONG;
    CreateTime : LARGE_INTEGER;
    UserTime : LARGE_INTEGER;
    KernelTime : LARGE_INTEGER;
    ProcessName : UNICODE_STRING;
    BasePriority : KPRIORITY;
    ProcessId : ULONG;
    InheritedFromProcessId : ULONG;
    HandleCount : ULONG;
    Reserved2 : array[0..1] of ULONG;
    VmCounters : VM_COUNTERS;
    PrivatePageCount : ULONG;
    IoCounters : IO_COUNTERS;
//    Threads : array[0..0] of SYSTEM_THREADS;
  end;
  PSYSTEM_PROCESSES_NT2000 = ^SYSTEM_PROCESSES_NT2000;

  { Информация о процессе для Windows NT 4 (отличается от аналогичной структуры
    для Windows 2000 отсутствием IoCounters) }
  SYSTEM_PROCESSES_NT4 = packed record
    NextEntryDelta : ULONG;
    ThreadCount : ULONG;
    Reserved1 : array[0..5] of ULONG;
    CreateTime : LARGE_INTEGER;
    UserTime : LARGE_INTEGER;
    KernelTime : LARGE_INTEGER;
    ProcessName : UNICODE_STRING;
    BasePriority : KPRIORITY;
    ProcessId : ULONG;
    InheritedFromProcessId : ULONG;
    HandleCount : ULONG;
    Reserved2 : array[0..1] of ULONG;
    VmCounters : VM_COUNTERS;
    PrivatePageCount : ULONG;
  end;
  PSYSTEM_PROCESSES_NT4 = ^SYSTEM_PROCESSES_NT4;
  { Информация о количестве системных вызовов (только для контрольной версии
    ядра }
  SYSTEM_CALLS_INFORMATION = packed record
    Size : ULONG;
    NumberOfDescriprorTables : ULONG;
    NumberOfRoutinesInTable : array[0..0] of ULONG;
    //CallCounts : array[0..] of ULONG;
  end;
  PSYSTEM_CALLS_INFORMATION = ^SYSTEM_CALLS_INFORMATION;
  { Информация об аппаратной конфигурации системы }
  SYSTEM_CONFIGURATION_INFORMATION = packed record
    DiskCount : ULONG;
    FloppyCount : ULONG;
    CdRomCount : ULONG;
    TapeCount : ULONG;
    SerialCount : ULONG;
    ParallelCount : ULONG;
  end;
  PSYSTEM_CONFIGURATION_INFORMATION = ^SYSTEM_CONFIGURATION_INFORMATION;
  { Информация о времени работы процессора в различных режимах. Для каждого
    процессора в системе возвращается по структуре }
  SYSTEM_PROCESSOR_TIMES = packed record
    IdleTime : LARGE_INTEGER;
    KernelTime : LARGE_INTEGER;
    UserTime : LARGE_INTEGER;
    DpcTime : LARGE_INTEGER;
    InterruptTime : LARGE_INTEGER;
    InterruptCount : ULONG;
  end;
  PSYSTEM_PROCESSOR_TIMES = ^SYSTEM_PROCESSOR_TIMES;
  { Информация о глобальных настройках системы }
  SYSTEM_GLOBAL_FLAG = packed record
    GlobalFlag : ULONG;
  end;
  PSYSTEM_GLOBAL_FLAG = ^SYSTEM_GLOBAL_FLAG;
  { Информация о загруженных модулях режима ядра }
  SYSTEM_MODULE_INFORMATION = packed record
    Reserved : array[0..1] of ULONG;
    Base : PVOID;
    Size : ULONG;
    Flags : ULONG;
    Index : USHORT;
    Unknown : USHORT;
    LoadCount : USHORT;
    ModuleNameOffset : USHORT;
    ImageName : array[0..256] of char; { ANSI }
  end;
  PSYSTEM_MODULE_INFORMATION = ^SYSTEM_MODULE_INFORMATION;
  SYSTEM_MODULE_INFORMATION_ARRAY = array[0..16384] of
                                    SYSTEM_MODULE_INFORMATION;
  { Массив информации для класса SystemLockInformation }
  SYSTEM_MODULES_INFORMATION = packed record
    Count : ULONG;
    Data : SYSTEM_MODULE_INFORMATION_ARRAY;
  end;
  PSYSTEM_MODULES_INFORMATION = ^SYSTEM_MODULES_INFORMATION;
  
  { Информация о блокировках системы }
  SYSTEM_LOCK_INFORMATION = packed record
    Address : PVOID;
    FType : USHORT;
    Reserved1 : USHORT;
    ExclusiveOwnerThread : ULONG;
    ActiveCount : ULONG;
    ContentionCount : ULONG;
    Reserved2 : array[0..1] of ULONG;
    NumberOfSharedWaiters : ULONG;
    NumberOfExclusiveWaiters : ULONG;
  end;
  PSYSTEM_LOCK_INFORMATION = ^SYSTEM_LOCK_INFORMATION;
  SYSTEM_LOCK_INFORMATION_ARRAY = array[0..16384] of SYSTEM_LOCK_INFORMATION;
  { Массив информации для класса SystemLockInformation }
  SYSTEM_LOCKS_INFORMATION = packed record
    Count : ULONG;
    Data : SYSTEM_LOCK_INFORMATION_ARRAY;
  end;
  PSYSTEM_LOCKS_INFORMATION = ^SYSTEM_LOCKS_INFORMATION;

{ Информация о дескрипторе }
  SYSTEM_HANDLE_INFORMATION = packed record
    PID : ULONG;        { Идентификатор процесса, владеющего данным дескриптором }
    ObjectType : UCHAR; { Тип объекта, идентифицируемого данным дескриптором }
    Flags : UCHAR;      { Флаги дескриптора }
    Handle : USHORT;    { Значение дескриптора }
    FObject : PVOID;    { Адрес объекта, идентифицируемого данным дескриптором }
    GrantedAccess : ACCESS_MASK; { Степень доступа к объекту, предоставленная
                                   в момент создания данного дескриптора }
  end;
  PSYSTEM_HANDLE_INFORMATION = ^SYSTEM_HANDLE_INFORMATION;
  SYSTEM_HANDLE_INFORMATION_ARRAY = array[0..16384] of SYSTEM_HANDLE_INFORMATION;
  { Массив информации для класса SystemHandleInformation }
  SYSTEM_HANDLES_INFORMATION = packed record
    Count : ULONG;
    Data : SYSTEM_HANDLE_INFORMATION_ARRAY;
  end;
  PSYSTEM_HANDLES_INFORMATION = ^SYSTEM_HANDLES_INFORMATION;
  { Инофрмация об объектах выдается только в том случае, если в системе
    установлен глобальный флаг FLG_MAINTAIN_OBJECT_TYPELIST }
  { Информация об объектах }
  SYSTEM_OBJECT_INFORMATION = packed record
    NextEntryOffset : ULONG;
    ObjectAddress : PVOID;
    CreatorProcessId : ULONG;
    Unknown : USHORT;
    Flags : USHORT;
    PointerCount : ULONG;
    HandleCount : ULONG;
    PagedPoolUsage : ULONG;
    NonPagedPoolUsage : ULONG;
    ExclusiveProcessId : ULONG;
    SecurityDescriptor : PSECURITY_DESCRIPTOR;
    Name : UNICODE_STRING;
  end;
  PSYSTEM_OBJECT_INFORMATION = ^SYSTEM_OBJECT_INFORMATION;
  SYSTEM_OBJECT_INFORMATION_ARRAY = array[0..16384] of
                                    SYSTEM_OBJECT_INFORMATION;
  PSYSTEM_OBJECT_INFORMATION_ARRAY = ^SYSTEM_OBJECT_INFORMATION_ARRAY;

  { Информация о  типе объекта }
  SYSTEM_OBJECT_TYPE_INFORMATION = packed record
    NextEntryOffset : ULONG;
    ObjectCount : ULONG;
    HandleCount : ULONG;
    TypeNumber : ULONG;
    InvalidAttributes : ULONG;
    GenericMapping : GENERIC_MAPPING;
    ValidAccessMask : ACCESS_MASK;
    PoolType : POOL_TYPE;
    { Свен Шрайбер. Неббет предполагает только наличие поля Unknown : UCHAR }
    SecurityRequired : UCHAR;
    Unknown : UCHAR;
    UnknownW : USHORT;
    Name : UNICODE_STRING;
    //Objects : SYSTEM_OBJECT_INFORMATION_ARRAY;
  end;
  PSYSTEM_OBJECT_TYPE_INFORMATION = ^SYSTEM_OBJECT_TYPE_INFORMATION;
  { Информация о файлах подкачки }
  SYSTEM_PAGEFILE_INFORMATION = packed record
    NextEntryOffset : ULONG;
    CurrentSize : ULONG;
    TotalUsed : ULONG;
    PeakUsed : ULONG;
    FileName : UNICODE_STRING;
  end;
  PSYSTEM_PAGEFILE_INFORMATION = ^SYSTEM_PAGEFILE_INFORMATION;
  { Информация об эмуляции команд виртуальной машиной ДОС }
  SYSTEM_INSTRUCTION_EMULATION_INFORMATION = packed record
    SegmentNotPresent : ULONG;
    TwoByteOpcode : ULONG;
    ESPrefix : ULONG;
    CSPrefix : ULONG;
    SSPrefix : ULONG;
    DSPrefix : ULONG;
    FSPrefix : ULONG;
    GSPrefix : ULONG;
    OPER32Prefix : ULONG;
    ADDR32Prefix : ULONG;
    INSB : ULONG;
    INSW : ULONG;
    OUTSB : ULONG;
    OUTSW : ULONG;
    PUSHFD : ULONG;
    POPFD: ULONG;
    INTnn : ULONG;
    INTO : ULONG;
    IRETD : ULONG;
    INBimm : ULONG;
    INWimm : ULONG;
    OUTBimm : ULONG;
    OUTWimm : ULONG;
    INB : ULONG;
    INW : ULONG;
    OUTB : ULONG;
    OUTW : ULONG;
    LOCKPrefix : ULONG;
    REPNEPrefix : ULONG;
    REPPrefix : ULONG;
    HLT : ULONG;
    CLI : ULONG;
    STI : ULONG;
    GenericInvalidOpcode : ULONG;
  end;
  PSYSTEM_INSTRUCTION_EMULATION_INFORMATION =
      ^SYSTEM_INSTRUCTION_EMULATION_INFORMATION;
  { Информация о рабочем наборе системы }
  SYSTEM_CACHE_INFORMATION = packed record
    SystemCacheWsSize : ULONG;
    SystemCacheWsPeakSize : ULONG;
    SystemCacheWsFaults : ULONG;
    SystemCacheWsMinimum : ULONG;
    SystemCacheWsMaximum : ULONG;
    TransitionSharedPages : ULONG;
    TransitionSharedPagesPeak : ULONG;
    Reserved : array[0..1] of ULONG;
  end;
  PSYSTEM_CACHE_INFORMATION = ^SYSTEM_CACHE_INFORMATION;
  { Информация об использовании памяти с включенными тегами }
  SYSTEM_POOL_TAG_INFORMATION = packed record
    Tag : array[0..3] of Char;
    PagedPoolAllocs : ULONG;
    PagedPoolFrees : ULONG;
    PagedPoolUsage : ULONG;
    NonPagedPoolAllocs : ULONG;
    NonPagedPoolFrees : ULONG;
    NonPagedPoolUsage : ULONG;
  end;
  PSYSTEM_POOL_TAG_INFORMATION = ^SYSTEM_POOL_TAG_INFORMATION;
  SYSTEM_POOL_TAG_INFORMATION_ARRAY = array[0..16384] of
                                    SYSTEM_POOL_TAG_INFORMATION;
  { Массив информации для класса SystemPoolTagInformation }
  SYSTEM_POOL_TAGS_INFORMATION = packed record
    Count : ULONG;
    Data : SYSTEM_POOL_TAG_INFORMATION_ARRAY;
  end;
  { Информация о статистике использования процессора системой }
  { В этом информационном классе возвращается массив структур, размер массива
    равен числу процессоров в системе }
  SYSTEM_PROCESSOR_STATISTICS = packed record
    ContextSwitches : ULONG;
    DpcCount : ULONG;
    DpcRequestRate : ULONG;
    TimeIncrement : ULONG;
    DpcBypassCount : ULONG;
    ApcBypassCount : ULONG;
  end;
  PSYSTEM_PROCESSOR_STATISTICS = ^SYSTEM_PROCESSOR_STATISTICS;
  { Информация об отложенных вызовах процедур (DPC) }
  SYSTEM_DPC_INFORMATION = packed record
    Reserved : ULONG;
    MaximumDpcQueueDepth : ULONG;
    MaximumDpcRate : ULONG;
    AdjustDpcThreshold : ULONG;
    IdealDpcRate : ULONG;
  end;
  PSYSTEM_DPC_INFORMATION = ^SYSTEM_DPC_INFORMATION;
  { Загрузка драйвера режима ядра. Этот класс информации используется только при
    установке и может быть вызван только из режима ядра }
  SYSTEM_LOAD_IMAGE = packed record
    ModuleName : UNICODE_STRING;
    ModuleBase : PVOID;
    Unknown : PVOID;
    EntryPoint : PVOID;
    ExportDirectory : PVOID;
  end;
  PSYSTEM_LOAD_IMAGE = ^SYSTEM_LOAD_IMAGE;
  { Выгрузка драйвера режима ядра. Ограничения те же самые, что и при загрузке }
  SYSTEM_UNLOAD_IMAGE = packed record
    ModuleBase : PVOID;
  end;
  { Информация о разрешении системного таймера }
  SYSTEM_TIME_ADJUSTMENT = packed record
    TimeAdjustment: ULONG;
    MaximumIncrement : ULONG;
    TimeSynchronization : BOOLEAN;
    Filler : array[0..2] of Char;
  end;
  PSYSTEM_TIME_ADJUSTMENT = ^SYSTEM_TIME_ADJUSTMENT;
  { Информация о дампе аварийного завершения }
  SYSTEM_CRASH_DUMP_INFORMATION_NT2000 = packed record
    CrashDumpSectionHandle : THandle;
    Unknown : THandle; //Только в Windows 2000
  end;
  PSYSTEM_CRASH_DUMP_INFORMATION_NT2000 = ^SYSTEM_CRASH_DUMP_INFORMATION_NT2000;
  { Информация о дампе аварийного завершения для Windows NT4 }
  SYSTEM_CRASH_DUMP_INFORMATION_NT4 = packed record
    CrashDumpSectionHandle : THandle;
  end;
  PSYSTEM_CRASH_DUMP_INFORMATION_NT4 = ^SYSTEM_CRASH_DUMP_INFORMATION_NT4;
  { Информация об исключениях }
  SYSTEM_EXCEPTION_INFORMATION = packed record
    AlignmentFixupCount : ULONG;
    ExceptionDispatchCount : ULONG;
    FloatingEmulationCount : ULONG;
    Reserved : ULONG;
  end;
  PSYSTEM_EXCEPTION_INFORMATION = ^SYSTEM_EXCEPTION_INFORMATION;
  { Информация о состоянии дампа аварийного завершения }
  SYSTEM_CRASH_DUMP_STATE_INFORMATION_NT2000 = packed record
    CrashDumpSectionExists : ULONG;
    Unknown : ULONG; //Только в Windows 2000
  end;
  PSYSTEM_CRASH_DUMP_STATE_INFORMATION_NT2000 =
    ^SYSTEM_CRASH_DUMP_STATE_INFORMATION_NT2000;
  { Информация о состоянии дампа аварийного завершения для Windows NT4 }
  SYSTEM_CRASH_DUMP_STATE_INFORMATION_NT4 = packed record
    CrashDumpSectionExists : ULONG;
  end;
  PSYSTEM_CRASH_DUMP_STATE_INFORMATION_NT4 =
    ^SYSTEM_CRASH_DUMP_STATE_INFORMATION_NT4;
  { Информация об отладчике ядра }
  SYSTEM_KERNEL_DEBUGGER_INFORMATION = packed record
    DebuggerEnabled : BOOLEAN;
    DebuggerNotPresent : BOOLEAN;
  end;
  PSYSTEM_KERNEL_DEBUGGER_INFORMATION = ^SYSTEM_KERNEL_DEBUGGER_INFORMATION;
  { Информация о счетчиках переключения контекста }
  SYSTEM_CONTEXT_SWITCH_INFORMATION = packed record
    ContextSwitches : ULONG;
    ContextSwitchCounters : array [0..10] of ULONG;
  end;
  PSYSTEM_CONTEXT_SWITCH_INFORMATION = ^SYSTEM_CONTEXT_SWITCH_INFORMATION;
  { Информация о квотах реестра в выгружаемом пуле }
  SYSTEM_REGISTRY_QUOTA_INFORMATION = packed record
    RegistryQuota : ULONG;
    RegistryQuotaInUse : ULONG;
    PagedPoolSize : ULONG;
  end;
  PSYSTEM_REGISTRY_QUOTA_INFORMATION = ^SYSTEM_REGISTRY_QUOTA_INFORMATION;
  { Загрузка и вызов драйвера режима ядра. Ограничения те же самые, что и для
    загрузки }
  SYSTEM_LOAD_AND_CALL_IMAGE = packed record
    ModuleName : UNICODE_STRING;
  end;
  PSYSTEM_LOAD_AND_CALL_IMAGE = ^SYSTEM_LOAD_AND_CALL_IMAGE;
  { Информация о плановых периодах выполнения приоритетного приложения }
  SYSTEM_PRIORITY_SEPARATION = packed record
    PrioritySeparation : ULONG;
  end;
  PSYSTEM_PRIORITY_SEPARATION = ^SYSTEM_PRIORITY_SEPARATION;
  { Информация о временной зоне }
  SYSTEM_TIME_ZONE_INFORMATION = packed record
    Bias : LongInt;
    StandardName : array[0..31] of WideChar;
    StandardDate : TIME_FIELDS;
    StandardBias : LongInt;
    DayLightName : array[0..31] of WideChar;
    DayLightDate : TIME_FIELDS;
    DayLightBias : LongInt;
  end;
  PSYSTEM_TIME_ZONE_INFORMATION = ^SYSTEM_TIME_ZONE_INFORMATION;
  { Информация об ассоциативных списках. Информация этого класса доступна только
    в режиме ядра (???) }
  SYSTEM_LOOKASIDE_INFORMATION = packed record
    Depth : USHORT;
    MaximumDepth : USHORT;
    TotalAllocates : ULONG;
    AllocateMisses : ULONG;
    TotalFrees : ULONG;
    FreeMisses : ULONG;
    PoolType : POOL_TYPE;
    Tag : ULONG;
    Size : ULONG;
  end;
  PSYSTEM_LOOKASIDE_INFORMATION = ^SYSTEM_LOOKASIDE_INFORMATION;
  { Информация о ошибке времени. Информационный класс SystemSetTimeSlipEvent
    допскает только установку. }
  SYSTEM_SET_TIME_SLIP_EVENT = packed record
    TimeSlipEvent : THandle;
  end;
  PSYSTEM_SET_TIME_SLIP_EVENT = ^SYSTEM_SET_TIME_SLIP_EVENT;
  { Создание сеанса Terminal Services. Допускает только установку }
  SYSTEM_CREATE_SESSION = packed record
    SessionId : ULONG;
  end;
  PSYSTEM_CREATE_SESSION = ^SYSTEM_CREATE_SESSION;
  { Удаление сеанса Terminal Services. Допускает только установку }
  SYSTEM_DELETE_SESSION = packed record
    SessionId : ULONG;
  end;
  PSYSTEM_DELETE_SESSION = ^SYSTEM_DELETE_SESSION;
  { Информация о базовом адресе ядра }
  SYSTEM_RANGE_START_INFORMATION = packed record
    SystemRangeStart : PVOID;
  end;
  PSYSTEM_RANGE_START_INFORMATION = ^SYSTEM_RANGE_START_INFORMATION;
  { Информация о процессах сеанса }
  SYSTEM_SESSION_PROCESSES_INFORMATION = packed record
    SessionId : ULONG;
    BufferSize : ULONG;
    Buffer : PVOID;
  end;
  PSYSTEM_SESSION_PROCESSES_INFORMATION = ^SYSTEM_SESSION_PROCESSES_INFORMATION;


const
{ Расшифровка KWAIT_REASON - коды причины ожидания потока }
  MIN_WAIT_REASON = 0;
  KWR_Executive = 0;
  KWR_FreePage  = 1;
  KWR_PageIn = 2;
  KWR_PoolAllocation = 3;
  KWR_DelayExecution = 4;
  KWR_Suspended = 5;
  KWR_UserRequest = 6;
  KWR_WrExecutive = 7;
  KWR_WrFreePage = 8;
  KWR_WrPageIn = 9;
  KWR_WrPoolAllocation = 10;
  KWR_WrDelayExecution = 11;
  KWR_WrSuspended = 12;
  KWR_WrUserRequest = 13;
  KWR_WrEventPair = 14;
  KWR_WrQueue = 15;
  KWR_WrLpcReceive = 16;
  KWR_WrLpcReply = 17;
  KWR_WrVirtualMemory = 18;
  KWR_WrPageOut = 19;
  KWR_WrRendezvous = 20;
  KWR_Spare2 = 21;
  KWR_Spare3 = 22;
  KWR_Spare4 = 23;
  KWR_Spare5 = 24;
  KWR_Spare6 = 25;
  KWR_WrKernel = 26;
  MAX_WAIT_REASON = 26;
{ Расшифровка THREAD_STATE - состояние потока }
  MIN_THREAD_STATE = 0;
  THREAD_STATE_INITIALIZED = 0;
  THREAD_STATE_READY = 1;
  THREAD_STATE_RUNNING = 2;
  THREAD_STATE_STANDBY = 3;
  THREAD_STATE_TERMINATED = 4;
  THREAD_STATE_WAIT = 5;
  THREAD_STATE_TRANSITION = 6;
  THREAD_STATE_UNKNOWN = 7;
  MAX_THREAD_STATE = 7;
{ Биты в GlobalFlag }
  FLG_STOP_ON_EXCEPTION = 1;
  FLG_SHOW_LDR_SNAPS = 2;
  FLG_DEBUG_INITIAL_COMMAND = 4;
  FLG_STOP_ON_HUNG_GUI = 8;
  FLG_HEAP_ENABLE_TAIL_CHECK = $10;
  FLG_HEAP_ENABLE_FREE_CHECK = $20;
  FLG_HEAP_VALIDATE_PARAMETERS = $40;
  FLG_HEAP_VALIDATE_ALL = $80;
  FLG_POOL_ENABLE_TAIL_CHECK = $100;
  FLG_POOL_ENABLE_FREE_CHECK = $200;
  FLG_POOL_ENABLE_TAGGING = $400;
  FLG_HEAP_ENABLE_TAGGING = $800;
  FLG_USER_STACK_TRACE_DB = $1000;
  FLG_KERNEL_STACK_TRACE_DB = $2000;
  FLG_MAINTAIN_OBJECT_TYPELIST = $4000;
  FLG_HEAP_ENABLE_TAG_BY_DLL = $8000;
  FLG_IGNORE_DEBUG_PRIV = $10000;
  FLG_ENABLE_CSRDEBUG = $20000;
  FLG_ENABLE_KDEBUG_SYMBOL_LOAD = $40000;
  FLG_DISABLE_PAGE_KERNEL_STACK = $80000;
  FLG_HEAP_ENABLE_CALL_TRACING = $100000;
  FLG_HEAP_DISABLE_COALESCING = $200000;
  FLG_ENABLE_CLOSE_EXCEPTIONS = $400000;
  FLG_ENABLE_EXCEPTION_LOGGING = $800000;
  FLG_ENABLE_DBGPRINT_BUFFERING = $8000000;
{ Pасшифровка POOL_TYPE }
  NonPagedPool = 0;
  PagedPool = 1;
  NonPagedPoolMustSucceed = 2;
  DontUseThisType = 3;
  NonPagedPoolCacheAligned = 4;
  PagedPoolCacheAligned = 5;
  NonPagedPoolCacheAlignedMustS = 6;

  NonPagedPoolSession = 32;
  PagedPoolSession = 33;
  NonPagedPoolMustSucceedSession = 34;
  DontUseThisTypeSession = 35;
  NonPagedPoolCacheAlignedSession = 36;
  PagedPoolCacheAlignedSession = 37;
  NonPagedPoolCacheAlignedMustSSession = 38;

{ Сбор информации об объекте }
function NtQueryObject (ObjectHandle : THandle;
              ObjectInformationClass : LongInt;
              ObjectInformation : Pointer; ObjectInformationLength : ULONG;
              ReturnLength : PDWORD) : Integer; stdcall;
{ Сбор информации о системе }
function NtQuerySystemInformation (SystemInformationClass : LongInt;
              SystemInformation : Pointer; SystemInformationLength : ULONG;
              ReturnLength : PDWORD) : Integer; stdcall;
{ Установка системной информации }
function NtSetSystemInformation (SystemInformationClass : LongInt;
              SystemInformation : Pointer;
              SystemInformationLength : ULONG) : Integer; stdcall;

{ Получение адреса Process Environment block }
function RtlGetCurrentPEB : Pointer;

{ Стандартая кодовая страница ANSI }
function NlsAnsiCodePage : WORD;
{ Заголовок PE-файла для указанного модуля }
function RtlImageNtHeader (hMod : HMODULE) : PImageNTHeaders; stdcall;
{ Преобразование строки из кодовой страницы Ansi или кодовой страницы,
  установленной по умолчанию в Unicode }
function RtlMultiByteToUnicodeN (Dest : PWideChar; MaxDestBufferSize : DWORD;
            PDestBufferSize : LPDWORD; Source : PAnsiChar;
            SourceSize : DWORD) : NTSTATUS; stdcall;
{ Вход в критическую секцию }
procedure RtlEnterCriticalSection (var Section : TRTLCriticalSection); stdcall;
{ Выход из критической секции }
procedure RtlLeaveCriticalSection (var Section : TRTLCriticalSection); stdcall;
{ Инициализация критической секции }
function RtlInitializeCriticalSection (
                        var Section : TRTLCriticalSection) : NTSTATUS; stdcall;


{ Преобразование времени из Int64 в набор полей }
procedure RtlTimeToTimeFields (ATime : PLARGE_INTEGER;
                               ATimeFields : PTIME_FIELDS); stdcall;

const
{ NtQueryObject object information class codes }
  ObjectBasicInformation = 0; { Базовая информация об объекте }
  ObjectNameInformation = 1; { Информация об имени объекта }
  ObjectTypeInformation = 2; { Информация об типе объекта }
  ObjectAllTypesInformation = 3; { Перечисление всех типов объектов
                                   (требует настройки GlobalFlags) }
  ObjectHandleInformation = 4; { Информация об атрибутах дескриптора объекта }
{ NtQuerySystemInformation/NtSetSystemInformation system information class codes }
  SystemBasicInformation = 0; { Базовая информация о системе }
  SystemProcessorInformation = 1; { Информация о процессоре }
  SystemPerformanceInformation = 2; { Информация о производительности }
  SystemTimeOfDayInformation = 3; { Информация о дате и времени }
  SystemProcessesAndThreadsInformation = 5; { Информация о процессах и потоках }
  SystemCallCounts = 6; { Информация о вызовах отладочной версии ядра }
  SystemConfigurationInformation = 7; { Информация о конфигурации }
  SystemProcessorTimes = 8; { }
  SystemGlobalFlag = 9; { }
  SystemModuleInfomation = 11; { }
  SystemLockInformation = 12; { }
  SystemPagedPoolInformation = 14; { Checked build only. TODO: Нет структуры }
  SystemNonPagedPoolInformation = 15; { Checked build only. TODO: Нет структуры}
  SystemHandleInformation = 16; { Информация о дескрипторах }
  SystemObjectInformation = 17; {}
  SystemPageFileinformation = 18; {}
  SystemInstructionEmulationCounts = 19; {}
  SystemCacheInformation = 21; {}
  SystemPoolTagInformation = 22; {}
  SystemProcessorStatistics = 23; {}
  SystemDpcInformation = 24; {}
  SystemLoadImage = 26; {}
  SystemUnloadImage = 27; {}
  SystemTimeAdjustment= 28; {}
  SystemCrashDumpInformation = 32; {}
  SystemExceptionInformation = 33; {}
  SystemCrashDumpStateInformation = 34; {}
  SystemKernelDebuggerInformation = 35; {}
  SystemContextSwitchInformation = 36; {}
  SystemRegistryQuotaInformation = 37; {}
  SystemLoadAndcallImage = 38; {}
  SystemPrioritySeparation = 39; {}
  SystemTimeZoneInformation = 44; {}
  SystemLookasideInformation = 45; {}
  SystemSetTimeSlipEvent = 46; {}
  SystemCreateSession = 47; {}
  SystemDeleteSession = 48; {}
  SystemRangeStartInformation = 50; {}
  SystemVerifierInformation = 51; {}
  SystemAddVerifier = 52; {}
  SystemSessionProcessesInformation = 53; {}

implementation
uses
  NtStatusDefs;

type
  TNtQueryQbject =
    function (ObjectHandle : THandle;
              ObjectInformationClass : LongInt;
              ObjectInformation : Pointer; ObjectInformationLength : ULONG;
              ReturnLength : PDWORD) : Integer; stdcall;
  TNtQuerySystemInformation =
    function (SystemInformationClass : LongInt;
              SystemInformation : Pointer; SystemInformationLength : ULONG;
              ReturnLength : PDWORD) : Integer; stdcall;
  TRtlImageNtHeader =
    function (hMod : HMODULE) : PImageNTHeaders; stdcall;
  TRtlMultiByteToUnicodeN =
    function (Dest : PWideChar; MaxDestBufferSize : DWORD;
            PDestBufferSize : LPDWORD; Source : PAnsiChar;
            SourceSize : DWORD) : NTSTATUS; stdcall;
  TRtlEnterCriticalSection =
    procedure (var Section : TRTLCriticalSection); stdcall;
  TRtlLeaveCriticalSection =
    procedure (var Section : TRTLCriticalSection); stdcall;
  TRtlInitializeCriticalSection =
    function (var Section : TRTLCriticalSection) : NTSTATUS; stdcall;
  TRtlTimeToTimeFields = procedure (ATime : PLARGE_INTEGER;
                               ATimeFields : PTIME_FIELDS); stdcall;
  TNtSetSystemInformation = function (SystemInformationClass : LongInt;
              SystemInformation : Pointer;
              SystemInformationLength : ULONG) : Integer; stdcall;

const
  ntdllname = 'ntdll.dll';

var
  NtdllHandle: THandle;
  _NtQueryObject : TNtQueryQbject;
  _NtQuerySystemInformation : TNtQuerySystemInformation;
  _NlsAnsiCodePage : PWORD;
  _RtlImageNtHeader : TRtlImageNtHeader;
  _RtlMultiByteToUnicodeN : TRtlMultiByteToUnicodeN;
  _RtlEnterCriticalSection : TRtlEnterCriticalSection;
  _RtlLeaveCriticalSection : TRtlLeaveCriticalSection;
  _RtlInitializeCriticalSection : TRtlInitializeCriticalSection;
  _RtlTimeToTimeFields : TRtlTimeToTimeFields;
  _NtSetSystemInformation : TNtSetSystemInformation;

function InitNT : Boolean;
var
  AOsVersionInfo : TOsVersionInfo;
begin
  if NtDllHandle = 0 then begin
    FillChar(AOsVersionInfo, Sizeof(AOsVersionInfo), 0);
    AOsVersionInfo.dwOSVersionInfoSize := Sizeof(AOsVersionInfo);
    if NOT GetVersionExA(AOsVersionInfo) then begin
      Result := false;
      Exit;
    end;
    if AOsVersionInfo.dwPlatformId = VER_PLATFORM_WIN32_NT then begin
      NtDllHandle := GetModuleHandle(ntdllname);
      if NtDllHandle <> 0 then begin
        @_NtQueryObject := GetProcAddress(NtDllHandle, 'NtQueryObject');
        @_NtQuerySystemInformation := GetProcAddress(NtDllHandle,
                                                  'NtQuerySystemInformation');
        _NlsAnsiCodePage := GetProcAddress(NtDllHandle, 'NlsAnsiCodePage');
        @_RtlImageNtHeader := GetProcAddress(NtDllHandle, 'RtlImageNtHeader');
        @_RtlMultiByteToUnicodeN := GetProcAddress(NtDllHandle,
                                                    'RtlMultiByteToUnicodeN');
        @_RtlEnterCriticalSection := GetProcAddress(NtDllHandle,
                                                    'RtlEnterCriticalSection');
        @_RtlLeaveCriticalSection := GetProcAddress(NtDllHandle,
                                                    'RtlLeaveCriticalSection');
        @_RtlInitializeCriticalSection := GetProcAddress(NtDllHandle,
                                                'RtlInitializeCriticalSection');
        @_RtlTimeToTimeFields := GetProcAddress(NtDllHandle,
                                                'RtlTimeToTimeFields');
        @_NtSetSystemInformation := GetProcAddress(NtDllHandle,
                                                'NtSetSystemInformation');
      end;
    end;
  end;
  Result := (NtDllHandle <> 0);
end;

function NtNotImplemented : Integer;
begin
  SetLastError(ERROR_CALL_NOT_IMPLEMENTED);
  Result := STATUS_NOT_IMPLEMENTED;
end;

function NlsAnsiCodePage : WORD;
begin
  if InitNt then
    Result := _NlsAnsiCodePage^
  else begin
    Result := 0;
    SetLastError(ERROR_CALL_NOT_IMPLEMENTED);
  end;
end;

function NtQueryObject (ObjectHandle : THandle;
              ObjectInformationClass : LongInt;
              ObjectInformation : Pointer; ObjectInformationLength : ULONG;
              ReturnLength : PDWORD) : Integer; stdcall;
begin
  if InitNt AND Assigned(_NtQueryObject) then
    Result := _NtQueryObject(ObjectHandle, ObjectInformationClass,
               ObjectInformation, ObjectInformationLength, ReturnLength)
  else
    Result := NtNotImplemented;
end;

function NtQuerySystemInformation (SystemInformationClass : LongInt;
              SystemInformation : Pointer; SystemInformationLength : ULONG;
              ReturnLength : PDWORD) : Integer; stdcall;
begin
  if InitNt AND Assigned(_NtQuerySystemInformation) then
    Result := _NtQuerySystemInformation(SystemInformationClass,
               SystemInformation, SystemInformationLength, ReturnLength)
  else
    Result := NtNotImplemented;
end;

{ Не будет работать в Windows 64 }
function RtlGetCurrentPEB : Pointer; assembler;
asm
  mov eax,fs:[$18]
  mov eax,[eax+$30]
end;

function RtlImageNtHeader (hMod : HMODULE) : PImageNTHeaders;
begin
  if InitNt AND Assigned(_RtlImageNtHeader) then
    Result := _RtlImageNtHeader(hMod)
  else begin
    SetLastError(ERROR_CALL_NOT_IMPLEMENTED);
    Result := nil;
  end;
end;

function RtlMultiByteToUnicodeN (Dest : PWideChar; MaxDestBufferSize : DWORD;
            PDestBufferSize : LPDWORD; Source : PAnsiChar;
            SourceSize : DWORD) : NTSTATUS;
begin
  if InitNt AND Assigned(_RtlMultiByteToUnicodeN) then
    Result := _RtlMultiByteToUnicodeN(Dest, MaxDestBufferSize, PDestBufferSize,
               Source, SourceSize)
  else
    Result := NtNotImplemented();
end;

{ Работа с критическими секциями }
function RtlInitializeCriticalSection (
  var Section : TRTLCriticalSection) : NTSTATUS;
begin
  if InitNt AND Assigned(_RtlInitializeCriticalSection) then
    Result := _RtlInitializeCriticalSection (Section)
  else
    Result := NtNotImplemented();
end;

procedure RtlEnterCriticalSection (var Section : TRTLCriticalSection);
begin
  if InitNt AND Assigned(_RtlEnterCriticalSection) then
    _RtlEnterCriticalSection (Section)
  else
    NtNotImplemented();
end;

procedure RtlLeaveCriticalSection (var Section : TRTLCriticalSection);
begin
  if InitNt AND Assigned(_RtlLeaveCriticalSection) then
    _RtlLeaveCriticalSection (Section)
  else
    NtNotImplemented();
end;

procedure RtlTimeToTimeFields (ATime : PLARGE_INTEGER;
                               ATimeFields : PTIME_FIELDS); stdcall;
begin
  if InitNt AND Assigned(_RtlTimeToTimeFields) then
    _RtlTimeToTimeFields (ATime, ATimeFields);
end;

function NtSetSystemInformation (SystemInformationClass : LongInt;
              SystemInformation : Pointer;
              SystemInformationLength : ULONG) : Integer; stdcall;
begin
  if InitNt AND Assigned(_NtSetSystemInformation) then
    Result := _NtSetSystemInformation(SystemInformationClass,
               SystemInformation, SystemInformationLength)
  else
    Result := NtNotImplemented;
end;

end.
