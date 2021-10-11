{
   ������: About

   ��������: ���������� � ���������

   �����: ����� ��������

   ���� ��������: 17.12.2002

   ������� ���������:
   23.12.2002 �������� ����� ��������� ������� ��� ����� �� �������� �����
}
unit About;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfAbout = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    CloseButton: TButton;
    Label4: TStaticText;
    LabelEmail: TLabel;
    procedure Label4MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label4Click(Sender: TObject);
    procedure LabelEmailClick(Sender: TObject);
  end;

implementation
uses
  ShellApi;

{$R *.dfm}
{
  ��������� ��������� ����� �� �������� ���� �� ���. ������� ��� �������������
  � Delphi 5, � Delphi 6 ������������� ������������ �������
  MouseEnter/MouseLeave
}
procedure TfAbout.Label4MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if (PtInRect(Label4.ClientRect, Point(X,Y))) then begin
    SetCapture(Label4.Handle);
    Screen.Cursor := crHandPoint;
  end else begin
    ReleaseCapture();
    Screen.Cursor := crDefault;
  end;
end;

procedure TfAbout.Label4Click(Sender: TObject);
begin
  ReleaseCapture();
  Screen.Cursor := crDefault;
  ShellExecute(Application.Handle,'open',PChar(Label4.Caption),'','',SW_SHOW);
end;

procedure TfAbout.LabelEmailClick(Sender: TObject);
begin
  ShellExecute(Application.Handle, 'open',
               'mailto:whitefranz@hotmail.com?subject=QuerySystemInformation',
               '', '', SW_SHOW);
end;

end.
