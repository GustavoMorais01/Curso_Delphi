unit uCadCliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, NumEdit, Mask;

type
  TfrmCadCliente = class(TForm)
    Button1: TButton;
    nedNum1: TNumEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    function testaCase(vTeste : integer) : Boolean;
  public
    { Public declarations }
  end;

var
  frmCadCliente: TfrmCadCliente;

implementation

{$R *.dfm}

procedure TfrmCadCliente.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   Action        := CaFree;   // destrói o form automaticamente
   frmCadCliente    := Nil;   // Vc atribui nil ao form, para "dizer que ele ainda nao foi criado"
end;

procedure TfrmCadCliente.Button1Click(Sender: TObject);
var
   teste : integer;
begin

   teste := 0;

   FloatToStr(nedNum1.Value);




   if testaCase(teste) then
      MessageDlg('Não existe nenhum prazo cadastrado!',mtwarning,[mbok],0);


end;

function TfrmCadCliente.testaCase(vTeste: integer): Boolean;
begin
   //case vTeste of
      //1 : return
end;

end.
