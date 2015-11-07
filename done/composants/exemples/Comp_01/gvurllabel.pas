{ |========================================================================|
  |                                                                        |
  |                  Projet : Aller plus loin avec Lazarus                 |
  |                  Description : Components - Programme exemple 01       |
  |                  Unité : gvurllabel.pas                                |
  |                  Site : www.developpez.net                             |
  |                  Copyright : © Roland CHASTAIN & Gilles VASSEUR 2015   |
  |                  Date:    04/11/2015 13:03:20                          |
  |                  Version : 1.0.0                                       |
  |                                                                        |
  |========================================================================| }

// HISTORIQUE
// 04/11/2015 13:03:20 - 1.0.0 - première version opérationnelle

// GVURLLABEL - part of "Aller plus loin avec Lazarus"
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

unit GVUrlLabel;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, StdCtrls;

type
  { TGVUrlLabel }
  TGVUrlLabel = class(TLabel)
  private
    fURLHint: Boolean; // lien dans l'aide ?
    procedure SetURLHint(AValue: Boolean); // changement de type de lien
  protected
    // entrée de la souris dans le champ du composant
    procedure MouseEnter; override;
    // sortie de la souris du champ du composant
    procedure MouseLeave; override;
    // clic sur le composant
    procedure Click; override;
  public
    // création du composant
    constructor Create(TheOwner: TComponent); override;
  published
    // URL dans l'aide contextuelle ?
    property URLHint: Boolean read fURLHint write SetURLHint default True;
  end;


procedure Register;

implementation

uses LCLIntf; // pour les URL

procedure Register;
begin
  {$I gvurllabel_icon.lrs}
  RegisterComponents('GVSoft',[TGVUrlLabel]);
end;

{ TGVUrlLabel }

procedure TGVUrlLabel.SetURLHint(AValue: Boolean);
// *** changement de l'emplacement du lien ***
begin
  if fURLHint = AValue then // même valeur ?
    Exit; // on sort
  fURLHint := AValue; // nouvelle valeur affectée
  if not fURLHint then // pas dans l'aide contextuelle ?
    Font.Color := clBlue // couleur bleue pour la police
  else
    Font.Color := clDefault; // couleur par défaut pour la police
end;

procedure TGVUrlLabel.MouseEnter;
// *** la souris entre dans la surface de l'étiquette ***
begin
  inherited MouseEnter; // on hérite
  if not URLHint then // lien dans l'étiquette ?
  begin
    Font.Color := clRed; // couleur rouge pour la police
    Font.Style := Font.Style + [fsUnderline]; // on souligne le lien
    Cursor := crHandPoint; // le curseur est un doigt qui pointe
  end;
end;

procedure TGVUrlLabel.MouseLeave;
// *** la souris sort de la surface de l'étiquette ***
begin
  inherited MouseLeave; // on hérite
  if not URLHint then // lien dans l'étiquette ?
  begin
    Font.Color := clBlue; // couleur bleue pour la police
    Font.Style := Font.Style - [fsUnderline]; // on ne souligne plus le lien
    Cursor := crDefault; // le curseur est celui par défaut
  end;
end;

procedure TGVUrlLabel.Click;
// *** clic sur l'étiquette ***
begin
  inherited Click; // on hérite
  if URLHint then // dans l'aide contextuelle ?
    OpenURL(Hint) // envoi vers le navigateur par défaut
  else
    OpenURL(Caption); // sinon envoi du texte de l'étiquette
end;

constructor TGVUrlLabel.Create(TheOwner: TComponent);
// *** construction du composant ***
begin
  inherited Create(TheOwner); // on hérite
  fURLHint := True; // URL dans l'aide contextuelle par défaut
end;

end.
