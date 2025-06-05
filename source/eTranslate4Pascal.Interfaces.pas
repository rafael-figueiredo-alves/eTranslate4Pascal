unit eTranslate4Pascal.Interfaces;

interface

type

 TOnSetLanguage = procedure of object;

 ieTranslate = interface
   ['{0A0D7CEA-6E04-4E91-96DC-CE7A9552C3E2}']
   function Version: string;
   function GetLanguage: string;
   function SetLanguage(Value: string): ieTranslate;
   function Translate(Key: string; ValuesToFillValue: array of string; DefaultValue: string = ''):string; overload;
   function Translate(Key: string):string; overload;
   function Translate(Key: string; DefaultValue: string):string; overload;
   function Translate(Key: string; DefaultValue: string; ValuesToFillValue: array of string):string; overload;
   function OnSetLanguage(const Event: TOnSetLanguage): ieTranslate;

 end;

implementation

end.
