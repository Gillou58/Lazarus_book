
{ |========================================================================|
  |                                                                        |
  |                  Projet : Aller plus loin avec Lazarus                 |
  |                  Description : POO - Programme exemple 02              |
  |                  Unité : main.pas                                      |
  |                  Site : www.developpez.net                             |
  |                  Copyright : © Roland CHASTAIN & Gilles VASSEUR 2015   |
  |                  Date:    03/06/2015 20:09:11                          |
  |                  Version : 1.0.0                                       |
  |                                                                        |
  |========================================================================| }

// HISTORIQUE
// 03/06/2015 20:09:50 - 1.0.0 - première version opérationnelle

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
  ExtCtrls,
  animal; // unité de la nouvelle classe

type

  { TMainForm }

  TMainForm = class(TForm)
    lbAction: TListBox;
    rbNemo: TRadioButton;
    rbRantanplan: TRadioButton;
    rbMinette: TRadioButton;
    rgAnimal: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lbActionClick(Sender: TObject);
    procedure rbMinetteClick(Sender: TObject);
    procedure rbNemoClick(Sender: TObject);
    procedure rbRantanplanClick(Sender: TObject);
  private
    { private declarations }
    Nemo, Minette, UnAnimal : TAnimal;
    Rantanplan: TChien;
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
   // on crée les instances et on donne un nom à l'animal créé
  Nemo := TAnimal.Create;
  Nemo.Nom := 'Némo';
  Rantanplan := TChien.Create;
  Rantanplan.Nom := 'Rantanplan';
  Minette := TAnimal.Create;
  Minette.Nom := 'Minette';

  // objet par défaut
  UnAnimal := Nemo;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
// *** destruction de la fiche ***
begin
  // on libère toutes les ressources
  Minette.Free;
  Rantanplan.Free;
  Nemo.Free;
end;

procedure TMainForm.lbActionClick(Sender: TObject);
// *** choix d'une action ***
begin
  case lbAction.ItemIndex of
    0: UnAnimal.Avancer;
    1: UnAnimal.Manger;
    2: UnAnimal.Boire;
    3: UnAnimal.Dormir;
  end;
end;

procedure TMainForm.rbMinetteClick(Sender: TObject);
// *** l'animal est Minette ***
begin
  UnAnimal := Minette;
end;

procedure TMainForm.rbNemoClick(Sender: TObject);
// *** l'animal est Némo ***
begin
  UnAnimal := Nemo;
end;

procedure TMainForm.rbRantanplanClick(Sender: TObject);
// *** l'animal est Rantanplan ***
begin
  UnAnimal := Rantanplan;
end;

end.

