unit UnitSecond;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit;

type
  TForm2 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure UpdateUI;
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

uses eTranslate4Pascal;

procedure TForm2.Button1Click(Sender: TObject);
begin
  Edit1.Text := eTranslate.GetLanguage;
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  eTranslate.SetLanguage(edit1.Text);
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  eTranslate.OnSetLanguage(UpdateUI);
  UpdateUI;
end;

procedure TForm2.UpdateUI;
begin
  Label1.Text := eTranslate.Translate('Main.Btn1', ['Rafael', '01/01/2024']);
end;

end.
