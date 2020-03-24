unit Menu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ComCtrls, ToolWin, Buttons, DB, DBTables, DBXpress,
  FMTBcd, DBClient, Provider, SqlExpr;

type
  TfrmMenu = class(TForm)
    menuPrincipal: TMainMenu;
    Cadastros1: TMenuItem;
    menuCadProd: TMenuItem;
    menuCadClienteNovo: TMenuItem;
    menuCadFornec: TMenuItem;
    Consulta1: TMenuItem;
    Relatrios1: TMenuItem;
    ToolBar1: TToolBar;
    spbClientes: TSpeedButton;
    spbProdutos: TSpeedButton;
    spbConsultaClientes: TSpeedButton;
    spbTestes: TSpeedButton;
    ToolButton1: TToolButton;
    SpeedButton5: TSpeedButton;
    StatusBar1: TStatusBar;
    DbResulth: TDatabase;
    CnResulth: TSQLConnection;
    procedure menuCadClienteNovoClick(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure spbTestesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
      procedure PConfDbxBDE(VFDbx: TSQLConnection; VFBDE: TDataBase);
  public
    { Public declarations }
  end;

var
  frmMenu: TfrmMenu;

implementation

uses uCadClie, uTestes;

{$R *.dfm}

procedure TfrmMenu.menuCadClienteNovoClick(Sender: TObject);
begin
   Screen.Cursor := crHourGlass;       // muda o cursor para ampuleta

   If frmCadClie  = Nil then           // verifica se o formulário já está instanciado
      frmCadClie := TfrmCadClie.Create(Application);  // cria o formulário

   frmCadClie.Show;                    // abre o formulário

   Screen.Cursor := crArrow;           // muda o cursor para o padrão
end;

procedure TfrmMenu.SpeedButton5Click(Sender: TObject);
begin
   Close;
end;

procedure TfrmMenu.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action     := caFree;   // tira o formulário da memória
   frmMenu    := Nil;      // marca como não instanciado
end;

procedure TfrmMenu.spbTestesClick(Sender: TObject);
begin
   Screen.Cursor := crHourGlass;       // muda o cursor para ampuleta

   If frmTestes  = Nil then           // verifica se o formulário já está instanciado
      frmTestes := TfrmTestes.Create(Application);  // cria o formulário

   frmTestes.Show;                    // abre o formulário

   Screen.Cursor := crArrow;           // muda o cursor para o padrão
end;

procedure TfrmMenu.PConfDbxBDE(VFDbx: TSQLConnection; VFBDE: TDataBase);
var                                                  // Declara algumas variáveis que serão utilizadas neste bloco
   MCaminho,
   MUsuario,
   MSenha   : String;
   MParmBDE : TStringList;
begin
   MCaminho := VFBDE.Params.Values['SERVER NAME'];   // Variável MCaminho recebe o caminho do banco na conexão BDE
   MUsuario := VFBDE.Params.Values['USER NAME'];     // Variável MUsuario recebe o usuário do banco na conexão BDE
   MSenha   := VFBDE.Params.Values['PASSWORD'];      // Variável MSenha recebe a senha do banco na conexão BDE

   If Trim(MCaminho) = '' Then                       // Verifica se o caminho do banco está vazio
      Begin                                          // Se estiver...
      MParmBDE := TStringList.Create;                // Cria uma variável (lista de strings)
      Session.GetAliasParams('DbResulth',MParmBDE);  // Carrega a variável com a lista de parâmetros da conexão BDE
      MCaminho := MParmBDE.Values['SERVER NAME'];    // Atribui o valor do caminho do banco da conexão BDE à variável
      MParmBDE.Free;                                 // Limpa a variável da memória
   End;

   VFDbx.Params.Values['DataBase' ] := MCaminho;     // Atribui o caminho do banco no parâmetro da conexão DbExpress
   VFDbx.Params.Values['User_Name'] := MUsuario;     // Atribui o usuário do banco no parâmetro da conexão DbExpress
   VFDbx.Params.Values['Password' ] := MSenha;       // Atribui a senha do banco no parâmetro da conexão DbExpress
end;

procedure TfrmMenu.FormCreate(Sender: TObject);
begin

   try
      DbResulth.Connected := False;
      DbResulth.Connected := True;
   Except
      MessageDlg('Falha ao conectar ao banco de dados.',mtError,[mbok],0);
      Exit;
   End;

   try
      PConfDbxBDE(CnResulth, DbResulth);
      CnResulth.Connected := true;
   Except
      MessageDlg('Falha ao configurar conexão DBExpress.',mtError,[mbok],0);
   End;
end;

end.
