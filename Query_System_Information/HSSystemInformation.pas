{
   Модуль: HSSystemInformation

   Описание: Класс-оболочка вокруг функции NtQuerySystemInformation. В настоящей
             реализации позволяет получать информацию только фиксированного
             размера.

   Автор: Игорь Шевченко

   Дата создания: 21.12.2002

   История изменений:
}
unit HSSystemInformation;

interface
uses
  Windows, NtDll, HSNtDef;

type
  THSSystemInformation = class
  private
    FLastResult : NTSTATUS;
    FLastReturnLength : ULONG;
    { Статические данные для информации постоянного размера }
    FSystemBasicInformation : SYSTEM_BASIC_INFORMATION;
    FSystemProcessorInformation : SYSTEM_PROCESSOR_INFORMATION;
    FSystemPerformanceInformation : SYSTEM_PERFORMANCE_INFORMATION;
    FSystemTimeOfDayInformation : SYSTEM_TIME_OF_DAY_INFORMATION;
    FSystemConfigurationInformation : SYSTEM_CONFIGURATION_INFORMATION;
    FSystemCacheInformation : SYSTEM_CACHE_INFORMATION;
    FSystemTimeAdjustment : SYSTEM_TIME_ADJUSTMENT;

    function GetSystemBasicInformation : PSYSTEM_BASIC_INFORMATION;
    function GetSystemProcessorInformation : PSYSTEM_PROCESSOR_INFORMATION;
    function GetSystemPerformanceInformation : PSYSTEM_PERFORMANCE_INFORMATION;
    function GetSystemTimeOfDayInformation : PSYSTEM_TIME_OF_DAY_INFORMATION;
    function GetSystemConfigurationInformation :
      PSYSTEM_CONFIGURATION_INFORMATION;
    function GetSystemTimeAdjustment : PSYSTEM_TIME_ADJUSTMENT;
    function GetSystemCacheInformation : PSYSTEM_CACHE_INFORMATION;
  protected
    {
      Функция, непосредственно выполняющая запрос информации. Объявление ее
      виртуальной дает возможность переопределять ее поведение в классах-
      наследниках и обрабатывать запросы на получение информации с классом,
      отсутствующем в NtQuerySystemInformation
    }
    function DoQuerySystemInformation (InfoClass : Integer; Buffer : Pointer;
      BufferLength : ULONG; var ReturnLength : ULONG) : NTSTATUS; virtual;
  public
    { Код завершения последнего вызова }
    property LastResult : NTSTATUS read FLastResult;
    { Размер информационного буфера, возвращенного последним вызовом }
    property LastReturnLength : ULONG read FLastReturnLength;
    { Базовая информация о системе }
    property SystemBasicInformation : PSYSTEM_BASIC_INFORMATION read
      GetSystemBasicInformation;
    { Информация о процессоре }
    property SystemProcessorInformation : PSYSTEM_PROCESSOR_INFORMATION read
      GetSystemProcessorInformation;
    { Информация о производительности }
    property SystemPerformanceInformation : PSYSTEM_PERFORMANCE_INFORMATION read
      GetSystemPerformanceInformation;
    { Информация о дате и времени }
    property SystemTimeOfDayInformation : PSYSTEM_TIME_OF_DAY_INFORMATION read
      GetSystemTimeOfDayInformation;
    { Информация об аппаратной конфигурации }
    property SystemConfigurationInformation : PSYSTEM_CONFIGURATION_INFORMATION
      read GetSystemConfigurationInformation;
    { Информация о системном рабочем наборе }
    property SystemCacheInformation : PSYSTEM_CACHE_INFORMATION read
      GetSystemCacheInformation;
    { Информация о разрешении системного таймера }
    property SystemTimeAdjustment : PSYSTEM_TIME_ADJUSTMENT
      read GetSystemTimeAdjustment;
  end;

implementation
uses
  NtStatusDefs;

{ THSSystemInformation }

function THSSystemInformation.GetSystemBasicInformation :
  PSYSTEM_BASIC_INFORMATION;
begin
  Result := @FSystemBasicInformation;
  FLastResult := DoQuerySystemInformation (NtDll.SystemBasicInformation,
                   Result, SizeOf(FSystemBasicInformation), FLastReturnLength);
  if FLastResult <> STATUS_SUCCESS then
    Result := nil;
end;

function THSSystemInformation.GetSystemProcessorInformation :
  PSYSTEM_PROCESSOR_INFORMATION;
begin
  Result := @FSystemProcessorInformation;
  FLastResult := DoQuerySystemInformation (NtDll.SystemProcessorInformation,
              Result, SizeOf(FSystemProcessorInformation), FLastReturnLength);
  if FLastResult <> STATUS_SUCCESS then
    Result := nil;
end;

function THSSystemInformation.GetSystemPerformanceInformation :
  PSYSTEM_PERFORMANCE_INFORMATION;
begin
  Result := @FSystemPerformanceInformation;
  FLastResult := DoQuerySystemInformation (NtDll.SystemPerformanceInformation,
         Result, SizeOf(FSystemPerformanceInformation), FLastReturnLength);
  if FLastResult <> STATUS_SUCCESS then
    Result := nil;
end;

function THSSystemInformation.GetSystemTimeOfDayInformation :
  PSYSTEM_TIME_OF_DAY_INFORMATION;
begin
  Result := @FSystemTimeOfDayInformation;
  FLastResult := DoQuerySystemInformation (NtDll.SystemTimeOfDayInformation,
         Result, SizeOf(FSystemTimeOfDayInformation), FLastReturnLength);
  if FLastResult <> STATUS_SUCCESS then
    Result := nil;
end;

function THSSystemInformation.GetSystemConfigurationInformation :
      PSYSTEM_CONFIGURATION_INFORMATION;
begin
  Result := @FSystemConfigurationInformation;
  FLastResult := DoQuerySystemInformation (NtDll.SystemConfigurationInformation,
     Result, SizeOf(FSystemConfigurationInformation), FLastReturnLength);
  if FLastResult <> STATUS_SUCCESS then
    Result := nil;
end;

function THSSystemInformation.GetSystemCacheInformation :
  PSYSTEM_CACHE_INFORMATION;
begin
  Result := @FSystemCacheInformation;
  FLastResult := DoQuerySystemInformation (NtDll.SystemCacheInformation,
     Result, SizeOf(FSystemCacheInformation), FLastReturnLength);
  if FLastResult <> STATUS_SUCCESS then
    Result := nil;
end;

function THSSystemInformation.GetSystemTimeAdjustment : PSYSTEM_TIME_ADJUSTMENT;
begin
  Result := @FSystemTimeAdjustment;
  FLastResult := DoQuerySystemInformation (NtDll.SystemTimeAdjustment,
     Result, SizeOf(FSystemTimeAdjustment), FLastReturnLength);
  if FLastResult <> STATUS_SUCCESS then
    Result := nil;
end;

function THSSystemInformation.DoQuerySystemInformation (InfoClass : Integer;
      Buffer : Pointer; BufferLength : ULONG;
      var ReturnLength : ULONG) : NTSTATUS;
begin
  Result := NtQuerySystemInformation(InfoClass, Buffer, BufferLength,
                                     @ReturnLength);
end;

end.
