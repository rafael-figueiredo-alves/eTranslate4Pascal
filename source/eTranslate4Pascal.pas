unit eTranslate4Pascal;

interface

uses
  eTranslate4Pascal.Interfaces;

 //Função ponto de entrada
 function eTranslate(TranslationFile: string = ''; CurrentLanguage: string = 'en-US'): ieTranslate;

var
 FInstance: ieTranslate;

implementation

uses
  eTranslate4Pascal.Classes;

{ TeTranslate }

function eTranslate(TranslationFile: string = ''; CurrentLanguage: string = 'en-US'): ieTranslate;
 begin
   if not Assigned(FInstance) then
    FInstance := TeTranslate.New(TranslationFile, CurrentLanguage);

   Result := FInstance;
 end;


end.
