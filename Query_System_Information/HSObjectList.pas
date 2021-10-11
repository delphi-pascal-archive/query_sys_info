{
   Модуль: HSObjectList

   Описание: Класс списка объектов. Уничтожает содержащиеся объекты
             при собственном разрушении,
             имеет метод очистки без уничтожения содержимого.

   Ограничения применения: Элементы списка должны быть наследниками TObject

   Автор: Игорь Шевченко

   Дата создания: 21.11.2001

   История изменений:
}
unit HSObjectList;

interface
uses
  Classes;

type
  THSObjectList = class(TList)
  public
    procedure Clear; override;
    { Очистка списка без разрушения содержимого }
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
