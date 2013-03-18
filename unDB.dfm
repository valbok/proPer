object frmDB: TfrmDB
  Left = 192
  Top = 103
  Width = 276
  Height = 300
  Caption = 'DataBase'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object pnlMain: TPanel
    Left = 0
    Top = 0
    Width = 268
    Height = 217
    Align = alClient
    BevelInner = bvLowered
    BorderWidth = 1
    TabOrder = 0
    object pc: TPageControl
      Left = 3
      Top = 3
      Width = 262
      Height = 211
      ActivePage = tsAddStatiskiks
      Align = alClient
      TabIndex = 0
      TabOrder = 0
      object tsAddStatiskiks: TTabSheet
        Caption = #1044#1086#1073#1072#1074#1080#1090#1100':'
        object pnlBotData: TPanel
          Left = 0
          Top = 0
          Width = 254
          Height = 183
          Align = alClient
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 0
          object Bevel1: TBevel
            Left = 5
            Top = 5
            Width = 242
            Height = 171
            Shape = bsFrame
            Style = bsRaised
          end
          object Label1: TLabel
            Left = 9
            Top = 13
            Width = 143
            Height = 13
            Caption = #1060#1088#1072#1082#1090#1072#1083#1100#1085#1072#1103' '#1088#1072#1079#1084#1077#1088#1085#1086#1089#1090#1100':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label3: TLabel
            Left = 9
            Top = 37
            Width = 114
            Height = 13
            Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1096#1072#1088#1086#1074' (N):'
          end
          object Label5: TLabel
            Left = 9
            Top = 61
            Width = 156
            Height = 13
            Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1096#1072#1088#1086#1074' '#1074' '#1082#1083#1072#1089#1090#1077#1088#1077':'
          end
          object Label6: TLabel
            Left = 9
            Top = 85
            Width = 123
            Height = 13
            Caption = #1055#1077#1088#1082#1086#1083#1103#1094#1080#1086#1085#1085#1099#1081' '#1087#1086#1088#1086#1075':'
          end
          object Label2: TLabel
            Left = 9
            Top = 109
            Width = 146
            Height = 13
            Caption = #1057#1090#1077#1087#1077#1085#1085#1086#1081' '#1082#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090' (m):'
          end
          object Label7: TLabel
            Left = 9
            Top = 133
            Width = 159
            Height = 13
            Caption = #1050#1086#1085#1089#1090#1072#1085#1090#1072' '#1074#1079#1072#1080#1084#1086#1076#1077#1081#1089#1090#1074#1080#1103' (a):'
          end
          object Label4: TLabel
            Left = 9
            Top = 157
            Width = 71
            Height = 13
            Caption = #1050#1086#1085#1089#1090#1072#1085#1090#1072' (b):'
          end
          object dbeD: TDBEdit
            Left = 168
            Top = 8
            Width = 67
            Height = 21
            DataField = 'D'
            DataSource = DM.dsStatistiks
            TabOrder = 0
          end
          object dbeN: TDBEdit
            Left = 168
            Top = 32
            Width = 67
            Height = 21
            DataField = 'N'
            DataSource = DM.dsStatistiks
            TabOrder = 1
          end
          object dbeGlubina: TDBEdit
            Left = 168
            Top = 56
            Width = 67
            Height = 21
            DataField = 'Glubina'
            DataSource = DM.dsStatistiks
            TabOrder = 2
            OnExit = dbeGlubinaExit
          end
          object dbePPorog: TDBEdit
            Left = 168
            Top = 80
            Width = 67
            Height = 21
            DataField = 'PPorog'
            DataSource = DM.dsStatistiks
            TabOrder = 3
          end
          object dbeM: TDBEdit
            Left = 168
            Top = 104
            Width = 67
            Height = 21
            DataField = 'm'
            DataSource = DM.dsStatistiks
            TabOrder = 4
          end
          object dbeA: TDBEdit
            Left = 168
            Top = 128
            Width = 67
            Height = 21
            DataField = 'a'
            DataSource = DM.dsStatistiks
            TabOrder = 5
          end
          object dbeB: TDBEdit
            Left = 168
            Top = 152
            Width = 67
            Height = 21
            DataField = 'b'
            DataSource = DM.dsStatistiks
            TabOrder = 6
          end
        end
      end
      object tsViewStatistiks: TTabSheet
        Caption = #1041#1044
        ImageIndex = 1
        object DBGrid1: TDBGrid
          Left = 0
          Top = 0
          Width = 492
          Height = 258
          Align = alClient
          Color = 15790335
          DataSource = DM.dsStatistiks
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
        end
      end
    end
  end
  object DBNavigator: TDBNavigator
    Left = 0
    Top = 217
    Width = 268
    Height = 18
    DataSource = DM.dsStatistiks
    Align = alBottom
    Flat = True
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 235
    Width = 268
    Height = 19
    Panels = <
      item
        Text = 'Waiting'
        Width = 50
      end>
    SimplePanel = False
  end
  object MainMenu: TMainMenu
    Left = 448
    Top = 112
    object Settings: TMenuItem
      Caption = 'Settings'
      OnClick = SettingsClick
      object mmiOpen: TMenuItem
        Caption = 'Open'
        ShortCut = 120
        OnClick = mmiOpenClick
      end
      object mmiClose: TMenuItem
        Caption = 'Close'
        ShortCut = 123
        OnClick = mmiCloseClick
      end
    end
  end
end
