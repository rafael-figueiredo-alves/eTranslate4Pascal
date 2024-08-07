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
begin
  {$ifdef fpc}
    Result := GetPath(Value) as TJSONObject;
  {$else}
    Result := GetValue(Value) as TJSONObject;
  {$endif}
end;

function tJSONObjectHelper.Value(Key: string): string;
begin
  {$ifdef fpc}
    Result := RemoveQuotes(GetPath(Key).AsString);
  {$else}
    Result := RemoveQuotes(GetValue(Key).ToString);
  {$endif}
end;

end.
