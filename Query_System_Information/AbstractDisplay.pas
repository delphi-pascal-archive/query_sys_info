{
   Модуль: AbstractDisplay

   Описание: Базовый класс для форм, отображающих результат
             NtQuerySystemInformation

   Автор: Игорь Шевченко

   Дата создания: 16.12.2002

   История изменений:
}
unit AbstractDisplay;

interface

uses
  Forms, Child;

type
  TfAbstractDisplayData = class(TfAbstractChild)
    procedure FormCreate(Sender: TObject);
  private
    FData : Pointer;
  protected
    procedure DisplayData; virtual; abstract;
  public
    property Data : Pointer read FData write FData;
  end;


implementation

{$R *.dfm}

procedure TfAbstractDisplayData.FormCreate(Sender: TObject);
begin
  DisplayData();
end;

end.
