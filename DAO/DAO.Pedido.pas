unit DAO.Pedido;

interface

uses
  FireDAC.Comp.Client, Model.Connection, System.SysUtils, Data.DB;

procedure SavePedido(const PEDIDO: TFDMemTable; TOTALPEDIDO: Currency; out Numero: Integer);
procedure LoadPedido(const NUMERO: Integer; PEDIDO: TFDMemTable);
procedure ExcluirPedido(const NUMERO: Integer);

implementation

procedure SavePedido(const PEDIDO: TFDMemTable; TOTALPEDIDO: Currency; out Numero: Integer);
var
  I, NumeroPedido: Integer;
  _qry: TFDQuery;
begin
  I := NewConnection;
  _qry := TFDQuery.Create(nil);
  try
    FConnList[I].StartTransaction;
    try
      _qry.Connection := FConnList[I];
      _qry.SQL.Add('INSERT INTO TESTEDELPHI.PEDIDO_DADOS_GERAIS(CODIGO_CLIENTE, VALOR_TOTAL)');
      _qry.SQL.Add('VALUES(:CLIENTE, :TOTAL); SELECT @@IDENTITY;');
      _qry.ParamByName('CLIENTE').AsInteger := PEDIDO.FieldByName('CLIENTE').AsInteger;
      _qry.ParamByName('TOTAL').AsCurrency  := TOTALPEDIDO;
      _qry.Open;
      NumeroPedido := _qry.Fields[0].AsInteger;
      Numero := _qry.Fields[0].AsInteger;
      _qry.Close;
      _qry.SQL.Clear;
      _qry.SQL.Add('INSERT INTO TESTEDELPHI.PEDIDO_PRODUTOS(NUMERO_PEDIDO, CODIGO_PRODUTO, QUANTIDADE, VALOR_UNITARIO, VALOR_TOTAL)');
      _qry.SQL.Add('VALUES(:PEDIDO, :PRODUTO, :QUANTIDADE, :UNITARIO, :TOTAL)');
      PEDIDO.First;
      while not PEDIDO.Eof do
      begin
        _qry.ParamByName('PEDIDO').AsInteger := NumeroPedido;
        _qry.ParamByName('PRODUTO').AsInteger := PEDIDO.FieldByName('CODIGO').AsInteger;
        _qry.ParamByName('QUANTIDADE').AsInteger := PEDIDO.FieldByName('QUANTIDADE').AsInteger;
        _qry.ParamByName('UNITARIO').AsCurrency  := PEDIDO.FieldByName('UNITARIO').AsCurrency;
        _qry.ParamByName('TOTAL').AsCurrency  := PEDIDO.FieldByName('TOTAL').AsCurrency;
        _qry.ExecSQL;
        PEDIDO.Next;
      end;
      FConnList[I].Commit
    except on E: Exception do
      begin
        raise Exception.Create('Erro ao salvar pedido. Erro: ' + E.Message);
        FConnList[I].Rollback;
      end;
    end;
  finally
    _qry.DisposeOf;
    Disconected(I);
  end;
end;

procedure LoadPedido(const NUMERO: Integer; PEDIDO: TFDMemTable);
var
  I: Integer;
  _qry: TFDQuery;
begin
  I := NewConnection;
  _qry := TFDQuery.Create(nil);

  with PEDIDO do
  begin
    FieldDefs.Add('CODIGO_CLIENTE', ftInteger);
    FieldDefs.Add('NOME', ftString, 100);
    FieldDefs.Add('CODIGO', ftInteger);
    FieldDefs.Add('DESCRICAO', ftString, 100);
    FieldDefs.Add('QUANTIDADE', ftInteger);
    FieldDefs.Add('VALOR_UNITARIO', ftCurrency);
    FieldDefs.Add('VALOR_TOTAL', ftCurrency);
    FieldDefs.Add('TOTAL_PEDIDO', ftCurrency);
    CreateDataSet;
  end;
  PEDIDO.Active := True;
  try
    try
      _qry.Connection := FConnList[I];
      _qry.Close;
      _qry.SQL.Clear;
      _qry.SQL.Add('SELECT C.CODIGO AS CODIGO_CLIENTE, C.NOME, D.CODIGO, D.DESCRICAO, A.QUANTIDADE, A.VALOR_UNITARIO, A.VALOR_TOTAL, B.VALOR_TOTAL AS TOTAL_PEDIDO FROM TESTEDELPHI.PEDIDO_PRODUTOS A');
      _qry.SQL.Add('INNER JOIN TESTEDELPHI.PEDIDO_DADOS_GERAIS B ON B.NUMERO = A.NUMERO_PEDIDO');
      _qry.SQL.Add('INNER JOIN TESTEDELPHI.CLIENTES C ON C.CODIGO = B.CODIGO_CLIENTE');
      _qry.SQL.Add('INNER JOIN TESTEDELPHI.PRODUTOS D ON D.CODIGO = A.CODIGO_PRODUTO');
      _qry.SQL.Add('WHERE A.NUMERO_PEDIDO = :ID');
      _qry.ParamByName('ID').AsInteger := NUMERO;
      _qry.Open;
      if not _qry.IsEmpty then
      begin
        _qry.First;
        while not _qry.Eof do
        begin
          Pedido.AppendRecord([_qry.Fields[0].AsInteger,
                               _qry.Fields[1].AsString,
                               _qry.Fields[2].AsInteger,
                               _qry.Fields[3].AsString,
                               _qry.Fields[4].AsInteger,
                               _qry.Fields[5].AsCurrency,
                               _qry.Fields[6].AsCurrency,
                               _qry.Fields[7].AsCurrency
                              ]);
          _qry.Next;
        end;
      end;
    except on E: Exception do
      raise Exception.Create('Erro ao carregar pedido. Erro: ' + E.Message);
    end;
  finally
    _qry.DisposeOf;
    Disconected(I);
  end;
end;

procedure ExcluirPedido(const NUMERO: Integer);
var
  I, NumeroPedido: Integer;
  _qry: TFDQuery;
begin
  I := NewConnection;
  _qry := TFDQuery.Create(nil);
  try
    FConnList[I].StartTransaction;
    try
      _qry.Connection := FConnList[I];

      _qry.SQL.Add('DELETE FROM TESTEDELPHI.PEDIDO_PRODUTOS WHERE NUMERO_PEDIDO = :NUMERO');
      _qry.ParamByName('NUMERO').AsCurrency := NUMERO;
      _qry.ExecSQL;

      _qry.SQL.Clear;
      _qry.SQL.Add('DELETE FROM TESTEDELPHI.PEDIDO_DADOS_GERAIS WHERE NUMERO = :NUMERO');
      _qry.ParamByName('NUMERO').AsCurrency := NUMERO;
      _qry.ExecSQL;

      FConnList[I].Commit
    except on E: Exception do
      begin
        raise Exception.Create('Erro ao excluir pedido. Erro: ' + E.Message);
        FConnList[I].Rollback;
      end;
    end;
  finally
    _qry.DisposeOf;
    Disconected(I);
  end;
end;

end.
