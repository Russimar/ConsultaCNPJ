unit uConsultaCNPJ;

interface

uses uPessoa, U_Principal, Controls;

type
  IConsultaCNPJ = Interface(IInterface)
    ['{F91C0F7B-47C1-4A48-B7FA-55281E049439}']
    function CNPJ(const Value: String): IConsultaCNPJ; overload;
    function CNPJ: string; overload;
    function Consulta : TPessoa;
  End;

  TConsultaCNPJ = class(TInterfacedObject, IConsultaCNPJ)
  strict private
    FCNPJ : String;
  public
    class function New: IConsultaCNPJ;
    function CNPJ(const Value: string): IConsultaCNPJ; overload;
    function CNPJ: string; overload;
    function Consulta : TPessoa;
  end;

implementation

uses
  System.SysUtils;

{ TConsultaCNPJ }
var
  Pessoa: TPessoa;

function TConsultaCNPJ.CNPJ(const Value: string): IConsultaCNPJ;
begin
  Result := Self;
  FCNPJ := Value;
end;

function TConsultaCNPJ.CNPJ: string;
begin
  Result := FCNPJ;
end;

function TConsultaCNPJ.Consulta: TPessoa;
var
 u_Principal : TF_Principal;
begin
  u_Principal := TF_Principal.Create(nil);
  try
    u_Principal.EditCNPJ.Text := FCNPJ;
    u_Principal.ShowModal;
    if u_Principal.ModalResult = mrOk then
    begin
      with u_Principal do
      begin
        Pessoa.RazaoSocial := ACBrConsultaCNPJ1.RazaoSocial;
        Pessoa.Endereco := ACBrConsultaCNPJ1.Endereco;
        Pessoa.Cidade := ACBrConsultaCNPJ1.Cidade;
        Pessoa.UF := ACBrConsultaCNPJ1.UF;
        Pessoa.Bairro := ACBrConsultaCNPJ1.Bairro;
        Pessoa.CEP := ACBrConsultaCNPJ1.CEP;
        Pessoa.Numero := ACBrConsultaCNPJ1.Numero;
        Pessoa.Fantasia := ACBrConsultaCNPJ1.Fantasia;
        Pessoa.Telefone :=  ACBrConsultaCNPJ1.Telefone;
        if Pessoa.Telefone <> EmptyStr then
        begin
          Pessoa.Telefone := StringReplace(Pessoa.Telefone,'(','', [rfReplaceAll]);
          Pessoa.Telefone := StringReplace(Pessoa.Telefone,')','', [rfReplaceAll]);
          Pessoa.Telefone := StringReplace(Pessoa.Telefone,'-','', [rfReplaceAll]);
          Pessoa.Telefone := StringReplace(Pessoa.Telefone,' ','', [rfReplaceAll]);
        end;

      end;
    end;
    Result := Pessoa;
  finally
    u_Principal.Free;
  end;
end;

class function TConsultaCNPJ.New: IConsultaCNPJ;
begin
  Result := Self.Create;
  Pessoa := TPessoa.create;
end;

end.
