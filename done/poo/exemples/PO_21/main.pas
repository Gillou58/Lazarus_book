{ |========================================================================|
  |                                                                        |
  |                  Projet : Aller plus loin avec Lazarus                 |
  |                  Description : POO - Programme exemple 21              |
  |                  Unité : main.pas                                      |
  |                  Site : www.developpez.net                             |
  |                  Copyright : © Roland CHASTAIN & Gilles VASSEUR 2015   |
  |                  Date:    22/06/2015 14:01:10                          |
  |                  Version : 1.0.0                                       |
  |                                                                        |
  |========================================================================| }

// HISTORIQUE
// 22/06/2015 14:01:10 - 1.0.0 - première version opérationnelle

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
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls;

type

  { TMyClass }

  TMyClass = class
  strict private
  class var
   fVersion : Integer ;
   fSubVersion: Real;
  class procedure SetVersion(const AValue: Integer); static;
  class procedure SetSubVersion(const AValue: Real); static;
  // […]
  public
  // […]
  class property Version : Integer read fVersion write SetVersion;
  class property SubVersion: Real read fSubVersion write SetSubVersion;
end;

  { TMySubClass }

  TMySubClass = class(TMyClass)
  strict private
    class procedure SetSubVersion(AValue: Real); static;
    class procedure SetVersion(AValue: Integer); static;
  public
    class property Version : Integer read fVersion write SetVersion ;
    class property SubVersion: Real read fSubVersion write SetSubVersion;
  end;

    { TMySubClass2 }

  TMySubClass2 = class(TMyClass)
  strict private
    class procedure SetSubVersion(AValue: Real); static;
    class procedure SetVersion(AValue: Integer); static;
  public
    class property Version : Integer read fVersion write SetVersion ;
    class property SubVersion: Real read fSubVersion write SetSubVersion;
  end;

  { TMainForm }

  TMainForm = class(TForm)
    btnTMyClass: TButton;
    btnTMySubClass: TButton;
    btnTMySubClass2: TButton;
    lbledt1: TLabeledEdit;
    lbledt2: TLabeledEdit;
    lbledt3: TLabeledEdit;
    lbledt4: TLabeledEdit;
    lbledt5: TLabeledEdit;
    lbledt6: TLabeledEdit;
    procedure btnTMyClassClick(Sender: TObject);
    procedure btnTMySubClassClick(Sender: TObject);
    procedure btnTMySubClass2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
    procedure UpdateEditors;
  public
    { public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.lfm}

{ TMySubClass2 }

class procedure TMySubClass2.SetSubVersion(AValue: Real);
// *** numéro de sous-version (autre sous-classe) ***
begin
  fSubVersion := AValue / 100;
end;

class procedure TMySubClass2.SetVersion(AValue: Integer);
// *** numéro de version (autre sous-classe) ***
begin
  fVersion := AValue * 100;
end;

{ TMainForm }

procedure TMainForm.FormCreate(Sender: TObject);
// *** création de la fiche ***
begin
  TMyClass.Version := 1; // initialisation des propriétés
  TMyClass.SubVersion := 11;
  UpdateEditors; // mise à jour
end;

procedure TMainForm.btnTMyClassClick(Sender: TObject);
// *** choix de TMyClass ***
begin
  TMyClass.Version := 1;
  TMyClass.SubVersion := 11;
  UpdateEditors;
end;

procedure TMainForm.btnTMySubClassClick(Sender: TObject);
// *** choix de TMySubClass ***
begin
  TMySubClass.Version := 2;
  TMySubClass.SubVersion := 22;
  UpdateEditors;
end;

procedure TMainForm.btnTMySubClass2Click(Sender: TObject);
// *** choix de TMySubClass2 ***
begin
  TMySubClass2.Version := 3;
  TMySubClass2.SubVersion := 33;
  UpdateEditors;
end;

procedure TMainForm.UpdateEditors;
// *** mise à jour des éditeurs ***
begin
  lbledt1.Caption := IntToStr(TMyClass.Version);
  lbledt2.Caption := FloatToStr(TMyClass.SubVersion);
  lbledt3.Caption := IntToStr(TMySubClass.Version);
  lbledt4.Caption := FloatToStr(TMySubClass.SubVersion);
  lbledt5.Caption := IntToStr(TMySubClass2.Version);
  lbledt6.Caption := FloatToStr(TMySubClass2.SubVersion);
end;

{ TMySubClass }

class procedure TMySubClass.SetSubVersion(AValue: Real);
// *** numéro de version (sous-classe) ***
begin
  fSubVersion := AValue / 10;
end;

class procedure TMySubClass.SetVersion(AValue: Integer);
// *** numéro de sous-version (sous-classe) ***
begin
  fVersion := AValue * 10;
end;

{ TMyClass }

class procedure TMyClass.SetVersion(const AValue: Integer);
// *** numéro de version ***
begin
  fVersion := AValue;
end;

class procedure TMyClass.SetSubVersion(const AValue: Real);
// *** numéro de sous-version ***
begin
  fSubVersion := AValue;
end;

end.

