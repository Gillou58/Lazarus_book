{ |========================================================================|
  |                                                                        |
  |                  Projet : Aller plus loin avec Lazarus                 |
  |                  Description : POO - Programme exemple 20              |
  |                  Unité : main.pas                                      |
  |                  Site : www.developpez.net                             |
  |                  Copyright : © Roland CHASTAIN & Gilles VASSEUR 2015   |
  |                  Date:    27/06/2015 22:47:10                          |
  |                  Version : 1.0.0                                       |
  |                                                                        |
  |========================================================================| }

// HISTORIQUE
// 27/06/2015 22:47:10 - 1.0.0 - première version opérationnelle

// MAIN - part of "Aller plus loin avec Lazarus"
// Copyright © Roland CHASTAIN & Gilles VASSEUR 2015
//
// This program is free software: you can redistribute it and/or modify it
// under the terms of the GNU General Public License as published by the
// Free Software Foundation, either version 3 of the License,
// or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY;
// without even the implied warranty of MERCHANTABILITY or
// FITNESS FOR A PARTICULAR PURPOSE.
// See the GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.
// If not, see <http://www.gnu.org/licenses/>.

unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Buttons,
  Grids, StdCtrls;

const
  // nom des pièces ***
  CCircle = 'rond';
  CSquare = 'carré';

type
  // *** taille du damier ***
  TSize8 = 0..7;

  // *** définition d'une case ***
  TSquare = record
    Piece: string;
    Used: Boolean;
  end;

  { TMyBoard }

  TMyBoard = class
  private
    fBoard: array[TSize8, TSize8] of TSquare;
    fColors: array[0..1] of TColor;
    function GetColor(const Name: string): TColor;
    function GetUsed(X, Y : TSize8): Boolean;
    function GetName(X, Y: TSize8): string;
    procedure SetColor(const Name: string; AValue: TColor);
    procedure SetUsed(X, Y : TSize8; AValue: Boolean);
    procedure SetName(X, Y: TSize8; AValue: string);
  public
    procedure Clear;
    function Count: Integer;
    property Used[X, Y: TSize8]: Boolean read GetUsed write SetUsed;
    property PieceName[X, Y: TSize8]: string read GetName write SetName;
    property Color[const Name: string]: TColor read GetColor write SetColor; default;
  end;

  { TMainForm }

  TMainForm = class(TForm)
    btnUpdate: TButton;
    btnReset: TButton;
    lblCount: TLabel;
    sgMain: TStringGrid;
    procedure btnResetClick(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure sgMainDrawCell(Sender: TObject; aCol, aRow: Integer;
      aRect: TRect; aState: TGridDrawState);
  private
    { private declarations }
    Board: TMyBoard;
  public
    { public declarations }
    procedure UpdateGrid;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.lfm}

{ TMainForm }

procedure TMainForm.FormCreate(Sender: TObject);
// *** création de la fiche ***
begin
  // création du damier
  Board := TMyBoard.Create;
  // couleur du cercle (accès complet)
  Board.Color[CCircle] := clRed;
  // couleur du rectangle (accès raccourci)
  Board[CSquare] := clBlue;
  // dessin de la grille
  UpdateGrid;
end;

procedure TMainForm.btnUpdateClick(Sender: TObject);
// *** rafraîchissement de l'affichage ***
begin
  UpdateGrid; // grille modifiée
  sgMain.Repaint; // affichage
end;

procedure TMainForm.btnResetClick(Sender: TObject);
// *** remise à zéro ***
begin
  Board.Clear; // damier réinitialisé
  sgMain.Repaint; // affichage
  // nombre d'éléments affichés
  lblCount.Caption := IntToStr(Board.Count);
end;

procedure TMainForm.FormDestroy(Sender: TObject);
// *** destruction de la fiche ***
begin
  Board.Free; // libération du damier
end;

procedure TMainForm.sgMainDrawCell(Sender: TObject; aCol, aRow: Integer;
  aRect: TRect; aState: TGridDrawState);
// *** dessin d'une cellule ***
begin
  with (Sender as TStringGrid) do // travail avec la grille
    if Board.Used[aCol, aRow] then // un élément à l'emplacement ?
    begin
      // couleur du fond
      Canvas.Brush.Color :=
        Board.Color[Board.PieceName[aCol, aRow]]; // couleur d'un cercle ou d'un carré
        // Board[Board.PieceName[aCol, aRow]]; // autre possibilité
      if Board.PieceName[aCol, aRow] = CCircle then
        with aRect do
          Canvas.Ellipse(aRect) // cercle dessiné
      else
        Canvas.FillRect(aRect); // ou un rectangle
      // nom de la forme
      Canvas.TextOut(aRect.Left + 8, aRect.Top + 12 ,
        Board.PieceName[aCol, aRow]);
    end;
end;

procedure TMainForm.UpdateGrid;
var
  Li, LX, LY: Integer;
begin
  // quelques cercles et rectangles
  for Li := 1 to 10 do
  begin
    // coordonnées
    LX := random(8);
    LY := random(8);
    Board.PieceName[LX, LY] := CCircle; // un cercle
    Board.Used[LX, LY] := True; // case occupée
    // nouvelles coordonnées (peut-être recouvrantes)
    LX := random(8);
    LY := random(8);
    Board.PieceName[LX, LY] := CSquare; // un carré
    Board.Used[LX, LY] := True; // case occupée
  end;
  // nombre d'éléments affichés
  lblCount.Caption := IntToStr(Board.Count);
end;

{ TMyBoard }

function TMyBoard.GetColor(const Name: string): TColor;
// *** couleur en fonction du nom ***
begin
  if Name = CCircle then
    Result := fColors[0]
  else
  if Name = CSquare then
    Result := fColors[1];
end;

function TMyBoard.GetUsed(X, Y : TSize8): Boolean;
// *** case vide ? ***
begin
  Result := fBoard[X, Y].Used;
end;

function TMyBoard.GetName(X, Y: TSize8): string;
// *** nom associé à la case ***
begin
  Result := fBoard[X, Y].Piece;
end;

procedure TMyBoard.SetColor(const Name: string; AValue: TColor);
// *** définition de la couleur d'une pièce ***
begin
 if Name = CCircle then
    fColors[0] := AValue
  else
  if Name = CSquare then
    fColors[1] := AValue;
end;

procedure TMyBoard.SetUsed(X, Y : TSize8; AValue: Boolean);
// *** mise à jour de l'occupation d'une case ***
begin
  fBoard[X, Y].Used := AValue;
end;

procedure TMyBoard.SetName(X, Y: TSize8; AValue: string);
// *** mise à jour du nom associé à la case ***
begin
  fBoard[X, Y].Piece := AValue;
end;

procedure TMyBoard.Clear;
// *** nettoyage du damier ***
var
  Li, Lj: Integer;
begin
   // on parcourt tout le damier
  for Li := Low(TSize8) to High(TSize8) do
    for Lj := Low(TSize8) to High(TSize8) do
    begin
      // remise à zéro de chaque élément
      fBoard[Li, Lj].Piece := '';
      fBoard[Li, Lj].Used := False;
    end;
end;

function TMyBoard.Count: Integer;
// *** nombre d'éléments du damier ***
var
  Li, Lj: Integer;
begin
  Result := 0; // résultat par défaut
  // on parcourt tout le damier
  for Li := Low(TSize8) to High(TSize8) do
    for Lj := Low(TSize8) to High(TSize8) do
      if fBoard[Li, Lj].Used then // case occupée ?
        Inc(Result); // résultat incrémenté
end;

end.

