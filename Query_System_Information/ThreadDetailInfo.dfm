object fThreadDetailInfo: TfThreadDetailInfo
  Left = 198
  Top = 107
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'fThreadDetailInfo'
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
        Width = 47
        Height = 13
        Caption = 'Wait time:'
      end
      object LabelWaitTime: TLabel
        Left = 124
        Top = 12
        Width = 6
        Height = 13
        Caption = '0'
      end
      object Label7: TLabel
        Left = 44
        Top = 32
        Width = 65
        Height = 13
        Caption = 'Start address:'
      end
      object LabelStartAddress: TLabel
        Left = 124
        Top = 32
        Width = 6
        Height = 13
        Caption = '0'
      end
      object Label12: TLabel
        Left = 44
        Top = 64
        Width = 34
        Height = 13
        Caption = 'Priority:'
      end
      object LabelPriority: TLabel
        Left = 124
        Top = 64
        Width = 6
        Height = 13
        Caption = '0'
      end
      object Label20: TLabel
        Left = 44
        Top = 112
        Width = 46
        Height = 13
        Caption = 'Reserved'
      end
      object LabelReserved: TLabel
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
      object Label28: TLabel
        Left = 44
        Top = 48
        Width = 60
        Height = 13
        Caption = 'Base priority:'
      end
      object LabelBasePriority: TLabel
        Left = 124
        Top = 48
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
