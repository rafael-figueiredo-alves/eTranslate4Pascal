unit eTranslate4Pascal.Shared;

interface

uses
  SysUtils,
  Classes,
  StrUtils,
  {$IFDEF FPC}
    fpjson;
  {$ELSE}
    System.JSON;
  {$ENDIF}

{$IFDEF FPC}
function GetJSONData(const aJSON: UTF8String): TJSONData;
{$endif}
function RemoveQuotes(const text: string) : string;
function GetStringContentFromFile(const FilePath: string) : string;
function GetJSONObjectFromFile(const FilePath: string) : TJSONObject;
function GetAllKeysFromKey(const Key: string) : {$ifdef FPC} TStringArray {$else} TArray<string> {$endif};

const DefaultDelimiter = '.';

implementation

uses
  {$ifdef fpc}
   jsonparser;
  {$else}
   IOUtils;
  {$endif}

{$region 'M�todos compartilhados'}
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

function GetStringContentFromFile(const FilePath: string) : string;
var
  StringListFile : TStringList;
begin
  StringListFile := TStringList.Create;
  try
    try
      if (FilePath = EmptyStr) then
         raise Exception.Create('It was not possible to read translation file.');

      StringListFile.LoadFromFile(FilePath, TEncoding.UTF8);

      Result := StringListFile.Text;
    except
      raise Exception.Create('It was not possible to read translation file.');
    end;
  finally
    FreeAndNil(StringListFile);
  end;
end;

function GetJSONObjectFromFile(const FilePath: string) : TJSONObject;
var
 Content : string;
begin
  Content := GetStringContentFromFile(FilePath);

  {$IFDEF FPC}
    Result := GetJSONData(Content) As TJSONObject;
  {$ELSE}
    Result := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(Content), 0) As TJSONObject;
  {$ENDIF}
end;

function GetAllKeysFromKey(const Key: string) : {$ifdef FPC} TStringArray {$else} TArray<string> {$endif};
begin
  Result := SplitString(Key, DefaultDelimiter);
end;
{$endregion}

end.
