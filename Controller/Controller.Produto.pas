unit Controller.Produto;

interface

uses
  Model.Produto, Generics.Collections, DAO.Produto, FireDAC.Comp.Client,
  System.SysUtils, Data.DB;

procedure ListaProdutos(Produtos: TList<TProduto>);

implementation

procedure ListaProdutos(Produtos: TList<TProduto>);
var
  MemProduto: TFDMemTable;
begin
  MemProduto := TFDMemTable.Create(nil);
  with MemProduto do
  begin
    FieldDefs.Add('Codigo', ftInteger);
    FieldDefs.Add('Descricao', ftString, 100);
    FieldDefs.Add('Preco', ftFloat);
    CreateDataSet;
  end;
  try
    try
      GetProduto(MemProduto);
      MemProduto.First;
      while not MemProduto.Eof do
      begin
        Produtos.Add(TProduto.Create(MemProduto.Fields[0].AsInteger, MemProduto.Fields[1].AsString, MemProduto.Fields[2].AsCurrency));
        MemProduto.Next;
      end;
    except
      raise Exception.Create('Erro ao carrear os produtos.');
    end;
  finally
    MemProduto.DisposeOf;
  end;
end;


end.
