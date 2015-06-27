{ |========================================================================|
  |                                                                        |
  |                  Projet : Aller plus loin avec Lazarus                 |
  |                  Description : POO - Programme exemple 22              |
  |                  Unité : submemos.pas                                  |
  |                  Site : www.developpez.net                             |
  |                  Copyright : © Roland CHASTAIN & Gilles VASSEUR 2015   |
  |                  Date:    23/06/2015 13:05:10                          |
  |                  Version : 1.0.0                                       |
  |                                                                        |
  |========================================================================| }

// HISTORIQUE
// 23/06/2015 13:05:10 - 1.0.0 - première version opérationnelle

// SUBMEMOS - part of "Aller plus loin avec Lazarus"
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

unit submemos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, StdCtrls, Graphics;

type

  { TSubmemo }

  TSubMemo = class(TMemo)
  strict private
    class var
      fmemos: TList;
  protected
    class procedure NewMemo;
  public
    class constructor Create;
    class destructor Destroy;
    class property Memos: TList read fMemos;
    class function ClassText: string; virtual;
    class function Version: Integer; virtual;
    class function ClassColor: TColor; virtual;
  end;

  TSubMemoClass = class of TSubMemo;

  { TSubMemoOne }

  TSubMemoOne = class(TSubMemo)
  public
    class function ClassText: string; override;
    class function Version: Integer; override;
    class function ClassColor: TColor; override;
  end;

  { TSubMemoTwo }

  TSubMemoTwo = class(TSubMemo)
  public
    class function ClassText: string; override;
    class function Version: Integer; override;
    class function ClassColor: TColor; override;
  end;

  { TSubMemoThree }

  TSubMemoThree = class(TSubMemo)
  public
    class function ClassText: string; override;
    class function Version: Integer; override;
  end;

implementation

{ TSubMemoThree }

class function TSubMemoThree.ClassText: string;
// *** légende 3 ***
begin
  Result := inherited ClassText + ' + 3 !';
end;

class function TSubMemoThree.Version: Integer;
// *** version 3 ***
begin
  Result := inherited Version + 30;
end;

{ TSubMemoTwo }

class function TSubMemoTwo.ClassText: string;
// *** légende 2 ***
begin
  Result := 'Mémo DEUX';
end;

class function TSubMemoTwo.Version: Integer;
// *** version 2 ***
begin
  Result := 2;
end;

class function TSubMemoTwo.ClassColor: TColor;
// *** couleur 2 ***
begin
  Result := clGreen;
end;

{ TSubMemoOne }

class function TSubMemoOne.ClassText: string;
// *** légende 1 ***
begin
  Result := 'Mémo UN';
end;

class function TSubMemoOne.Version: Integer;
// *** version 1 ***
begin
  Result := 1;
end;

class function TSubMemoOne.ClassColor: TColor;
// *** couleur 1 ***
begin
  Result := clBlue;
end;

{ TSubMemo }

class procedure TSubMemo.NewMemo;
// *** nouveau mémo ***
begin
  // mémo non enregistré ?
  if (fMemos.IndexOf(Self) = -1) then
    // on l'ajoute
    fMemos.Add(Self);
end;

class constructor TSubMemo.Create;
// *** création ***
begin
  // on crée la liste de travail
  fMemos := TList.Create;
end;

class destructor TSubMemo.Destroy;
// *** destruction ***
begin
  // la liste de travail est libérée
  fMemos.Free;
end;

class function TSubMemo.ClassText: string;
// *** légende 0 ***
begin
  Result := 'Mémo ANCETRE';
end;

class function TSubMemo.Version: Integer;
// *** version 0 ***
begin
  Result := 0;
end;

class function TSubMemo.ClassColor: TColor;
// *** couleur 0 ***
begin
  Result := clRed;
end;

initialization
  // enregistrement des classes
  TSubMemoOne.NewMemo;
  TSubMemoTwo.NewMemo;
  TSubMemoThree.NewMemo;
end.

