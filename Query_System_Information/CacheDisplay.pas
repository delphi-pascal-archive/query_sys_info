{
   ������: CacheDisplay

   ��������: ����������� ���������� �������� ������ ������ �������
             (����� SystemCacheInformation)

   �����: ����� ��������

   ���� ��������: 23.12.2002

   ������� ���������:
}
unit CacheDisplay;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, AbstractDisplay, ComCtrls;

type
  TfCacheDisplay = class(TfAbstractDisplayData)
    ListView: TListView;
  protected
    procedure DisplayData; override;
  end;

implementation
uses
  NtDll;

{$R *.dfm}

procedure TfCacheDisplay.DisplayData;

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
  with SYSTEM_CACHE_INFORMATION(Data^) do begin
    AddDataItem('SystemCacheWsSize', SystemCacheWsSize);
    AddDataItem('SystemCacheWsPeakSize', SystemCacheWsPeakSize);
    AddDataItem('SystemCacheWsFaults', SystemCacheWsFaults);
    AddDataItem('SystemCacheWsMinimum', SystemCacheWsMinimum);
    AddDataItem('SystemCacheWsMaximum', SystemCacheWsMaximum);
    AddDataItem('TransitionSharedPages', TransitionSharedPages);
    AddDataItem('TransitionSharedPagesPeak', TransitionSharedPagesPeak);
    AddDataItem('Reserved[0]', Reserved[0], '0x%.8x');
    AddDataItem('Reserved[1]', Reserved[1], '0x%.8x');
  end;
end;

initialization
  RegisterClass(TfCacheDisplay);
end.
