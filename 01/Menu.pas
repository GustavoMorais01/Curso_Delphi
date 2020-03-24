unit Menu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ComCtrls, ToolWin, ImgList, Buttons, DBXpress, DB,
  SqlExpr;

type
  TfrmMenu = class(TForm)
    menuPrincipal: TMainMenu;
    Cadastros1: TMenuItem;
    Clientes1: TMenuItem;
    Produtos1: TMenuItem;
    Consultas1: TMenuItem;
    ToolBar1: TToolBar;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    ToolButton1: TToolButton;
    SpeedButton3: TSpeedButton;
    StatusBar1: TStatusBar;
    SQLConnection1: TSQLConnection;
    procedure Clientes1Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMenu: TfrmMenu;

implementation

uses uCadCliente;

{$R *.dfm}

procedure TfrmMenu.Clientes1Click(Sender: TObject);
begin
   Screen.Cursor := crHourGlass;

   If frmCadCliente  = Nil then
      frmCadCliente := TfrmCadCliente.Create(Application);

   frmCadCliente.Show;

   Screen.Cursor := crArrow;
end;

procedure TfrmMenu.SpeedButton3Click(Sender: TObject);
begin
   Close;
end;

procedure TfrmMenu.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   frmMenu := Nil;
end;

end.
