program eTranslate_Demo_Lazarus;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, unitMain, SysUtils, eTranslate4Pascal
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  eTranslate(ExtractFilePath(ParamStr(0)) + 'translate.json');
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

