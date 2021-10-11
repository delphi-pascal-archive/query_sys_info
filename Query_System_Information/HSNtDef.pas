{
   Модуль: HSNtDef

   Описание: Определения стандартных типов, используемых в Native API

   Автор: Игорь Шевченко

   Дата создания: 29.10.2002

   История изменений:
}
unit HSNtDef;

interface
uses
  Windows;

type
  NTSTATUS = Integer;

{ Структура UNICODE_STRING - Передача строковых параметров для Native API и
  хранение строк во внутренних структурах Windows }
  TUnicodeString = packed record
    Length : WORD;
    MaximumLength : WORD;
    Buffer : PWideChar;
  end;
  PUnicodeString = ^TUnicodeString;
  TUNICODE_STRING = TUnicodeString;
  UNICODE_STRING = TUnicodeString;
  PUNICODE_STRING = PUnicodeString;

  CLIENT_ID = packed record
    UniqueProcess : THandle;
    UniqueThread : THandle;
  end;

implementation

end.

