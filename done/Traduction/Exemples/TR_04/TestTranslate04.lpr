{ |========================================================================|
  |                                                                        |
  |                  Projet : Aller plus loin avec Lazarus                 |
  |                  Description : Traduction - Programme exemple 04       |
  |                  Unité : TestTranslate04.lpr                           |
  |                  Site : www.developpez.net                             |
  |                  Copyright : © Roland CHASTAIN & Gilles VASSEUR 2015   |
  |                  Date:    28/05/2015 20:09:11                          |
  |                  Version : 1.0.0                                       |
  |                                                                        |
  |========================================================================| }

// HISTORIQUE
// 28/05/2015 20:09:50 - 1.0.0 - première version opérationnelle

// TESTTRANSLATE04 - part of "Aller plus loin avec Lazarus"
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

program TestTranslate04;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, main,
  { you can add units after this }
  DefaultTranslator; // unité ajoutée

{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

