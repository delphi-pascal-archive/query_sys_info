inherited fPerformanceInfoDisplay: TfPerformanceInfoDisplay
  Caption = 'fPerformanceInfoDisplay'
  PixelsPerInch = 96
  TextHeight = 13
  object FixedInfoPanel: TPanel
    Left = 0
    Top = 0
    Width = 536
    Height = 113
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 4
      Top = 4
      Width = 79
      Height = 13
      Caption = 'System Idle time:'
    end
    object LabelIdleTime: TLabel
      Left = 96
      Top = 4
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
    object Label2: TLabel
      Left = 4
      Top = 20
      Width = 56
      Height = 13
      Caption = 'Page faults:'
    end
    object LabelPageFaults: TLabel
      Left = 96
      Top = 20
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
    object Label3: TLabel
      Left = 4
      Top = 36
      Width = 85
      Height = 13
      Caption = 'Available memory:'
    end
    object LabelAvailabePages: TLabel
      Left = 96
      Top = 36
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
    object Label4: TLabel
      Left = 4
      Top = 52
      Width = 78
      Height = 13
      Caption = 'Commited pages'
    end
    object LabelTotalCommitedPages: TLabel
      Left = 96
      Top = 52
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
      Left = 208
      Top = 4
      Width = 83
      Height = 13
      Caption = 'Context switches:'
    end
    object LabelContextSwitches: TLabel
      Left = 304
      Top = 4
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
      Left = 208
      Top = 20
      Width = 61
      Height = 13
      Caption = 'System calls:'
    end
    object LabelSystemCalls: TLabel
      Left = 304
      Top = 20
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
  end
  object VarInfoListView: TListView
    Left = 0
    Top = 113
    Width = 536
    Height = 235
    Align = alClient
    Columns = <
      item
        Caption = 'Information'
        Width = 200
      end
      item
        Caption = 'Value'
        Width = 150
      end>
    Ctl3D = False
    TabOrder = 1
    ViewStyle = vsReport
  end
end
