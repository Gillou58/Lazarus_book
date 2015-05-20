{ |========================================================================|
  |                                                                        |
  |                  G V S O F T                                           |
  |                  Projet : Paquet GVORPHEUS                             |
  |                  Description : Attente colorée                         |
  |                  Unité : GVWaitngPanel.pas                             |
  |                  Ecrit par  : VASSEUR Gilles                           |
  |                  e-mail : g.vasseur58@laposte.net                      |
  |                  Copyright : © G. VASSEUR 2015                         |
  |                  Date:    03-05-2015 18:00:00                          |
  |                  Version : 1.0.0                                       |
  |                                                                        |
  |========================================================================| }

// HISTORIQUE
// 03/05/2015 - 1.0.0 - première version opérationnelle

// GVWAITINGPANEL - part of GVORPHEUS.LPK
// Copyright © 2015 Gilles VASSEUR
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

unit gvwaitingpanel;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, ExtCtrls;


type
  // exception pour taille incorrecte
  EWaitingSizeException = class(Exception);
  // desins possibles
  TGVWaitingType = (gvwRectangle, gvwFrame, gvwEllipse);

  { TGVWaitingPanel }

  TGVWaitingPanel = class(TPanel)
  private
    fShape: TGVWaitingType;
    fTimer: TTimer;
    fActiveFrame: Integer;
    fWidth, fHeight: Integer;
    fActiveColor: TColor;
    fInactiveColor: TColor;
    fInactiveBorderColor: TColor;
    fActiveBorderColor: TColor;
    fNbOfItems: Integer;
    procedure SetActiveBorderColor(AValue: TColor);
    procedure SetActiveColor(AValue: TColor);
    procedure SetInactiveBorderColor(AValue: TColor);
    procedure SetInactiveColor(AValue: TColor);
    procedure SetNbOfItems(AValue: Integer);
    procedure SetShape(AValue: TGVWaitingType);
    { Private declarations }
  protected
    { Protected declarations }
    procedure Paint; override; // dessin
    procedure WaitingDraw(Sender: TObject); // activité
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override; // constructeur
    destructor Destroy; override; // destructeur
  published
    { Published declarations }
    // nombre d'éléments
    property NbOfItems: Integer read fNbOfItems write SetNbOfItems default 5;
    // couleur active
    property ActiveColor: TColor read fActiveColor write SetActiveColor default clBlue;
    // couleur inactive
    property InactiveColor: TColor read fInactiveColor write SetInactiveColor default clAqua;
    // couleur de bordure active
    property ActiveBorderColor: TColor read fActiveColor write SetActiveBorderColor default clBlack;
    // couleur de bordure inactive
    property InactiveBorderColor: TColor read fInactiveBorderColor write SetInactiveBorderColor default clNone;
    // type de dessin
    property Shape: TGVWaitingType read fShape write SetShape default gvwRectangle;

  end;

resourcestring
  ESizeTooSmall = 'Le composant est trop petit !';

procedure Register;

implementation

procedure Register;
begin
  {$I gvwaitingpanel_icon.lrs}
  RegisterComponents('GVSoft',[TGVWaitingPanel]);
end;

{ TGVWaitingPanel }

procedure TGVWaitingPanel.SetNbOfItems(AValue: Integer);
// *** définit le nombre d'éléments affichés ***
begin
  if fNbOfItems = AValue then // même valeur
    Exit; // sortie
  fNbOfItems := AValue; // nouvelle valeur
end;

procedure TGVWaitingPanel.SetShape(AValue: TGVWaitingType);
// *** définit la forme à dessiner ***
begin
  if fShape = AValue then // la même ?
    Exit; // on sort
  fShape := AValue; // nouvelle valeur
end;

procedure TGVWaitingPanel.Paint;
// *** dessin du composant ***
begin
  inherited Paint;
end;

procedure TGVWaitingPanel.WaitingDraw(Sender: TObject);
// *** activité ***
var
  Li: Integer;
begin
  fHeight := (Height div 4); // hauteur pour dessiner
  fWidth := (Width div (2 * NbOfItems)); // largeur pour dessiner
  if (fHeight < 2) or (fWidth < 2) then
    raise EWaitingSizeException.Create(ESizeTooSmall);
  Inc(fActiveFrame); // calcul de l'élément actif
  if fActiveFrame > NbOfItems then
    fActiveFrame := 0;
  with Canvas do
  begin
    for Li := 0 to NbOfItems do // on balaie les éléments
    begin
      if Li = fActiveFrame then // actif ?
      begin
        Brush.Color := ActiveColor;
        Pen.Color := ActiveBorderColor;
      end
      else  // inactif ?
      begin
        Brush.Color := InactiveColor;
        Pen.Color := InactiveBorderColor;
      end;
      if Odd(Li) then // ménage des espaces
      case Shape of // dessin suivant la forme voulue
        gvwRectangle: Rectangle(2*Li * fWidth, fHeight, 2*(Li + 1)* fWidth, fHeight * 3);
        gvwEllipse: Ellipse(2*Li * fWidth, fHeight, 2*(Li + 1)* fWidth, fHeight * 3);
        gvwFrame: Frame(2*Li * fWidth, fHeight, 2*(Li + 1)* fWidth, fHeight * 3);
      end;
    end;
  end;
end;

procedure TGVWaitingPanel.SetActiveColor(AValue: TColor);
// *** couleur active ***
begin
  if fActiveColor = AValue then // la même ?
    Exit; // on sort
  fActiveColor := AValue; // nouvelle couleur
end;

procedure TGVWaitingPanel.SetActiveBorderColor(AValue: TColor);
// *** couleur de bordure active ***
begin
  if fActiveBorderColor = AValue then // même valeur ?
    Exit; // on sort
  fActiveBorderColor := AValue; // nouvelle valeur
end;

procedure TGVWaitingPanel.SetInactiveBorderColor(AValue: TColor);
// *** couleur de bordure inactive ***
begin
  if fInactiveBorderColor = AValue then // même valeur ?
    Exit; // on sort
  fInactiveBorderColor := AValue; // nouvelle valeur
end;

procedure TGVWaitingPanel.SetInactiveColor(AValue: TColor);
// *** couleur inactive ***
begin
  if fInactiveColor = AValue then // la même ?
    Exit; // on sort
  fInactiveColor := AValue; // nouvelle valeur
end;

constructor TGVWaitingPanel.Create(AOwner: TComponent);
// *** constructeur ***
begin
  NbOfItems := 5; // nombre d'éléments par défaut
  fTimer := TTimer.Create(Self); // création du timer
  fTimer.OnTimer := @WaitingDraw; // génération du dessin
  fTimer.Interval:=100;
  fTimer.Enabled:= True; // timer actif par défaut
  ActiveColor := clBlue; // couleurs par défaut
  InactiveColor := clAqua;
  ActiveBorderColor := clBlack;
  InactiveBorderColor := clNone;

  Shape := gvwRectangle; // forme par défaut
  fActiveFrame := -1; // forme active de début
  inherited Create(AOwner); // on hérite
end;

destructor TGVWaitingPanel.Destroy;
// *** destructeur ***
begin
  fTimer.Free; // timer libéré
  inherited Destroy; // on hérite
end;

end.
