{
   ������: TimeAdjustmentDisplay

   ��������: ����������� ���������� � ���������� ���������� �������
             (����� SystemTimeAdjustment)

   �����: ����� ��������

   ���� ��������: 23.12.2002

   ������� ���������:
}
unit TimeAdjustmentDisplay;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, AbstractDisplay, ComCtrls;

type
  TfTimeAdjustmentDisplay = class(TfAbstractDisplayData)
    ListView: TListView;
  protected
    procedure DisplayData; override;
  end;

implementation
uses
  NtDll;

{$R *.dfm}

procedure TfTimeAdjustmentDisplay.DisplayData;

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
  with SYSTEM_TIME_ADJUSTMENT(Data^) do begin
    AddDataItem('TimeAdjustment', TimeAdjustment);
    AddDataItem('MaximumIncrement', MaximumIncrement);
    AddDataItem('TimeSynchronization', Integer(TimeSynchronization));
  end;
end;

initialization
  RegisterClass(TfTimeAdjustmentDisplay);
end.
