unit unit2;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm2 }

  TForm2 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure UpdateUI;
  public

  end;

var
  Form2: TForm2;

implementation

{$R *.lfm}

{ TForm2 }

uses eTranslate4Pascal;

procedure TForm2.Button1Click(Sender: TObject);
begin
  eTranslate.SetLanguage(Edit1.Text);
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  UpdateUI;
  eTranslate.OnSetLanguage(@UpdateUI);
end;

procedure TForm2.UpdateUI;
begin
  Label1.Caption:= eTranslate.Translate('Main.Btn1', ['Lazarus', 'Excelente']);;
end;

end.

