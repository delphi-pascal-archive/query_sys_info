inherited fProcessesAndThreadsDisplay: TfProcessesAndThreadsDisplay
  Caption = 'fProcessesAndThreadsDisplay'
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 221
    Width = 536
    Height = 4
    Cursor = crVSplit
    Align = alTop
  end
  object ListViewProcesses: TListView
    Left = 0
    Top = 0
    Width = 536
    Height = 221
    Align = alTop
    Columns = <
      item
        Caption = 'Process'
        Width = 100
      end
      item
        Caption = 'Pid'
        Width = 45
      end
      item
        Caption = 'Base Pri.'
        Width = 55
      end
      item
        Caption = 'VM bytes'
        Width = 70
      end
      item
        Caption = 'Handles'
        Width = 55
      end
      item
        Caption = 'Parent'
        Width = 45
      end
      item
        Caption = 'Mem'
        Width = 60
      end
      item
        Caption = 'Pagefile'
        Width = 60
      end
      item
        Caption = 'Threads'
      end>
    ReadOnly = True
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
    OnChange = ListViewProcessesChange
    OnDblClick = ListViewProcessesDblClick
  end
  object PanelClient: TPanel
    Left = 0
    Top = 225
    Width = 536
    Height = 123
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object ListViewThread: TListView
      Left = 0
      Top = 0
      Width = 536
      Height = 108
      Align = alClient
      Columns = <
        item
          Caption = 'TID'
          Width = 40
        end
        item
          Caption = 'PID'
          Width = 40
        end
        item
          Caption = 'Context Switch'
          Width = 90
        end
        item
          Caption = 'Pri'
          Width = 35
        end
        item
          Caption = 'Base'
          Width = 40
        end
        item
          Caption = 'Start address'
          Width = 75
        end
        item
          Caption = 'State'
          Width = 70
        end
        item
          Caption = 'Wait reason'
          Width = 90
        end>
      ReadOnly = True
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
      OnDblClick = ListViewThreadDblClick
    end
    object Panel1: TPanel
      Left = 0
      Top = 108
      Width = 536
      Height = 15
      Align = alBottom
      BevelOuter = bvNone
      Caption = 'Double-click on process or thread to see details'
      Color = clBtnShadow
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindow
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
  end
end
