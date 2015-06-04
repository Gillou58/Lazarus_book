{ |========================================================================|
  |                                                                        |
  |                  Projet : Aller plus loin avec Lazarus                 |
  |                  Description : Traduction - Programme exemple 06       |
  |                  Unité : TestTranslate06.lpr                           |
  |                  Site : www.developpez.net                             |
  |                  Copyright : © Roland CHASTAIN & Gilles VASSEUR 2015   |
  |                  Date:    28/05/2015 20:09:11                          |
  |                  Version : 1.0.0                                       |
  |                                                                        |
  |========================================================================| }

// HISTORIQUE
// 28/05/2015 20:09:50 - 1.0.0 - première version opérationnelle

// TESTTRANSLATE06 - part of "Aller plus loin avec Lazarus"
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

program TestTranslate06;

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, main,
  { you can add units after this }
  sysutils, // une unité ajoutée pour PathDelim
  gettext, translations; // deux unités ajoutées

{$R *.res}

procedure LCLTranslate;
var
  PODirectory, Lang, FallbackLang: String;
begin
  Lang := ''; // langue d’origine
  FallbackLang := ''; // langue d’origine étendue
  PODirectory := '.' + PathDelim + 'languages' + PathDelim; // répertoire de travail
  GetLanguageIDs(Lang, FallbackLang); // récupération des descriptifs de la langue
  TranslateUnitResourceStrings('LCLStrConsts',
    PODirectory + 'lclstrconsts.fr.po', Lang, FallbackLang); // traduction
end;

begin
  RequireDerivedFormResource := True;
  LCLTranslate; // on ordonne la traduction
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

