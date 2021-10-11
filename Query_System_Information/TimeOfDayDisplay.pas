{
   Модуль: TimeOfDayDisplay

   Описание: Отображение информации о времени (класс SystemTimeOfDayInformation)

   Автор: Игорь Шевченко

   Дата создания: 18.12.2002

   История изменений:
}
unit TimeOfDayDisplay;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  AbstractDisplay, StdCtrls, ExtCtrls, NtDll;

type
  TfTimeOfDayDisplay = class(TfAbstractDisplayData)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    LabelBootTime: TLabel;
    LabelCurrentTime: TLabel;
    LabelTimeZoneBias: TLabel;
    LabelCurrentTimeZoneId: TLabel;
    Label5: TLabel;
    LabelReserved: TLabel;
    Label6: TLabel;
    LabelUptime: TLabel;
    Timer: TTimer;
    procedure TimerTimer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FTimeInfo : SYSTEM_TIME_OF_DAY_INFORMATION;
  protected
    procedure DisplayData; override;
  end;


implementation
uses
  NtStatusDefs, NtUtils;

{$R *.DFM}

procedure TfTimeOfDayDisplay.DisplayData;

  { Отображение времени с учетом разницы между всемирным временем и
    местным временем }
  procedure DisplayLocalTime (ALabel : TLabel;
     const ATime, ABias : LARGE_INTEGER; const TimeSign : String);
  var
    ALocalTime : LARGE_INTEGER;
  begin
    ALocalTime.QuadPart := ATime.QuadPart - ABias.QuadPart;
    ALabel.Caption := HSFormatUTCTime(ALocalTime);
  end;

var
  TempTime : LARGE_INTEGER;
begin
  with SYSTEM_TIME_OF_DAY_INFORMATION(Data^) do begin
    DisplayLocalTime(LabelBootTime, BootTime, TimeZoneBias, '');
    DisplayLocalTime(LabelCurrentTime, CurrentTime, TimeZoneBias, '');
    LabelTimeZoneBias.Caption := HSFormatUTCTime(TimeZoneBias);
    LabelCurrentTimeZoneId.Caption := Format('%.8x', [CurrentTimeZoneId]);
    LabelReserved.Caption := Format('%.8x', [Reserved]);
    { Время работы системы: CurrentTime - BootTime }
    TempTime.QuadPart := CurrentTime.QuadPart - BootTime.QuadPart;
    LabelUptime.Caption := HSFormatDateTimeInterval(
         HSTimeIntervalToDateTime(TempTime));
  end;
end;

procedure TfTimeOfDayDisplay.TimerTimer(Sender: TObject);
var
  ReturnLength : DWORD;
begin
  if NtQuerySystemInformation(SystemTimeOfDayInformation, @FTimeInfo,
       SizeOf(FTimeInfo), @ReturnLength) = STATUS_SUCCESS then begin
    Data := @FTimeInfo;
    DisplayData();
  end;
end;

procedure TfTimeOfDayDisplay.FormDestroy(Sender: TObject);
begin
  Timer.Enabled := false;
end;

initialization
  RegisterClass(TfTimeOfDayDisplay);
end.
