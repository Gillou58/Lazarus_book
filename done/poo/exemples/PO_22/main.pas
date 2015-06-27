{ |========================================================================|
  |                                                                        |
  |                  Projet : Aller plus loin avec Lazarus                 |
  |                  Description : POO - Programme exemple 22              |
  |                  Unité : main.pas                                      |
  |                  Site : www.developpez.net                             |
  |                  Copyright : © Roland CHASTAIN & Gilles VASSEUR 2015   |
  |                  Date:    23/06/2015 13:05:10                          |
  |                  Version : 1.0.0                                       |
  |                                                                        |
  |========================================================================| }

// HISTORIQUE
// 23/06/2015 13:05:10 - 1.0.0 - première version opérationnelle

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
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  StdCtrls, ExtCtrls, subMemos;  // unité des étiquettes

type

  { TMainForm }

  TMainForm = class(TForm)
    btnNew: TButton;
    lwMemos: TListView;
    pnlMain: TPanel;
    procedure btnNewClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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

procedure TMainForm.FormCreate(Sender: TObject);
// *** création de la fiche ***
var
  LPtr: Pointer;
  LNewItem: TListItem;
begin
  // remplissage de la liste
  lwMemos.Items.BeginUpdate; // évite les scintillements
  try
    // on parcourt la liste des mémos enregistrés
    for LPtr in TSubMemo.Memos do
    begin
      LNewItem := lwMemos.Items.Add; // position de l'ajout
      // légende récupérée
      LNewItem.Caption := (TSubMemoClass(LPtr)).ClassText;
      // idem pour la version
      LNewItem.SubItems.Add(IntToStr(TSubMemoClass(LPtr).Version));
      // enregistrement de la classe
      LNewItem.Data := LPtr;
    end;
  finally
    lwMemos.Items.EndUpdate; // affichage
  end;
end;

procedure TMainForm.btnNewClick(Sender: TObject);
// *** nouveau mémo ***
var
  LNewMemo: TMemo;
begin
  if lwMemos.SelCount <> 0 then // des mémos enregistrés ?
  begin
    // on crée le mémo à partir de l'élément choisi dans la liste
    LNewMemo := TSubMemoClass(lwMemos.Selected.Data).Create(pnlMain);
    // position aléatoire
    LNewMemo.Left := random(400);
    LNewMemo.Top := random(300);
    // nom affiché
    LNewMemo.Caption := LNewMemo.ToString;
    // couleur de fond dépendant de la classe
    LNewMemo.Color := TSubMemoClass(lwMemos.Selected.Data).ClassColor;
    // le parent est le panneau pour l'affichage
    LNewMemo.Parent := pnlMain;
  end;
end;


end.

