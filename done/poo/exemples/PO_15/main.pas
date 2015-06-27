{ |========================================================================|
  |                                                                        |
  |                  Projet : Aller plus loin avec Lazarus                 |
  |                  Description : POO - Programme exemple 15              |
  |                  Unité : main.pas                                      |
  |                  Site : www.developpez.net                             |
  |                  Copyright : © Roland CHASTAIN & Gilles VASSEUR 2015   |
  |                  Date:    21/06/2015 21:15:10                          |
  |                  Version : 1.0.0                                       |
  |                                                                        |
  |========================================================================| }

// HISTORIQUE
// 21/06/2015 21:15:10 - 1.0.0 - première version opérationnelle

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
  check;

type

  { TMainForm }

  TMainForm = class(TForm)
    cbDash: TCheckBox;
    edtNum: TEdit;
    lblStr: TLabel;
    procedure cbDashChange(Sender: TObject);
    procedure edtNumChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { private declarations }
    Value: TValue2StBelg; // modification
  public
    { public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.lfm}

{ TMainForm }

procedure TMainForm.edtNumChange(Sender: TObject);
// *** l'éditeur change ***
var
  Li: Integer;
begin
  if edtNum.Text = '' then // chaîne vide ?
    Exit;
  if TryStrToInt(edtNum.Text, Li) then // nombre entier correct ?
  begin
    Value.Value := Li;
    lblStr.Caption:= Value.StValue;
  end
  else
    ShowMessage('"'+ edtNum.Text + '" n''est pas un nombre entier correct !');
end;

procedure TMainForm.cbDashChange(Sender: TObject);
// *** avec ou sans tirets ***
begin
  Value.WithDash := cbDash.Checked;
  lblStr.Caption:= Value.StValue;
end;

procedure TMainForm.FormCreate(Sender: TObject);
// *** création de la fiche ***
begin
  Value := TValue2StBelg.Create; // modification
end;

procedure TMainForm.FormDestroy(Sender: TObject);
// *** destruction de la fiche ***
begin
  Value.Free;
end;

end.

