{ |========================================================================|
  |                                                                        |
  |                  Projet : Aller plus loin avec Lazarus                 |
  |                  Description : POO - Programme exemple 12              |
  |                  Unité : main.pas                                      |
  |                  Site : www.developpez.net                             |
  |                  Copyright : © Roland CHASTAIN & Gilles VASSEUR 2015   |
  |                  Date:    09/06/2015 14:56:25                          |
  |                  Version : 1.0.0                                       |
  |                                                                        |
  |========================================================================| }

// HISTORIQUE
// 09/06/2015 14:56:35 - 1.0.0 - première version opérationnelle

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
  LMessages;

const
  M_CHANGEDMESSAGE = LM_User + 1; // message de changement
  M_LOSTMESSAGE = LM_User + 2; // message perdu

type

  { TMainForm }

  TMainForm = class(TForm)
    btnLost: TButton;
    edtDummy: TEdit;
    mmoDisplay: TMemo;
    procedure btnLostClick(Sender: TObject);
    procedure edtDummyChange(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
    procedure Changed(var Msg: TLMessage); message M_CHANGEDMESSAGE;
    procedure DefaultHandler(var AMessage); override;
  end;


var
  MainForm: TMainForm;

implementation

{$R *.lfm}

{ TMainForm }

procedure TMainForm.edtDummyChange(Sender: TObject);
// *** l'éditeur signale un changement ***
var
  Msg: TLMessage;
begin
  Msg.msg := M_CHANGEDMESSAGE; // assignation du message
  Dispatch(Msg); // répartition
  //Perform(M_CHANGEDMESSAGE, 0, 0); // envoi du message sans queue d'attente
end;

procedure TMainForm.btnLostClick(Sender: TObject);
// *** le bouton envoie un message perdu ***
var
  Msg: TLMessage;
begin
  Msg.msg := M_LOSTMESSAGE; // assignation du message
  Dispatch(Msg); // répartition
  //Perform(M_LOSTMESSAGE, 0, 0); // envoi du message sans queue d'attente
end;

procedure TMainForm.Changed(var Msg: TLMessage);
// *** changement récupéré avec numéro du message ***
begin
  mmoDisplay.Lines.Add('Changement ! Message : ' + IntToStr(Msg.msg));
end;

procedure TMainForm.DefaultHandler(var AMessage);
// *** message perdu ? ***
begin
  // transtypage de la variable sans type en TLMessage
  if (TLMessage(AMessage).msg = M_LOSTMESSAGE) then // message perdu ?
    mmoDisplay.Lines.Add('Non Traité ! Message : ' + IntToStr(TLMessage(AMessage).msg));
  inherited DefaultHandler(AMessage); // on hérite
end;

end.

