unit eTranslate4Pascal.JsonObjectHelper;

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

  TJSONObjectHelper = class helper for TJSONObject
    public
      function Key(Value: string) : TJSONObject;
      function Value(Key: string) : string;
  end;

implementation

{ tJSONObject }

uses
  eTranslate4Pascal.Shared;

function tJSONObjectHelper.Key(Value: string): TJSONObject;
{$ifdef fpc}
var
  Elemento : TJsonData;
{$endif}
begin
  {$ifdef fpc}
    if(Find(Value, Elemento))then
     Result := Elemento as TJSONObject
    else
     Result := TJSONObject.Create;
  {$else}
    Result := GetValue(Value) as TJSONObject;
  {$endif}
end;

function tJSONObjectHelper.Value(Key: string): string;
var
  ValueReturned : {$ifdef fpc}TJsonData; {$else} TJsonValue; {$endif}
begin
  {$ifdef fpc}
    if(not Find(Key, ValueReturned))then
     Result := EmptyStr
    else
     Result := RemoveQuotes(ValueReturned.AsString);
  {$else}
    if(not TryGetValue(Key, ValueReturned))then
     Result := EmptyStr
    else
     if(ValueReturned is TJSONString)then
      Result := RemoveQuotes(ValueReturned.ToString)
     else
      Result := EmptyStr;
  {$endif}
end;

end.
