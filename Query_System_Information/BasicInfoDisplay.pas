{
   Модуль: BasicInfoDisplay

   Описание: Отображение базовой информации (класс SystemBasicInformation)

   Автор: Игорь Шевченко

   Дата создания: 16.12.2002

   История изменений:
}
unit BasicInfoDisplay;

interface

uses
  SysUtils, Classes, Controls, Forms, AbstractDisplay, ComCtrls;

type
  TfBasicInfoDisplay = class(TfAbstractDisplayData)
    ListView: TListView;
  protected
    procedure DisplayData; override;
  end;

implementation
uses
  NtDll;

{$R *.dfm}

procedure TfBasicInfoDisplay.DisplayData;

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
  with SYSTEM_BASIC_INFORMATION(Data^) do begin
    AddDataItem('AlwaysZero', AlwaysZero);
    AddDataItem('MaximumIncrement', MaximumIncrement);
    AddDataItem('PhysicalPageSize', PhysicalPageSize);
    AddDataItem('NumberOfPhysicalPages', NumberOfPhysicalPages);
    AddDataItem('LowestPhysicalPage', LowestPhysicalPage);
    AddDataItem('HighestPhysicalPage', HighestPhysicalPage);
    AddDataItem('AllocationGranularity', AllocationGranularity);
    AddDataItem('LowestUserAddress', LowestUserAddress, '0x%.8x');
    AddDataItem('HighestUserAddress', HighestUserAddress, '0x%.8x');
    AddDataItem('ActiveProcessors', ActiveProcessors, '0x%.8x');
    AddDataItem('NumberProcessors', NumberProcessors);
  end;
end;

initialization
  RegisterClass(TfBasicInfoDisplay);
end.
