object frmMenu: TfrmMenu
  Left = 413
  Top = 168
  Width = 767
  Height = 512
  Caption = 'frmMenu'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = menuPrincipal
  OldCreateOrder = False
  Position = poDesktopCenter
  WindowState = wsMaximized
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 751
    Height = 71
    ButtonHeight = 67
    ButtonWidth = 71
    Caption = 'ToolBar1'
    TabOrder = 0
    object SpeedButton1: TSpeedButton
      Left = 0
      Top = 2
      Width = 74
      Height = 67
    end
    object SpeedButton2: TSpeedButton
      Left = 74
      Top = 2
      Width = 77
      Height = 67
    end
    object ToolButton1: TToolButton
      Left = 151
      Top = 2
      Width = 26
      Caption = 'ToolButton1'
      Style = tbsSeparator
    end
    object SpeedButton3: TSpeedButton
      Left = 177
      Top = 2
      Width = 72
      Height = 67
      OnClick = SpeedButton3Click
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 435
    Width = 751
    Height = 19
    Panels = <>
  end
  object menuPrincipal: TMainMenu
    Left = 56
    Top = 216
    object Cadastros1: TMenuItem
      Caption = 'Cadastros'
      object Clientes1: TMenuItem
        Caption = 'Clientes'
        OnClick = Clientes1Click
      end
      object Produtos1: TMenuItem
        Caption = 'Produtos'
      end
    end
    object Consultas1: TMenuItem
      Caption = 'Consultas'
    end
  end
  object SQLConnection1: TSQLConnection
    ConnectionName = 'IBConnection'
    DriverName = 'Interbase'
    GetDriverFunc = 'getSQLDriverINTERBASE'
    LibraryName = 'dbexpint.dll'
    LoginPrompt = False
    Params.Strings = (
      'DriverName=Interbase'
      'Database=C:\Reswincs\Delphi\RESULTH.FB'
      'RoleName=RoleName'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'ServerCharSet='
      'SQLDialect=1'
      'ErrorResourceFile='
      'LocaleCode=0000'
      'BlobSize=-1'
      'CommitRetain=False'
      'WaitOnLocks=True'
      'Interbase TransIsolation=ReadCommited'
      'Trim Char=False')
    VendorLib = 'gds32.dll'
    Left = 168
    Top = 144
  end
end
