unit eTranslate4Pascal;

interface

type
 ieTranslate = interface
   ['{0A0D7CEA-6E04-4E91-96DC-CE7A9552C3E2}']
   function Version: string;
   function GetLanguage: string;
   function SetLanguage(Value: string): ieTranslate;
   function Translate(Key: string; ParamValues: array of string):string; overload;
   function Translate(Key: string):string; overload;
 end;

 TeTranslate = class(TInterfacedObject, ieTranslate)
   private
    CurrentLanguage: string;
    const _version = '1.0';
   public
    constructor Create(TranslationFile: string = '');
    destructor Destroy; override;
    class function New(TranslationFile: string = ''): ieTranslate;

    //functions
    function Version: string;
    function GetLanguage: string;
    function SetLanguage(Value: string): ieTranslate;
    function Translate(Key: string; ParamValues: array of string):string; overload;
    function Translate(Key: string):string; overload;
 end;

 function eTranslate(TranslationFile: string = ''): ieTranslate;

var
 FInstancia: ieTranslate;

implementation

uses
  SysUtils,
  Classes,
  {$IFDEF FPC}
    fpjson;
  {$ELSE}
    System.JSON;
  {$ENDIF}

{ TeTranslate }

function eTranslate(TranslationFile: string = ''): ieTranslate;
 begin
   if not Assigned(FInstancia) then
    FInstancia := TeTranslate.New(TranslationFile);

   Result := FInstancia
 end;

constructor TeTranslate.Create(TranslationFile: string = '');
begin
  if (TranslationFile = EmptyStr) then
   raise Exception.Create('It´s not possible to begin eTranslate without telling which file to read for translations and where it is.');
  CurrentLanguage := 'en-US';
end;

destructor TeTranslate.Destroy;
begin

  inherited;
end;

class function TeTranslate.New(TranslationFile: string = ''): ieTranslate;
begin
  result := TeTranslate.Create(TranslationFile);
end;

function TeTranslate.GetLanguage: string;
begin
  Result := CurrentLanguage;
end;

function TeTranslate.SetLanguage(Value: string): ieTranslate;
begin
  CurrentLanguage := Value;
  Result := self;
end;

function TeTranslate.Translate(Key: string): string;
begin
  Result := self.Translate(Key, []);
end;

function TeTranslate.Translate(Key: string;ParamValues: array of string): string;
var
  i: integer;
  texto : string;
begin
  Result := Key;
  texto := EmptyStr;
  if(Length(ParamValues) > 0) then
   begin
     texto := '{0} de {1}';
     for i := Low(ParamValues) to High(ParamValues) do
        texto := StringReplace(texto, '{' + i.ToString + '}', ParamValues[i], []);
   end;
   if texto = EmptyStr then
    Result := Result
   else
    Result := Result + ' => ' + texto;
end;

function TeTranslate.Version: string;
begin
  Result :=  _version;
end;

end.
