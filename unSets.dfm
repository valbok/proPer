object frmSets: TfrmSets
  Left = 200
  Top = 129
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
  ClientHeight = 271
  ClientWidth = 139
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
    Width = 139
    Height = 271
    Align = alClient
    BevelInner = bvLowered
    BorderWidth = 1
    TabOrder = 0
    object Label4: TLabel
      Left = 13
      Top = 171
      Width = 39
      Height = 13
      Caption = #1056#1072#1076#1080#1091#1089':'
    end
    object Label5: TLabel
      Left = 13
      Top = 195
      Width = 47
      Height = 13
      Caption = #1052#1086#1083#1077#1082#1091#1083':'
    end
    object gbLim: TGroupBox
      Left = 5
      Top = 3
      Width = 129
      Height = 162
      Caption = #1057#1077#1090#1082#1072':'
      TabOrder = 0
      object Label1: TLabel
        Left = 8
        Top = 64
        Width = 55
        Height = 13
        Caption = #1042#1099#1089#1086#1090#1072' (z):'
      end
      object Label2: TLabel
        Left = 8
        Top = 40
        Width = 50
        Height = 13
        Caption = #1044#1083#1080#1085#1072' (y):'
      end
      object Label3: TLabel
        Left = 8
        Top = 16
        Width = 56
        Height = 13
        Caption = #1064#1080#1088#1080#1085#1072' (x):'
      end
      object Label7: TLabel
        Left = 8
        Top = 89
        Width = 42
        Height = 13
        Caption = #1047#1072#1087#1072#1089' x:'
        WordWrap = True
      end
      object Label8: TLabel
        Left = 8
        Top = 112
        Width = 42
        Height = 13
        Caption = #1047#1072#1087#1072#1089' y:'
      end
      object Label9: TLabel
        Left = 8
        Top = 136
        Width = 42
        Height = 13
        Caption = #1047#1072#1087#1072#1089' z:'
      end
      object eLim_x: TEdit
        Left = 64
        Top = 16
        Width = 60
        Height = 21
        TabOrder = 0
        Text = '5'
        OnExit = eLim_xExit
      end
      object eLim_y: TEdit
        Left = 64
        Top = 40
        Width = 60
        Height = 21
        TabOrder = 1
        Text = '5'
      end
      object eLim_z: TEdit
        Left = 64
        Top = 64
        Width = 60
        Height = 21
        TabOrder = 2
        Text = '5'
      end
      object eLn_x: TEdit
        Left = 64
        Top = 88
        Width = 60
        Height = 21
        TabOrder = 3
        Text = '15'
      end
      object eLn_y: TEdit
        Left = 64
        Top = 112
        Width = 60
        Height = 21
        TabOrder = 4
        Text = '15'
      end
      object eLn_z: TEdit
        Left = 64
        Top = 136
        Width = 60
        Height = 21
        TabOrder = 5
        Text = '15'
      end
    end
    object eRadius: TEdit
      Left = 69
      Top = 171
      Width = 60
      Height = 21
      TabOrder = 1
      Text = '1'
    end
    object btnOk: TBitBtn
      Left = 6
      Top = 237
      Width = 127
      Height = 25
      Caption = 'Ok'
      Default = True
      TabOrder = 3
      OnClick = btnOkClick
    end
    object cbOver: TCheckBox
      Left = 9
      Top = 219
      Width = 124
      Height = 17
      Caption = #1053#1072#1083#1086#1078#1077#1085#1080#1077' '#1084#1086#1083#1077#1082#1091#1083
      Checked = True
      Ctl3D = True
      Enabled = False
      ParentCtl3D = False
      State = cbChecked
      TabOrder = 4
    end
    object eSetColMol: TEdit
      Left = 69
      Top = 195
      Width = 60
      Height = 21
      TabOrder = 2
      Text = '???'
    end
  end
end
