unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls;

type

  { TMyRect }

  TMyRect = class
  strict private
    fValues: array[0..3] of Integer;
    function GetValue(AIndex: Integer): Integer;
    procedure SetValue(AIndex: Integer; AValue: Integer);
  public
    property Left: Integer index 0 read GetValue write SetValue;
    property Top: Integer index 1 read GetValue write SetValue;
    property Width: Integer index 2 read GetValue write SetValue;
    property Height: Integer index 3 read GetValue write SetValue;
  end;


  { TMainForm }

  TMainForm = class(TForm)
    imgMain: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure imgMainResize(Sender: TObject);
  private
    { private declarations }
    MyRect: TMyRect;
  public
    { public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.lfm}

{ TMainForm }

procedure TMainForm.FormCreate(Sender: TObject);
// *** création de la fiche ***
begin
  MyRect := TMyRect.Create; // rectangle créé
  // affectation de points
  with MyRect do
  begin
    Left:= 50;
    Top := 30;
    Width := 320;
    Height := 250;
  end;
  // en-tête de fenêtre avec les coordonnées
  with MyRect do
    Caption := Caption + Format(' ( %d, %d, %d, %d)', [Left, Top, Width, Height]);
end;

procedure TMainForm.FormDestroy(Sender: TObject);
// *** destruction de la fiche ***
begin
  MyRect.Free; // libération du rectangle
end;

procedure TMainForm.imgMainResize(Sender: TObject);
// *** dessin ***
begin
  // couleur bleue
  imgMain.Canvas.Brush.Color := clBlue;
  // dessin du rectangle
  with MyRect do
    imgMain.Canvas.Rectangle(Left, Top, Width - Left, Height - Top);
end;

{ TMyRect }

function TMyRect.GetValue(AIndex: Integer): Integer;
// *** récupération d'une valeur ***
begin
  Result := fValues[AIndex];
end;

procedure TMyRect.SetValue(AIndex: Integer; AValue: Integer);
// *** établissement d'une valeur ***
begin
  fValues[AIndex] := AValue;
end;

end.

