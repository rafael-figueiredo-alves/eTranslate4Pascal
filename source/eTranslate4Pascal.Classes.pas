unit eTranslate4Pascal.Classes;

interface

uses
  SysUtils,
  Classes,
  eTranslate4Pascal.Interfaces,
  {$IFDEF FPC}
    fpjson;
  {$ELSE}
    System.JSON;
  {$ENDIF}

type

 TeTranslate = class(TInterfacedObject, ieTranslate)
   private
    CurrentLanguage : string;
    TranslateJson   : TJsonObject;
    function LanguageJSON: TJSONObject;
    function GetValueFromKey(Key : string): string;
    function FillValueWithValues(Value: string; Values: array of string): string;
   public
    constructor Create(TranslationFile: string = ''; _CurrentLanguage: string = 'en-US');
    destructor Destroy; override;
    class function New(TranslationFile: string = ''; _CurrentLanguage: string = 'en-US'): ieTranslate;

    //functions
    function Version: string;
    function GetLanguage: string;
    function SetLanguage(Value: string): ieTranslate;
    function Translate(Key: string; ValuesToFillValue: array of string):string; overload;
    function Translate(Key: string):string; overload;
 end;

 const _version = '1.0.0';

implementation

uses
  eTranslate4Pascal.Shared,
  eTranslate4Pascal.JsonObjectHelper;

function TeTranslate.LanguageJSON: TJSONObject;
begin
    Result := TranslateJson.Key(CurrentLanguage);
end;

{$region 'M�todos b�sicos de Cria��o e destrui��o'}
constructor TeTranslate.Create(TranslationFile: string = ''; _CurrentLanguage: string = 'en-US');
var
  JsonFileContent : string;
begin
  if (TranslationFile = EmptyStr) then
    raise Exception.Create('It�s not possible to begin eTranslate without telling which file to read for translations and where it is.');

  if (not FileExists(TranslationFile)) then
    raise Exception.Create('It was not possible to load translation file because it couldn`t be found.');

  TranslateJson := GetJSONObjectFromFile(TranslationFile);

  CurrentLanguage := _CurrentLanguage;
end;

destructor TeTranslate.Destroy;
begin
  if Assigned(TranslateJson) then
    FreeAndNil(TranslateJson);
  inherited;
end;

function TeTranslate.FillValueWithValues(Value: string; Values: array of string): string;
var
  index : integer;
begin
  Result := Value;
  for index := Low(Values) to High(Values) do
    Result := StringReplace(Result, '{' + index.ToString + '}', Values[index], []);
end;

class function TeTranslate.New(TranslationFile: string = ''; _CurrentLanguage: string = 'en-US'): ieTranslate;
begin
  result := TeTranslate.Create(TranslationFile,_CurrentLanguage);
end;
{$endregion}

{$region 'M�todos principais da lib'}
function TeTranslate.GetLanguage: string;
begin
  Result := CurrentLanguage;
end;

function TeTranslate.GetValueFromKey(Key: string): string;
var
  {$ifdef fpc}
   Keys            : TStringArray;
  {$else}
   Keys            : TArray<string>;
  {$endif}
  index           : integer;
  TranslateObject : TJSONObject;
begin
  if (key = EmptyStr) then
    raise Exception.Create('It was not possible to get value from key because the key was empty.');

  Keys            := GetAllKeysFromKey(Key);
  TranslateObject := LanguageJSON;
  Result          := EmptyStr;

  for index := 0 to Length(Keys) - 1  do
   begin
     if (index <> Length(Keys) - 1)  then
       TranslateObject := TranslateObject.Key(Keys[index])
     else
       Result := TranslateObject.Value(keys[index]);
   end;
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

function TeTranslate.Translate(Key: string;ValuesToFillValue: array of string): string;
var
  ValueFromKey : string;
begin
  ValueFromKey := GetValueFromKey(key);

  if(Length(ValuesToFillValue) > 0) then
   begin
     if ValueFromKey = EmptyStr then
       raise Exception.Create('It`s not possible to fill an empty string.');

     Result := FillValueWithValues(ValueFromKey, ValuesToFillValue)
   end
  else
   result := ValueFromKey;
end;

function TeTranslate.Version: string;
begin
  Result := _version;
end;
{$endregion}

end.
