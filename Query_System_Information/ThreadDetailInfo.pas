{
   ������: ThreadDetailInfo

   ��������: ����������� ������ ���������� � ������, ���������� �������
             NtQuerySystemInformation.
             (����� SystemProcessesAndThreadsInformation)

   �����: ����� ��������

   ���� ��������: 22.12.2002

   ������� ���������:
}
unit ThreadDetailInfo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, NtProcessInfo, StdCtrls, ComCtrls, ExtCtrls;

type
  TfThreadDetailInfo = class(TForm)
    PageControl: TPageControl;
    OkButton: TButton;
    CancelButton: TButton;
    TabSheetGeneral: TTabSheet;
    Label1: TLabel;
    LabelWaitTime: TLabel;
    Label7: TLabel;
    LabelStartAddress: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    LabelPriority: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label20: TLabel;
    LabelReserved: TLabel;
    Label22: TLabel;
    LabelCreateTime: TLabel;
    GroupBoxCPU: TGroupBox;
    Label24: TLabel;
    LabelKernelTime: TLabel;
    Label25: TLabel;
    LabelUserTime: TLabel;
    Label26: TLabel;
    LabelTotalTime: TLabel;
    Bevel1: TBevel;
    Label28: TLabel;
    LabelBasePriority: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    FThread : THSNtThreadInfo;
    procedure DisplayThreadInfo;
  public
    constructor CreateArg (AOwner : TComponent; AThread : THSNtThreadInfo);
  end;

implementation
uses
  NtUtils;

{$R *.dfm}

constructor TfThreadDetailInfo.CreateArg (AOwner : TComponent;
  AThread : THSNtThreadInfo);
begin
  FThread := AThread;
  inherited Create (AOwner);
end;

procedure TfThreadDetailInfo.DisplayThreadInfo;
var
  TempTime : LARGE_INTEGER;
begin
  with FThread.Info.ClientId do
    Caption := Format('  Thread %d (process %d) information',
                      [UniqueThread, UniqueProcess]);
  with FThread.Info do begin
    LabelWaitTime.Caption := Format('%d', [WaitTime]);
    LabelStartAddress.Caption := Format('%.8x', [Integer(StartAddress)]);
    LabelBasePriority.Caption := Format('%d', [BasePriority]);
    LabelPriority.Caption := Format('%d', [Priority]);
    LabelReserved.Caption := Format('%.8x', [Reserved]);
    //TODO: �������� ������� �������� � ���� ���������� �������, ��� �����
    //      �������� �����. ��-��������, ����� ���������� SystemTimeOfDayInfo
    //      � �������� ����� ��� ������ �� �����.
    if CreateTime.QuadPart = 0 then
      LabelCreateTime.Caption := 'n/a'
    else
    //TODO: ������ non-biased, �����(����) ����� ���������� ��������� �����.
      LabelCreateTime.Caption := HSFormatUTCTime(CreateTime) + ' (non-biased)';
    LabelKernelTime.Caption := HSFormatDateTimeInterval(
         HSTimeIntervalToDateTime(KernelTime));
    LabelUserTime.Caption := HSFormatDateTimeInterval(
         HSTimeIntervalToDateTime(UserTime));
    TempTime.QuadPart := KernelTime.QuadPart + UserTime.QuadPart;
    LabelTotalTime.Caption := HSFormatDateTimeInterval(
         HSTimeIntervalToDateTime(TempTime));
  end;
end;

procedure TfThreadDetailInfo.FormCreate(Sender: TObject);
begin
  DisplayThreadInfo;
end;

end.
