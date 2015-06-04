unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

uses
  Unit2;

{ TForm1 }

resourcestring
  RS_Hello = 'Hello world !';
  RS_Bye = 'Goodbye cruel world !';

procedure TForm1.Button1Click(Sender: TObject);
// *** inversion de la légende du bouton 1 ***
begin
  if Button1.Caption = RS_Hello then
    Button1.Caption := RS_Bye
  else
    Button1.Caption := RS_Hello;
end;

procedure TForm1.Button2Click(Sender: TObject);
// *** ouverture d'une nouvelle fiche ***
var
  MyForm: TForm2;
begin
  MyForm := TForm2.Create(Self);  // on crée la fiche
  try
    MyForm.ShowModal;  // on la montre (seule active
  finally
    MyForm.Close; // on libère la fiche
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
// *** création de l'application ***
begin
  Button1.Caption := RS_Hello;
end;

end.

