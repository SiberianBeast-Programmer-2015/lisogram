object Form1: TForm1
  Left = 129
  Top = 20
  Width = 1157
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
  object Image1: TImage
    Left = 480
    Top = 80
    Width = 649
    Height = 273
  end
  object ThemeLabel: TLabel
    Left = 240
    Top = 8
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
    Left = 488
    Top = 88
    Width = 593
    Height = 201
    AutoSize = False
    Caption = 'query'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object WindowsMediaPlayer1: TWindowsMediaPlayer
    Left = 192
    Top = 80
    Width = 281
    Height = 273
    TabOrder = 12
    OnOpenStateChange = WindowsMediaPlayer1OpenStateChange
    OnPlayStateChange = WindowsMediaPlayer1PlayStateChange
    ControlData = {
      0003000008003A00000043003A005C00480065006C00700073005C004C006900
      73006F006700720061006D005C0064006100740061005C0031002E0061007600
      690000000500000000000000F03F030000000000050000000000000000000800
      0200000000000300010000000B00FFFF0300000000000B00FFFF080002000000
      00000300320000000B00000008000A0000006E006F006E00650000000B000000
      0B00FFFF0B00FFFF0B00FFFF0B00000008000200000000000800020000000000
      080002000000000008000200000000000B0000000B1D0000371C0000}
  end
  object Variant1: TEdit
    Left = 368
    Top = 384
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
    Left = 256
    Top = 376
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
    Left = 368
    Top = 432
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
    Left = 256
    Top = 424
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
    Left = 368
    Top = 480
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
    Left = 256
    Top = 480
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
    Left = 368
    Top = 528
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
    Left = 256
    Top = 528
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
    Left = 480
    Top = 616
    Width = 75
    Height = 25
    Caption = #1055#1088#1086#1074#1077#1088#1082#1072
    TabOrder = 8
    OnClick = ButtonCheckClick
  end
  object buttonHelp: TButton
    Left = 888
    Top = 616
    Width = 75
    Height = 25
    Caption = 'HELP ME'
    TabOrder = 9
    OnClick = buttonHelpClick
  end
  object variant5: TEdit
    Left = 368
    Top = 568
    Width = 689
    Height = 33
    AutoSize = False
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 10
    Text = 'variant5'
  end
  object CheckBox5: TCheckBox
    Left = 256
    Top = 568
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
    TabOrder = 11
  end
end
