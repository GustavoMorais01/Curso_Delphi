program GDP;

uses
  Forms,
  Menu in 'Menu.pas' {frmMenu},
  uCadCliente in 'E:\D\Apostilas Delphi\Treinamento ATS\Imagens para programas\uCadCliente.pas' {frmCadCliente};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMenu, frmMenu);
  Application.Run;
end.
