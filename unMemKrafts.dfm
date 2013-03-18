object frmMemKrafts: TfrmMemKrafts
  Left = 196
  Top = 133
  Width = 544
  Height = 375
  Caption = #1057#1080#1083#1099' & '#1088#1072#1089#1089#1090#1086#1103#1085#1080#1103
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 536
    Height = 348
    ActivePage = tsData
    Align = alClient
    TabIndex = 0
    TabOrder = 0
    object tsData: TTabSheet
      Caption = 'Data'
      object Splitter1: TSplitter
        Left = 261
        Top = 48
        Width = 3
        Height = 257
        Cursor = crHSplit
        Align = alRight
      end
      object progress: TGauge
        Left = 0
        Top = 305
        Width = 528
        Height = 15
        Align = alBottom
        Progress = 0
      end
      object memKrafts: TRichEdit
        Left = 0
        Top = 48
        Width = 261
        Height = 257
        Align = alClient
        Color = 16770790
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object pnlTop: TPanel
        Left = 0
        Top = 0
        Width = 528
        Height = 48
        Align = alTop
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 1
        object Label1: TLabel
          Left = 8
          Top = 32
          Width = 32
          Height = 13
          Caption = #1057#1048#1083#1099':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8404992
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label2: TLabel
          Left = 280
          Top = 32
          Width = 63
          Height = 13
          Caption = #1056#1072#1089#1089#1090#1086#1103#1085#1080#1103':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8404992
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object btnSortByValue_kraft: TBitBtn
          Left = 43
          Top = 31
          Width = 75
          Height = 14
          Caption = 'Sort by Kraft'
          TabOrder = 0
          OnClick = btnSortByValue_kraftClick
        end
        object btnShow: TBitBtn
          Left = 8
          Top = 6
          Width = 75
          Height = 20
          Caption = 'Show'
          TabOrder = 1
          OnClick = btnShowClick
        end
        object btnSortByIndex_kraft: TBitBtn
          Left = 123
          Top = 31
          Width = 75
          Height = 14
          Caption = 'Sort By Index'
          TabOrder = 2
          OnClick = btnSortByIndex_kraftClick
        end
        object cboxIndex: TCheckBox
          Left = 100
          Top = 10
          Width = 125
          Height = 17
          Caption = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1048#1085#1076#1077#1082#1089
          Checked = True
          State = cbChecked
          TabOrder = 3
        end
        object btnSortByValue_Distances: TBitBtn
          Left = 347
          Top = 31
          Width = 94
          Height = 14
          Caption = 'Sort by Distances'
          TabOrder = 4
          OnClick = btnSortByValue_DistancesClick
        end
        object btnSortByIndex_Distances: TBitBtn
          Left = 443
          Top = 31
          Width = 75
          Height = 14
          Caption = 'Sort By Index'
          TabOrder = 5
          OnClick = btnSortByIndex_DistancesClick
        end
        object btnSetIndex: TBitBtn
          Left = 221
          Top = 30
          Width = 49
          Height = 16
          Caption = '<<<'
          TabOrder = 6
          OnClick = btnSetIndexClick
        end
      end
      object memDistance: TRichEdit
        Left = 264
        Top = 48
        Width = 264
        Height = 257
        Align = alRight
        Color = 16770790
        ScrollBars = ssVertical
        TabOrder = 2
      end
    end
    object tsGraph: TTabSheet
      Caption = 'Graph'
      ImageIndex = 1
      object Chart1: TChart
        Left = 97
        Top = 0
        Width = 431
        Height = 320
        BackWall.Brush.Color = clWhite
        BackWall.Brush.Style = bsClear
        Title.Text.Strings = (
          #1053#1072#1087#1088#1103#1078#1105#1085#1085#1086#1089#1090#1100' '#1086#1090' '#1088#1072#1089#1089#1090#1086#1103#1085#1080#1103)
        BottomAxis.Title.Caption = 'R'
        LeftAxis.Title.Angle = 0
        LeftAxis.Title.Caption = 'E'
        Legend.Visible = False
        View3D = False
        Align = alClient
        BevelInner = bvLowered
        TabOrder = 0
        object Series1: TLineSeries
          Marks.ArrowLength = 8
          Marks.Visible = False
          SeriesColor = clRed
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
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
      object pnlRight: TPanel
        Left = 0
        Top = 0
        Width = 97
        Height = 320
        Align = alLeft
        TabOrder = 1
        object btnRun: TBitBtn
          Left = 8
          Top = 8
          Width = 75
          Height = 25
          Caption = 'Show'
          TabOrder = 0
          OnClick = btnRunClick
        end
      end
    end
  end
end
