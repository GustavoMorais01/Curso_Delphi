unit uCadClie;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, FMTBcd, DBClient, Provider, DB,
  SqlExpr, SimpleDS, Grids, DBGrids, ComCtrls, Funcoes;

type
  TfrmCadClie = class(TForm)
    qryClientes: TSQLQuery;
    dspClientes: TDataSetProvider;
    cdsClientes: TClientDataSet;
    qryGravaRegistro: TSQLQuery;
    sdsClientes: TSimpleDataSet;
    Label1: TLabel;
    edtCodigo: TEdit;
    Label2: TLabel;
    edtNome: TEdit;
    stbtStatus: TStatusBar;
    dbgClientes: TDBGrid;
    dtsClientes: TDataSource;
    Panel1: TPanel;
    BtIncluir: TBitBtn;
    BtAlterar: TBitBtn;
    BtExcluir: TBitBtn;
    BtSair: TBitBtn;
    BtConsulta: TBitBtn;
    BtLista: TBitBtn;
    BtPesquisa: TBitBtn;
    BtOk: TBitBtn;
    BtCancelar: TBitBtn;
    BtProximo: TBitBtn;
    BtAnterior: TBitBtn;
    BtVoltar: TBitBtn;
    qryProximoCodigo: TSQLQuery;
    qryGravacao: TSQLQuery;
    qryConsulta: TSQLQuery;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtPesquisaClick(Sender: TObject);
    procedure BtOkClick(Sender: TObject);
    procedure BtIncluirClick(Sender: TObject);
    procedure BtAlterarClick(Sender: TObject);
    procedure BtExcluirClick(Sender: TObject);
    procedure BtConsultaClick(Sender: TObject);
    procedure BtSairClick(Sender: TObject);
    procedure BtVoltarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgClientesDblClick(Sender: TObject);
    procedure BtCancelarClick(Sender: TObject);
    procedure BtProximoClick(Sender: TObject);
    procedure BtAnteriorClick(Sender: TObject);
    procedure edtCodigoExit(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    MOpcao : String;
    MPesquisou : Boolean;
    MKey   : Word;
    procedure PCamposLimpa;
    procedure PExecutaOpcao;
    procedure PproximoCodigo;
    procedure PCarregaCampos;
    procedure PCamposEnabled(VOpcao : Boolean);
    procedure PBotoesVisibled(VOpcao : Boolean);
    procedure PBotoesEnabled(VOpcao : Boolean);
    function  FValidaDados : Boolean;
    procedure PGravaRegistro;
  public
    { Public declarations }
  end;

var
  frmCadClie: TfrmCadClie;

implementation

uses Menu;

{$R *.dfm}

procedure TfrmCadClie.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action     := caFree;   // tira o formulário da memória
   frmCadClie := Nil;      // marca como não instanciado
end;

procedure TfrmCadClie.BtPesquisaClick(Sender: TObject);
begin
   Screen.Cursor := crHourGlass;
   sdsClientes.close;
   sdsClientes.DataSet.CommandText := 'select * from CLIENTE order by codCliente';
   sdsClientes.Open;
   Screen.Cursor := crDefault;

   if sdsClientes.IsEmpty then
      begin
      MessageDlg('Não há dados para a pesquisa',mtInformation,[mbOk],0);
      exit;
   end;

   PBotoesVisibled(false);
   BtVoltar.Visible    := true;
   dbgClientes.Align   := alClient;
   dbgClientes.Visible := true;
end;

procedure TfrmCadClie.BtOkClick(Sender: TObject);
begin
   if not FValidaDados then
      exit;

   try
      PGravaRegistro;
   Except
      on msg : Exception do
         begin
         MessageDlg('Não foi possível salvar o cliente.' +#13+
                    'Entre em contato com o suporte técnico.' +#13+#13+
                    'Erro gerado: ' + msg.Message ,mtError,[mbOk],0);
         exit;
      end;
   end;

   MPesquisou := false;

   if (MOpcao = 'I') or (MOpcao = 'A') then
      begin
      PCamposLimpa;
      PExecutaOpcao;
   end;

end;

procedure TfrmCadClie.BtIncluirClick(Sender: TObject);
begin
   MOpcao := 'I';
   PCamposLimpa;
   PExecutaOpcao;
end;

procedure TfrmCadClie.BtAlterarClick(Sender: TObject);
begin
   MOpcao := 'A';
   PExecutaOpcao;
end;

procedure TfrmCadClie.BtExcluirClick(Sender: TObject);
begin
   MOpcao := 'E';
   PExecutaOpcao;
end;

procedure TfrmCadClie.BtConsultaClick(Sender: TObject);
begin
   MOpcao := 'C';
   PCamposLimpa;
   PExecutaOpcao;
end;

procedure TfrmCadClie.PCamposLimpa;
begin
   edtCodigo.Clear;
   edtNome.Clear;
end;

procedure TfrmCadClie.PExecutaOpcao;
begin
   // Setar um estado inicial no procedimento PExecutaOpcao
   BtOk.Enabled       := true;
   BtCancelar.Enabled := true;
   BtAlterar.Enabled  := false;
   BtExcluir.Enabled  := false;
   BtConsulta.Enabled := false;
   BtLista.Enabled    := false;
   BtPesquisa.Enabled := false;
   BtProximo.Enabled  := false;
   BtAnterior.Enabled := false;
   BtVoltar.Enabled   := false;
   BtIncluir.Enabled  := false;

   if MOpcao = 'I' then
      begin
      stbtStatus.Panels[0].Text := 'Você está na Inclusão.';
      PCamposEnabled(true);
      edtCodigo.Enabled := false;
      edtNome.SetFocus;
   end;

   if MOpcao = 'C' then
      begin
      stbtStatus.Panels[0].Text := 'Você está na Consulta.';
      PCamposEnabled(true);
      edtCodigo.SetFocus;
   end;

   if MOpcao = 'A' then
      begin
      stbtStatus.Panels[0].Text := 'Você está na Alteração.';

      if MPesquisou then
         begin
         PCamposEnabled(true);
         edtCodigo.Enabled  := false;
         edtNome.SetFocus;
         BtAnterior.Visible := false;
         BtProximo.Visible  := false;
      end
      else
         begin
         PCamposEnabled(false);
         edtCodigo.Enabled := true;
         edtCodigo.SetFocus;
      end;
   end;

end;

procedure TfrmCadClie.PproximoCodigo;
begin
   qryProximoCodigo.Close;
   qryProximoCodigo.SQL.Clear;
   qryProximoCodigo.SQL.Add('select max(codcliente) as codigo from cliente');
   qryProximoCodigo.Open;

   if qryProximoCodigo.FieldByName('codigo').IsNull then
      edtCodigo.Text := '00000001'
   else
      edtCodigo.Text := StrZero(IntToStr(qryProximoCodigo.FieldByName('codigo').AsVariant + 1), 8);
end;

procedure TfrmCadClie.BtSairClick(Sender: TObject);
begin
   close;
end;

procedure TfrmCadClie.BtVoltarClick(Sender: TObject);
begin
   PBotoesVisibled(true);
   BtAnterior.Visible  := false;
   BtProximo.Visible   := false;
   dbgClientes.Visible := false;
   BtVoltar.Visible    := false;
   sdsClientes.Close;
end;

procedure TfrmCadClie.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   MKey := key;

   Case Key of
       13 : Perform(WM_NextDlgCtl,0,0);     // Enter - chama a função que passa o
                                            // foco para o próximo campo de acordo
                                            // com a propriedade do tabOrder.

       27 : Begin                           // Esc
            If MPesquisou Then
               BtVoltar.Click
            Else
               If BtConsulta.Enabled Then
                  Close;
               End;

       38 : If not dbgClientes.Focused Then // seta para cima
               Begin
               Key := VK_Clear;
               Perform(WM_NextDlgCTL,1,0);
            End;

       113 : If BtIncluir.Enabled Then
                BtIncluir.Click;

       114 : If BtAlterar.Enabled Then
                BtAlterar.Click;

       115 : If BtExcluir.Enabled Then
                BtExcluir.Click;

       116 : If BtConsulta.Enabled Then
                BtConsulta.Click;

       117 : If BtLista.Enabled Then
                BtLista.Click;

       119 : If BtPesquisa.Enabled Then
                BtPesquisa.Click;

   End; //Case
end;

procedure TfrmCadClie.dbgClientesDblClick(Sender: TObject);
begin
   PCarregaCampos;

   dbgClientes.Visible := false;
   MPesquisou := true;

   PBotoesVisibled(true);

   BtIncluir.Enabled  := false;
   BtAlterar.Enabled  := true;
   BtExcluir.Enabled  := true;
   BtConsulta.Enabled := false;
   BtLista.Enabled    := false;
   BtPesquisa.Enabled := false;
   BtAnterior.Enabled := true;
   BtProximo.Enabled  := true;
   BtOk.Enabled       := false;
   BtCancelar.Enabled := true;
   BtVoltar.Visible   := false;
end;

procedure TfrmCadClie.PCarregaCampos;
begin
   edtCodigo.Text := dbgClientes.DataSource.DataSet.fieldByName('codCliente').AsString;
   edtNome.Text   := dbgClientes.DataSource.DataSet.fieldByName('nome').AsString;
end;

procedure TfrmCadClie.BtCancelarClick(Sender: TObject);
begin
   PCamposEnabled(false);
   PBotoesVisibled(true);
   PBotoesEnabled(true);

   BtOk.Enabled       := false;
   BtCancelar.Enabled := false;
   BtAnterior.Visible := false;
   BtProximo.Visible  := false;
   BtVoltar.Visible   := false;

   MOpcao     := '';
   MPesquisou := false;

   PCamposLimpa;

   stbtStatus.Panels[0].Text := '';
end;

procedure TfrmCadClie.PCamposEnabled(VOpcao: Boolean);
begin
   edtCodigo.Enabled := VOpcao;
   edtNome.Enabled   := VOpcao;
end;

procedure TfrmCadClie.PBotoesVisibled(VOpcao: Boolean);
begin
   BtOk.Visible       := VOpcao;
   BtCancelar.Visible := VOpcao;
   BtAlterar.Visible  := VOpcao;
   BtExcluir.Visible  := VOpcao;
   BtConsulta.Visible := VOpcao;
   BtLista.Visible    := VOpcao;
   BtPesquisa.Visible := VOpcao;
   BtProximo.Visible  := VOpcao;
   BtAnterior.Visible := VOpcao;
   BtVoltar.Visible   := VOpcao;
   BtIncluir.Visible  := VOpcao;
end;

procedure TfrmCadClie.PBotoesEnabled(VOpcao: Boolean);
begin
   BtOk.Enabled       := VOpcao;
   BtCancelar.Enabled := VOpcao;
   BtAlterar.Enabled  := VOpcao;
   BtExcluir.Enabled  := VOpcao;
   BtConsulta.Enabled := VOpcao;
   BtLista.Enabled    := VOpcao;
   BtPesquisa.Enabled := VOpcao;
   BtProximo.Enabled  := VOpcao;
   BtAnterior.Enabled := VOpcao;
   BtVoltar.Enabled   := VOpcao;
   BtIncluir.Enabled  := VOpcao;
end;

procedure TfrmCadClie.BtProximoClick(Sender: TObject);
begin
   if sdsClientes.Eof then
      sdsClientes.First
   else
      sdsClientes.Next;

   PCarregaCampos;
end;

procedure TfrmCadClie.BtAnteriorClick(Sender: TObject);
begin
   if sdsClientes.Bof then
      sdsClientes.Last
   else
      sdsClientes.Prior;

   PCarregaCampos;
end;

function TfrmCadClie.FValidaDados: Boolean;
begin
   Result := true;

   if edtNome.Text = '' then
      begin
      MessageDlg('Informe um valor para o campo de nome.',mtInformation,[mbOk],0);
      edtNome.SetFocus;
      Result := false;
      exit;
   end;

   // Demais validações futuras de outros campos...
end;

procedure TfrmCadClie.PGravaRegistro;
begin
   if MOpcao = 'I' then // é uma inclusão
      begin

      PproximoCodigo;

      qryGravacao.Close;
      qryGravacao.SQL.Clear;
      qryGravacao.SQL.Add('Insert Into cliente    ');
      qryGravacao.SQL.Add('(CodCliente, Nome)     ');
      qryGravacao.SQL.Add('values                 ');
      qryGravacao.SQL.Add('(:PCodCliente, :PNome) ');

      qryGravacao.ParamByName('PCodCliente').AsString := edtCodigo.Text;
      qryGravacao.ParamByName('PNome').AsString       := edtNome.Text;
      qryGravacao.ExecSQL;

      MessageDlg('O Código do cliente é: ' + edtCodigo.Text ,mtInformation,[mbOk],0);
   end
   else
      begin    // é uma alteração

      qryGravacao.Close;
      qryGravacao.SQL.Clear;
      qryGravacao.SQL.Add('Update cliente                ');
      qryGravacao.SQL.Add('Set                           ');
      qryGravacao.SQL.Add('Nome =:PNome                  ');
      qryGravacao.SQL.Add('Where CodCliente =:PCodCliente');

      qryGravacao.ParamByName('PCodCliente').AsString := edtCodigo.Text;
      qryGravacao.ParamByName('PNome').AsString       := edtNome.Text;
      qryGravacao.ExecSQL;

   end;
end;

procedure TfrmCadClie.edtCodigoExit(Sender: TObject);
begin
   if MKey <> 13 then  // Verifico se clicou no enter
      exit;

   if edtCodigo.Text = '' then
      begin
      MessageDlg('Informe um código de cliente para pesquisa.',mtInformation,[mbOk],0);
      edtCodigo.SetFocus;
      exit;
   end;

   edtCodigo.Text := StrZero(edtCodigo.Text, 8); // Completa zeros à esquerda para
                                                 // preencher o campo

   sdsClientes.Close;
   sdsClientes.DataSet.CommandText := 'Select * from Cliente            '+
                                      'Where CodCliente =   :PCodCliente';

   sdsClientes.DataSet.ParamByName('PCodCliente').AsString := edtCodigo.Text;
   sdsClientes.Open;

   if sdsClientes.FieldByName('CodCliente').AsString <> '' then
      begin
      PCarregaCampos;

      if MOpcao = 'A' then  // Se for alteração
         begin
         PCamposEnabled(true);
         edtCodigo.Enabled := false;
         edtNome.SetFocus;
      end;

      if MOpcao = 'C' then  // Se for consulta
         begin
         PCamposEnabled(false);
         BtAlterar.Enabled := true;
         BtExcluir.Enabled := true;
         BtOk.Enabled      := false;
         MPesquisou := True;
      end;

   end
   else
      begin
      MessageDlg('Código de cliente não encontrado.',mtInformation,[mbOk],0);
      edtCodigo.SetFocus;
      exit;
   end;


end;

procedure TfrmCadClie.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   MKey := 0;
end;

end.























