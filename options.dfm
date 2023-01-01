object Form1: TForm1
  Left = 192
  Top = 107
  Width = 402
  Height = 369
  Caption = 'Options'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object OpsPages: TPageControl
    Left = 0
    Top = 0
    Width = 393
    Height = 289
    ActivePage = TabSheet1
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'New window'
      object Label1: TLabel
        Left = 8
        Top = 10
        Width = 100
        Height = 13
        Alignment = taRightJustify
        Caption = 'Number of track lines'
      end
      object Label2: TLabel
        Left = 30
        Top = 58
        Width = 78
        Height = 13
        Alignment = taRightJustify
        Caption = 'Track font name'
      end
      object Label3: TLabel
        Left = 80
        Top = 32
        Width = 208
        Height = 16
        Caption = 'Select only monowidth fonts !!!'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Edit1: TEdit
        Left = 112
        Top = 8
        Width = 25
        Height = 21
        TabOrder = 0
        Text = '8'
        OnExit = Edit1Exit
      end
      object UpDown1: TUpDown
        Left = 137
        Top = 8
        Width = 15
        Height = 21
        Associate = Edit1
        Min = 3
        Max = 64
        Position = 8
        TabOrder = 1
      end
      object Edit2: TEdit
        Left = 112
        Top = 56
        Width = 153
        Height = 21
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 2
      end
      object Button3: TButton
        Left = 272
        Top = 56
        Width = 75
        Height = 25
        Caption = 'Choose...'
        TabOrder = 3
        OnClick = Button3Click
      end
    end
    object CurWinds: TTabSheet
      Caption = 'Windows'
      ImageIndex = 2
      object ChanVisAlloc: TRadioGroup
        Left = 8
        Top = 8
        Width = 105
        Height = 121
        Caption = 'Channels allocation'
        ItemIndex = 0
        Items.Strings = (
          'ABC'
          'ACB'
          'BAC'
          'BCA'
          'CAB'
          'CBA')
        TabOrder = 0
        OnClick = ChanVisAllocClick
      end
    end
    object AYEmu: TTabSheet
      Caption = 'Chip emulation'
      ImageIndex = 1
      object Label7: TLabel
        Left = 152
        Top = 242
        Width = 163
        Height = 13
        Caption = 'Some changes will be heared after'
        Visible = False
      end
      object LBChg: TLabel
        Left = 319
        Top = 242
        Width = 40
        Height = 13
        Caption = '2178 ms'
        Visible = False
      end
      object ChipSel: TRadioGroup
        Left = 8
        Top = 8
        Width = 105
        Height = 57
        Caption = 'Sound chip'
        ItemIndex = 1
        Items.Strings = (
          'AY-3-8910/12'
          'YM2149F')
        TabOrder = 0
        OnClick = ChipSelClick
      end
      object ChanSel: TRadioGroup
        Left = 8
        Top = 72
        Width = 105
        Height = 121
        Caption = 'Channels allocation'
        ItemIndex = 1
        Items.Strings = (
          'Mono'
          'ABC'
          'ACB'
          'BAC'
          'BCA'
          'CAB'
          'CBA')
        TabOrder = 1
        OnClick = ChanSelClick
      end
      object IntSel: TRadioGroup
        Left = 120
        Top = 72
        Width = 161
        Height = 57
        Caption = 'Interrupt frequency'
        ItemIndex = 0
        Items.Strings = (
          'ZX Spectrum 50 Hz'
          'Pentagon 128K 48.828 Hz')
        TabOrder = 2
        OnClick = IntSelClick
      end
      object Opt: TRadioGroup
        Left = 8
        Top = 200
        Width = 105
        Height = 57
        Caption = 'Optimization'
        ItemIndex = 0
        Items.Strings = (
          'for quality'
          'for perfomance')
        TabOrder = 3
        OnClick = OptClick
      end
      object ChFreq: TRadioGroup
        Left = 120
        Top = 8
        Width = 161
        Height = 57
        Caption = 'Chip frequency'
        ItemIndex = 0
        Items.Strings = (
          'ZX Spectrum 1.7734 MHz'
          'Pentagon 128K 1.75 MHz')
        TabOrder = 4
        OnClick = ChFreqClick
      end
      object FiltersGroup: TGroupBox
        Left = 120
        Top = 136
        Width = 161
        Height = 105
        Caption = 'Downsampling'
        TabOrder = 5
        object Label8: TLabel
          Left = 64
          Top = 40
          Width = 35
          Height = 13
          Caption = 'Quality:'
        end
        object Label9: TLabel
          Left = 8
          Top = 88
          Width = 20
          Height = 13
          Caption = 'Low'
        end
        object Label10: TLabel
          Left = 128
          Top = 88
          Width = 22
          Height = 13
          Caption = 'High'
        end
        object FiltChk: TCheckBox
          Left = 8
          Top = 16
          Width = 89
          Height = 17
          Caption = 'Use FIR-filter'
          Checked = True
          State = cbChecked
          TabOrder = 0
          OnClick = FiltChkClick
        end
        object FiltNK: TTrackBar
          Left = 8
          Top = 56
          Width = 145
          Height = 33
          Max = 9
          Min = 4
          PageSize = 1
          Position = 5
          TabOrder = 1
          OnChange = FiltNKChange
        end
      end
    end
    object OpMod: TTabSheet
      Caption = 'Compatibility'
      ImageIndex = 3
      object RadioGroup1: TRadioGroup
        Left = 8
        Top = 8
        Width = 113
        Height = 73
        Caption = '3xxx command style'
        ItemIndex = 2
        Items.Strings = (
          'Vortex Tracker II'
          'Pro Tracker 3.5'
          'Try detect')
        TabOrder = 0
        OnClick = RadioGroup1Click
      end
      object SaveHead: TRadioGroup
        Left = 128
        Top = 8
        Width = 177
        Height = 73
        Caption = 'Save with '#1085'eader'
        ItemIndex = 2
        Items.Strings = (
          'Vortex Tracker II 1.0 module: '
          'ProTracker 3.x compilation of '
          'Try detect')
        TabOrder = 1
        OnClick = SaveHeadClick
      end
    end
    object WOAPITAB: TTabSheet
      Caption = 'Wave out'
      ImageIndex = 4
      object SpeedButton1: TSpeedButton
        Left = 312
        Top = 232
        Width = 55
        Height = 22
        Action = MainForm.Stop1
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          1800000000000003000000000000000000000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FF000000000000000000000000000000000000000000FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00000000000000
          0000000000000000000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FF000000000000000000000000000000000000000000FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00000000000000
          0000000000000000000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FF000000000000000000000000000000000000000000FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00000000000000
          0000000000000000000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FF000000000000000000000000000000000000000000FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00000000000000
          0000000000000000000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      end
      object SR: TRadioGroup
        Left = 8
        Top = 8
        Width = 81
        Height = 105
        Caption = 'Sample rate'
        ItemIndex = 2
        Items.Strings = (
          '11025 Hz'
          '22050 Hz'
          '44100 Hz'
          '48000 Hz')
        TabOrder = 0
        OnClick = SRClick
      end
      object BR: TRadioGroup
        Left = 96
        Top = 8
        Width = 65
        Height = 49
        Caption = 'Bit rate'
        ItemIndex = 1
        Items.Strings = (
          '8 bit'
          '16 bit')
        TabOrder = 1
        OnClick = BRClick
      end
      object NCh: TRadioGroup
        Left = 96
        Top = 64
        Width = 65
        Height = 49
        Caption = 'Channels'
        ItemIndex = 1
        Items.Strings = (
          'Mono'
          'Stereo')
        TabOrder = 2
        OnClick = NChClick
      end
      object Buff: TGroupBox
        Left = 8
        Top = 120
        Width = 153
        Height = 137
        Caption = 'Buffers'
        TabOrder = 3
        object LbLen: TLabel
          Left = 72
          Top = 16
          Width = 34
          Height = 13
          Caption = '726 ms'
        end
        object LbNum: TLabel
          Left = 96
          Top = 64
          Width = 6
          Height = 13
          Caption = '3'
        end
        object Label4: TLabel
          Left = 8
          Top = 115
          Width = 56
          Height = 13
          Caption = 'Total length'
        end
        object LBTot: TLabel
          Left = 69
          Top = 115
          Width = 40
          Height = 13
          Caption = '2178 ms'
        end
        object Label5: TLabel
          Left = 8
          Top = 16
          Width = 60
          Height = 13
          Caption = 'Buffer length'
        end
        object Label6: TLabel
          Left = 8
          Top = 64
          Width = 84
          Height = 13
          Caption = 'Number of buffers'
        end
        object TrackBar1: TTrackBar
          Left = 2
          Top = 32
          Width = 149
          Height = 33
          Hint = 'Length of one buffer'
          Max = 2000
          Min = 5
          PageSize = 1
          Frequency = 100
          Position = 726
          TabOrder = 0
          OnChange = TrackBar1Change
        end
        object TrackBar2: TTrackBar
          Left = 2
          Top = 80
          Width = 149
          Height = 33
          Hint = 'Number of buffers'
          Min = 2
          PageSize = 1
          Position = 3
          TabOrder = 1
          OnChange = TrackBar2Change
        end
      end
      object SelDev: TGroupBox
        Left = 168
        Top = 8
        Width = 193
        Height = 105
        Caption = 'Wave out device'
        TabOrder = 4
        object Edit3: TEdit
          Left = 8
          Top = 16
          Width = 177
          Height = 21
          Color = clBtnFace
          ReadOnly = True
          TabOrder = 0
          Text = 'Wave mapper'
        end
        object Button4: TButton
          Left = 8
          Top = 40
          Width = 177
          Height = 25
          Caption = 'Get full list'
          TabOrder = 1
          OnClick = Button4Click
        end
        object ComboBox1: TComboBox
          Left = 8
          Top = 72
          Width = 177
          Height = 21
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 2
          Visible = False
          OnChange = ComboBox1Change
        end
      end
    end
    object OtherOps: TTabSheet
      Caption = 'Other'
      ImageIndex = 5
      object PriorGrp: TRadioGroup
        Left = 8
        Top = 8
        Width = 121
        Height = 57
        Caption = 'Application priority'
        ItemIndex = 0
        Items.Strings = (
          'normal'
          'high')
        TabOrder = 0
        OnClick = PriorGrpClick
      end
    end
  end
  object Button1: TButton
    Left = 104
    Top = 304
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TButton
    Left = 208
    Top = 304
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [fdEffects, fdForceFontExist]
    Left = 16
    Top = 304
  end
end
