unit eTranslate4Pascal.Interfaces;

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

implementation

end.
