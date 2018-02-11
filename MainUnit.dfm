object Form1: TForm1
  Left = 270
  Top = 150
  Width = 870
  Height = 689
  Caption = 'Test player'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ThemeLabel: TLabel
    Left = 24
    Top = 16
    Width = 809
    Height = 57
    Alignment = taCenter
    AutoSize = False
    Caption = 
      'THEME the txt of txtxt  saudas asdsadhas duhsad7d hdas7 7sa8d78s' +
      'da78a78as78sa87as78sa7as7as78sa'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object QueryLabel: TLabel
    Left = 24
    Top = 328
    Width = 817
    Height = 57
    AutoSize = False
    Caption = 'query'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Image1: TImage
    Left = 304
    Top = 72
    Width = 449
    Height = 241
  end
  object Memo1: TMemo
    Left = 856
    Top = 72
    Width = 185
    Height = 305
    ScrollBars = ssVertical
    TabOrder = 10
  end
  object Variant1: TEdit
    Left = 152
    Top = 392
    Width = 689
    Height = 33
    AutoSize = False
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    Text = 'Variant1'
  end
  object CheckBox1: TCheckBox
    Left = 40
    Top = 384
    Width = 97
    Height = 41
    Caption = '1'
    Constraints.MaxHeight = 100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object Variant2: TEdit
    Left = 152
    Top = 440
    Width = 689
    Height = 33
    AutoSize = False
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    Text = 'Edit1'
  end
  object CheckBox2: TCheckBox
    Left = 40
    Top = 432
    Width = 97
    Height = 41
    Caption = '2'
    Constraints.MaxHeight = 100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object Variant3: TEdit
    Left = 152
    Top = 488
    Width = 689
    Height = 33
    AutoSize = False
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    Text = 'Edit1'
  end
  object CheckBox3: TCheckBox
    Left = 40
    Top = 488
    Width = 97
    Height = 41
    Caption = '3'
    Constraints.MaxHeight = 100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object Variant4: TEdit
    Left = 152
    Top = 536
    Width = 689
    Height = 33
    AutoSize = False
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    Text = 'Edit1'
  end
  object CheckBox4: TCheckBox
    Left = 40
    Top = 536
    Width = 97
    Height = 41
    Caption = '4'
    Constraints.MaxHeight = 100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
  end
  object ButtonCheck: TButton
    Left = 264
    Top = 616
    Width = 75
    Height = 25
    Caption = #1055#1088#1086#1074#1077#1088#1082#1072
    TabOrder = 8
    OnClick = ButtonCheckClick
  end
  object buttonHelp: TButton
    Left = 656
    Top = 616
    Width = 75
    Height = 25
    Caption = 'HELP ME'
    TabOrder = 9
    OnClick = buttonHelpClick
  end
  object variant5: TEdit
    Left = 152
    Top = 576
    Width = 689
    Height = 33
    AutoSize = False
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 12
    Text = 'variant5'
  end
  object CheckBox5: TCheckBox
    Left = 40
    Top = 576
    Width = 97
    Height = 41
    Caption = '5'
    Constraints.MaxHeight = 100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 13
  end
  object Button1: TButton
    Left = 200
    Top = 288
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 14
    OnClick = Button1Click
  end
  object WindowsMediaPlayer1: TWindowsMediaPlayer
    Left = 56
    Top = 16
    Width = 245
    Height = 240
    TabOrder = 15
    OnPlayStateChange = WindowsMediaPlayer1PlayStateChange
    OnEndOfStream = WindowsMediaPlayer1EndOfStream
    OnMediaChange = WindowsMediaPlayer1MediaChange
    ControlData = {
      000300000800000000000500000000000000F03F030000000000050000000000
      0000000008000200000000000300010000000B00FFFF0300000000000B00FFFF
      08000200000000000300320000000B00000008000A000000660075006C006C00
      00000B0000000B0000000B00FFFF0B00FFFF0B00000008000200000000000800
      020000000000080002000000000008000200000000000B00000052190000CE18
      0000}
  end
  object Button2: TButton
    Left = 760
    Top = 224
    Width = 75
    Height = 25
    Caption = 'Button2'
    TabOrder = 16
    OnClick = Button2Click
  end
  object Button4: TButton
    Left = 760
    Top = 272
    Width = 75
    Height = 25
    Caption = 'Button4'
    TabOrder = 17
    OnClick = Button4Click
  end
end
