{ |========================================================================|
  |                                                                        |
  |                  Projet : Aller plus loin avec Lazarus                 |
  |                  Description : POO - Programme exemple 08              |
  |                  Unité : animal.pas                                    |
  |                  Site : www.developpez.net                             |
  |                  Copyright : © Roland CHASTAIN & Gilles VASSEUR 2015   |
  |                  Date:    06/06/2015 14:56:25                          |
  |                  Version : 1.0.0                                       |
  |                                                                        |
  |========================================================================| }

// HISTORIQUE
// 06/06/2015 14:56:35 - 1.0.0 - première version opérationnelle

// ANIMAL - part of "Aller plus loin avec Lazarus"
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

unit animal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type

  { TAnimal }

  TAnimal = class
  private
    fNom: string;
    fASoif: Boolean ;
    fAFaim: Boolean ;
    procedure SetNom(AValue: string);
  public
    procedure Avancer;
    procedure Manger; virtual;
    procedure Boire;
    procedure Dormir;
    class function Copyright: string;
  published
    property ASoif: Boolean read fASoif write fASoif;
    property AFaim: Boolean read fAFaim write fAFaim;
    property Nom: string read fNom write SetNom;
  end ;

  { TChien }

  TChien = class(TAnimal)
  strict private
    fBatard : Boolean ;
    procedure SetBatard(AValue: Boolean);
  public
    procedure Manger; override;
    procedure Aboyer;
    procedure RemuerDeLaQueue;
    property Batard: Boolean read fBatard write SetBatard;
  end;


implementation

uses
  Dialogs; // pour les boîtes de dialogue

{ TChien }

procedure TChien.SetBatard(AValue: Boolean);
begin
  fBatard := AValue;
end;

procedure TChien.Manger;
begin
  inherited Manger; // on hérite de la méthode du parent
  MessageDlg('... mais principalement de la viande...', mtInformation, [mbOK], 0);
end;

procedure TChien.Aboyer;
begin
  MessageDlg(Nom + ' aboie...', mtInformation, [mbOK], 0);
end;

procedure TChien.RemuerDeLaQueue;
begin
  inherited Manger; // <= Manger vient de TAnimal !
  MessageDlg('C''est pourquoi il remue de la queue...', mtInformation, [mbOK], 0);
end;

{ TAnimal }

procedure TAnimal.SetNom(AValue: string);
begin
  if fNom=AValue then Exit;
  fNom:=AValue;
end;

class function TAnimal.Copyright: string;
begin
  Result := 'Roland Chastain - Gilles Vasseur 2015';
end;

procedure TAnimal.Avancer;
begin
  MessageDlg(Nom + ' avance...', mtInformation, [mbOK], 0);
end;

procedure TAnimal.Manger;
begin
  MessageDlg(Nom + ' mange...', mtInformation, [mbOK], 0);
end;

procedure TAnimal.Boire;
begin
  MessageDlg(Nom + ' boit...', mtInformation, [mbOK], 0);
end;

procedure TAnimal.Dormir;
begin
  MessageDlg(Nom + ' dort...', mtInformation, [mbOK], 0);
end;

end.
