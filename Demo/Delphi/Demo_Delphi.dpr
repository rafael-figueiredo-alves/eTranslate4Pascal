program Demo_Delphi;

uses
  System.StartUpCopy,
  FMX.Forms,
  System.SysUtils,
  eTranslate4Pascal,
  UnitMain in 'UnitMain.pas' {Form1},
  UnitSecond in 'UnitSecond.pas' {Form2};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := true;
  Application.Initialize;
  eTranslate(ExtractFilePath(ParamStr(0)) + 'translate.json', 'pt-BR');
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
