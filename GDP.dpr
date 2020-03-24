program GDP;

uses
  Forms,
  Menu in 'Menu.pas' {frmMenu},
  uCadClie in 'uCadClie.pas' {frmCadClie},
  uTestes in 'uTestes.pas' {frmTestes},
  Funcoes in 'Funcoes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMenu, frmMenu);
  Application.Run;
end.
