unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TMyClass }

  TMyClass = class
    private
      class var fMyValue: string;
    public
      class procedure SetMyValue(const AValue: string); static;
      class function GetMyValue: string; static;
  end;

  { TMainForm }

  TMainForm = class(TForm)
    btnClear: TButton;
    btnOK: TButton;
    edtSetVar: TEdit; // entrée de la valeur
    mmoDisplay: TMemo; // affichage de la valeur
    procedure btnClearClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure edtSetVarExit(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.lfm}

{ TMainForm }

procedure TMainForm.btnClearClick(Sender: TObject);
// *** nettoyage de la zone d'affichage ***
begin
  mmoDisplay.Lines.Clear;
end;

procedure TMainForm.btnOKClick(Sender: TObject);
// *** affichage de la valeur ***
begin
  mmoDisplay.Lines.Add(TMyClass.GetMyValue); // affichage de la nouvelle valeur
end;

procedure TMainForm.edtSetVarExit(Sender: TObject);
// *** nouvelle valeur ***
begin
  TMyClass.SetMyValue(edtSetVar.Text); // on affecte à la variable de classe
end;


{ TMyClass }

class procedure TMyClass.SetMyValue(const AValue: string);
// *** la valeur est mise à jour ***
begin
  fMyValue := Upcase(AValue); // en majuscules
end;

class function TMyClass.GetMyValue: string;
// *** récupération de la valeur ***
begin
  Result := fMyValue;
end;

end.

