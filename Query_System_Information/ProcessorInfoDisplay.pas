{
   Модуль: ProcessorInfoDisplay

   Описание: Отображение информации о процессоре
   (класс SystemProcessorInformation)

   Автор: Игорь Шевченко

   Дата создания: 17.12.2002

   История изменений:
}
unit ProcessorInfoDisplay;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, AbstractDisplay, StdCtrls;

type
  TfProcessorInfoDisplay = class(TfAbstractDisplayData)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    FeaturesListBox: TListBox;
    LabelArchitecture: TLabel;
    LabelLevel: TLabel;
    LabelRevision: TLabel;
    LabelUnknown: TLabel;
    LabelFeatures: TLabel;
    procedure FeaturesListBoxDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
  protected
    procedure DisplayData; override;
  end;

implementation
uses
  NtDll;

{$R *.dfm}

{
  Рисование марки CheckBox'а.
  Идея взята из FlatStyle controls, автор Maik Porkert (www.flatstyle2k.com)
}
procedure DrawCheckBoxMark (Canvas : TCanvas; const Rect : TRect; AColor : TColor);
begin
  with Canvas do begin
    FillRect(Rect);
    Pen.Color := AColor;
    PenPos := Point(Rect.Left+2, Rect.Top+4);
    LineTo(Rect.Left+6, Rect.Top+8);
    PenPos := Point(Rect.Left+2, Rect.Top+5);
    LineTo(Rect.Left+5, Rect.Top+8);
    PenPos := Point(Rect.Left+2, Rect.Top+6);
    LineTo(Rect.Left+5, Rect.Top+9);
    PenPos := Point(Rect.Left+8, Rect.Top+2);
    LineTo(Rect.Left+4, Rect.Top+6);
    PenPos := Point(Rect.Left+8, Rect.Top+3);
    LineTo(Rect.Left+4, Rect.Top+7);
    PenPos := Point(Rect.Left+8, Rect.Top+4);
    LineTo(Rect.Left+5, Rect.Top+7);
  end;
end;

procedure TfProcessorInfoDisplay.FeaturesListBoxDrawItem(
  Control: TWinControl; Index: Integer; Rect: TRect;
  State: TOwnerDrawState);
var
  Checked : Boolean;
  CheckBoxRect : TRect;
  ListBox : TListBox;
begin
  Listbox := Control AS TListBox;
  ListBox.Canvas.FillRect(Rect);
  Checked := ListBox.Items.Objects[Index] <> nil;
  CheckBoxRect := Rect;
  CheckBoxRect.Right := Rect.Left + Rect.Bottom - Rect.Top; { Сделать квадратным }
  Inc(Rect.Left, CheckBoxRect.Right - CheckBoxRect.Left); { Место для текста }
  if Checked then begin
    { Разместить CheckBox Mark по центру его места }
    Inc(CheckBoxRect.Left, ((CheckBoxRect.Right - CheckBoxRect.Left) - 17) DIV 2);
    Inc(CheckBoxRect.Top, ((CheckBoxRect.Bottom - CheckBoxRect.Top) - 13) DIV 2);
    DrawCheckBoxMark(ListBox.Canvas, CheckBoxRect, clMaroon);
  end;
  DrawText(ListBox.Canvas.Handle, PChar(ListBox.Items[Index]), -1, Rect,
           DT_SINGLELINE OR DT_LEFT OR DT_VCENTER);
end;

procedure TfProcessorInfoDisplay.DisplayData;
begin
  with SYSTEM_PROCESSOR_INFORMATION(Data^) do begin
    LabelArchitecture.Caption := Format('%.4x', [ProcessorArchitecture]);
    LabelLevel.Caption := Format('%.4x', [ProcessorLevel]);
    LabelRevision.Caption := Format('%.4x', [ProcessorRevision]);
    LabelUnknown.Caption := Format('%.4x', [Unknown]);
    LabelFeatures.Caption := Format('%.8x', [FeatureBits]);
    with FeaturesListBox.Items do begin
      AddObject('Virtual-8086 mode enhancements',
          TObject((FeatureBits AND PFB_VME) <> 0));
      AddObject('Time Stamp counter',
          TObject((FeatureBits AND PFB_TCS) <> 0));
      AddObject('CR4 register',
          TObject((FeatureBits AND PFB_CR4) <> 0));
      AddObject('Conditional Mov/Cmp instruction',
          TObject((FeatureBits AND PFB_CMOV) <> 0));
      AddObject('PTE Global bit', TObject((FeatureBits AND PFB_PGE) <> 0));
      AddObject('Page Size extension', TObject((FeatureBits AND PFB_PSE) <> 0));
      AddObject('Memory Type Range registers',
          TObject((FeatureBits AND PFB_MTRR) <> 0));
      AddObject('CMPXCHGB8 instruction',
          TObject((FeatureBits AND PFB_CXS) <> 0));
      AddObject('MMX Technology',
          TObject((FeatureBits AND PFB_MMX) <> 0));
      AddObject('Page Attribute Table',
          TObject((FeatureBits AND PFB_PAT) <> 0));
      AddObject('Fast Floating Point save/restore',
          TObject((FeatureBits AND PFB_FXSR) <> 0));
      AddObject('Streaming SIMD extension',
          TObject((FeatureBits AND PFB_SIMD) <> 0));
    end;
  end;
end;

initialization
  RegisterClass(TfProcessorInfoDisplay);
end.
