unit UnitMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses eTranslate4Pascal, UnitSecond;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Edit1.Text := eTranslate.GetLanguage;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  eTranslate.SetLanguage(Edit1.Text);
end;


procedure TForm1.Button3Click(Sender: TObject);
begin
  Form2 := TForm2.Create(Application);
  try
    Form2.ShowModal;
  finally
    FreeAndNil(Form2);
  end;
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  texto : string;
begin
  texto := EmptyStr;
  texto := eTranslate.Translate('Teste');
  showmessage(texto);
  texto := eTranslate.Translate('Teste 2', ['Rafael', '11/01/2024']);
  ShowMessage(texto);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  form1.Caption := 'eTranslate version ' + eTranslate.Version;
end;

end.
