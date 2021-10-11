{
   Модуль: Main

   Описание: Демонстрация использования функции NtQuerySystemInformation.
             Показан запрос некоторых информационных классов и отображение
             полученной информации.
             Интерфейс программы специально сделан англоязычным для упрощения
             переноса проекта из Delphi 6 personal (где он изначально создан)
             в младшие версии Delphi.

             При указании в условиях компиляции символа EXPLORE_INFOCLASS,
             производится вызов всех информационных классов от 0 до 127.
             Результат вызова NtQuerySsytemInformation добавляется в дерево
             в виде № класса, код возврата, длина возвращаемой информации.
             Таким образом, возможно определить максимально возможный
             информационный класс, поддерживаемый системой (в Windows XP Pro
             без Service Pack 1, максимальный класс равен 65, к примеру).

             Не все информационный классы возвращают длину информации, для
             дальнейших исследований можно воспользоваться методом последо-
             вательных приближений к требуемому размеру буфера для информации,
             по аналогии с тем, как сделано в функции QueryListInformation

   Автор: Игорь Шевченко

   Дата создания: 16.12.2002

   История изменений:
}
unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, HsNtDef, Menus, HSSystemInformation;

type
{ Класс для хранения информации, буфер которой не выделяется
  динамически и не нуждается в освобождении }
  TSystemStaticInfo = class
  protected
    procedure ClearData; virtual;
  public
    Index : Integer;
    rc : NTSTATUS;
    Length : DWORD;
    Data : Pointer;

    constructor Create (AIndex : Integer; Arc : NTSTATUS; ALength : DWORD);
    constructor CreateArg (AIndex : Integer; Arc : NTSTATUS;
                           ALength : DWORD; AData : Pointer);
    destructor Destroy; override;
  end;

{ Класс для хранения в дереве фиксированной информации, буфер под которую
  выделяется динамически }
  TSystemInfo = class (TSystemStaticInfo)
  protected
    procedure ClearData; override;
  end;

{ Класс для хранения в дереве информации переменной длины, представленной
  классом-списком }
  TSystemListInfo = class(TSystemInfo)
  protected
    procedure ClearData; override;
  public
    List : TObject;
  end;

  TfMain = class(TForm)
    TreeView: TTreeView;
    Splitter1: TSplitter;
    PanelDetail: TPanel;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Exit1: TMenuItem;
    N1: TMenuItem;
    About1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure TreeViewChange(Sender: TObject; Node: TTreeNode);
    procedure Exit1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FRoot : TTreeNode;
    FLastDisplay : TCustomForm;
    FHSSystemInformation : THSSystemInformation;
    procedure GatherData;
    procedure AddResult (Index : Integer; const AInfoClassName : String;
                         AObject : TObject = nil);
    procedure AddRawResult (Index : Integer; rc : NTSTATUS; ALength : DWORD;
                         AObject : TObject = nil);
    procedure DisplaySystemInfo (ASystemInfo : TSystemStaticInfo);
  end;

var
  fMain: TfMain;

implementation
uses
  NtDll, NtStatusDefs, AbstractDisplay, About, NtProcessInfo;

{$R *.dfm}

{ Соответствие классов информации и форм, отображающих данные этих классов }
const DisplayNames : array[SystemBasicInformation..
                           SystemSessionProcessesInformation]
         of String = (
  'TfBasicInfoDisplay',
  'TfProcessorInfoDisplay',
  'TfPerformanceInfoDisplay',
  'TfTimeOfDayDisplay',
  '',  //4
  'TfProcessesAndThreadsDisplay',
  '',  //SystemCallCounts = 6
  'TfConfigurationDisplay',
  '', //SystemProcessorTimes = 8;
  '', //SystemGlobalFlag = 9;
  '', //10
  '', //SystemModuleInfomation = 11;
  '', //SystemLockInformation = 12;
  '', //13
  '', //SystemPagedPoolInformation = 14;
  '', //SystemNonPagedPoolInformation = 15;
  '', //SystemHandleInformation = 16;
  '', //SystemObjectInformation = 17;
  '', //SystemPageFileinformation = 18;
  '', //SystemInstructionEmulationCounts = 19;
  '', //20
  'TfCacheDisplay',
  '', //SystemPoolTagInformation = 22;
  '', //SystemProcessorStatistics = 23;
  '', //SystemDpcInformation = 24;
  '', //25
  '', //SystemLoadImage = 26;
  '', //SystemUnloadImage = 27;
  'TfTimeAdjustmentDisplay', //SystemTimeAdjustment= 28;
  '', //29
  '', //30
  '', //31
  '', //SystemCrashDumpInformation = 32;
  '', //SystemExceptionInformation = 33;
  '', //SystemCrashDumpStateInformation = 34;
  '', //SystemKernelDebuggerInformation = 35;
  '', //SystemContextSwitchInformation = 36;
  '', //SystemRegistryQuotaInformation = 37;
  '', //SystemLoadAndcallImage = 38;
  '', //SystemPrioritySeparation = 39;
  '', //40
  '', //41
  '', //42
  '', //43
  '', //SystemTimeZoneInformation = 44;
  '', //SystemLookasideInformation = 45;
  '', //SystemSetTimeSlipEvent = 46;
  '', //SystemCreateSession = 47;
  '', //SystemDeleteSession = 48;
  '', //49
  '', //SystemRangeStartInformation = 50;
  '', //SystemVerifierInformation = 51;
  '', //SystemAddVerifier = 52;
  ''  //SystemSessionProcessesInformation = 53;
);

{ Запрос информации переменной длины }

function QueryListInformation (InfoClass : Integer; var rc : NTSTATUS;
                               var ReturnLength : DWORD) : Pointer;
var
  ListSize : Integer;
begin
  ListSize := $400; { Начальный размер буфера }

  GetMem(Result, ListSize);
  rc := NtQuerySystemInformation(InfoClass, Result,
                                 ListSize, @ReturnLength);
  while (rc = STATUS_INFO_LENGTH_MISMATCH) do begin
    FreeMem(Result);
    ListSize := ListSize * 2;
    GetMem(Result, ListSize);
    rc := NtQuerySystemInformation(InfoClass, Result,
                                   ListSize, @ReturnLength);
  end;
  if (rc <> STATUS_SUCCESS) then begin
    FreeMem(Result);
    Result := nil;
  end;
end;

{ TSystemStaticInfo }

procedure TSystemStaticInfo.ClearData;
begin
  //Do notning
end;

constructor TSystemStaticInfo.Create (AIndex : Integer; Arc : NTSTATUS;
  ALength : DWORD);
begin
  inherited Create();
  Index := AIndex;
  rc := Arc;
  Length := ALength;
end;

constructor TSystemStaticInfo.CreateArg (AIndex : Integer; Arc : NTSTATUS;
  ALength : DWORD; AData : Pointer);
begin
  inherited Create();
  Index := AIndex;
  rc := Arc;
  Length := ALength;
  Data := AData;
end;

destructor TSystemStaticInfo.Destroy;
begin
  ClearData();
  inherited;
end;

{ TSystemInfo }

procedure TSystemInfo.ClearData;
begin
  if Assigned(Data) then
    FreeMem(Data);
end;

{ TSystemListInfo }

procedure TSystemListInfo.ClearData;
begin
  List.Free();
  inherited;
end;

{ TfMain }

procedure TfMain.GatherData;
var
{$IFDEF EXPLORE_INFOCLASS}
  I : Integer;
{$ENDIF}
  rc : NTSTATUS;
  SystemListInfo : TSystemListInfo;
  InfoData : Pointer;
  ReturnLength : ULONG;
begin
  FRoot := TreeView.Items.Add(nil, 'NtQuerySystemInformation');
  InfoData := FHSSystemInformation.SystemBasicInformation;
  if InfoData <> nil then
    AddResult (SystemBasicInformation, 'SystemBasicInformation',
               TSystemStaticInfo.CreateArg(SystemBasicInformation,
                         STATUS_SUCCESS, FHSSystemInformation.LastReturnLength,
                         InfoData));
  InfoData := FHSSystemInformation.SystemProcessorInformation;
  if InfoData <> nil then
    AddResult (SystemProcessorInformation, 'SystemProcessorInformation',
               TSystemStaticInfo.CreateArg(SystemProcessorInformation,
                         STATUS_SUCCESS, FHSSystemInformation.LastReturnLength,
                         InfoData));
  InfoData := FHSSystemInformation.SystemPerformanceInformation;
  if InfoData <> nil then
    AddResult (SystemPerformanceInformation, 'SystemPerformanceInformation',
               TSystemStaticInfo.CreateArg(SystemPerformanceInformation,
                         STATUS_SUCCESS, FHSSystemInformation.LastReturnLength,
                         InfoData));
  InfoData := FHSSystemInformation.SystemTimeOfDayInformation;
  if InfoData <> nil then
    AddResult (SystemTimeOfDayInformation, 'SystemTimeOfDayInformation',
               TSystemStaticInfo.CreateArg(SystemTimeOfDayInformation,
                         STATUS_SUCCESS, FHSSystemInformation.LastReturnLength,
                         InfoData));
  { Список процессов и потоков }
  InfoData := QueryListInformation(SystemProcessesAndThreadsInformation,
                                   rc, ReturnLength);
  if rc = STATUS_SUCCESS then begin
    SystemListInfo := TSystemListInfo.Create(
           SystemProcessesAndThreadsInformation, rc, ReturnLength);
    SystemListInfo.Data := InfoData;
    SystemListInfo.List := THSNtProcessInfoList.Create(InfoData);
    AddResult (SystemProcessesAndThreadsInformation,
               'SystemProcessesAndThreadsInformation',
                                     SystemListInfo);
  end else
    AddRawResult(SystemProcessesAndThreadsInformation, rc, ReturnLength);
  InfoData := FHSSystemInformation.SystemConfigurationInformation;
  if InfoData <> nil then
    AddResult (SystemConfigurationInformation, 'SystemConfigurationInformation',
               TSystemStaticInfo.CreateArg(SystemConfigurationInformation,
                         STATUS_SUCCESS, FHSSystemInformation.LastReturnLength,
                         InfoData));
  InfoData := FHSSystemInformation.SystemCacheInformation;
  if InfoData <> nil then
    AddResult (SystemCacheInformation, 'SystemCacheInformation',
               TSystemStaticInfo.CreateArg(SystemCacheInformation,
                         STATUS_SUCCESS, FHSSystemInformation.LastReturnLength,
                         InfoData));
  InfoData := FHSSystemInformation.SystemTimeAdjustment;
  if InfoData <> nil then
    AddResult (SystemTimeAdjustment, 'SystemTimeAdjustment',
               TSystemStaticInfo.CreateArg(SystemTimeAdjustment,
                         STATUS_SUCCESS, FHSSystemInformation.LastReturnLength,
                         InfoData));
{$IFDEF EXPLORE_INFOCLASS}
  for I:=SystemBasicInformation to 127 do begin
    ReturnLength := 0;
    rc := NtQuerySystemInformation (I, nil, 0, @Returnlength);
    if (rc <> STATUS_INVALID_INFO_CLASS) then
      AddRawResult (I, rc, Returnlength);
  end;
{$ENDIF}
end;

procedure TfMain.FormCreate(Sender: TObject);
begin
  FHSSystemInformation := THSSystemInformation.Create();
  if Win32Platform <> VER_PLATFORM_WIN32_NT then
    PanelDetail.Caption := 'В этой операционной системе программа не работает'
  else
    GatherData();
end;

procedure TfMain.FormDestroy(Sender: TObject);
begin
  FHSSystemInformation.Free();
end;

procedure TfMain.AddResult (Index : Integer; const AInfoClassName : String;
                     AObject : TObject);
var
  S : String;
begin
  S := Format('%3d %s', [Index, AInfoClassName]);
  if Assigned(AObject) then
    TreeView.Items.AddChildObject(FRoot, S, AObject)
  else
    TreeView.Items.AddChild(FRoot, S);
end;

procedure TfMain.AddRawResult (Index : Integer; rc : NTSTATUS; ALength : DWORD;
                            AObject : TObject);
var
  S : String;
begin
  S := Format('%3d (0x%.8x)', [Index, rc]);
  if (rc = STATUS_BUFFER_TOO_SMALL) or (rc = STATUS_SUCCESS) or
     (rc = STATUS_INFO_LENGTH_MISMATCH) then
    S := S + Format(' %d', [ALength]);
  if Assigned(AObject) then
    TreeView.Items.AddChildObject(FRoot, S, AObject)
  else
    TreeView.Items.AddChild(FRoot, S);
end;

procedure TfMain.DisplaySystemInfo (ASystemInfo : TSystemStaticInfo);
var
  Display : TfAbstractDisplayData;
  FormClass : TPersistentClass;
begin
  with ASystemInfo do
    if (Data <> nil) and
       (Index >= Low(DisplayNames)) and (Index <= High(DisplayNames)) then begin
      FormClass := GetClass(DisplayNames[Index]);
      if Assigned(FormClass) then begin
        Display := TfAbstractDisplayData(FormClass.NewInstance);
        if ASystemInfo IS TSystemListInfo then
          Display.Data := TSystemListInfo(ASystemInfo).List
        else
          Display.Data := Data;
        Display.Create(Application, PanelDetail);
        Display.Show();
        FLastDisplay := Display;
      end;
    end;
end;

procedure TfMain.TreeViewChange(Sender: TObject; Node: TTreeNode);
begin
  if Assigned(FLastDisplay) then
    FreeAndNil(FLastDisplay);
  if Node.Data <> nil then
    DisplaySystemInfo (TSystemInfo(Node.Data));
end;

procedure TfMain.Exit1Click(Sender: TObject);
begin
  Close();
end;

procedure TfMain.About1Click(Sender: TObject);
begin
  with TfAbout.Create(Application) do
    try
      ShowModal();
    finally
      Free();
    end;
end;


procedure TfMain.FormShow(Sender: TObject);
begin
  TreeView.AutoExpand := true;
end;


end.
