object frmTestes: TfrmTestes
  Left = 281
  Top = 279
  Width = 588
  Height = 358
  Caption = 'Tela de testes'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poMainFormCenter
  PrintScale = poNone
  Visible = True
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 10
    Top = 25
    Width = 64
    Height = 13
    Caption = 'Primeiro Valor'
  end
  object Label2: TLabel
    Left = 120
    Top = 25
    Width = 70
    Height = 13
    Caption = 'Segundo Valor'
  end
  object Label3: TLabel
    Left = 10
    Top = 121
    Width = 64
    Height = 13
    Caption = 'Primeiro Valor'
  end
  object Label4: TLabel
    Left = 120
    Top = 121
    Width = 70
    Height = 13
    Caption = 'Segundo Valor'
  end
  object btnSair: TButton
    Left = 488
    Top = 280
    Width = 75
    Height = 25
    Caption = 'Sair'
    TabOrder = 0
    OnClick = btnSairClick
  end
  object nedPrimeiroValor: TNumEdit
    Left = 10
    Top = 40
    Width = 80
    Height = 21
    Alignment = taRightJustify
    Decimals = 2
    ShowSeparator = True
    TabOrder = 1
  end
  object nedSegundoValor: TNumEdit
    Left = 120
    Top = 40
    Width = 80
    Height = 21
    Alignment = taRightJustify
    Decimals = 2
    ShowSeparator = True
    TabOrder = 2
  end
  object btnSoma: TButton
    Left = 216
    Top = 40
    Width = 75
    Height = 25
    Caption = 'Soma'
    TabOrder = 3
    OnClick = btnSomaClick
  end
  object btnSomaFunc: TButton
    Left = 304
    Top = 40
    Width = 124
    Height = 25
    Caption = 'Soma Com Fun'#231#227'o'
    TabOrder = 4
    OnClick = btnSomaFuncClick
  end
  object btnLimpar: TButton
    Left = 448
    Top = 40
    Width = 75
    Height = 25
    Caption = 'Limpar'
    TabOrder = 5
    OnClick = btnLimparClick
  end
  object nedVlr1: TNumEdit
    Left = 12
    Top = 136
    Width = 79
    Height = 21
    Alignment = taRightJustify
    Decimals = 2
    ShowSeparator = True
    TabOrder = 6
  end
  object nedVlr2: TNumEdit
    Left = 120
    Top = 136
    Width = 79
    Height = 21
    Alignment = taRightJustify
    Decimals = 2
    ShowSeparator = True
    TabOrder = 7
  end
  object rdgOperacao: TRadioGroup
    Left = 213
    Top = 130
    Width = 105
    Height = 116
    Caption = 'Opera'#231#227'o'
    ItemIndex = 0
    Items.Strings = (
      'Adi'#231#227'o'
      'Subtra'#231#227'o'
      'Multiplica'#231#227'o'
      'Divis'#227'o')
    TabOrder = 8
  end
  object btnExecutaIF: TButton
    Left = 330
    Top = 136
    Width = 104
    Height = 25
    Caption = 'Executa Com IF'
    TabOrder = 9
    OnClick = btnExecutaIFClick
  end
  object btnExecutaCase: TButton
    Left = 330
    Top = 171
    Width = 104
    Height = 25
    Caption = 'Executa Com Case'
    TabOrder = 10
    OnClick = btnExecutaCaseClick
  end
  object Panel1: TPanel
    Left = 352
    Top = 224
    Width = 185
    Height = 41
    Caption = 'Panel1'
    TabOrder = 11
  end
end
