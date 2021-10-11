{
   ������: HSNtDef

   ��������: ����������� ����������� �����, ������������ � Native API

   �����: ����� ��������

   ���� ��������: 29.10.2002

   ������� ���������:
}
unit HSNtDef;

interface
uses
  Windows;

type
  NTSTATUS = Integer;

{ ��������� UNICODE_STRING - �������� ��������� ���������� ��� Native API �
  �������� ����� �� ���������� ���������� Windows }
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

