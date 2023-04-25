program TesteDelphi;

uses
  System.StartUpCopy,
  FMX.Forms,
  View.Principal in 'View\View.Principal.pas' {frmPrincipal},
  Model.Cliente in 'Model\Model.Cliente.pas',
  Model.Produto in 'Model\Model.Produto.pas',
  Model.Venda in 'Model\Model.Venda.pas',
  Model.Connection in 'Model\Model.Connection.pas',
  Controller.Cliente in 'Controller\Controller.Cliente.pas',
  DAO.Cliente in 'DAO\DAO.Cliente.pas',
  Controller.Produto in 'Controller\Controller.Produto.pas',
  DAO.Produto in 'DAO\DAO.Produto.pas',
  DAO.Pedido in 'DAO\DAO.Pedido.pas';

{$R *.res}

begin
  Application.Initialize;
  //Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
