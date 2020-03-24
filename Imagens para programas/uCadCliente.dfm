object frmCadCliente: TfrmCadCliente
  Left = 533
  Top = 190
  Width = 637
  Height = 488
  Caption = 'frmCadCliente'
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
  object Button1: TButton
    Left = 536
    Top = 64
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object nedNum1: TNumEdit
    Left = 48
    Top = 64
    Width = 121
    Height = 21
    Alignment = taRightJustify
    Decimals = 0
    ShowSeparator = True
    TabOrder = 1
  end
end
