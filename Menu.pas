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

   If frmCadClie  = Nil then           // verifica se o formul�rio j� est� instanciado
      frmCadClie := TfrmCadClie.Create(Application);  // cria o formul�rio

   frmCadClie.Show;                    // abre o formul�rio

   Screen.Cursor := crArrow;           // muda o cursor para o padr�o
end;

procedure TfrmMenu.SpeedButton5Click(Sender: TObject);
begin
   Close;
end;

procedure TfrmMenu.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action     := caFree;   // tira o formul�rio da mem�ria
   frmMenu    := Nil;      // marca como n�o instanciado
end;

procedure TfrmMenu.spbTestesClick(Sender: TObject);
begin
   Screen.Cursor := crHourGlass;       // muda o cursor para ampuleta

   If frmTestes  = Nil then           // verifica se o formul�rio j� est� instanciado
      frmTestes := TfrmTestes.Create(Application);  // cria o formul�rio

   frmTestes.Show;                    // abre o formul�rio

   Screen.Cursor := crArrow;           // muda o cursor para o padr�o
end;

procedure TfrmMenu.PConfDbxBDE(VFDbx: TSQLConnection; VFBDE: TDataBase);
var                                                  // Declara algumas vari�veis que ser�o utilizadas neste bloco
   MCaminho,
   MUsuario,
   MSenha   : String;
   MParmBDE : TStringList;
begin
   MCaminho := VFBDE.Params.Values['SERVER NAME'];   // Vari�vel MCaminho recebe o caminho do banco na conex�o BDE
   MUsuario := VFBDE.Params.Values['USER NAME'];     // Vari�vel MUsuario recebe o usu�rio do banco na conex�o BDE
   MSenha   := VFBDE.Params.Values['PASSWORD'];      // Vari�vel MSenha recebe a senha do banco na conex�o BDE

   If Trim(MCaminho) = '' Then                       // Verifica se o caminho do banco est� vazio
      Begin                                          // Se estiver...
      MParmBDE := TStringList.Create;                // Cria uma vari�vel (lista de strings)
      Session.GetAliasParams('DbResulth',MParmBDE);  // Carrega a vari�vel com a lista de par�metros da conex�o BDE
      MCaminho := MParmBDE.Values['SERVER NAME'];    // Atribui o valor do caminho do banco da conex�o BDE � vari�vel
      MParmBDE.Free;                                 // Limpa a vari�vel da mem�ria
   End;

   VFDbx.Params.Values['DataBase' ] := MCaminho;     // Atribui o caminho do banco no par�metro da conex�o DbExpress
   VFDbx.Params.Values['User_Name'] := MUsuario;     // Atribui o usu�rio do banco no par�metro da conex�o DbExpress
   VFDbx.Params.Values['Password' ] := MSenha;       // Atribui a senha do banco no par�metro da conex�o DbExpress
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
      MessageDlg('Falha ao configurar conex�o DBExpress.',mtError,[mbok],0);
   End;
end;

end.
