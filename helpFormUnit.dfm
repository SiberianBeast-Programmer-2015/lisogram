object Form2: TForm2
  Left = 192
  Top = 124
  Width = 928
  Height = 480
  Caption = 'Form2'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Visible = True
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 136
    Top = 312
    Width = 32
    Height = 13
    Caption = 'Label1'
  end
  object RichEdit1: TRichEdit
    Left = 328
    Top = 16
    Width = 561
    Height = 385
    Lines.Strings = (
      'RichEdit1')
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object WindowsMediaPlayer1: TWindowsMediaPlayer
    Left = 40
    Top = 40
    Width = 245
    Height = 240
    TabOrder = 1
    ControlData = {
      000300000800000000000500000000000000F03F030000000000050000000000
      0000000008000200000000000300010000000B00FFFF0300000000000B00FFFF
      08000200000000000300320000000B00000008000A000000660075006C006C00
      00000B0000000B0000000B00FFFF0B00FFFF0B00000008000200000000000800
      020000000000080002000000000008000200000000000B00000052190000CE18
      0000}
  end
  object Button1: TButton
    Left = 128
    Top = 360
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 2
    OnClick = Button1Click
  end
end
