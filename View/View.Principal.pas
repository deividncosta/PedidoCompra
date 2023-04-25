unit View.Principal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts, FMX.Objects, System.Rtti, FMX.Grid.Style, FMX.Grid, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Edit, FMX.Ani, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FMX.TabControl, System.Actions,
  FMX.ActnList, Controller.Cliente, Controller.Produto, Model.Cliente, Model.Produto, Model.Venda, Generics.Collections, FireDAC.UI.Intf, FireDAC.FMXUI.Wait, FireDAC.Comp.UI, FMX.EditBox, FMX.NumberBox,
  DAO.Pedido;

type
  BStatusBotao = (bEditar, bExcluir);
  TfrmPrincipal = class(TForm)
    lytTopo: TLayout;
    lytRodape: TLayout;
    lytGrid: TLayout;
    StyleBook1: TStyleBook;
    rectFundoTopo: TRectangle;
    rectRodape: TRectangle;
    circleLogo1: TCircle;
    circleLogo2: TCircle;
    txtTitulo: TText;
    txtNome: TText;
    RectAnimation1: TRectAnimation;
    rectTituloGrid: TRectangle;
    txtProduto: TText;
    rectBtnAdd: TRectangle;
    AnimationAdd: TColorAnimation;
    txtAdd: TText;
    gridPedido: TStringGrid;
    rectVlTotal: TRectangle;
    txtVlTotal: TText;
    rectProduto: TRectangle;
    edtProduto: TEdit;
    AnimationProduto: TColorAnimation;
    rectQuantidade: TRectangle;
    AnimationQuantidade: TColorAnimation;
    rectPreco: TRectangle;
    AnimationPreco: TColorAnimation;
    FDMemPedido: TFDMemTable;
    FDMemPedidoCliente: TIntegerField;
    FDMemPedidoDescricao: TStringField;
    FDMemPedidoQuantidade: TIntegerField;
    FDMemPedidoUnitario: TCurrencyField;
    FDMemPedidoTotal: TCurrencyField;
    FDMemPedidoCodigo: TIntegerField;
    ColumnCodigo: TIntegerColumn;
    ColumnDescricao: TStringColumn;
    ColumnQuantidade: TIntegerColumn;
    ColumnUnitario: TCurrencyColumn;
    ColumnTotal: TCurrencyColumn;
    FDMemPedidoGUID: TStringField;
    ColumnGUID: TStringColumn;
    rectGravar: TRectangle;
    AnimationGravar: TColorAnimation;
    txtGravar: TText;
    txtStatus: TText;
    TimerStatus: TTimer;
    tabControlEditar: TTabControl;
    TabNumero: TTabItem;
    rectClient: TRectangle;
    edtCliente: TEdit;
    AnimationCliente: TColorAnimation;
    rectNumeroPedido: TRectangle;
    edtNumeroPedido: TEdit;
    AnimationNumeroPedido: TColorAnimation;
    actListEditar: TActionList;
    TabVazio: TTabItem;
    actVazio: TChangeTabAction;
    actNumero: TChangeTabAction;
    actExcluir: TChangeTabAction;
    edtPreco: TNumberBox;
    edtQuantidade: TNumberBox;
    lytBotoes: TLayout;
    recExcluir: TRectangle;
    AnimationExcluir: TColorAnimation;
    txtExcluir: TText;
    rectEditar: TRectangle;
    ColorAnimation1: TColorAnimation;
    txtEditar: TText;
    procedure rectClientMouseEnter(Sender: TObject);
    procedure rectClientMouseLeave(Sender: TObject);
    procedure rectQuantidadeMouseEnter(Sender: TObject);
    procedure rectQuantidadeMouseLeave(Sender: TObject);
    procedure rectProdutoMouseEnter(Sender: TObject);
    procedure rectProdutoMouseLeave(Sender: TObject);
    procedure edtPrecoMouseEnter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtClienteKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure rectBtnAddClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure gridPedidoCellDblClick(const Column: TColumn; const Row: Integer);
    procedure rectGravarClick(Sender: TObject);
    procedure TimerStatusTimer(Sender: TObject);
    procedure edtNumeroPedidoMouseEnter(Sender: TObject);
    procedure edtNumeroPedidoMouseLeave(Sender: TObject);
    procedure edtClienteChangeTracking(Sender: TObject);
    procedure rectEditarClick(Sender: TObject);
    procedure edtNumeroPedidoClick(Sender: TObject);
    procedure recExcluirClick(Sender: TObject);
    procedure edtProdutoKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edtPrecoMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure edtQuantidadeMouseEnter(Sender: TObject);
    procedure edtQuantidadeMouseLeave(Sender: TObject);
    procedure edtQuantidadeKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edtPrecoKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edtNumeroPedidoKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
  private
    { Private declarations }
    //procedure CarregarClientes;
    //procedure CarregarProdutos;
    StatusBotao: BStatusBotao;
    Clientes: TList<TCliente>;
    Produtos: TList<TProduto>;
    procedure CarregarListas;
    function SomenteNumero(Key: Char; Texto: String; IsDecimal: Boolean = False): Char;
    function CalcularTotalPedido: Currency;
    procedure CarregarGrid;
    procedure CarregarPedido(const CODIGO: Integer);
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.fmx}

{$REGION 'Animações'}

procedure TfrmPrincipal.rectProdutoMouseEnter(Sender: TObject);
begin
  AnimationProduto.StartValue := TAlphaColorRec.White;
  AnimationProduto.StopValue  := TAlphaColorRec.Black;
  AnimationProduto.Start;
end;

procedure TfrmPrincipal.rectProdutoMouseLeave(Sender: TObject);
begin
  AnimationProduto.StopValue   := TAlphaColorRec.White;
  AnimationProduto.StartValue  := TAlphaColorRec.Black;
  AnimationProduto.Start;
end;

procedure TfrmPrincipal.rectQuantidadeMouseEnter(Sender: TObject);
begin
  AnimationQuantidade.StartValue := TAlphaColorRec.White;
  AnimationQuantidade.StopValue  := TAlphaColorRec.Black;
  AnimationQuantidade.Start;
end;

procedure TfrmPrincipal.rectQuantidadeMouseLeave(Sender: TObject);
begin
  AnimationQuantidade.StopValue   := TAlphaColorRec.White;
  AnimationQuantidade.StartValue  := TAlphaColorRec.Black;
  AnimationQuantidade.Start;
end;

procedure TfrmPrincipal.rectClientMouseEnter(Sender: TObject);
begin
  AnimationCliente.StartValue := TAlphaColorRec.White;
  AnimationCliente.StopValue  := TAlphaColorRec.Black;
  AnimationCliente.Start;
end;

procedure TfrmPrincipal.rectClientMouseLeave(Sender: TObject);
begin
  AnimationCliente.StopValue   := TAlphaColorRec.White;
  AnimationCliente.StartValue  := TAlphaColorRec.Black;
  AnimationCliente.Start;
end;

procedure TfrmPrincipal.edtPrecoMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  AnimationPreco.StartValue := TAlphaColorRec.White;
  AnimationPreco.StopValue  := TAlphaColorRec.Black;
  AnimationPreco.Start;
end;

procedure TfrmPrincipal.edtPrecoMouseEnter(Sender: TObject);
begin
  AnimationPreco.StopValue   := TAlphaColorRec.White;
  AnimationPreco.StartValue  := TAlphaColorRec.Black;
  AnimationPreco.Start;
end;

procedure TfrmPrincipal.edtQuantidadeMouseEnter(Sender: TObject);
begin
  AnimationQuantidade.StartValue := TAlphaColorRec.White;
  AnimationQuantidade.StopValue  := TAlphaColorRec.Black;
  AnimationQuantidade.Start;
end;

procedure TfrmPrincipal.edtQuantidadeMouseLeave(Sender: TObject);
begin
  AnimationQuantidade.StopValue   := TAlphaColorRec.White;
  AnimationQuantidade.StartValue  := TAlphaColorRec.Black;
  AnimationQuantidade.Start;
end;

procedure TfrmPrincipal.edtNumeroPedidoMouseEnter(Sender: TObject);
begin
  AnimationNumeroPedido.StartValue := TAlphaColorRec.White;
  AnimationNumeroPedido.StopValue  := TAlphaColorRec.Black;
  AnimationNumeroPedido.Start;
end;

procedure TfrmPrincipal.edtNumeroPedidoMouseLeave(Sender: TObject);
begin
  AnimationNumeroPedido.StopValue   := TAlphaColorRec.White;
  AnimationNumeroPedido.StartValue  := TAlphaColorRec.Black;
  AnimationNumeroPedido.Start;
end;
{$ENDREGION}

procedure TfrmPrincipal.edtClienteChangeTracking(Sender: TObject);
begin
  lytBotoes.Visible := Trim(edtCliente.Text) = '' ;
  actVazio.Execute;
end;

procedure TfrmPrincipal.edtClienteKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
var
  _cliente: TCliente;
begin
  if ((KeyChar = #0) and (Key = 13)) then
  begin
    edtCliente.Tag := 0;
    if Trim(TEdit(Sender).Text) = '' then
      Exit;
    for _cliente in Clientes do
      if _cliente.Codigo = Trim(edtCliente.Text).ToInteger then
      begin
        edtCliente.Text := _cliente.Codigo.ToString + ' - ' + _cliente.Nome;
        edtCliente.Tag  := _cliente.Codigo;
        Break;
      end;
    if edtCliente.Tag = 0 then
    begin
      ShowMessage('Cliente não encontrado.');
      edtCliente.Text := '';
      edtCliente.SetFocus;
      Exit;
    end;

    edtProduto.SetFocus;
  end
  else
    KeyChar := SomenteNumero(KeyChar, TEdit(Sender).Text);
end;

procedure TfrmPrincipal.edtPrecoKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Key = 13 then
    rectBtnAddClick(Sender);
end;

procedure TfrmPrincipal.edtProdutoKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
var
  _produto: TProduto;
begin
  if ((KeyChar = #0) and (Key = 13)) then
  begin
    edtProduto.Tag := 0;
    if Trim(TEdit(Sender).Text) = '' then
      Exit;
    for _produto in Produtos do
      if _produto.Codigo = Trim(edtProduto.Text).ToInteger then
      begin
        edtProduto.Text := _produto.Codigo.ToString + ' - ' + _produto.Descricao;
        edtPreco.Value  := _produto.Preco;
        edtProduto.Tag  := _produto.Codigo;
        Break;
      end;
    if edtProduto.Tag = 0 then
    begin
      ShowMessage('Produto não encontrado.');
      edtProduto.Text := '';
      edtProduto.SetFocus;
      Exit;
    end;
    edtQuantidade.SetFocus;
  end
  else
    KeyChar := SomenteNumero(KeyChar, TEdit(Sender).Text);
end;

procedure TfrmPrincipal.edtQuantidadeKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if key = 13 then
    edtPreco.SetFocus;
end;

procedure TfrmPrincipal.recExcluirClick(Sender: TObject);
begin
  actNumero.Execute;
  StatusBotao := bExcluir;
  edtNumeroPedido.SetFocus;
end;

procedure TfrmPrincipal.rectBtnAddClick(Sender: TObject);
var
  GUID: TGUID;
begin
  FDMemPedido.Active := True;
  if Trim(edtProduto.Text) = '' then
  begin
    edtProduto.Text := 'INFORME O PRODUTO';
    rectProduto.Stroke.Color := TAlphaColorRec.Orangered;
    Exit;
  end
  else if Trim(edtQuantidade.Text) = '' then
  begin
    edtQuantidade.Text := 'INFORME A QUANTIDADE';
    rectQuantidade.Stroke.Color := TAlphaColorRec.Orangered;
    Exit;
  end
  else if Trim(edtPreco.Text) = '' then
  begin
    edtPreco.Text := 'INFORME O PREÇO';
    rectPreco.Stroke.Color := TAlphaColorRec.Orangered;
    Exit;
  end
  else if Trim(edtCliente.Text) = '' then
  begin
    edtCliente.Text := 'INFORME O CLIENTE';
    rectClient.Stroke.Color := TAlphaColorRec.Orangered;
    Exit;
  end;
  if txtAdd.Text = 'Atualizar registro' then
  begin
    FDMemPedido.Filtered := False;
    FDMemPedido.Filter := 'GUID = ' + QuotedStr(gridPedido.Cells[5, gridPedido.Row]);
    FDMemPedido.Filtered := True;
    if FDMemPedido.RecordCount > 0 then
    begin
      FDMemPedido.Edit;
      FDMemPedidoQuantidade.AsInteger := Round(edtQuantidade.Value);
      FDMemPedidoUnitario.AsCurrency  := edtPreco.Value;
      FDMemPedidoTotal.AsCurrency     := edtPreco.Value * edtQuantidade.Value;
      FDMemPedido.Post;
    end;
    txtAdd.Text := 'Adicionar Produto';
    edtProduto.Enabled := True;
    FDMemPedido.Filtered := False;
    CarregarGrid;
  end
  else
  begin
    CreateGUID(GUID);
    FDMemPedido.AppendRecord([
      edtCliente.Tag,
      edtProduto.Tag,
      Trim(Copy(edtProduto.Text, Pos('-', edtProduto.Text) + 1, 100)),
      edtQuantidade.Text.ToInteger,
      StrToCurr(edtPreco.Text),
      StrToCurr(edtPreco.Text) * edtQuantidade.Text.ToInteger,
      GUID.ToString
      ]);
    gridPedido.RowCount := FDMemPedido.RecordCount;
    gridPedido.Cells[0, Pred(gridPedido.RowCount)] := edtProduto.Tag.ToString;
    gridPedido.Cells[1, Pred(gridPedido.RowCount)] := Trim(Copy(edtProduto.Text, Pos('-', edtProduto.Text) + 1, 100));
    gridPedido.Cells[2, Pred(gridPedido.RowCount)] := edtQuantidade.Text;
    gridPedido.Cells[3, Pred(gridPedido.RowCount)] := edtPreco.Text;
    gridPedido.Cells[4, Pred(gridPedido.RowCount)] := CurrToStr(StrToCurr(edtPreco.Text) * edtQuantidade.Text.ToInteger);
    gridPedido.Cells[5, Pred(gridPedido.RowCount)] := GUID.ToString;
  end;
  edtProduto.Text := '';
  edtQuantidade.Text := '';
  edtPreco.Text := '';
  txtVlTotal.Text := formatfloat('R$ #,##0.00', CalcularTotalPedido);
  edtProduto.SetFocus;
  txtAdd.Text := 'Adicionar Produto';
end;


procedure TfrmPrincipal.rectEditarClick(Sender: TObject);
begin
  actNumero.Execute;
  StatusBotao := bEditar;
  edtNumeroPedido.SetFocus;
end;

procedure TfrmPrincipal.rectGravarClick(Sender: TObject);
var
  Numero: Integer;
begin
  SavePedido(FDMemPedido, CalcularTotalPedido, Numero);
  FDMemPedido.EmptyDataSet;
  CarregarGrid;
  edtProduto.Text := '';
  edtQuantidade.Text := '';
  edtPreco.Text := '';
  edtCliente.Text := '';
  edtCliente.SetFocus;
  actVazio.Execute;
  txtStatus.Text := 'Pedido ' + Numero.ToString + ' gravado!';
  TimerStatus.Enabled := True;
  actVazio.Execute;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  CarregarListas;
  actVazio.Execute;
end;

procedure TfrmPrincipal.FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
var
  Control : iControl;
  MyControl : TFMXObject;
begin
  Control := frmPrincipal.focused;
  try
    if not Assigned(Control) then
      Exit;
    MyControl := TFmxObject(Control.GetObject);
    if MyControl.Name = 'gridPedido' then
    begin
      if Key = 46 then
      begin
        MessageDlg('Deseja remover o registro?', TMsgDlgType.mtWarning, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0, procedure(const AResult: TModalResult)
        begin
          if AResult = mrYes then
          begin
            FDMemPedido.Filtered := False;
            FDMemPedido.Filter := 'GUID = ' + QuotedStr(gridPedido.Cells[5, gridPedido.Row]);
            FDMemPedido.Filtered := True;
            if FDMemPedido.RecordCount > 0 then
              FDMemPedido.Delete;
            FDMemPedido.Filtered := False;
            CarregarGrid;
          end
          else
            Abort;
        end);
      end;
    end;
  finally
    MyControl := nil;
    Control := nil;
  end;
end;

procedure TfrmPrincipal.gridPedidoCellDblClick(const Column: TColumn; const Row: Integer);
begin
  FDMemPedido.First;
  while not FDMemPedido.Eof do
  begin
    if FDMemPedidoCodigo.AsInteger = gridPedido.Cells[0, Row].ToInteger then
      Break;
    FDMemPedido.Next;
  end;
  txtAdd.Text := 'Atualizar registro';
  edtProduto.Text := FDMemPedidoCodigo.Text + ' - ' + FDMemPedidoDescricao.Text;
  edtQuantidade.Text := FDMemPedidoQuantidade.Text;
  edtPreco.Text := FDMemPedidoUnitario.Text;
  edtProduto.Enabled := False;
end;

function TfrmPrincipal.CalcularTotalPedido: Currency;
var
  Valor: Currency;
begin
  FDMemPedido.First;
  Valor := 0;
  while not FDMemPedido.Eof do
  begin
    Valor := Valor + FDMemPedidoTotal.AsCurrency;
    FDMemPedido.Next;
  end;
  Result := Valor;
end;

procedure TfrmPrincipal.CarregarGrid;
var
  I: Integer;
begin
  FDMemPedido.First;
  gridPedido.RowCount := 0;
  gridPedido.RowCount := FDMemPedido.RecordCount;
  I := 0;
  while not FDMemPedido.Eof do
  begin
    gridPedido.Cells[0, I] := FDMemPedido.FieldByName('CODIGO').AsString;
    gridPedido.Cells[1, I] := FDMemPedido.FieldByName('DESCRICAO').AsString;
    gridPedido.Cells[2, I] := FDMemPedido.FieldByName('QUANTIDADE').AsString;
    gridPedido.Cells[3, I] := FDMemPedido.FieldByName('UNITARIO').AsString;
    gridPedido.Cells[4, I] := FDMemPedido.FieldByName('TOTAL').AsString;
    gridPedido.Cells[5, I] := FDMemPedido.FieldByName('GUID').AsString;
    Inc(I);
    FDMemPedido.Next;
  end;
  edtProduto.Text := '';
  edtQuantidade.Text := '';
  edtPreco.Text := '';
  txtVlTotal.Text := formatfloat('R$ #,##0.00', CalcularTotalPedido);
  edtProduto.SetFocus;
end;

procedure TfrmPrincipal.CarregarListas;
begin
  Clientes := TList<TCliente>.Create;
  Produtos := TList<TProduto>.Create;
  ListaClientes(Clientes);
  ListaProdutos(Produtos);
end;

procedure TfrmPrincipal.CarregarPedido(const CODIGO: Integer);
var
  MemPedido: TFDMemTable;
  I: Integer;
begin
  MemPedido := TFDMemTable.Create(nil);
  try
    LoadPedido(CODIGO, MemPedido);
    if not MemPedido.IsEmpty then
    begin
      MemPedido.First;
      edtCliente.Text := MemPedido.FieldByName('CODIGO_CLIENTE').AsString + ' - ' + MemPedido.FieldByName('NOME').AsString;
      I := 0;
      gridPedido.RowCount := MemPedido.RecordCount;
      while not MemPedido.Eof do
      begin
        gridPedido.Cells[0, I] := MemPedido.FieldByName('CODIGO').AsString;
        gridPedido.Cells[1, I] := MemPedido.FieldByName('DESCRICAO').AsString;
        gridPedido.Cells[2, I] := MemPedido.FieldByName('QUANTIDADE').AsString;
        gridPedido.Cells[3, I] := MemPedido.FieldByName('VALOR_UNITARIO').AsString;
        gridPedido.Cells[4, I] := MemPedido.FieldByName('VALOR_TOTAL').AsString;
        Inc(I);
        MemPedido.Next;
      end;
      txtVlTotal.Text := FormatFloat('R$ #,##0.00', MemPedido.FieldByName('TOTAL_PEDIDO').AsCurrency);
    end
    else
    begin
      txtStatus.Text := 'Pedido não encontrado';
      TimerStatus.Enabled := True;
    end;
  finally
    MemPedido.DisposeOf;
  end;
end;

function TfrmPrincipal.SomenteNumero(Key: Char; Texto: String; IsDecimal: Boolean): Char;
begin
  if not IsDecimal then
  begin
    if not ( Key in ['0'..'9', Chr(8)] ) then
      Key := #0
  end
  else
  begin
    if Key = #46 then
      Key := FormatSettings.DecimalSeparator;
    if not ( Key in ['0'..'9', Chr(8), FormatSettings.DecimalSeparator] ) then
      Key := #0
    else if (Key = FormatSettings.DecimalSeparator ) and ( Pos( Key, Texto ) > 0 ) then
      Key := #0;
  end;
  Result := Key;
end;

procedure TfrmPrincipal.TimerStatusTimer(Sender: TObject);
begin
  txtStatus.Text := '';
  TimerStatus.Enabled := False;
end;

procedure TfrmPrincipal.edtNumeroPedidoClick(Sender: TObject);
begin
  edtNumeroPedido.Text := '';
end;

procedure TfrmPrincipal.edtNumeroPedidoKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Key = 13 then
  begin
    case StatusBotao of
      bEditar:  CarregarPedido(Trim(edtNumeroPedido.Text).ToInteger);
      bExcluir:
      begin
        MessageDlg('Deseja remover o registro?', TMsgDlgType.mtWarning, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0, procedure(const AResult: TModalResult)
        begin
          if AResult = mrYes then
          begin
            ExcluirPedido(Trim(edtNumeroPedido.Text).ToInteger);
            txtStatus.Text := 'Pedido ' + edtNumeroPedido.Text + ' excluido';
            TimerStatus.Enabled := True;
            edtNumeroPedido.Text := '';
            actVazio.Execute;
            edtCliente.Text := '';
            edtCliente.SetFocus;
          end
          else
            Abort;
        end);
      end;
    end;
  end;
end;

end.
