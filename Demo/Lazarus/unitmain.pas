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
    Edit1: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

uses eTranslate4Pascal;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Form1.Caption := 'eTranslate4Pascal version ' + eTranslate.Version;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  edit1.Text:= eTranslate.GetTexto;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  eTranslate.SetTexto(edit1.Text);
end;

end.

