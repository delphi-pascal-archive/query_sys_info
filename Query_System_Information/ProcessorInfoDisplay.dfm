inherited fProcessorInfoDisplay: TfProcessorInfoDisplay
  Caption = 'fProcessorInfoDisplay'
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 8
    Width = 109
    Height = 13
    Caption = 'Processor architecture:'
  end
  object Label2: TLabel
    Left = 16
    Top = 28
    Width = 75
    Height = 13
    Caption = 'Processor level:'
  end
  object Label3: TLabel
    Left = 16
    Top = 48
    Width = 89
    Height = 13
    Caption = 'Processor revision:'
  end
  object Label4: TLabel
    Left = 16
    Top = 68
    Width = 49
    Height = 13
    Caption = 'Unknown:'
  end
  object Label5: TLabel
    Left = 16
    Top = 88
    Width = 91
    Height = 13
    Caption = 'Processor features:'
  end
  object LabelArchitecture: TLabel
    Left = 136
    Top = 8
    Width = 24
    Height = 13
    Caption = '0000'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object LabelLevel: TLabel
    Left = 136
    Top = 28
    Width = 24
    Height = 13
    Caption = '0000'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object LabelRevision: TLabel
    Left = 136
    Top = 48
    Width = 24
    Height = 13
    Caption = '0000'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object LabelUnknown: TLabel
    Left = 136
    Top = 68
    Width = 24
    Height = 13
    Caption = '0000'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object LabelFeatures: TLabel
    Left = 136
    Top = 88
    Width = 48
    Height = 13
    Caption = '00000000'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object FeaturesListBox: TListBox
    Left = 16
    Top = 112
    Width = 317
    Height = 225
    Style = lbOwnerDrawFixed
    BorderStyle = bsNone
    Ctl3D = False
    ItemHeight = 16
    ParentColor = True
    ParentCtl3D = False
    TabOrder = 0
    OnDrawItem = FeaturesListBoxDrawItem
  end
end
