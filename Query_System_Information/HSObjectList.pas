{
   ������: HSObjectList

   ��������: ����� ������ ��������. ���������� ������������ �������
             ��� ����������� ����������,
             ����� ����� ������� ��� ����������� �����������.

   ����������� ����������: �������� ������ ������ ���� ������������ TObject

   �����: ����� ��������

   ���� ��������: 21.11.2001

   ������� ���������:
}
unit HSObjectList;

interface
uses
  Classes;

type
  THSObjectList = class(TList)
  public
    procedure Clear; override;
    { ������� ������ ��� ���������� ����������� }
    procedure RemoveAll;
  end;


implementation

{ THSObjectList }

procedure THSObjectList.Clear;
var I : Integer;
begin
  for I:=0 to Pred(Count) do
    TObject(inherited Items[I]).Free();
  inherited;
end;

procedure THSObjectList.RemoveAll;
var I : Integer;
begin
  for I:=Pred(Count) downto 0 do
    Delete(I);
end;

end.
