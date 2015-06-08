{ |========================================================================|
  |                                                                        |
  |                  Projet : Aller plus loin avec Lazarus                 |
  |                  Description : POO - Programme exemple 09              |
  |                  Unité : main.pas                                      |
  |                  Site : www.developpez.net                             |
  |                  Copyright : © Roland CHASTAIN & Gilles VASSEUR 2015   |
  |                  Date:    06/06/2015 14:56:25                          |
  |                  Version : 1.0.0                                       |
  |                                                                        |
  |========================================================================| }

// HISTORIQUE
// 06/06/2015 14:56:35 - 1.0.0 - première version opérationnelle

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
  Buttons;

type

  { TMainForm }

  TMainForm = class(TForm)
    btnForm: TButton;
    btnClear: TButton;
    btnMemo: TButton;
    btnButton: TButton;
    btnFontDialog: TButton;
    btnChien: TButton;
    mmoDisplay: TMemo;
    procedure btnButtonClick(Sender: TObject);
    procedure btnChienClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure btnFontDialogClick(Sender: TObject);
    procedure btnFormClick(Sender: TObject);
    procedure btnMemoClick(Sender: TObject);
  private
    { private declarations }
    procedure Display(AClass: TClass);
  public
    { public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.lfm}

uses
  animal;

{ TMainForm }

procedure TMainForm.btnFormClick(Sender: TObject);
// *** généalogie de TForm ***
begin
  Display(TForm);
end;

procedure TMainForm.btnMemoClick(Sender: TObject);
// *** généalogie de TMemo ***
begin
  Display(TMemo);
end;

procedure TMainForm.btnClearClick(Sender: TObject);
// *** effacement du mémo ***
begin
  mmoDisplay.Lines.Clear;
end;

procedure TMainForm.btnFontDialogClick(Sender: TObject);
// *** généalogie de TFontDialog ***
begin
  Display(TFontDialog);
end;

procedure TMainForm.btnButtonClick(Sender: TObject);
// *** généalogie de TButton ***
begin
  Display(TButton);
end;

procedure TMainForm.btnChienClick(Sender: TObject);
// *** généalogie de TChien ***
begin
  Display(TChien);
end;

procedure TMainForm.Display(AClass: TClass);
// *** reconstitution de la généalogie ***
begin
  repeat
    mmoDisplay.Lines.Add(AClass.ClassName); // classe en cours
    AClass := AClass.ClassParent; // on change de classe pour la classe parent
  until AClass = nil; // on boucle tant que la classe existe
  mmoDisplay.Lines.Add(''); // ligne vide pour séparation
end;

end.

