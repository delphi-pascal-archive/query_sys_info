{
   Модуль: NtUtils

   Описание: Разные утилиты, облегчающие преобразование данных Native API

   Автор: Игорь Шевченко

   Дата создания: 18.12.2002

   История изменений:
   20.12.2002 Добавлена функция HSUnicodeStringToAnsiString
}
unit NtUtils;

interface
uses
  Windows, HsNtDef;

{ Преобразование интервала времени в стандартном формате
  в тип TDateTime Delphi }
function HSTimeIntervalToDateTime (const ATime : LARGE_INTEGER) : TDateTime;
{ Форматирование времени в формате UTC (количество интервалов по 100 наносекунд
  с 1 января 1601 года) в виде hh.mm.ss.zzz dd.mm.yyyy
  Для отрицательных значений в начало строки добавляется знак '-'. }
function HSFormatUTCTime (const ATime : LARGE_INTEGER) : String;
{ Форматирование временного интервала в виде (xxxx day(s)) hh:mm:ss.zzz
  Если число дней равно нулю, то временной интервал представляется
  в виде hh:mm:ss.zzz }
function HSFormatDateTimeInterval (const ATime : TDateTime) : String;
{ Преобразование строки из формата UNICODE_STRING Native API к стандартной
  ANSI строке Delphi }
function HSUnicodeStringToAnsiString (usString : TUNICODE_STRING) : AnsiString;

implementation
uses
  NtDll, SysUtils;

function HSTimeIntervalToDateTime (const ATime : LARGE_INTEGER) : TDateTime;
var
  TimeFields : TIME_FIELDS;
begin
  RtlTimeToTimeFields (@ATime, @TimeFields);
  { Альфа-версия алгоритма, предполагающая, что интервалы не бывают больше
    одного месяца.
    TODO: Расширить на произвольное количество месяцев и лет. }

  with TimeFields do begin
    Result := Day - 1;
    Result := Result + EncodeTime(Hour, Minute, Second, MilliSeconds);
  end;
end;

function HSFormatDateTimeInterval (const ATime : TDateTime) : String;
var
  Days : Integer;
begin
  Days := Trunc(ATime);
  Result := FormatDateTime('hh:nn:ss.zzz', ATime);
  if Days <> 0 then
    Result := Format('(%d day(s)) ', [Days]) + Result;
end;

function HSUnicodeStringToAnsiString (usString : TUNICODE_STRING) : AnsiString;
begin
  Result := WideCharLenToString(usString.Buffer,
                                usString.Length DIV SizeOf(WideChar));
end;

function HSFormatUTCTime (const ATime : LARGE_INTEGER) : String;
var
  TempTime : LARGE_INTEGER;
  Negative : Boolean;
  TimeFields : TIME_FIELDS;
const
  Signs : array[Boolean] of String = ('','-');
begin
  TempTime.QuadPart := ATime.QuadPart;
  Negative := TempTime.QuadPart < 0;
  if Negative then
    TempTime.QuadPart := -TempTime.QuadPart;
  RtlTimeToTimeFields (@TempTime, @TimeFields);
  with TimeFields do
    Result := Format('%s%.2d:%.2d:%.2d.%.3d %.2d.%.2d.%.4d',
         [Signs[Negative],
          Hour, Minute, Second, MilliSeconds, Day, Month, Year]);
end;

end.
