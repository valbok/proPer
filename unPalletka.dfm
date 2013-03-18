object frmPalletka: TfrmPalletka
  Left = 172
  Top = 148
  Width = 527
  Height = 343
  Caption = #1052#1077#1090#1086#1076' '#1055#1072#1083#1077#1090#1082#1080
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlMain: TPanel
    Left = 0
    Top = 0
    Width = 169
    Height = 316
    Align = alLeft
    BevelInner = bvLowered
    Color = 15658734
    TabOrder = 0
    object Progress: TGauge
      Left = 8
      Top = 154
      Width = 144
      Height = 18
      BackColor = 15132390
      ForeColor = 8404992
      Progress = 0
    end
    object Bevel1: TBevel
      Left = 160
      Top = 7
      Width = 25
      Height = 306
      Shape = bsLeftLine
    end
    object ProgressInner: TGauge
      Left = 8
      Top = 175
      Width = 144
      Height = 18
      Color = clWhite
      ParentColor = False
      Progress = 0
    end
    object btnGo: TBitBtn
      Left = 8
      Top = 196
      Width = 145
      Height = 23
      Caption = #1055#1086#1089#1095#1080#1090#1072#1090#1100
      Default = True
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btnGoClick
    end
    object gbDefPos: TGroupBox
      Left = 8
      Top = 2
      Width = 145
      Height = 151
      Caption = 'Sets'
      TabOrder = 1
      object Label6: TLabel
        Left = 8
        Top = 16
        Width = 25
        Height = 13
        Caption = 'Step:'
      end
      object Label1: TLabel
        Left = 8
        Top = 80
        Width = 29
        Height = 13
        Caption = 'ln(n1):'
      end
      object Label7: TLabel
        Left = 8
        Top = 40
        Width = 30
        Height = 13
        Caption = 'Begin:'
      end
      object Label2: TLabel
        Left = 8
        Top = 104
        Width = 29
        Height = 13
        Caption = 'ln(n2):'
      end
      object sbGO: TSpeedButton
        Left = 5
        Top = 127
        Width = 132
        Height = 19
        Caption = #1057' '#1091#1095#1105#1090#1086#1084' '#1087#1088#1077#1076#1077#1083#1072
        OnClick = sbGOClick
      end
      object Bevel2: TBevel
        Left = 56
        Top = 69
        Width = 57
        Height = 17
        Shape = bsTopLine
        Style = bsRaised
      end
      object Label4: TLabel
        Left = 8
        Top = 63
        Width = 49
        Height = 13
        Caption = #1055#1088#1077#1076#1077#1083#1099':'
        Enabled = False
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object eStep: TEdit
        Left = 56
        Top = 16
        Width = 81
        Height = 21
        TabOrder = 0
        Text = '0,1'
      end
      object eN1: TEdit
        Left = 56
        Top = 80
        Width = 81
        Height = 21
        Color = 14803455
        TabOrder = 2
        Text = '0,1'
      end
      object eBegin: TEdit
        Left = 56
        Top = 40
        Width = 81
        Height = 21
        TabOrder = 1
        Text = '0,1'
      end
      object eN2: TEdit
        Left = 56
        Top = 104
        Width = 81
        Height = 21
        Color = 14803455
        TabOrder = 3
        Text = '1'
      end
    end
    object gbResults: TGroupBox
      Left = 8
      Top = 221
      Width = 145
      Height = 92
      Caption = 'Results:'
      TabOrder = 2
      object Label3: TLabel
        Left = 8
        Top = 19
        Width = 83
        Height = 13
        Caption = #1050#1086#1083'. '#1074#1093#1086#1078#1076#1077#1085#1080#1081':'
      end
      object Label5: TLabel
        Left = 8
        Top = 43
        Width = 85
        Height = 13
        Caption = #1060'.'#1056'a'#1079#1084#1077#1088#1085#1086#1089#1090#1100':'
      end
      object Label8: TLabel
        Left = 8
        Top = 67
        Width = 10
        Height = 13
        Caption = 'B:'
      end
      object eOutN: TEdit
        Left = 96
        Top = 19
        Width = 41
        Height = 21
        Color = 15132390
        ReadOnly = True
        TabOrder = 0
        Text = '0'
      end
      object eD: TEdit
        Left = 96
        Top = 43
        Width = 41
        Height = 21
        Color = 15132390
        ReadOnly = True
        TabOrder = 1
        Text = '0'
      end
      object eB: TEdit
        Left = 96
        Top = 67
        Width = 41
        Height = 21
        Color = 15132390
        ReadOnly = True
        TabOrder = 2
        Text = '0'
      end
    end
  end
  object PageControl1: TPageControl
    Left = 169
    Top = 0
    Width = 350
    Height = 316
    ActivePage = tsGraffik
    Align = alClient
    TabIndex = 0
    TabOrder = 1
    object tsGraffik: TTabSheet
      Caption = 'Graphik'
      object Chart: TChart
        Left = 0
        Top = 0
        Width = 342
        Height = 288
        BackWall.Brush.Color = clWhite
        BackWall.Brush.Style = bsClear
        Title.Text.Strings = (
          '')
        BottomAxis.Title.Caption = 'ln(n)'
        LeftAxis.EndPosition = 99
        LeftAxis.Title.Angle = 0
        LeftAxis.Title.Caption = 'ln(N)'
        View3D = False
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        object Series1: TPointSeries
          Marks.ArrowLength = 8
          Marks.Visible = False
          SeriesColor = clRed
          Title = 'ln(N)/ln(n)'
          Pointer.HorizSize = 3
          Pointer.InflateMargins = True
          Pointer.Style = psCircle
          Pointer.VertSize = 3
          Pointer.Visible = True
          XValues.DateTime = False
          XValues.Name = 'X'
          XValues.Multiplier = 1
          XValues.Order = loAscending
          YValues.DateTime = False
          YValues.Name = 'Y'
          YValues.Multiplier = 1
          YValues.Order = loNone
        end
        object Series2: TLineSeries
          Marks.ArrowLength = 8
          Marks.Visible = False
          SeriesColor = clGreen
          Title = 'line'
          Pointer.InflateMargins = True
          Pointer.Style = psCircle
          Pointer.Visible = False
          XValues.DateTime = False
          XValues.Name = 'X'
          XValues.Multiplier = 1
          XValues.Order = loAscending
          YValues.DateTime = False
          YValues.Name = 'Y'
          YValues.Multiplier = 1
          YValues.Order = loNone
        end
      end
    end
    object tsGrid: TTabSheet
      Caption = 'Values'
      ImageIndex = 1
      object grid: TStringGrid
        Left = 0
        Top = 0
        Width = 342
        Height = 288
        Align = alClient
        BorderStyle = bsNone
        ColCount = 4
        Ctl3D = False
        FixedCols = 0
        RowCount = 2
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing]
        ParentCtl3D = False
        TabOrder = 0
        ColWidths = (
          36
          108
          45
          102)
      end
    end
  end
  object Anim: TAnimate
    Left = 127
    Top = 65
    Width = 16
    Height = 16
    Active = False
    AutoSize = False
    CommonAVI = aviFindComputer
    StopFrame = 8
  end
end
