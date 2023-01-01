object GlbTrans: TGlbTrans
  Left = 132
  Top = 119
  BorderStyle = bsDialog
  Caption = 'Global Transposition'
  ClientHeight = 136
  ClientWidth = 345
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 145
    Height = 89
    Caption = 'Select tracks to transpose'
    TabOrder = 0
    object CheckBox4: TCheckBox
      Left = 16
      Top = 64
      Width = 97
      Height = 17
      Caption = 'Envelope track'
      Checked = True
      State = cbChecked
      TabOrder = 3
    end
    object CheckBox1: TCheckBox
      Left = 16
      Top = 16
      Width = 97
      Height = 17
      Caption = 'Channel A track'
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
    object CheckBox2: TCheckBox
      Left = 16
      Top = 32
      Width = 97
      Height = 17
      Caption = 'Channel B track'
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
    object CheckBox3: TCheckBox
      Left = 16
      Top = 48
      Width = 97
      Height = 17
      Caption = 'Channel C track'
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
  end
  object GroupBox2: TGroupBox
    Left = 160
    Top = 8
    Width = 177
    Height = 89
    Caption = 'Global options'
    TabOrder = 1
    object Label8: TLabel
      Left = 16
      Top = 22
      Width = 99
      Height = 13
      Caption = 'Number of semitones'
    end
    object UpDown8: TUpDown
      Left = 145
      Top = 19
      Width = 15
      Height = 21
      Hint = 'Current pattern'
      Associate = Edit8
      Min = -95
      Max = 95
      TabOrder = 0
    end
    object Edit8: TEdit
      Left = 120
      Top = 19
      Width = 25
      Height = 21
      Hint = 
        'Number of semitones to transpose: positive - up and negative - d' +
        'own'
      TabOrder = 1
      Text = '0'
      OnExit = Edit8Exit
    end
    object RadioButton1: TRadioButton
      Left = 16
      Top = 40
      Width = 89
      Height = 17
      Caption = 'Whole module'
      Checked = True
      TabOrder = 2
      TabStop = True
    end
    object RadioButton2: TRadioButton
      Left = 16
      Top = 56
      Width = 89
      Height = 17
      Caption = 'Only pattern #'
      TabOrder = 3
    end
    object Edit2: TEdit
      Left = 112
      Top = 54
      Width = 33
      Height = 21
      Hint = 'Pattern number to transpose'
      TabOrder = 4
      Text = '0'
      OnExit = Edit2Exit
    end
    object UpDown1: TUpDown
      Left = 145
      Top = 54
      Width = 15
      Height = 21
      Hint = 'Current pattern'
      Associate = Edit2
      Max = 84
      TabOrder = 5
    end
  end
  object Button1: TButton
    Left = 80
    Top = 104
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 184
    Top = 104
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
end
