{ |========================================================================|
  |                                                                        |
  |                  Projet : Aller plus loin avec Lazarus                 |
  |                  Description : POO - Programme exemple 11              |
  |                  Unité : main.pas                                      |
  |                  Site : www.developpez.net                             |
  |                  Copyright : © Roland CHASTAIN & Gilles VASSEUR 2015   |
  |                  Date:    08/06/2015 14:56:25                          |
  |                  Version : 1.0.0                                       |
  |                                                                        |
  |========================================================================| }

// HISTORIQUE
// 08/06/2015 14:56:35 - 1.0.0 - première version opérationnelle

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
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TMyClass }

  TMyClass = class
  private
    class var fClass: TMyClass;
    class constructor Create;
    class destructor Destroy;
  public
    function MyFunct: string;
    class property Access: TMyClass read fClass;
  end;

  { TMainForm }

  TMainForm = class(TForm)
    btnGO: TButton;
    procedure btnGOClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.lfm}

{ TMyClass }

class constructor TMyClass.Create;
// *** constructeur de classe ***
begin
  fClass := TMyClass.Create; // on crée la classe
  MessageDlg('Class constructor', mtInformation, [mbOK], 0);
end;

class destructor TMyClass.Destroy;
// *** destructeur de classe ***
begin
  fClass.Free; // on libère la classe
  MessageDlg('Class destructor', mtInformation, [mbOK], 0);
end;

function TMyClass.MyFunct: string;
// *** fonction de test ***
begin
  Result := 'C''est fait !';
end;

{ TMainForm }

procedure TMainForm.btnGOClick(Sender: TObject);
// *** appel direct de la classe ***
begin
  btnGO.Caption := TMyClass.Access.MyFunct;
end;

initialization
  MessageDlg('Initialization : ' + TMyClass.Access.MyFunct, mtInformation, [mbOK], 0);
finalization
  MessageDlg('Finalization', mtInformation, [mbOK], 0);
end.

