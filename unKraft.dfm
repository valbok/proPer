object frmKraft: TfrmKraft
  Left = 192
  Top = 103
  Width = 345
  Height = 455
  Caption = 'Kraft'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
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
    Width = 337
    Height = 278
    Align = alTop
    BevelInner = bvLowered
    Color = 15658734
    TabOrder = 0
    object Label5: TLabel
      Left = 8
      Top = 262
      Width = 32
      Height = 13
      Caption = #1057#1048#1083#1099':'
      Color = 15658734
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 8404992
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object Progress: TGauge
      Left = 8
      Top = 95
      Width = 146
      Height = 16
      BackColor = 15132390
      ForeColor = 8404992
      Kind = gkVerticalBar
      Progress = 0
    end
    object Label9: TLabel
      Left = 15
      Top = 129
      Width = 54
      Height = 13
      Caption = #1064#1072#1075' '#1076#1083#1103' '#1061':'
    end
    object Label10: TLabel
      Left = 15
      Top = 150
      Width = 54
      Height = 13
      Caption = #1064#1072#1075' '#1076#1083#1103' Y:'
    end
    object Label11: TLabel
      Left = 15
      Top = 171
      Width = 54
      Height = 13
      Caption = #1064#1072#1075' '#1076#1083#1103' Z:'
    end
    object Label12: TLabel
      Left = 15
      Top = 192
      Width = 72
      Height = 13
      Caption = #1055#1088#1077#1076#1077#1083' '#1076#1083#1103' '#1061':'
    end
    object Label13: TLabel
      Left = 15
      Top = 213
      Width = 72
      Height = 13
      Caption = #1055#1088#1077#1076#1077#1083' '#1076#1083#1103' Y:'
    end
    object Label14: TLabel
      Left = 15
      Top = 234
      Width = 72
      Height = 13
      Caption = #1055#1088#1077#1076#1077#1083' '#1076#1083#1103' Z:'
    end
    object Bevel3: TBevel
      Left = 4
      Top = 120
      Width = 150
      Height = 137
      Shape = bsFrame
      Style = bsRaised
    end
    object Label15: TLabel
      Left = 8
      Top = 114
      Width = 64
      Height = 13
      Caption = #1057#1077#1090#1082#1072' '#1090#1086#1095#1077#1082':'
      Enabled = False
    end
    object Label3: TLabel
      Left = 168
      Top = 215
      Width = 88
      Height = 13
      Caption = #1059#1084#1077#1085#1100#1096#1080#1090#1100' 3D '#1074':'
    end
    object Label8: TLabel
      Left = 167
      Top = 154
      Width = 104
      Height = 13
      Caption = #1044#1083#1080#1085#1072' '#1082#1072#1089#1072#1090#1077#1083#1100#1085#1086#1081':'
    end
    object gbDefPos: TGroupBox
      Left = 8
      Top = 2
      Width = 145
      Height = 87
      Caption = 'Sets'
      TabOrder = 0
      object Label6: TLabel
        Left = 8
        Top = 16
        Width = 56
        Height = 13
        Caption = #1050#1086#1083'. '#1090#1086#1095#1077#1082':'
      end
      object Label1: TLabel
        Left = 8
        Top = 40
        Width = 18
        Height = 13
        Caption = 'Mu:'
      end
      object Label2: TLabel
        Left = 8
        Top = 64
        Width = 19
        Height = 13
        Caption = 'RO:'
      end
      object eColDOts: TEdit
        Left = 72
        Top = 16
        Width = 65
        Height = 21
        TabOrder = 0
        Text = '225'
      end
      object eMu: TEdit
        Left = 72
        Top = 40
        Width = 65
        Height = 21
        TabOrder = 1
        Text = '1'
      end
      object eRo: TEdit
        Left = 72
        Top = 64
        Width = 65
        Height = 21
        TabOrder = 2
        Text = '1'
      end
    end
    object PageControl1: TPageControl
      Left = 157
      Top = 2
      Width = 178
      Height = 151
      ActivePage = TabSheet1
      TabIndex = 2
      TabOrder = 8
      object ts3d: TTabSheet
        Caption = '3D'
        object sbKasatel3d: TSpeedButton
          Left = 3
          Top = 26
          Width = 166
          Height = 22
          Caption = #1053#1072#1088#1080#1089#1086#1074#1072#1090#1100' 3D '#1082#1072#1089#1072#1090#1077#1083#1100#1085#1099#1077
          OnClick = sbKasatel3dClick
        end
        object btnGo_Kraft: TBitBtn
          Left = 3
          Top = 2
          Width = 166
          Height = 23
          Caption = #1055#1086#1089#1095#1080#1090#1072#1090#1100' 3D'
          Default = True
          TabOrder = 0
          OnClick = btnGo_KraftClick
        end
        object btnPaintPole3d: TBitBtn
          Left = 3
          Top = 98
          Width = 167
          Height = 25
          Caption = 'Paint POLE'
          TabOrder = 1
          OnClick = btnPaintPole3dClick
        end
        object btnExportToMem: TBitBtn
          Left = 3
          Top = 64
          Width = 166
          Height = 25
          Caption = #1057#1080#1083#1099' '#1080' '#1088#1072#1089#1089#1090#1086#1103#1085#1080#1103
          TabOrder = 2
          OnClick = btnExportToMemClick
        end
      end
      object ts2d: TTabSheet
        Caption = '2D'
        ImageIndex = 1
        object Label7: TLabel
          Left = 7
          Top = 10
          Width = 106
          Height = 13
          Caption = #8470' '#1087#1083#1086#1097#1072#1076#1082#1080' '#1076#1083#1103' 2D:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object sbKasatel2d: TSpeedButton
          Left = 3
          Top = 66
          Width = 166
          Height = 22
          Caption = #1053#1072#1088#1080#1089#1086#1074#1072#1090#1100' 2D '#1082#1072#1089#1072#1090#1077#1083#1100#1085#1099#1077
          OnClick = sbKasatel2dClick
        end
        object Bevel2: TBevel
          Left = 3
          Top = 0
          Width = 166
          Height = 33
          Shape = bsFrame
        end
        object cbNumPlane: TComboBox
          Left = 124
          Top = 8
          Width = 41
          Height = 21
          BevelKind = bkSoft
          Style = csDropDownList
          Ctl3D = True
          ItemHeight = 13
          ParentCtl3D = False
          TabOrder = 0
        end
        object btnGo_kraft2d: TBitBtn
          Left = 3
          Top = 42
          Width = 166
          Height = 23
          Caption = #1055#1086#1089#1095#1080#1090#1072#1090#1100' 2D'
          TabOrder = 1
          OnClick = btnGo_kraft2dClick
        end
        object btnPaintPOle: TBitBtn
          Left = 3
          Top = 89
          Width = 167
          Height = 25
          Caption = 'Paint POLE '
          TabOrder = 2
          OnClick = btnPaintPOleClick
        end
      end
      object TabSheet1: TTabSheet
        Caption = #1059#1075#1086#1083
        ImageIndex = 2
        object Label4: TLabel
          Left = 8
          Top = 8
          Width = 42
          Height = 13
          Caption = #1059#1075#1086#1083'XY:'
        end
        object Label16: TLabel
          Left = 8
          Top = 56
          Width = 22
          Height = 13
          Caption = 'Step'
        end
        object Label17: TLabel
          Left = 8
          Top = 32
          Width = 42
          Height = 13
          Caption = #1059#1075#1086#1083'XZ:'
        end
        object eKutXY: TEdit
          Left = 56
          Top = 8
          Width = 57
          Height = 21
          TabOrder = 0
          Text = '0'
        end
        object btnKut3d: TBitBtn
          Left = 3
          Top = 96
          Width = 166
          Height = 25
          Caption = #1055#1086#1089#1095#1080#1090#1072#1090#1100' 3D'
          Default = True
          TabOrder = 3
          OnClick = btnKut3dClick
        end
        object eStepKut: TEdit
          Left = 56
          Top = 56
          Width = 57
          Height = 21
          TabOrder = 2
          Text = '1'
        end
        object eKutXZ: TEdit
          Left = 56
          Top = 32
          Width = 57
          Height = 21
          TabOrder = 1
          Text = '0'
        end
      end
    end
    object btnPaint: TBitBtn
      Left = 156
      Top = 234
      Width = 179
      Height = 23
      Caption = 'Paint'
      TabOrder = 7
      OnClick = btnPaintClick
    end
    object eStepX: TEdit
      Left = 109
      Top = 130
      Width = 41
      Height = 19
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 1
      Text = '1'
    end
    object eSTepZ: TEdit
      Left = 109
      Top = 172
      Width = 41
      Height = 19
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 3
      Text = '1'
    end
    object eStepY: TEdit
      Left = 109
      Top = 151
      Width = 41
      Height = 19
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 2
      Text = '1'
    end
    object eLimStepX: TEdit
      Left = 109
      Top = 193
      Width = 41
      Height = 19
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 4
      Text = '1'
    end
    object eLimStepZ: TEdit
      Left = 109
      Top = 235
      Width = 41
      Height = 19
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 6
      Text = '1'
    end
    object eLimStepY: TEdit
      Left = 109
      Top = 214
      Width = 41
      Height = 19
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 5
      Text = '1'
    end
    object eChange: TEdit
      Left = 262
      Top = 214
      Width = 41
      Height = 19
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 9
      Text = '2'
    end
    object btnPaintLiteri: TBitBtn
      Left = 164
      Top = 194
      Width = 167
      Height = 16
      Caption = #1053#1072#1088#1080#1089#1086#1074#1072#1090#1100' '#1094#1080#1092#1088#1099
      TabOrder = 10
      OnClick = btnPaintLiteriClick
    end
    object cbRandom: TCheckBox
      Left = 168
      Top = 176
      Width = 89
      Height = 17
      Caption = 'Random'
      TabOrder = 11
    end
    object eLenKasatel: TEdit
      Left = 285
      Top = 155
      Width = 41
      Height = 19
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 12
      Text = '0,5'
    end
  end
  object memKrafts: TRichEdit
    Left = 0
    Top = 278
    Width = 337
    Height = 150
    Align = alClient
    Color = 16770790
    ScrollBars = ssVertical
    TabOrder = 1
  end
end
