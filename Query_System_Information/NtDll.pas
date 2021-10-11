{
   ������: NtDll

   ��������: ��������� � ������������ ���������� NTDLL.DLL.
             �������� �������� � ���������� ������� ��������� �� ������
             ���������� �� ����� ���� ������� "���������� �� ������� ��������
             API Windows NT/2000",
             �������� ������� ��������� NTINFO ����� �������� (������� Digitman)
             MSDN (http://msdn.microsoft.com)
             � ����������� ������������.

   �����: ����� ��������

   ���� ��������: 31.08.2002

   ������� ���������:
   03.09.2002 ��������� ������� RtlGetCurrentPEB
   15.12.2002 ��������� ���������� �� ������ ���� (HsUserNt, CsrTest)
   18.12.2002 ��������� ������ TIME_FIELDS � ������� RtlTimeToTimeFields;
   23.12.2002 ��������� ������� NtSetSystemInformation
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

{ ������� ���������� �� ������� }
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
{ ���������� � ���� ������� - ���������� ����� }
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
{ ���������� �� ����� ������� - ���������� ����� }
  TOBJECT_NAME_INFORMATION = packed record
    Name : TUNICODE_STRING;
  end;
  POBJECT_NAME_INFORMATION = ^TOBJECT_NAME_INFORMATION;
{ ������� ���������� � ������� }
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
{ ���������� � ���������� }
  SYSTEM_PROCESSOR_INFORMATION = packed record
    ProcessorArchitecture : USHORT;
    ProcessorLevel : USHORT;
    ProcessorRevision : USHORT;
    Unknown : USHORT;
    FeatureBits : ULONG;
  end;
  PSYSTEM_PROCESSOR_INFORMATION = ^SYSTEM_PROCESSOR_INFORMATION;
{ ���� ���������� � ���������� }
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
{ ������ ������� (��������� ���������� SYSTEMTIME � Win32 API }
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
{ ���������� � ������������������ ������� }
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
{ ���������� � ������� ������� � ������� ����� }
  SYSTEM_TIME_OF_DAY_INFORMATION = packed record
    BootTime : LARGE_INTEGER;
    CurrentTime : LARGE_INTEGER;
    TimeZoneBias : LARGE_INTEGER;
    CurrentTimeZoneId : ULONG;
    Reserved : ULONG;
  end;
  PSYSTEM_TIME_OF_DAY_INFORMATION = ^SYSTEM_TIME_OF_DAY_INFORMATION;
{ ���������� � ��������� � ������� }
  THREAD_STATE = Integer;

  KWAIT_REASON = Integer;

  KPRIORITY = Integer;

  POOL_TYPE = Integer;

  { �������� ������ }
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

  { �������� ����������� ������ }
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

  {�������� �����-������. ��� ��������� ���������� ������ � Windows 2000 � ����}
  IO_COUNTERS = packed record
    ReadOperationCount : LARGE_INTEGER;
    WriteOperationCount : LARGE_INTEGER;
    OtherOperationCount : LARGE_INTEGER;
    ReadTransferCount : LARGE_INTEGER;
    WriteTransferCount : LARGE_INTEGER;
    OtherTransferCount : LARGE_INTEGER;
  end;

  { ���������� � �������� ��� Windows 2000 � ���� }
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

  { ���������� � �������� ��� Windows NT 4 (���������� �� ����������� ���������
    ��� Windows 2000 ����������� IoCounters) }
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
  { ���������� � ���������� ��������� ������� (������ ��� ����������� ������
    ���� }
  SYSTEM_CALLS_INFORMATION = packed record
    Size : ULONG;
    NumberOfDescriprorTables : ULONG;
    NumberOfRoutinesInTable : array[0..0] of ULONG;
    //CallCounts : array[0..] of ULONG;
  end;
  PSYSTEM_CALLS_INFORMATION = ^SYSTEM_CALLS_INFORMATION;
  { ���������� �� ���������� ������������ ������� }
  SYSTEM_CONFIGURATION_INFORMATION = packed record
    DiskCount : ULONG;
    FloppyCount : ULONG;
    CdRomCount : ULONG;
    TapeCount : ULONG;
    SerialCount : ULONG;
    ParallelCount : ULONG;
  end;
  PSYSTEM_CONFIGURATION_INFORMATION = ^SYSTEM_CONFIGURATION_INFORMATION;
  { ���������� � ������� ������ ���������� � ��������� �������. ��� �������
    ���������� � ������� ������������ �� ��������� }
  SYSTEM_PROCESSOR_TIMES = packed record
    IdleTime : LARGE_INTEGER;
    KernelTime : LARGE_INTEGER;
    UserTime : LARGE_INTEGER;
    DpcTime : LARGE_INTEGER;
    InterruptTime : LARGE_INTEGER;
    InterruptCount : ULONG;
  end;
  PSYSTEM_PROCESSOR_TIMES = ^SYSTEM_PROCESSOR_TIMES;
  { ���������� � ���������� ���������� ������� }
  SYSTEM_GLOBAL_FLAG = packed record
    GlobalFlag : ULONG;
  end;
  PSYSTEM_GLOBAL_FLAG = ^SYSTEM_GLOBAL_FLAG;
  { ���������� � ����������� ������� ������ ���� }
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
  { ������ ���������� ��� ������ SystemLockInformation }
  SYSTEM_MODULES_INFORMATION = packed record
    Count : ULONG;
    Data : SYSTEM_MODULE_INFORMATION_ARRAY;
  end;
  PSYSTEM_MODULES_INFORMATION = ^SYSTEM_MODULES_INFORMATION;
  
  { ���������� � ����������� ������� }
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
  { ������ ���������� ��� ������ SystemLockInformation }
  SYSTEM_LOCKS_INFORMATION = packed record
    Count : ULONG;
    Data : SYSTEM_LOCK_INFORMATION_ARRAY;
  end;
  PSYSTEM_LOCKS_INFORMATION = ^SYSTEM_LOCKS_INFORMATION;

{ ���������� � ����������� }
  SYSTEM_HANDLE_INFORMATION = packed record
    PID : ULONG;        { ������������� ��������, ���������� ������ ������������ }
    ObjectType : UCHAR; { ��� �������, ����������������� ������ ������������ }
    Flags : UCHAR;      { ����� ����������� }
    Handle : USHORT;    { �������� ����������� }
    FObject : PVOID;    { ����� �������, ����������������� ������ ������������ }
    GrantedAccess : ACCESS_MASK; { ������� ������� � �������, ���������������
                                   � ������ �������� ������� ����������� }
  end;
  PSYSTEM_HANDLE_INFORMATION = ^SYSTEM_HANDLE_INFORMATION;
  SYSTEM_HANDLE_INFORMATION_ARRAY = array[0..16384] of SYSTEM_HANDLE_INFORMATION;
  { ������ ���������� ��� ������ SystemHandleInformation }
  SYSTEM_HANDLES_INFORMATION = packed record
    Count : ULONG;
    Data : SYSTEM_HANDLE_INFORMATION_ARRAY;
  end;
  PSYSTEM_HANDLES_INFORMATION = ^SYSTEM_HANDLES_INFORMATION;
  { ���������� �� �������� �������� ������ � ��� ������, ���� � �������
    ���������� ���������� ���� FLG_MAINTAIN_OBJECT_TYPELIST }
  { ���������� �� �������� }
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

  { ���������� �  ���� ������� }
  SYSTEM_OBJECT_TYPE_INFORMATION = packed record
    NextEntryOffset : ULONG;
    ObjectCount : ULONG;
    HandleCount : ULONG;
    TypeNumber : ULONG;
    InvalidAttributes : ULONG;
    GenericMapping : GENERIC_MAPPING;
    ValidAccessMask : ACCESS_MASK;
    PoolType : POOL_TYPE;
    { ���� �������. ������ ������������ ������ ������� ���� Unknown : UCHAR }
    SecurityRequired : UCHAR;
    Unknown : UCHAR;
    UnknownW : USHORT;
    Name : UNICODE_STRING;
    //Objects : SYSTEM_OBJECT_INFORMATION_ARRAY;
  end;
  PSYSTEM_OBJECT_TYPE_INFORMATION = ^SYSTEM_OBJECT_TYPE_INFORMATION;
  { ���������� � ������ �������� }
  SYSTEM_PAGEFILE_INFORMATION = packed record
    NextEntryOffset : ULONG;
    CurrentSize : ULONG;
    TotalUsed : ULONG;
    PeakUsed : ULONG;
    FileName : UNICODE_STRING;
  end;
  PSYSTEM_PAGEFILE_INFORMATION = ^SYSTEM_PAGEFILE_INFORMATION;
  { ���������� �� �������� ������ ����������� ������� ��� }
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
  { ���������� � ������� ������ ������� }
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
  { ���������� �� ������������� ������ � ����������� ������ }
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
  { ������ ���������� ��� ������ SystemPoolTagInformation }
  SYSTEM_POOL_TAGS_INFORMATION = packed record
    Count : ULONG;
    Data : SYSTEM_POOL_TAG_INFORMATION_ARRAY;
  end;
  { ���������� � ���������� ������������� ���������� �������� }
  { � ���� �������������� ������ ������������ ������ ��������, ������ �������
    ����� ����� ����������� � ������� }
  SYSTEM_PROCESSOR_STATISTICS = packed record
    ContextSwitches : ULONG;
    DpcCount : ULONG;
    DpcRequestRate : ULONG;
    TimeIncrement : ULONG;
    DpcBypassCount : ULONG;
    ApcBypassCount : ULONG;
  end;
  PSYSTEM_PROCESSOR_STATISTICS = ^SYSTEM_PROCESSOR_STATISTICS;
  { ���������� �� ���������� ������� �������� (DPC) }
  SYSTEM_DPC_INFORMATION = packed record
    Reserved : ULONG;
    MaximumDpcQueueDepth : ULONG;
    MaximumDpcRate : ULONG;
    AdjustDpcThreshold : ULONG;
    IdealDpcRate : ULONG;
  end;
  PSYSTEM_DPC_INFORMATION = ^SYSTEM_DPC_INFORMATION;
  { �������� �������� ������ ����. ���� ����� ���������� ������������ ������ ���
    ��������� � ����� ���� ������ ������ �� ������ ���� }
  SYSTEM_LOAD_IMAGE = packed record
    ModuleName : UNICODE_STRING;
    ModuleBase : PVOID;
    Unknown : PVOID;
    EntryPoint : PVOID;
    ExportDirectory : PVOID;
  end;
  PSYSTEM_LOAD_IMAGE = ^SYSTEM_LOAD_IMAGE;
  { �������� �������� ������ ����. ����������� �� �� �����, ��� � ��� �������� }
  SYSTEM_UNLOAD_IMAGE = packed record
    ModuleBase : PVOID;
  end;
  { ���������� � ���������� ���������� ������� }
  SYSTEM_TIME_ADJUSTMENT = packed record
    TimeAdjustment: ULONG;
    MaximumIncrement : ULONG;
    TimeSynchronization : BOOLEAN;
    Filler : array[0..2] of Char;
  end;
  PSYSTEM_TIME_ADJUSTMENT = ^SYSTEM_TIME_ADJUSTMENT;
  { ���������� � ����� ���������� ���������� }
  SYSTEM_CRASH_DUMP_INFORMATION_NT2000 = packed record
    CrashDumpSectionHandle : THandle;
    Unknown : THandle; //������ � Windows 2000
  end;
  PSYSTEM_CRASH_DUMP_INFORMATION_NT2000 = ^SYSTEM_CRASH_DUMP_INFORMATION_NT2000;
  { ���������� � ����� ���������� ���������� ��� Windows NT4 }
  SYSTEM_CRASH_DUMP_INFORMATION_NT4 = packed record
    CrashDumpSectionHandle : THandle;
  end;
  PSYSTEM_CRASH_DUMP_INFORMATION_NT4 = ^SYSTEM_CRASH_DUMP_INFORMATION_NT4;
  { ���������� �� ����������� }
  SYSTEM_EXCEPTION_INFORMATION = packed record
    AlignmentFixupCount : ULONG;
    ExceptionDispatchCount : ULONG;
    FloatingEmulationCount : ULONG;
    Reserved : ULONG;
  end;
  PSYSTEM_EXCEPTION_INFORMATION = ^SYSTEM_EXCEPTION_INFORMATION;
  { ���������� � ��������� ����� ���������� ���������� }
  SYSTEM_CRASH_DUMP_STATE_INFORMATION_NT2000 = packed record
    CrashDumpSectionExists : ULONG;
    Unknown : ULONG; //������ � Windows 2000
  end;
  PSYSTEM_CRASH_DUMP_STATE_INFORMATION_NT2000 =
    ^SYSTEM_CRASH_DUMP_STATE_INFORMATION_NT2000;
  { ���������� � ��������� ����� ���������� ���������� ��� Windows NT4 }
  SYSTEM_CRASH_DUMP_STATE_INFORMATION_NT4 = packed record
    CrashDumpSectionExists : ULONG;
  end;
  PSYSTEM_CRASH_DUMP_STATE_INFORMATION_NT4 =
    ^SYSTEM_CRASH_DUMP_STATE_INFORMATION_NT4;
  { ���������� �� ��������� ���� }
  SYSTEM_KERNEL_DEBUGGER_INFORMATION = packed record
    DebuggerEnabled : BOOLEAN;
    DebuggerNotPresent : BOOLEAN;
  end;
  PSYSTEM_KERNEL_DEBUGGER_INFORMATION = ^SYSTEM_KERNEL_DEBUGGER_INFORMATION;
  { ���������� � ��������� ������������ ��������� }
  SYSTEM_CONTEXT_SWITCH_INFORMATION = packed record
    ContextSwitches : ULONG;
    ContextSwitchCounters : array [0..10] of ULONG;
  end;
  PSYSTEM_CONTEXT_SWITCH_INFORMATION = ^SYSTEM_CONTEXT_SWITCH_INFORMATION;
  { ���������� � ������ ������� � ����������� ���� }
  SYSTEM_REGISTRY_QUOTA_INFORMATION = packed record
    RegistryQuota : ULONG;
    RegistryQuotaInUse : ULONG;
    PagedPoolSize : ULONG;
  end;
  PSYSTEM_REGISTRY_QUOTA_INFORMATION = ^SYSTEM_REGISTRY_QUOTA_INFORMATION;
  { �������� � ����� �������� ������ ����. ����������� �� �� �����, ��� � ���
    �������� }
  SYSTEM_LOAD_AND_CALL_IMAGE = packed record
    ModuleName : UNICODE_STRING;
  end;
  PSYSTEM_LOAD_AND_CALL_IMAGE = ^SYSTEM_LOAD_AND_CALL_IMAGE;
  { ���������� � �������� �������� ���������� ������������� ���������� }
  SYSTEM_PRIORITY_SEPARATION = packed record
    PrioritySeparation : ULONG;
  end;
  PSYSTEM_PRIORITY_SEPARATION = ^SYSTEM_PRIORITY_SEPARATION;
  { ���������� � ��������� ���� }
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
  { ���������� �� ������������� �������. ���������� ����� ������ �������� ������
    � ������ ���� (???) }
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
  { ���������� � ������ �������. �������������� ����� SystemSetTimeSlipEvent
    �������� ������ ���������. }
  SYSTEM_SET_TIME_SLIP_EVENT = packed record
    TimeSlipEvent : THandle;
  end;
  PSYSTEM_SET_TIME_SLIP_EVENT = ^SYSTEM_SET_TIME_SLIP_EVENT;
  { �������� ������ Terminal Services. ��������� ������ ��������� }
  SYSTEM_CREATE_SESSION = packed record
    SessionId : ULONG;
  end;
  PSYSTEM_CREATE_SESSION = ^SYSTEM_CREATE_SESSION;
  { �������� ������ Terminal Services. ��������� ������ ��������� }
  SYSTEM_DELETE_SESSION = packed record
    SessionId : ULONG;
  end;
  PSYSTEM_DELETE_SESSION = ^SYSTEM_DELETE_SESSION;
  { ���������� � ������� ������ ���� }
  SYSTEM_RANGE_START_INFORMATION = packed record
    SystemRangeStart : PVOID;
  end;
  PSYSTEM_RANGE_START_INFORMATION = ^SYSTEM_RANGE_START_INFORMATION;
  { ���������� � ��������� ������ }
  SYSTEM_SESSION_PROCESSES_INFORMATION = packed record
    SessionId : ULONG;
    BufferSize : ULONG;
    Buffer : PVOID;
  end;
  PSYSTEM_SESSION_PROCESSES_INFORMATION = ^SYSTEM_SESSION_PROCESSES_INFORMATION;


const
{ ����������� KWAIT_REASON - ���� ������� �������� ������ }
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
{ ����������� THREAD_STATE - ��������� ������ }
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
{ ���� � GlobalFlag }
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
{ P���������� POOL_TYPE }
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

{ ���� ���������� �� ������� }
function NtQueryObject (ObjectHandle : THandle;
              ObjectInformationClass : LongInt;
              ObjectInformation : Pointer; ObjectInformationLength : ULONG;
              ReturnLength : PDWORD) : Integer; stdcall;
{ ���� ���������� � ������� }
function NtQuerySystemInformation (SystemInformationClass : LongInt;
              SystemInformation : Pointer; SystemInformationLength : ULONG;
              ReturnLength : PDWORD) : Integer; stdcall;
{ ��������� ��������� ���������� }
function NtSetSystemInformation (SystemInformationClass : LongInt;
              SystemInformation : Pointer;
              SystemInformationLength : ULONG) : Integer; stdcall;

{ ��������� ������ Process Environment block }
function RtlGetCurrentPEB : Pointer;

{ ���������� ������� �������� ANSI }
function NlsAnsiCodePage : WORD;
{ ��������� PE-����� ��� ���������� ������ }
function RtlImageNtHeader (hMod : HMODULE) : PImageNTHeaders; stdcall;
{ �������������� ������ �� ������� �������� Ansi ��� ������� ��������,
  ������������� �� ��������� � Unicode }
function RtlMultiByteToUnicodeN (Dest : PWideChar; MaxDestBufferSize : DWORD;
            PDestBufferSize : LPDWORD; Source : PAnsiChar;
            SourceSize : DWORD) : NTSTATUS; stdcall;
{ ���� � ����������� ������ }
procedure RtlEnterCriticalSection (var Section : TRTLCriticalSection); stdcall;
{ ����� �� ����������� ������ }
procedure RtlLeaveCriticalSection (var Section : TRTLCriticalSection); stdcall;
{ ������������� ����������� ������ }
function RtlInitializeCriticalSection (
                        var Section : TRTLCriticalSection) : NTSTATUS; stdcall;


{ �������������� ������� �� Int64 � ����� ����� }
procedure RtlTimeToTimeFields (ATime : PLARGE_INTEGER;
                               ATimeFields : PTIME_FIELDS); stdcall;

const
{ NtQueryObject object information class codes }
  ObjectBasicInformation = 0; { ������� ���������� �� ������� }
  ObjectNameInformation = 1; { ���������� �� ����� ������� }
  ObjectTypeInformation = 2; { ���������� �� ���� ������� }
  ObjectAllTypesInformation = 3; { ������������ ���� ����� ��������
                                   (������� ��������� GlobalFlags) }
  ObjectHandleInformation = 4; { ���������� �� ��������� ����������� ������� }
{ NtQuerySystemInformation/NtSetSystemInformation system information class codes }
  SystemBasicInformation = 0; { ������� ���������� � ������� }
  SystemProcessorInformation = 1; { ���������� � ���������� }
  SystemPerformanceInformation = 2; { ���������� � ������������������ }
  SystemTimeOfDayInformation = 3; { ���������� � ���� � ������� }
  SystemProcessesAndThreadsInformation = 5; { ���������� � ��������� � ������� }
  SystemCallCounts = 6; { ���������� � ������� ���������� ������ ���� }
  SystemConfigurationInformation = 7; { ���������� � ������������ }
  SystemProcessorTimes = 8; { }
  SystemGlobalFlag = 9; { }
  SystemModuleInfomation = 11; { }
  SystemLockInformation = 12; { }
  SystemPagedPoolInformation = 14; { Checked build only. TODO: ��� ��������� }
  SystemNonPagedPoolInformation = 15; { Checked build only. TODO: ��� ���������}
  SystemHandleInformation = 16; { ���������� � ������������ }
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

{ �� ����� �������� � Windows 64 }
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

{ ������ � ������������ �������� }
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
