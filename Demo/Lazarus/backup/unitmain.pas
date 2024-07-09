unit unitMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure UpdateUI;
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

uses eTranslate4Pascal, Unit2;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Form1.Caption := 'eTranslate4Pascal version ' + eTranslate.Version;
  UpdateUI;
  eTranslate.OnSetLanguage(@UpdateUI);
end;

procedure TForm1.UpdateUI;
begin
  Label1.Caption:= eTranslate.Translate('Main.Btn2.Text');;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  edit1.Text:= eTranslate.GetLanguage;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  eTranslate.SetLanguage(edit1.Text);
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  texto : string;
begin
  eTranslate.SetLanguage('pt-BR');
  texto := eTranslate.Translate('Main.Btn2.Text');
  ShowMessage(texto);
  texto := eTranslate.Translate('Main.Btn1', ['Lazarus', 'Excelente']);
  ShowMessage(texto);
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  Form2 := TForm2.Create;
  try
    Form2.ShowModal;
  finally
    FreeAndNil(Form2);
  end;
end;

end.

