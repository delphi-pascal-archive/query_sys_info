inherited fTimeOfDayDisplay: TfTimeOfDayDisplay
  Caption = 'fTimeOfDayDisplay'
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 12
    Top = 8
    Width = 47
    Height = 13
    Caption = 'Boot time:'
  end
  object Label2: TLabel
    Left = 12
    Top = 28
    Width = 59
    Height = 13
    Caption = 'Current time:'
  end
  object Label3: TLabel
    Left = 12
    Top = 48
    Width = 73
    Height = 13
    Caption = 'TimeZone bias:'
  end
  object Label4: TLabel
    Left = 12
    Top = 68
    Width = 99
    Height = 13
    Caption = 'Current TimeZone id:'
  end
  object LabelBootTime: TLabel
    Left = 128
    Top = 8
    Width = 6
    Height = 13
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object LabelCurrentTime: TLabel
    Left = 128
    Top = 28
    Width = 6
    Height = 13
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object LabelTimeZoneBias: TLabel
    Left = 128
    Top = 48
    Width = 6
    Height = 13
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object LabelCurrentTimeZoneId: TLabel
    Left = 128
    Top = 68
    Width = 6
    Height = 13
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 12
    Top = 87
    Width = 46
    Height = 13
    Caption = 'Reserved'
  end
  object LabelReserved: TLabel
    Left = 128
    Top = 87
    Width = 6
    Height = 13
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label6: TLabel
    Left = 12
    Top = 119
    Width = 71
    Height = 13
    Caption = 'System uptime:'
  end
  object LabelUptime: TLabel
    Left = 128
    Top = 119
    Width = 6
    Height = 13
    Caption = '0'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object Timer: TTimer
    OnTimer = TimerTimer
    Left = 184
    Top = 12
  end
end
