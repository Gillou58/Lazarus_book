{ |========================================================================|
  |                                                                        |
  |                  Projet : Aller plus loin avec Lazarus                 |
  |                  Description : POO - Programme exemple 13              |
  |                  Unité : main.pas                                      |
  |                  Site : www.developpez.net                             |
  |                  Copyright : © Roland CHASTAIN & Gilles VASSEUR 2015   |
  |                  Date:    09/06/2015 12:49:10                          |
  |                  Version : 1.0.0                                       |
  |                                                                        |
  |========================================================================| }

// HISTORIQUE
// 09/06/2015 12:49:10 - 1.0.0 - première version opérationnelle

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

  { TAddition }

  TAddition = class
    function AddEnChiffres(Nombre1, Nombre2: Integer): string;
    function AddVirtEnChiffres(Nombre1, Nombre2: Integer): string; virtual;
  end;

  { TAdditionPlus }

  TAdditionPlus = class(TAddition)
    function AddEnChiffres(const St1, St2: string): string; overload;
    function AddVirtEnChiffres(St1, St2: string): string; reintroduce; overload;
  end;

  { TMainForm }

  TMainForm = class(TForm)
    btnComputeSt: TButton;
    btnComputeInt: TButton;
    btnComputeStV: TButton;
    btnComputeIntV: TButton;
    edtNum1: TEdit;
    edtNum2: TEdit;
    lblResult: TLabel;
    procedure btnComputeIntClick(Sender: TObject);
    procedure btnComputeIntVClick(Sender: TObject);
    procedure btnComputeStClick(Sender: TObject);
    procedure btnComputeStVClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { private declarations }
    Ad: TAdditionPlus;
  public
    { public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.lfm}

{ TMainForm }

procedure TMainForm.FormCreate(Sender: TObject);
// *** création de la fiche principale ***
begin
  Ad := TAdditionPlus.Create; // additionneur créé
end;

procedure TMainForm.btnComputeStClick(Sender: TObject);
// *** addition simple de chaînes ***
begin
  lblResult.Caption := Ad.AddEnChiffres(edtNum1.Text, edtNum2.Text);
end;

procedure TMainForm.btnComputeStVClick(Sender: TObject);
// *** addition de chaînes par méthode virtuelle ***
begin
  lblResult.Caption := Ad.AddVirtEnChiffres(edtNum1.Text, edtNum2.Text);
end;

procedure TMainForm.btnComputeIntClick(Sender: TObject);
// *** addition simple d'entiers ***
begin
  lblResult.Caption := Ad.AddEnChiffres(StrToInt(edtNum1.Text),
    StrToInt(edtNum2.Text));
end;

procedure TMainForm.btnComputeIntVClick(Sender: TObject);
// *** addition d'entiers par méthode virtuelle ***
begin
  lblResult.Caption := Ad.AddVirtEnChiffres(StrToInt(edtNum1.Text),
    StrToInt(edtNum2.Text));
end;

procedure TMainForm.FormDestroy(Sender: TObject);
// *** destruction de la fiche principale ***
begin
  Ad.Free; // additionneur libéré
end;

{ TAddition }

function TAddition.AddEnChiffres(Nombre1, Nombre2: Integer): string;
// *** addition avec méthode statique ***
begin
  Result := IntToStr(Nombre1 + Nombre2);
  MessageDlg('Entiers...', 'Addition d''entiers effectuée', mtInformation,
    [mbOK], 0);
end;

function TAddition.AddVirtEnChiffres(Nombre1, Nombre2: Integer): string;
// *** addition avec méthode virtuelle ***
begin
  Result := IntToStr(Nombre1 + Nombre2);
  MessageDlg('Entiers (méthode virtuelle)...', 'Addition d''entiers effectuée',
    mtInformation, [mbOK], 0);
end;

{ TAdditionPlus }

function TAdditionPlus.AddEnChiffres(const St1, St2: string): string;
// *** méthode statique surchargée ***
begin
  Result := IntToStr(StrToInt(St1) + StrToInt(St2));
  MessageDlg('Chaînes...', 'Addition à partir de chaînes effectuée',
    mtInformation, [mbOK], 0);
end;

function TAdditionPlus.AddVirtEnChiffres(St1, St2: string): string;
// *** méthode virtuelle surchargée ***
begin
  Result := inherited AddVirtEnChiffres(StrToInt(St1), StrToInt(St2));
  MessageDlg('Chaînes... (méthode virtuelle)',
    'Addition à partir de chaînes effectuée', mtInformation,[mbOK], 0);
end;

end.

