{ |========================================================================|
  |                                                                        |
  |                  Projet : Aller plus loin avec Lazarus                 |
  |                  Description : Traduction - Programme exemple 08       |
  |                  Unité : main.pas                                      |
  |                  Site : www.developpez.net                             |
  |                  Copyright : © Roland CHASTAIN & Gilles VASSEUR 2015   |
  |                  Date:    28/05/2015 20:09:11                          |
  |                  Version : 1.0.0                                       |
  |                                                                        |
  |========================================================================| }

// HISTORIQUE
// 28/05/2015 20:09:50 - 1.0.0 - première version opérationnelle

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


{$mode objfpc}{$H+}

unit main;

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls,
  GVTranslate; // unité de la gestion des traductions

type

  { TMainForm }

  TMainForm = class(TForm)
    btnRestart: TButton;
    lblLanguage: TLabel;
    lblDirectory: TLabel;
    lblFile: TLabel;
    lblAccess: TLabel;
    lbLanguages: TListBox;
    pnlData: TPanel;
    procedure btnRestartClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lbLanguagesClick(Sender: TObject);
  private
    Process: TGVTranslate; // traducteur
  end;

var
  MainForm: TMainForm;

implementation

{$R *.lfm}

resourcestring
  R_Language = 'Language: ';
  R_Directory = 'Directory: ';
  R_File = 'File: ';
  R_Access = 'Access: ';

{ TMainForm }

procedure TMainForm.btnRestartClick(Sender: TObject);
// *** bouton pour redémarrer le programme ***
begin
  // choix enregistré
  Process.Language := lbLanguages.Items[lbLanguages.ItemIndex];
  // on redémarre
  Process.Restart;
end;

procedure TMainForm.FormCreate(Sender: TObject);
// *** création de la fiche ***
begin
  Process := TGVTranslate.Create; // nouveau traducteur créé
  // mise à jour des légendes des étiquettes
  lblLanguage.Caption := R_Language + Process.Language;
  lblDirectory.Caption := R_Directory + Process.FileDir;
  lblFile.Caption := R_File + Process.FileName;
  lblAccess.Caption := R_Access + Process.LanguageFile;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
// *** destruction de la fiche ***
begin
  Process.Free; // traducteur libéré
end;

procedure TMainForm.lbLanguagesClick(Sender: TObject);
// *** clic sur la liste de choix ***
begin
  // on active le bouton si un choix a été fait
  btnRestart.Enabled := (lbLanguages.ItemIndex <> - 1);
end;


end.

