program Demo_Delphi;

uses
  System.StartUpCopy,
  FMX.Forms,
  System.SysUtils,
  UnitMain in 'UnitMain.pas' {Form1},
  UnitSecond in 'UnitSecond.pas' {Form2},
  eTranslate4Pascal in '..\source\eTranslate4Pascal.pas',
  eTranslate4Pascal.Classes in '..\source\eTranslate4Pascal.Classes.pas',
  eTranslate4Pascal.Interfaces in '..\source\eTranslate4Pascal.Interfaces.pas',
  eTranslate4Pascal.Shared in '..\source\eTranslate4Pascal.Shared.pas',
  eTranslate4Pascal.JsonObjectHelper in '..\source\eTranslate4Pascal.JsonObjectHelper.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := true;
  Application.Initialize;
  eTranslate(ExtractFilePath(ParamStr(0)) + 'translate.json', 'pt-BR');
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
