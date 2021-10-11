object fAbout: TfAbout
  Left = 199
  Top = 107
  Width = 404
  Height = 287
  Caption = 'About QuerySystemInformation'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 120
  TextHeight = 16
  object Label1: TLabel
    Left = 39
    Top = 44
    Width = 307
    Height = 41
    Alignment = taCenter
    AutoSize = False
    Caption = 'Demonstrates use of NtQuerySystemInformation Native API function'
    WordWrap = True
  end
  object Label2: TLabel
    Left = 34
    Top = 98
    Width = 152
    Height = 16
    Caption = 'Author: Igor Schevchenko'
  end
  object Label3: TLabel
    Left = 49
    Top = 128
    Width = 143
    Height = 16
    Caption = 'Written for community at '
  end
  object LabelEmail: TLabel
    Left = 197
    Top = 98
    Width = 158
    Height = 16
    Caption = '<whitefranz@hotmail.com>'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    OnClick = LabelEmailClick
  end
  object Label4: TStaticText
    Left = 197
    Top = 128
    Width = 134
    Height = 20
    Caption = 'http://delphi.mastak.ru'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsUnderline]
    ParentColor = False
    ParentFont = False
    TabOrder = 1
    OnClick = Label4Click
    OnMouseMove = Label4MouseMove
  end
  object CloseButton: TButton
    Left = 151
    Top = 207
    Width = 93
    Height = 31
    Caption = 'Close'
    ModalResult = 2
    TabOrder = 0
  end
end
