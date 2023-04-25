unit DAO.Produto;

interface

uses
  FireDAC.Comp.Client, Data.DB, Model.Connection, System.SysUtils;

procedure GetProduto(MemTable: TFDMemTable);

implementation

procedure GetProduto(MemTable: TFDMemTable);
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
      _qry.SQL.Add('SELECT CODIGO, DESCRICAO, PRECO FROM TESTEDELPHI.PRODUTOS ORDER BY CODIGO');
      _qry.Open;
      _qry.First;
      while not _qry.Eof do
      begin
        MemTable.AppendRecord([_qry.Fields[0].AsInteger, _qry.Fields[1].AsString, _qry.Fields[2].AsFloat]);
        _qry.Next;
      end;
    except
      raise Exception.Create('Erro ao carrear os produtos.');
    end;
  finally
    _qry.DisposeOf;
    Disconected(I);
  end;
end;

end.
