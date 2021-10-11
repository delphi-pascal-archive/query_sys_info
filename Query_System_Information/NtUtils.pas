{
   ������: NtUtils

   ��������: ������ �������, ����������� �������������� ������ Native API

   �����: ����� ��������

   ���� ��������: 18.12.2002

   ������� ���������:
   20.12.2002 ��������� ������� HSUnicodeStringToAnsiString
}
unit NtUtils;

interface
uses
  Windows, HsNtDef;

{ �������������� ��������� ������� � ����������� �������
  � ��� TDateTime Delphi }
function HSTimeIntervalToDateTime (const ATime : LARGE_INTEGER) : TDateTime;
{ �������������� ������� � ������� UTC (���������� ���������� �� 100 ����������
  � 1 ������ 1601 ����) � ���� hh.mm.ss.zzz dd.mm.yyyy
  ��� ������������� �������� � ������ ������ ����������� ���� '-'. }
function HSFormatUTCTime (const ATime : LARGE_INTEGER) : String;
{ �������������� ���������� ��������� � ���� (xxxx day(s)) hh:mm:ss.zzz
  ���� ����� ���� ����� ����, �� ��������� �������� ��������������
  � ���� hh:mm:ss.zzz }
function HSFormatDateTimeInterval (const ATime : TDateTime) : String;
{ �������������� ������ �� ������� UNICODE_STRING Native API � �����������
  ANSI ������ Delphi }
function HSUnicodeStringToAnsiString (usString : TUNICODE_STRING) : AnsiString;

implementation
uses
  NtDll, SysUtils;

function HSTimeIntervalToDateTime (const ATime : LARGE_INTEGER) : TDateTime;
var
  TimeFields : TIME_FIELDS;
begin
  RtlTimeToTimeFields (@ATime, @TimeFields);
  { �����-������ ���������, ��������������, ��� ��������� �� ������ ������
    ������ ������.
    TODO: ��������� �� ������������ ���������� ������� � ���. }

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
