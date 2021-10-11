object fProcessDetailInfo: TfProcessDetailInfo
  Left = 198
  Top = 107
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'fProcessDetailInfo'
  ClientHeight = 386
  ClientWidth = 402
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label9: TLabel
    Left = 16
    Top = 12
    Width = 72
    Height = 13
    Caption = 'Threads count:'
  end
  object Label10: TLabel
    Left = 96
    Top = 12
    Width = 6
    Height = 13
    Caption = '0'
  end
  object Label14: TLabel
    Left = 16
    Top = 32
    Width = 64
    Height = 13
    Caption = 'Reserved1[0]'
  end
  object Label15: TLabel
    Left = 96
    Top = 32
    Width = 6
    Height = 13
    Caption = '0'
  end
  object PageControl: TPageControl
    Left = 6
    Top = 6
    Width = 391
    Height = 342
    ActivePage = TabSheetGeneral
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    object TabSheetGeneral: TTabSheet
      Caption = 'General'
      object Label1: TLabel
        Left = 44
        Top = 12
        Width = 72
        Height = 13
        Caption = 'Threads count:'
      end
      object LabelThreadCount: TLabel
        Left = 124
        Top = 12
        Width = 6
        Height = 13
        Caption = '0'
      end
      object Label7: TLabel
        Left = 44
        Top = 32
        Width = 64
        Height = 13
        Caption = 'Reserved1[0]'
      end
      object LabelReserved0: TLabel
        Left = 124
        Top = 32
        Width = 6
        Height = 13
        Caption = '0'
      end
      object Label8: TLabel
        Left = 44
        Top = 48
        Width = 64
        Height = 13
        Caption = 'Reserved1[1]'
      end
      object LabelReserved1: TLabel
        Left = 124
        Top = 48
        Width = 6
        Height = 13
        Caption = '0'
      end
      object Label12: TLabel
        Left = 44
        Top = 64
        Width = 64
        Height = 13
        Caption = 'Reserved1[2]'
      end
      object LabelReserved2: TLabel
        Left = 124
        Top = 64
        Width = 6
        Height = 13
        Caption = '0'
      end
      object Label16: TLabel
        Left = 44
        Top = 80
        Width = 64
        Height = 13
        Caption = 'Reserved1[3]'
      end
      object LabelReserved3: TLabel
        Left = 124
        Top = 80
        Width = 6
        Height = 13
        Caption = '0'
      end
      object Label18: TLabel
        Left = 44
        Top = 96
        Width = 64
        Height = 13
        Caption = 'Reserved1[4]'
      end
      object LabelReserved4: TLabel
        Left = 124
        Top = 96
        Width = 6
        Height = 13
        Caption = '0'
      end
      object Label20: TLabel
        Left = 44
        Top = 112
        Width = 64
        Height = 13
        Caption = 'Reserved1[5]'
      end
      object LabelReserved5: TLabel
        Left = 124
        Top = 112
        Width = 6
        Height = 13
        Caption = '0'
      end
      object Label22: TLabel
        Left = 44
        Top = 136
        Width = 52
        Height = 13
        Caption = 'Created at:'
      end
      object LabelCreateTime: TLabel
        Left = 124
        Top = 136
        Width = 6
        Height = 13
        Caption = '0'
      end
      object Label27: TLabel
        Left = 212
        Top = 12
        Width = 72
        Height = 13
        Caption = 'Handles count:'
      end
      object LabelHandleCount: TLabel
        Left = 292
        Top = 12
        Width = 6
        Height = 13
        Caption = '0'
      end
      object Label28: TLabel
        Left = 212
        Top = 32
        Width = 60
        Height = 13
        Caption = 'Base priority:'
      end
      object LabelBasePriority: TLabel
        Left = 292
        Top = 32
        Width = 6
        Height = 13
        Caption = '0'
      end
      object Label29: TLabel
        Left = 212
        Top = 48
        Width = 64
        Height = 13
        Caption = 'Reserved2[0]'
      end
      object LabelReserved20: TLabel
        Left = 292
        Top = 48
        Width = 6
        Height = 13
        Caption = '0'
      end
      object Label30: TLabel
        Left = 212
        Top = 64
        Width = 64
        Height = 13
        Caption = 'Reserved2[1]'
      end
      object LabelReserved21: TLabel
        Left = 292
        Top = 64
        Width = 6
        Height = 13
        Caption = '0'
      end
      object Label31: TLabel
        Left = 212
        Top = 80
        Width = 55
        Height = 13
        Caption = 'Process ID:'
      end
      object LabelProcessId: TLabel
        Left = 292
        Top = 80
        Width = 6
        Height = 13
        Caption = '0'
      end
      object Label32: TLabel
        Left = 212
        Top = 96
        Width = 74
        Height = 13
        Caption = 'Parent process:'
      end
      object LabelInheritedFromProcessId: TLabel
        Left = 292
        Top = 96
        Width = 6
        Height = 13
        Caption = '0'
      end
      object Label33: TLabel
        Left = 212
        Top = 112
        Width = 68
        Height = 13
        Caption = 'Private pages:'
      end
      object LabelPrivatePageCount: TLabel
        Left = 292
        Top = 112
        Width = 6
        Height = 13
        Caption = '0'
      end
      object GroupBoxCPU: TGroupBox
        Left = 44
        Top = 160
        Width = 325
        Height = 81
        Anchors = [akLeft, akTop, akRight]
        Caption = 'CPU'
        TabOrder = 0
        object Label24: TLabel
          Left = 136
          Top = 12
          Width = 55
          Height = 13
          Caption = 'Kernel time:'
        end
        object LabelKernelTime: TLabel
          Left = 220
          Top = 12
          Width = 6
          Height = 13
          Caption = '0'
        end
        object Label25: TLabel
          Left = 136
          Top = 28
          Width = 47
          Height = 13
          Caption = 'User time:'
        end
        object LabelUserTime: TLabel
          Left = 220
          Top = 28
          Width = 6
          Height = 13
          Caption = '0'
        end
        object Label26: TLabel
          Left = 136
          Top = 52
          Width = 49
          Height = 13
          Caption = 'Total time:'
        end
        object LabelTotalTime: TLabel
          Left = 220
          Top = 52
          Width = 6
          Height = 13
          Caption = '0'
        end
        object Bevel1: TBevel
          Left = 216
          Top = 44
          Width = 85
          Height = 3
          Shape = bsBottomLine
        end
      end
    end
    object TabSheetVMCounters: TTabSheet
      Caption = 'VM Counters'
      ImageIndex = 1
      object Label2: TLabel
        Left = 40
        Top = 36
        Width = 81
        Height = 13
        Caption = 'Peak Virtual size:'
      end
      object LabelPeakVirtualSize: TLabel
        Left = 216
        Top = 36
        Width = 6
        Height = 13
        Caption = '0'
      end
      object Label3: TLabel
        Left = 40
        Top = 52
        Width = 53
        Height = 13
        Caption = 'Virtual size:'
      end
      object LabelVirtualSize: TLabel
        Left = 216
        Top = 52
        Width = 6
        Height = 13
        Caption = '0'
      end
      object Label4: TLabel
        Left = 40
        Top = 68
        Width = 111
        Height = 13
        Caption = 'Peak Working Set size:'
      end
      object LabelPeakWorkingSetSize: TLabel
        Left = 216
        Top = 68
        Width = 6
        Height = 13
        Caption = '0'
      end
      object Label6: TLabel
        Left = 40
        Top = 84
        Width = 83
        Height = 13
        Caption = 'Working Set size:'
      end
      object LabelWorkingSetSize: TLabel
        Left = 216
        Top = 84
        Width = 6
        Height = 13
        Caption = '0'
      end
      object Label5: TLabel
        Left = 40
        Top = 112
        Width = 56
        Height = 13
        Caption = 'Page faults:'
      end
      object LabelPageFaults: TLabel
        Left = 216
        Top = 112
        Width = 6
        Height = 13
        Caption = '0'
      end
      object Label11: TLabel
        Left = 40
        Top = 136
        Width = 117
        Height = 13
        Caption = 'Peak Paged pool usage:'
      end
      object LabelQuotaPeakPagedPoolUsage: TLabel
        Left = 216
        Top = 136
        Width = 6
        Height = 13
        Caption = '0'
      end
      object Label17: TLabel
        Left = 40
        Top = 152
        Width = 89
        Height = 13
        Caption = 'Paged pool usage:'
      end
      object LabelPagedPoolUsage: TLabel
        Left = 216
        Top = 152
        Width = 6
        Height = 13
        Caption = '0'
      end
      object Label13: TLabel
        Left = 40
        Top = 168
        Width = 139
        Height = 13
        Caption = 'Peak Non-paged pool usage:'
      end
      object LabelQuotaPeakNonPagedPoolUsage: TLabel
        Left = 216
        Top = 168
        Width = 6
        Height = 13
        Caption = '0'
      end
      object Label21: TLabel
        Left = 40
        Top = 184
        Width = 111
        Height = 13
        Caption = 'Non-paged pool usage:'
      end
      object LabelNonPagedPoolUsage: TLabel
        Left = 216
        Top = 184
        Width = 6
        Height = 13
        Caption = '0'
      end
      object Label19: TLabel
        Left = 40
        Top = 208
        Width = 104
        Height = 13
        Caption = 'Peak Page file usage:'
      end
      object LabelPeakPageFileUsage: TLabel
        Left = 216
        Top = 208
        Width = 6
        Height = 13
        Caption = '0'
      end
      object Label23: TLabel
        Left = 40
        Top = 224
        Width = 76
        Height = 13
        Caption = 'Page file usage:'
      end
      object LabelPageFileUsage: TLabel
        Left = 216
        Top = 224
        Width = 6
        Height = 13
        Caption = '0'
      end
    end
    object TabSheetIOCounters: TTabSheet
      Caption = 'IO Counters'
      ImageIndex = 2
      object Label34: TLabel
        Left = 20
        Top = 20
        Width = 72
        Height = 13
        Caption = 'Read transfers:'
      end
      object LabelReadTransferCount: TLabel
        Left = 104
        Top = 20
        Width = 6
        Height = 13
        Caption = '0'
      end
      object LabelReadOperationCount: TLabel
        Left = 208
        Top = 20
        Width = 64
        Height = 13
        Caption = '0 operation(s)'
      end
      object Label35: TLabel
        Left = 20
        Top = 44
        Width = 71
        Height = 13
        Caption = 'Write transfers:'
      end
      object LabelWriteTransferCount: TLabel
        Left = 104
        Top = 44
        Width = 6
        Height = 13
        Caption = '0'
      end
      object LabelWriteOperationCount: TLabel
        Left = 208
        Top = 44
        Width = 64
        Height = 13
        Caption = '0 operation(s)'
      end
      object Label38: TLabel
        Left = 20
        Top = 68
        Width = 72
        Height = 13
        Caption = 'Other transfers:'
      end
      object LabelOtherTransferCount: TLabel
        Left = 104
        Top = 68
        Width = 6
        Height = 13
        Caption = '0'
      end
      object LabelOtherOperationCount: TLabel
        Left = 208
        Top = 68
        Width = 64
        Height = 13
        Caption = '0 operation(s)'
      end
    end
  end
  object OkButton: TButton
    Left = 240
    Top = 356
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object CancelButton: TButton
    Left = 322
    Top = 356
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
