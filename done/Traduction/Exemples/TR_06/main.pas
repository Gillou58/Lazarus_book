{ |========================================================================|
  |                                                                        |
  |                  Projet : Aller plus loin avec Lazarus                 |
  |                  Description : Traduction - Programme exemple 06       |
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

unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ColorBox,
  StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    ColorListBox1: TColorListBox;
    procedure Button1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

resourcestring
 // chaînes de ressources pour leur future traduction
  RS_Pretty = 'Joli !';
  RS_NotPretty = 'Pas joli !';

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
  if cbPrettyNames in ColorListBox1.Style then
  begin
   // propriété exclue
    ColorListBox1.Style := ColorListBox1.Style - [cbPrettyNames];
    Button1.Caption := RS_Pretty;
  end
  else
  begin
    // propriété incluse
    ColorListBox1.Style := ColorListBox1.Style + [cbPrettyNames];
    Button1.Caption := RS_NotPretty;
  end;
end;


end.

