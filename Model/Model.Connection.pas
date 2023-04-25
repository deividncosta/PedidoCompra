unit Model.Connection;

interface

uses
  FireDAC.Stan.Intf,
  FireDac.Stan.Error,
  FireDac.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.DApt,
  FireDAC.Phys.MySQL,
  System.Generics.Collections,
  FireDAC.Phys.MySQLDef,
  IniFiles,
  System.SysUtils,
  FireDAC.FMXUI.Wait,
  FireDAC.Comp.UI;

var
  FDriver: TFDPhysMySQLDriverLink;
  FConnList: TObjectList<TFDConnection>;
  FWait: TFDGUIxWaitCursor;

function NewConnection: Integer;
procedure Disconected(const INDEX: Integer);

implementation

function NewConnection: Integer;
var
  Arq: TIniFile;
  Server, Usuario, Senha: String;
  Porta: Integer;
begin
  {$REGION 'Leitura do arquivo ini com configurações'}
  Arq := TIniFile.Create(ExtractFilePath(ParamStr(0)) + '\config.ini');
  Server  := Arq.ReadString('CONFIG','SERVER','127.0.0.1');
  Porta   := Arq.ReadInteger('CONFIG','PORTA',3306);
  Usuario := Arq.ReadString('CONFIG','USER','root');
  Senha   := Arq.ReadString('CONFIG','PASSWORD','root');
  Arq.DisposeOf;
  {$ENDREGION}

  FWait := TFDGUIxWaitCursor.Create(nil);

  if not Assigned(FConnList) then
    FConnList := TObjectList<TFDConnection>.Create;

  FConnList.Add(TFDConnection.Create(nil));
  Result := Pred(FConnList.Count);

  FConnList.Items[Result].Params.DriverID := 'MySQL';

  if not Assigned(FDriver) then
    FDriver := TFDPhysMySQLDriverLink.Create(nil);
  TFDPhysMySQLConnectionDefParams(FConnList.Items[Result].Params).Server   := Server;
  TFDPhysMySQLConnectionDefParams(FConnList.Items[Result].Params).Port     := Porta;
  TFDPhysMySQLConnectionDefParams(FConnList.Items[Result].Params).UserName := Usuario;
  TFDPhysMySQLConnectionDefParams(FConnList.Items[Result].Params).Password := Senha;

  FConnList.Items[Result].Connected;
end;

procedure Disconected(const INDEX: Integer);
begin
  FConnList.Items[INDEX].Connected := False;
  FConnList.Items[INDEX].Free;
  FConnList.TrimExcess;
end;

end.
