object Form2: TForm2
  Left = 170
  Top = 125
  BorderStyle = bsDialog
  Caption = #1060#1086#1088#1084#1072' '#1087#1086#1084#1086#1097#1080
  ClientHeight = 442
  ClientWidth = 951
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
    Left = 304
    Top = 392
    Width = 191
    Height = 48
    Caption = #1047#1072#1082#1088#1086#1081#1090#1077', '#1095#1090#1086#1073#1099' '#1074#1077#1088#1085#1091#1090#1100#1089#1103' '#1082' '#1079#1072#1076#1072#1085#1080#1102
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object Button1: TButton
    Left = 48
    Top = 376
    Width = 139
    Height = 25
    Caption = #1042#1077#1088#1085#1091#1090#1100#1089#1103' '#1082' '#1079#1072#1076#1072#1085#1080#1102
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
    Left = 8
    Top = 104
    Width = 209
    Height = 240
    TabOrder = 2
    OnPlayStateChange = WindowsMediaPlayer2PlayStateChange
    ControlData = {
      000300000800000000000500000000000000F03F030000000000050000000000
      0000000008000200000000000300010000000B00FFFF0300000000000B00FFFF
      08000200000000000300320000000B00000008000A000000660075006C006C00
      00000B0000000B0000000B00FFFF0B00FFFF0B00000008000200000000000800
      020000000000080002000000000008000200000000000B0000009A150000CE18
      0000}
  end
end
