{
   Модуль: ConfigurationDisplay

   Описание: Отображение информации об аппаратной конфигурации
             (класс SystemConfigurationInformation)

   Автор: Игорь Шевченко

   Дата создания: 22.12.2002

   История изменений:
}
unit ConfigurationDisplay;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, AbstractDisplay, ComCtrls;

type
  TfConfigurationDisplay = class(TfAbstractDisplayData)
    ListView: TListView;
  protected
    procedure DisplayData; override;
  end;

implementation
uses
  NtDll;

{$R *.dfm}

procedure TfConfigurationDisplay.DisplayData;

  procedure AddDataItem (const AName : String; AValue : Integer;
                         const AFormat : String = '%d');
  var
    LI : TListItem;
  begin
    LI := ListView.Items.Add();
    LI.Caption := AName;
    LI.SubItems.Add(Format(AFormat, [AValue]));
  end;

begin
  ListView.Items.Clear();
  with SYSTEM_CONFIGURATION_INFORMATION(Data^) do begin
    AddDataItem('Disk count', DiskCount);
    AddDataItem('Floppy count', FloppyCount);
    AddDataItem('CD-ROM count', CdRomCount);
    AddDataItem('Tape count', TapeCount);
    AddDataItem('Serial count', SerialCount);
    AddDataItem('Parallel count', ParallelCount);
  end;
end;

initialization
  RegisterClass(TfConfigurationDisplay);
end.
