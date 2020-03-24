unit uTestes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, NumEdit, ExtCtrls;

type
  TfrmTestes = class(TForm)
    btnSair: TButton;
    nedPrimeiroValor: TNumEdit;
    nedSegundoValor: TNumEdit;
    Label1: TLabel;
    Label2: TLabel;
    btnSoma: TButton;
    btnSomaFunc: TButton;
    btnLimpar: TButton;
    nedVlr1: TNumEdit;
    nedVlr2: TNumEdit;
    Label3: TLabel;
    Label4: TLabel;
    rdgOperacao: TRadioGroup;
    btnExecutaIF: TButton;
    btnExecutaCase: TButton;
    Panel1: TPanel;
    procedure btnSairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSomaClick(Sender: TObject);
    procedure btnSomaFuncClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure btnExecutaIFClick(Sender: TObject);
    procedure btnExecutaCaseClick(Sender: TObject);
  private
    { Private declarations }
   function somaValores(pVlr1, pVlr2 : Real) : Real;
  public
    { Public declarations }

  end;

var
  frmTestes: TfrmTestes;

implementation

{$R *.dfm}

procedure TfrmTestes.btnSairClick(Sender: TObject);
begin
   Close;
end;

procedure TfrmTestes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action     := caFree;   // tira o formulário da memória
   frmTestes  := Nil;      // marca como não instanciado
end;

procedure TfrmTestes.btnSomaClick(Sender: TObject);
var
   vTotal : Real;
begin
   vTotal := nedPrimeiroValor.Value + nedSegundoValor.Value;
   ShowMessage('O valor da soma é: ' + FormatFloat('###,##0.00',vTotal));
end;

function TfrmTestes.somaValores(pVlr1, pVlr2: Real): Real;
begin
   Result := pVlr1 + pVlr2;
end;

procedure TfrmTestes.btnSomaFuncClick(Sender: TObject);
begin
   ShowMessage('O valor da soma é: ' +
      FormatFloat('###,##0.00', somaValores(nedPrimeiroValor.Value,nedSegundoValor.Value)));
end;

procedure TfrmTestes.btnLimparClick(Sender: TObject);
begin
   nedPrimeiroValor.Clear;      // limpa o valor do primeiro campo com o clear
   nedSegundoValor.Value := 0;  // limpa o valor do segundo campo setando zero
   nedPrimeiroValor.SetFocus;   // seta o foco no primeiro campo
end;

procedure TfrmTestes.btnExecutaIFClick(Sender: TObject);
var
   vTotal : Real;
begin
   // Primeiro validamos os valores
   if ((nedVlr1.Value = 0) or (nedVlr2.Value = 0)) then
      begin
      MessageDlg('Informe os dois valores e tente novamente.',mtInformation,[mbok],0);
      Exit;
   end;

   // Depois fazemos as condições
   if rdgOperacao.ItemIndex = 0 then
      vTotal := nedVlr1.Value + nedVlr2.Value  // adição
   else if rdgOperacao.ItemIndex = 1 then
      vTotal := nedVlr1.Value - nedVlr2.Value  // subtração
   else if rdgOperacao.ItemIndex = 2 then
      vTotal := nedVlr1.Value * nedVlr2.Value  // multiplicação
   else
      vTotal := nedVlr1.Value / nedVlr2.Value; // divisão

   MessageDlg('O valor resultante da operação é: ' +
      FormatFloat('###,##0.00', vTotal) +'.',
      mtInformation,[mbok],0);

end;

procedure TfrmTestes.btnExecutaCaseClick(Sender: TObject);
var
   vTotal : Real;
begin
   // Primeiro validamos os valores
   if ((nedVlr1.Value = 0) or (nedVlr2.Value = 0)) then
      begin
      MessageDlg('Informe os dois valores e tente novamente.',mtInformation,[mbok],0);
      nedVlr1.SetFocus;  // o campo de valor 1 recebe o foco
      Exit;
   end;

   Case rdgOperacao.ItemIndex of
      0 : vTotal := nedVlr1.Value + nedVlr2.Value;  // adição
      1 : vTotal := nedVlr1.Value - nedVlr2.Value;  // subtração
      2 : vTotal := nedVlr1.Value * nedVlr2.Value;  // multiplicação
      3 : vTotal := nedVlr1.Value / nedVlr2.Value;  // divisão
   end;

   MessageDlg('O valor resultante da operação é: ' +
      FormatFloat('###,##0.00', vTotal),mtInformation,[mbok],0);
end;

end.
