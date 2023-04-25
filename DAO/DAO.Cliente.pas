unit DAO.Cliente;

interface

uses
  FireDAC.Comp.Client, Data.DB, Model.Connection, System.SysUtils;

procedure GetClientes(MemTable: TFDMemTable);

implementation

procedure GetClientes(MemTable: TFDMemTable);
var
  _qry: TFDQuery;
  I: Integer;
begin
  I := NewConnection;
  _qry := TFDQuery.Create(nil);
  MemTable.Active := True;
  try
    try
      _qry.Connection := FConnList[I];
      _qry.SQL.Add('SELECT CODIGO, NOME, CIDADE, UF FROM TESTEDELPHI.CLIENTES ORDER BY CODIGO');
      _qry.Open;
      _qry.First;
      while not _qry.Eof do
      begin
        MemTable.AppendRecord([_qry.Fields[0].AsInteger, _qry.Fields[1].AsString, _qry.Fields[2].AsString, _qry.Fields[3].AsString]);
        _qry.Next;
      end;
    except
      on E: Exception do
        raise Exception.Create('Erro ao carregar os clientes. Erro: ' + E.Message);
    end;
  finally
    _qry.DisposeOf;
    Disconected(I)
  end;
end;

end.
