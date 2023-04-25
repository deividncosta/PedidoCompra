unit Model.Produto;

interface

uses
  Generics.Collections, FireDAC.Comp.Client, System.SysUtils;

type
  TProduto = class
  private
    FCodigo: Integer;
    FDescricao: String;
    FPreco: Currency;
  public
    property Codigo: Integer read FCodigo write FCodigo;
    property Descricao: String read FDescricao write FDescricao;
    property Preco: Currency read FPreco write FPreco;
    constructor Create(ACodigo: Integer; ADescricao: String; APreco: Currency); overload;
  end;

implementation

{ TProduto }

constructor TProduto.Create(ACodigo: Integer; ADescricao: String; APreco: Currency);
begin
  FCodigo := ACodigo;
  FDescricao := ADescricao;
  FPreco := APreco;
end;

end.
