unit eTranslate4Pascal;

interface

type
 ieTranslate = interface
   ['{0A0D7CEA-6E04-4E91-96DC-CE7A9552C3E2}']
   function Version: string;
   function GetTexto: string;
   function SetTexto(Value: string): ieTranslate;
 end;

 TeTranslate = class(TInterfacedObject, ieTranslate)
   private
    Texto: string;
    const _version = '1.0';
   public
    function Version: string;
    function GetTexto: string;
    function SetTexto(Value: string): ieTranslate;
    constructor Create;
    destructor Destroy; override;
    class function New: ieTranslate;
 end;

 function eTranslate: ieTranslate;

var
 FInstancia: ieTranslate;

implementation

uses
  SysUtils;

{ TeTranslate }

function eTranslate: ieTranslate;
 begin
   if not Assigned(FInstancia) then
    FInstancia := TeTranslate.Create;
   Result := FInstancia;
 end;

constructor TeTranslate.Create;
begin
  Texto := 'Valor inicial';
end;

destructor TeTranslate.Destroy;
begin

  inherited;
end;

function TeTranslate.GetTexto: string;
begin
  result := Texto;
end;

class function TeTranslate.New: ieTranslate;
begin
  result := TeTranslate.Create;
end;

function TeTranslate.SetTexto(Value: string): ieTranslate;
begin
  Texto := Value;
  Result := self;
end;

function TeTranslate.Version: string;
begin
  Result :=  _version;
end;

end.
