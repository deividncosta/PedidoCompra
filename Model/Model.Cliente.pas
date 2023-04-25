unit Model.Cliente;

interface

type
  TCliente = class
  private
    FCodigo: Integer;
    FNome: String;
    FCidade: String;
    FUF: String;
  public
    property Codigo: Integer read FCodigo write FCodigo;
    property Nome: String read FNome write FNome;
    property Cidade: String read FCidade write FCidade;
    property UF: String read FUF write FUF;
    constructor Create(ACodigo: Integer; ANome, ACidade, AUF: String); overload;
  end;

implementation

{ TCliente }

constructor TCliente.Create(ACodigo: Integer; ANome, ACidade, AUF: String);
begin
  FCodigo := ACodigo;
  FNome := ANome;
  FCidade := ACidade;
  FUF := AUF;
end;

end.
