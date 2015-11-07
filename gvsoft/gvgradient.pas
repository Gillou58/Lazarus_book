{ |========================================================================|
  |                                                                        |
  |                  Projet : Aller plus loin avec Lazarus                 |
  |                  Description : Components - Programme exemple 04       |
  |                  Unité : gvgradient.pas                                |
  |                  Site : www.developpez.net                             |
  |                  Copyright : © Roland CHASTAIN & Gilles VASSEUR 2015   |
  |                  Date:    05/11/2015 13:03:20                          |
  |                  Version : 1.0.0                                       |
  |                                                                        |
  |========================================================================| }


// HISTORIQUE
// 05/11/2015 13:03:20 - 1.0.0 - première version opérationnelle

// GVGRADIENT - part of "Aller plus loin avec Lazarus"
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

unit gvgradient;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs;

type

  { TGVGradient }

  TGVGradient = class(TGraphicControl)
  strict private
    fDirection: TGradientDirection;
    fEnabled: Boolean;
    fBeginColor, fEndColor: TColor;
    procedure SetBeginColor(AValue: TColor);
    procedure SetDirection(AValue: TGradientDirection);
    procedure SetEndColor(AValue: TColor);
  protected
    procedure SetEnabled(AValue: Boolean); override;
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    // actif/inactif
    property Enabled: Boolean read fEnabled write SetEnabled default True;
    // couleur de départ
    property BeginColor: TColor read fBeginColor write SetBeginColor default clBlue;
    // couleur de fin
    property EndColor: TColor read fEndColor write SetEndColor default clAqua;
    // direction du dégradé
    property Direction: TGradientDirection read fDirection write SetDirection default gdVertical;
  end;

procedure Register;

implementation

uses
  graphutil;

procedure Register;
begin
  {$I gvgradient_icon.lrs}
  RegisterComponents('GVSoft',[TGVGradient]);
end;

{ TGVGradient }


procedure TGVGradient.SetBeginColor(AValue: TColor);
// *** couleur de début ***
begin
  if fBeginColor = AValue then // inchangée ?
    Exit; // on sort
  fBeginColor := AValue; // nouvelle valeur
  Repaint;
end;

procedure TGVGradient.SetDirection(AValue: TGradientDirection);
// *** direction du dégradé ***
begin
  if fDirection = AValue then // même valeur ?
    Exit; // on sort
  fDirection := AValue; // nouvelle valeur
  Repaint;
end;

procedure TGVGradient.SetEndColor(AValue: TColor);
// *** couleur de fin ***
begin
  if fEndColor = AValue then // inchangée ?
    Exit; // on sort
  fEndColor := AValue; // nouvelle couleur
  Repaint;
end;

procedure TGVGradient.SetEnabled(AValue: Boolean);
// *** activité du composant ***
begin
  if fEnabled = AValue then // valeur inchangée ?
    Exit; // on sort
  inherited SetEnabled(AValue);
  fEnabled := AValue; // nouvelle valeur
  Repaint;
end;

procedure TGVGradient.Paint;
// *** dessin du fond ***
begin
  inherited Paint;
  if Enabled then // actif ?
    Canvas.GradientFill(ClientRect, BeginColor, EndColor, Direction);
end;

constructor TGVGradient.Create(AOwner: TComponent);
// *** construction du composant ***
begin
  inherited Create(AOwner);
  Parent := (AOwner as TWinControl);
  Align := alClient;
  BeginColor := clBlue;
  EndColor := clAqua;
  Enabled := True;
  Direction := gdVertical;
end;

end.
