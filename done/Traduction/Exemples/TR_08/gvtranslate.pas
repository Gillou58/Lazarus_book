{ |========================================================================|
  |                                                                        |
  |                  Projet : Aller plus loin avec Lazarus                 |
  |                  Description : Traduction - Programme exemple 08       |
  |                  Unité : GVTranslate.pas                               |
  |                  Site : www.developpez.net                             |
  |                  Copyright : © Roland CHASTAIN & Gilles VASSEUR 2015   |
  |                  Date:    28/05/2015 20:09:11                          |
  |                  Version : 1.0.0                                       |
  |                                                                        |
  |========================================================================| }

// HISTORIQUE
// 28/05/2015 20:09:50 - 1.0.0 - première version opérationnelle

// GVTRANSLATE - part of "Aller plus loin avec Lazarus"
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

unit GVTranslate;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms;

type

  { TGVTranslate }

  TGVTranslate = class
  strict private
    fFileName: string;
    fFileDir: string;
    fLanguage: string;
    function GetLanguageFile: string;
    procedure SetFileName(const AValue: string);
    procedure SetFileDir(const AValue: string);
    procedure SetLanguage(const AValue: string);
    procedure Translate;
  public
    constructor Create;
    procedure Restart;
    property Language: string read fLanguage write SetLanguage;
    property FileName: string read fFileName write SetFileName;
    property FileDir: string read fFileDir write SetFileDir;
    property LanguageFile: string read GetLanguageFile;
  end;

implementation

uses
  UTF8Process,
  LCLTranslator,
  GetText,
  LResources,
  Translations,
  FileUtil;

const
  C_DefaultDir = 'languages';
  C_PoExtension = 'po';
  C_DefaultLanguage = 'en';

resourcestring
  RS_FallBackLanguage = 'auto';

{ TGVTranslate }

procedure TGVTranslate.SetLanguage(const AValue: string);
// *** détermine la langue pour la traduction ***
var
  LDummyLang: string;
begin
  if AValue = RS_FallBackLanguage then // langue de la machine ?
  begin
    LDummyLang := '';
    GetLanguageIDs(LDummyLang,fLanguage); // on retrouve son identifiant
  end
  else
    fLanguage := AValue; // nouvelle valeur
end;

constructor TGVTranslate.Create;
// *** création ***
begin
  inherited Create;
  if Application.ParamCount > 0 then // au moins un paramètre ?
    Language := Application.Params[1] // c'est l'identifiant de la langue
  else
    Language := C_DefaultLanguage; // langue par défaut
  if Application.ParamCount > 1 then // au moins deux paramètres ?
    FileDir := Application.Params[2] // c'est le répertoire des fichiers
  else
    FileDir := ''; // répertoire par défaut
  if Application.ParamCount > 2 then // au moins trois paramètres ?
    FileName := Application.Params[3] // c'est le nom du fichier
  else
    FileName := ''; // fichier par défaut
  Translate;
end;

procedure TGVTranslate.SetFileName(const AValue: string);
// *** détermine le nom du fichier ***
begin
  if AValue <> '' then // pas valeur par défaut ?
    // à partir de l'extraction du nom du fichier
    fFileName := ExtractFileName(AValue)
  else
    // à partir du nom du programme
    fFileName := ExtractFileNameOnly(Application.ExeName);
end;

function TGVTranslate.GetLanguageFile: string;
// *** construit et renvoie le chemin complet du fichier de traduction ***
begin
  Result := '.' + PathDelim + FileDir + PathDelim + FileName + '.' +
    Language + '.' + C_POExtension;
end;

procedure TGVTranslate.SetFileDir(const AValue: string);
// *** détermine le répertoire où sont les fichiers de traduction ***
begin
  fFileDir := AValue; // valeur affectée
  if fFileDir <> '' then // pas la valeur par défaut ?
    fFileDir := ExtractFilePath(fFileDir); // on récupère le chemin
  if fFileDir = '' then // chemin vide ?
    fFileDir := C_DefaultDir; // répertoire par défaut
end;

procedure TGVTranslate.Restart;
// *** redémarrage de l'application ***
var Exe: TProcessUTF8;
begin
  Exe := TProcessUTF8.Create(nil); // processus créé
  try
    Exe.Executable := Application.ExeName; // il porte le nom de l'application
    // ajout des paramètres
    Exe.Parameters.Add(Language); // langue en paramètre
    Exe.Parameters.Add(FileDir);  // répertoire
    Exe.Parameters.Add(FileName); // nom de fichier
    Exe.Execute; // on démarre la nouvelle application
  finally
    Exe.Free; // processus libéré
    Application.Terminate; // l'ancienne application est terminée
  end;
end;

procedure TGVTranslate.Translate;
// *** traduction ***
var
  LF: string;
begin
  if Language = C_DefaultLanguage then // l'anglais n'a pas besoin d'être traité
    Exit;
  LF := LanguageFile; // fichier de traduction
  if FileExistsUTF8(LF) then // existe-t-il ?
    SetDefaultLang(Language, FileDir) // on traduit
  else
    Language := C_DefaultLanguage; // langue par défaut si erreur
  // accès au fichier de traduction de la LCL
  LF := '.' + PathDelim + FileDir + PathDelim + 'lclstrconsts' + '.' +
    Language + '.' + C_PoExtension;
  if FileExistsUTF8(LF) then // existe-t-il ?
    Translations.TranslateUnitResourceStrings('LCLStrConsts', LF); // on traduit
end;

end.

