unit Controller.Cliente;

interface

uses
  Model.Cliente, Generics.Collections, DAO.Cliente, FireDAC.Comp.Client,
  System.SysUtils, Data.DB;

procedure ListaClientes(Clientes: TList<TCliente>);

implementation

procedure ListaClientes(Clientes: TList<TCliente>);
var
  MemCliente: TFDMemTable;
begin
  MemCliente := TFDMemTable.Create(nil);
  with MemCliente do
  begin
    FieldDefs.Add('Codigo', ftInteger);
    FieldDefs.Add('Nome', ftString, 100);
    FieldDefs.Add('Cidade', ftString, 100);
    FieldDefs.Add('UF', ftString, 2);
    CreateDataSet;
  end;
  try
    try
      GetClientes(MemCliente);
      MemCliente.First;
      while not MemCliente.Eof do
      begin
        Clientes.Add(TCliente.Create(MemCliente.Fields[0].AsInteger, MemCliente.Fields[1].AsString, MemCliente.Fields[2].AsString, MemCliente.Fields[3].AsString));
        MemCliente.Next;
      end;
    except
      raise Exception.Create('Erro ao carregar os clientes.');
    end;
  finally
    MemCliente.DisposeOf;
  end;
end;


end.
