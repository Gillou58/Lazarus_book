{ |========================================================================|
  |                                                                        |
  |                  Projet : Aller plus loin avec Lazarus                 |
  |                  Description : POO - Programme exemple 14              |
  |                  Unité : check.pas                                     |
  |                  Site : www.developpez.net                             |
  |                  Copyright : © Roland CHASTAIN & Gilles VASSEUR 2015   |
  |                  Date:    18/06/2015 08:38:10                          |
  |                  Version : 1.0.0                                       |
  |                                                                        |
  |========================================================================| }

// HISTORIQUE
// 18/06/2015 08:38:10 - 1.0.0 - première version opérationnelle

// CHECK - part of "Aller plus loin avec Lazarus"
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

unit check;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type

  { TValue2St }

  TValue2St = class
  strict private
    fValue: Integer;
    fStValue: string;
    fWithDash: Boolean;
    fDash: Char;
    procedure SetWithDash(AValue: Boolean);
  protected
    procedure SetValue(const AValue: Integer);
    function Digit2St(const AValue: Integer): string; virtual;
    function Decade2St(const AValue: Integer; Plural: Boolean = True): string; virtual;
    function Hundred2St(const AValue: Integer; Plural: Boolean = True): string; virtual;
    function Thousand2St(const AValue: Integer): string; virtual;
    function Million2St(const AValue: Integer): string; virtual;
  public
    constructor Create;
    property WithDash: Boolean read fWithDash write SetWithDash;
    property Value: Integer read fValue write SetValue;
    property StValue: string read fStValue;
  end;

implementation

const
  CDigit : array[0..9] of string =('zéro','un','deux','trois','quatre',
                                       'cinq','six','sept','huit','neuf');
  CNum1: array[10..19] of string = ('dix','onze','douze','treize','quatorze',
                           'quinze','seize','dix-sept','dix-huit','dix-neuf');
  CNum2: array[1..7] of string = ('vingt','trente','quarante','cinquante',
                           'soixante','soixante-dix','quatre-vingt');
  CHundred = 'cent';
  CThousand = 'mille';
  CMillion = 'million';

{ TValue2St }

procedure TValue2St.SetWithDash(AValue: Boolean);
// *** tiret obligatoire ou non ***
begin
  if fWithDash = AValue then
    Exit;
  fWithDash := AValue;
  if fWithDash then
    fDash := '-'
  else
    fDash := ' ';
  Value := Value; // force la mise à jour du texte associé au nombre
end;

procedure TValue2St.SetValue(const AValue: Integer);
// *** nouvelle valeur ***
begin
  fValue := AValue;
  fStValue := Million2St(fValue);
end;

function TValue2St.Digit2St(const AValue: Integer): string;
// *** chiffres en lettres ***
begin
  Result := CDigit[AValue];
end;

function TValue2St.Decade2St(const AValue: Integer; Plural: Boolean = True): string;
// *** dizaines en lettres ***
begin
  case AValue of
    0..9: Result := Digit2St(AValue);
    10..19: Result := CNum1[AValue];
    20, 30, 40, 50, 60, 70: Result := CNum2[(AValue div 10) - 1];
    21, 31, 41, 51, 61: Result := CNum2[(AValue div 10) - 1] + '-et-un';
    22..29: Result := CNum2[1] + '-' + Digit2St(AValue - 20);
    32..39: Result := CNum2[2] + '-' + Digit2St(AValue - 30);
    42..49: Result := CNum2[3] + '-' + Digit2St(AValue - 40);
    52..59: Result := CNum2[4] + '-' + Digit2St(AValue - 50);
    62..69: Result := CNum2[5] + '-' + Digit2St(AValue - 60);
    71: Result := 'soixante-et-onze';
    72..79: Result := CNum2[5] + '-' + CNum1[AValue - 60];
    80: if Plural then // cas de 80 avec ou sans s
          Result := CNum2[7] + 's'
        else
          Result := CNum2[7];
    81..89: Result := CNum2[7] + '-' + Digit2St(AValue - 80);
    90..99: Result := CNum2[7] + '-' + CNum1[AValue - 80];
  end;
end;

function TValue2St.Hundred2St(const AValue: Integer; Plural: Boolean = True): string;
// *** centaines en lettres ***
begin
  if (AValue < 100) then
    Result := Decade2St(AValue, Plural)
  else
  if (AValue = 100) then
    Result := CHundred
  else
  if (AValue < 200) then
    Result := CHundred + fDash + Decade2St(AValue - 100, Plural)
  else
  if ((AValue mod 100) = 0 ) then
    Result := Decade2St(AValue div 100, False) + fDash + CHundred
  else
    Result := Decade2St(AValue div 100, False) + fDash + CHundred + fDash +
      Decade2St(AValue - 100 * (AValue  div 100));
  if Plural and ((AValue mod 100) = 0) and (AValue <> 100) and (AValue <> 0) then
    Result := Result + 's'; // cas de 100 multiplié
end;

function TValue2St.Thousand2St(const AValue: Integer): string;
// *** milliers en lettres ***
begin
  if AValue < 1000 then
    Result := Hundred2St(AValue)
  else
  if AValue = 1000 then
    Result := CThousand + fDash
  else
  if AValue < 2000 then
    Result := CThousand + fDash + Hundred2St(AValue - 1000)
  else
  if (AValue mod 1000) = 0 then
    Result := Hundred2St(AValue div 1000, False) + fDash + CThousand + fDash
  else
    Result := Hundred2St(AValue div 1000, False) + fDash + CThousand + fDash
      + Hundred2St(AValue - 1000 * (AValue div 1000));
end;

function TValue2St.Million2St(const AValue: Integer): string;
// *** millions en lettres ***
begin
  if AValue= 1000000 then
    Result := CDigit[1] + fDash + CMillion
  else
  if AValue < 1000000 then
    Result := Thousand2St(AValue)
  else
  if AValue < 2000000 then
    Result := CDigit[1] + fDash + CMillion + fDash + Thousand2St(AValue - 1000000)
  else
  if(AValue mod 1000000) = 0 then
    Result := Thousand2St(AValue div 1000000)+ fDash + CMillion + 's'
  else
    Result := Thousand2St(AValue div 1000000)+ fDash + CMillion + 's' + fDash +
      Thousand2St(AValue - 1000000 * (AValue div 1000000));
end;

constructor TValue2St.Create;
// *** création de l'objet ***
begin
  inherited Create; // on hérite
  fDash := ' ';
end;






end.

