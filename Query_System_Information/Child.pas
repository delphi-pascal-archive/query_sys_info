{
   ������: Child

   ��������: ������� ����� ��� ����, ������� ����� ������������ ��� �����������
             ��������� ��� ����������� �����, � ����� ���� ��������� ������
             � ����� ������ ����.

   ������: ���� ���������, ������ ������ (Delphi 5 ����������� ������������,
           ��� 1, ���. 170).

   ���� ��������: 16.12.2002

   ������� ���������:
}
unit Child;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs;

type
  TfAbstractChild = class(TForm)
  private
    FAsChild : Boolean;
    FTempParent : TWinControl;
  protected
    procedure CreateParams (var Params : TCreateParams); override;
    procedure Loaded; override;
  public
    constructor Create (AOwner : TComponent); overload; override;
    constructor Create (AOwner : TComponent;
                        AParent : TWinControl); reintroduce; overload;
  end;

implementation

{$R *.dfm}

constructor TfAbstractChild.Create (AOwner : TComponent);
begin
  FAsChild := false;
  inherited;
end;

constructor TfAbstractChild.Create (AOwner : TComponent; AParent : TWinControl);
begin
  FAsChild := true;
  FTempParent := AParent;
  inherited Create (AOwner);
end;

procedure TfAbstractChild.CreateParams (var Params : TCreateParams);
begin
  inherited;
  if FAsChild then
    Params.Style := Params.Style or WS_CHILD;
end;

procedure TfAbstractChild.Loaded;
begin
  inherited;
  if FAsChild then begin
    Align := alClient;
    BorderStyle := bsNone;
    BorderIcons := [];
    Parent := FTempParent;
    Position := poDefault;
  end;
end;

end.