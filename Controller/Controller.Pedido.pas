unit Controller.Pedido;

interface

uses
  Model.Pedido, Model.Produto, Generics.Collections, FireDAC.Comp.Client;

procedure SavePedido(const NUMERO, CLIENTE: Integer; PRODUTOS: TFDMemTable);

implementation

procedure SavePedido(const NUMERO, CLIENTE: Integer; PRODUTOS: TFDMemTable);
var
  Pedido: TPedido;
begin
  Pedido := TPedido.Create(NUMERO, CLIENTE);
  try
    PRODUTOS.First;
    while PRODUTOS.Eof do
    begin
      Pedido.Produtos.Add(TProduto.Create())
    end;
  finally
    Pedido.DisposeOf;
  end;
end;

end.
