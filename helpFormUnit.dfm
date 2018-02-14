object Form2: TForm2
  Left = 193
  Top = 128
  Width = 1175
  Height = 480
  Caption = #1060#1086#1088#1084#1072' '#1087#1086#1084#1086#1097#1080
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Visible = True
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 136
    Top = 312
    Width = 32
    Height = 13
    Caption = 'Label1'
  end
  object Button1: TButton
    Left = 128
    Top = 360
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object r: TRichEdit
    Left = 256
    Top = 8
    Width = 681
    Height = 393
    Lines.Strings = (
      'r')
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object WindowsMediaPlayer2: TWindowsMediaPlayer
    Left = 0
    Top = 48
    Width = 245
    Height = 240
    TabOrder = 2
    ControlData = {
      000300000800000000000500000000000000F03F030000000000050000000000
      0000000008000200000000000300010000000B00FFFF0300000000000B00FFFF
      08000200000000000300320000000B00000008000A000000660075006C006C00
      00000B0000000B0000000B00FFFF0B00FFFF0B00000008000200000000000800
      020000000000080002000000000008000200000000000B00000052190000CE18
      0000}
  end
end
