{ |========================================================================|
  |                                                                        |
  |                  Projet : Aller plus loin avec Lazarus                 |
  |                  Description : Components - Programme exemple 03       |
  |                  Unité : main.pas                                      |
  |                  Site : www.developpez.net                             |
  |                  Copyright : © Roland CHASTAIN & Gilles VASSEUR 2015   |
  |                  Date:    05/11/2015 11:24:20                          |
  |                  Version : 1.0.0                                       |
  |                                                                        |
  |========================================================================| }

// HISTORIQUE
// 05/11/2015 11:24:20 - 1.0.0 - première version opérationnelle

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
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ColorBox, GVUrlLabel;

type

  { TMainForm }

  TMainForm = class(TForm)
    cbColor: TCheckBox;
    cbUnderlined: TCheckBox;
    cboxEnter: TColorBox;
    cboxLeave: TColorBox;
    GVUrlLabel1: TGVUrlLabel;
    StaticText1: TStaticText;
    stEnter: TStaticText;
    procedure cbColorClick(Sender: TObject);
    procedure cboxEnterChange(Sender: TObject);
    procedure cboxLeaveChange(Sender: TObject);
    procedure cbUnderlinedClick(Sender: TObject);
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

procedure TMainForm.cbColorClick(Sender: TObject);
// *** couleur prise en compte ? ***
begin
  GVUrlLabel1.Colored := not GVUrlLabel1.Colored;
end;

procedure TMainForm.cboxEnterChange(Sender: TObject);
// *** changement de la couleur d'entrée ***
begin
  GVUrlLabel1.EnterColor := cboxEnter.Selected;
end;

procedure TMainForm.cboxLeaveChange(Sender: TObject);
// *** changement de la couleur de sortie ***
begin
  GVUrlLabel1.LeaveColor := cboxLeave.Selected;
end;

procedure TMainForm.cbUnderlinedClick(Sender: TObject);
// *** soulignement pris en compte ? ***
begin
  GVUrlLabel1.Underlined := not GVUrlLabel1.Underlined;
end;

end.

