unit eTranslate4Pascal.Classes;

interface

uses
  SysUtils,
  Classes,
  eTranslate4Pascal.Interfaces,
  Generics.Collections,
  {$IFDEF FPC}
    fpjson;
  {$ELSE}
    System.JSON;
  {$ENDIF}

type

 TeTranslate = class(TInterfacedObject, ieTranslate)
   private
    {$ifdef FPC}
    ListOnSetLanguage: specialize TList<TOnSetLanguage>;
    {$else}
    ListOnSetLanguage: TList<TOnSetLanguage>;
    {$endif}
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
    function Translate(Key: string; ValuesToFillValue: array of string; DefaultValue: string = ''):string; overload;
    function Translate(Key: string):string; overload;
    function Translate(Key: string; DefaultValue: string):string; overload;
    function Translate(Key: string; DefaultValue: string; ValuesToFillValue: array of string):string; overload;
    function OnSetLanguage(const Event: TOnSetLanguage): ieTranslate;
 end;

 const _version = '1.2.0';

implementation

uses
  eTranslate4Pascal.Shared,
  eTranslate4Pascal.JsonObjectHelper;

{$region 'Métodos básicos de Criação e destruição'}
constructor TeTranslate.Create(TranslationFile: string = ''; _CurrentLanguage: string = 'en-US');
var
  JsonFileContent : string;
begin
  if (TranslationFile = EmptyStr) then
    raise Exception.Create('It´s not possible to begin eTranslate without telling which file to read for translations and where it is.');

  if (not FileExists(TranslationFile)) then
    raise Exception.Create('It was not possible to load translation file because it couldn`t be found.');

  TranslateJson := GetJSONObjectFromFile(TranslationFile);

  CurrentLanguage := _CurrentLanguage;

  {$ifdef FPC}
  ListOnSetLanguage := specialize TList<TOnSetLanguage>.Create;
  {$else}
  ListOnSetLanguage := TList<TOnSetLanguage>.Create;
  {$endif}
end;

destructor TeTranslate.Destroy;
begin
  if Assigned(TranslateJson) then
    FreeAndNil(TranslateJson);
  if Assigned(ListOnSetLanguage) then
    FreeAndNil(ListOnSetLanguage);
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

{$region 'Métodos de apoio'}
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

function TeTranslate.LanguageJSON: TJSONObject;
begin
    Result := TranslateJson.Key(CurrentLanguage);
end;
{$endregion}

{$region 'Métodos principais da lib'}
function TeTranslate.GetLanguage: string;
begin
  Result := CurrentLanguage;
end;

function TeTranslate.OnSetLanguage(const Event: TOnSetLanguage): ieTranslate;
begin
  if ListOnSetLanguage.IndexOf(Event) = -1 then
    ListOnSetLanguage.Add(Event);
  Result := Self;
end;

function TeTranslate.SetLanguage(Value: string): ieTranslate;
var
  Event : TOnSetLanguage;
begin
  CurrentLanguage := Value;
  for Event in ListOnSetLanguage do
   begin
     try
       Event();
     except
       ListOnSetLanguage.Remove(Event);
     end;
   end;

  Result := self;
end;

function TeTranslate.Translate(Key: string): string;
begin
  Result := self.Translate(Key, [], EmptyStr);
end;

function TeTranslate.Translate(Key: string;ValuesToFillValue: array of string; DefaultValue: string = ''): string;
var
  ValueFromKey : string;
begin
  ValueFromKey := GetValueFromKey(key);

  if(Length(ValuesToFillValue) > 0) then
   begin
     if ValueFromKey = EmptyStr then
       Result := DefaultValue
     else
      Result := FillValueWithValues(ValueFromKey, ValuesToFillValue);
   end
  else
   if(ValueFromKey = EmptyStr)then
    result := DefaultValue
   else
    result := ValueFromKey;
end;

function TeTranslate.Translate(Key, DefaultValue: string;ValuesToFillValue: array of string): string;
begin
  Result := self.Translate(Key, ValuesToFillValue, DefaultValue);
end;

function TeTranslate.Translate(Key, DefaultValue: string): string;
begin
  Result := self.Translate(Key, [], DefaultValue);
end;


function TeTranslate.Version: string;
begin
  Result := _version;
end;
{$endregion}
end.
