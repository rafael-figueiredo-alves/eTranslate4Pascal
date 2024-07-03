unit eTranslate4Pascal;

interface

uses
  SysUtils,
  Classes,
  {$IFDEF FPC}
    fpjson;
  {$ELSE}
    System.JSON;
  {$ENDIF}

type
 {$Region 'Interface'}
 ieTranslate = interface
   ['{0A0D7CEA-6E04-4E91-96DC-CE7A9552C3E2}']
   function Version: string;
   function GetLanguage: string;
   function SetLanguage(Value: string): ieTranslate;
   function Translate(Key: string; ParamValues: array of string):string; overload;
   function Translate(Key: string):string; overload;
 end;
 {$ENDREGION}

 {$region 'Classe Concreta - declaração'}
 TeTranslate = class(TInterfacedObject, ieTranslate)
   private
    CurrentLanguage : string;
    TranslateJson   : TJsonObject;
    function Language: TJSONObject;
    function GetKey(Previous: TJSONObject; Key: string): TJSONObject;
    function GetValue(Previous: TJSONObject; Key: string): string;

    const _version = '1.0';
   public
    constructor Create(TranslationFile: string = ''; _CurrentLanguage: string = 'en-US');
    destructor Destroy; override;
    class function New(TranslationFile: string = ''; _CurrentLanguage: string = 'en-US'): ieTranslate;

    //functions
    function Version: string;
    function GetLanguage: string;
    function SetLanguage(Value: string): ieTranslate;
    function Translate(Key: string; ParamValues: array of string):string; overload;
    function Translate(Key: string):string; overload;
 end;
 {$endregion}

 //Função ponto de entrada
 function eTranslate(TranslationFile: string = ''; CurrentLanguage: string = 'en-US'): ieTranslate;

var
 FInstancia: ieTranslate;

implementation

uses
  {$ifdef fpc}
   jsonparser;
  {$else}
   IOUtils;
  {$endif}

{ TeTranslate }

function eTranslate(TranslationFile: string = ''; CurrentLanguage: string = 'en-US'): ieTranslate;
 begin
   if not Assigned(FInstancia) then
    FInstancia := TeTranslate.New(TranslationFile, CurrentLanguage);

   Result := FInstancia
 end;


{$region 'Métodos da Classe Concreta'}

{$region 'Métodos compartilhados'}
{$IFDEF FPC}
function GetJSONData(const aJSON: UTF8String): TJSONData;
var
  jParser: TJSONParser;
begin
  Result := nil;
  jParser := TJSONParser.Create(aJSON, True);
  try
    Result := jParser.Parse;
  finally
    jParser.Free;
  end;
end;
{$ENDIF}

function RemoveQuotes(const text: string) : string;
begin
 Result := text.Replace('"', '');
 Result := Result.TrimLeft;
 Result := Result.TrimRight;
end;

function ReadFileToString(const FilePath: string) : string;
var
  StringListFile : TStringList;
begin
  StringListFile := TStringList.Create;
  try
    try
      if (FilePath = EmptyStr) then
         raise Exception.Create('It was not possible to read translation file.');

      StringListFile.LoadFromFile(FilePath);
      Result := StringListFile.Text;
    except
      raise Exception.Create('It was not possible to read translation file.');
    end;
  finally
    FreeAndNil(StringListFile);
  end;
end;

function StringToJsonObject(Content: string) : TJSONObject;
begin
  {$IFDEF FPC}
    Result := GetJSONData(Content) As TJSONObject;
  {$ELSE}
    Result := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(Content), 0) As TJSONObject;
  {$ENDIF}
end;
{$endregion}

{$region 'Métodos para tratar leituras de valores JSON'}
function TeTranslate.Language: TJSONObject;
begin
  {$ifdef fpc}
    Result := TranslateJson.GetPath(CurrentLanguage) as TJSONObject;
  {$else}
    Result := TranslateJson.GetValue(CurrentLanguage) as TJSONObject;
  {$endif}
end;

function TeTranslate.GetValue(Previous: TJSONObject; Key: string): string;
begin
  {$ifdef fpc}
    Result := RemoveQuotes(Previous.GetPath(Key).AsString);
  {$else}
    Result := RemoveQuotes(Previous.GetValue(Key).ToString);
  {$endif}
end;

function TeTranslate.GetKey(Previous: TJSONObject; Key: string): TJSONObject;
begin
  {$ifdef fpc}
    Result := Previous.GetPath(Key) as TJSONObject;
  {$else}
    Result := Previous.GetValue(Key) as TJSONObject;
  {$endif}
end;
{$endregion}

{$region 'Métodos básicos de Criação e destruição'}
constructor TeTranslate.Create(TranslationFile: string = ''; _CurrentLanguage: string = 'en-US');
var
  JsonFileContent : string;
begin
  if (TranslationFile = EmptyStr) then
    raise Exception.Create('It´s not possible to begin eTranslate without telling which file to read for translations and where it is.');

  if (not FileExists(TranslationFile)) then
    raise Exception.Create('It was not possible to load translation file because it couldn`t be found.');

  JsonFileContent := ReadFileToString(TranslationFile); //TFile.ReadAllText(TranslationFile);

  TranslateJson := StringToJsonObject(JsonFileContent);

  CurrentLanguage := _CurrentLanguage;
end;

destructor TeTranslate.Destroy;
begin
  if Assigned(TranslateJson) then
    FreeAndNil(TranslateJson);
  inherited;
end;

class function TeTranslate.New(TranslationFile: string = ''; _CurrentLanguage: string = 'en-US'): ieTranslate;
begin
  result := TeTranslate.Create(TranslationFile,_CurrentLanguage);
end;
{$endregion}

{$region 'Métodos principais da lib'}
/// <summary>
/// Função para retornar a linguagem em uso
/// </summary>
function TeTranslate.GetLanguage: string;
begin
  //Result := CurrentLanguage;
  Result := GetValue(GetKey(Language, 'Main'), 'Btn1')
end;

/// <summary>
/// Método para definir a linguagem a usar
/// </summary>
function TeTranslate.SetLanguage(Value: string): ieTranslate;
begin
  CurrentLanguage := Value;
  Result := self;
end;

/// <summary>
/// Função para traduzir mensagem (pegar a mensagem em questão usando a chave passada
/// </summary>
function TeTranslate.Translate(Key: string): string;
begin
  Result := self.Translate(Key, []);
end;

/// <summary>
/// Função para traduzir mensagem (pegar a mensagem em questão usando a chave passada
/// </summary>
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

//      {$ifdef fpc}
//      Result := RemoveQuotes(((TranslateJson.GetPath(CurrentLanguage) as TJSONObject).GetPath('Main') as TJSONObject).GetPath('Btn1').AsString);
//  {$else}
//    Result := RemoveQuotes(((TranslateJson.GetValue(CurrentLanguage) as TJSONObject).GetValue('Main') as TJSONObject).GetValue('Btn1').ToString);
//  {$endif}
end;

 /// <summary>
 /// Função para exibir versão da lib
 /// </summary>
function TeTranslate.Version: string;
begin
  Result :=  _version;
end;
{$endregion}

{$endregion}

end.
