unit Model.Pedido;

interface

uses
  Model.Produto, Generics.Collections;

type
  TPedido = class
  private
    FNumero: Integer;
    FCodigoCliente: Integer;
    FValorTotal: Double;
    FProdutos: TList<TProduto>;
  public
    property Numero: Integer read FNumero write FNumero;
    property ValorTotal: Double read FValorTotal write FValorTotal;
    property Produtos: TList<TProduto> read FProdutos write FProdutos;

    constructor Create(ANumero, ACliente: Integer); overload;
    destructor Destroy; override;
  end;

implementation

{ TPedido }

constructor TPedido.Create(ANumero, ACliente: Integer);
begin
  FNumero := ANumero;
  FCodigoCliente := ACliente;
  FProdutos := TList<TProduto>.Create(nil);
end;

destructor TPedido.Destroy;
begin
  FProdutos.DisposeOf;
  inherited;
end;

end.
