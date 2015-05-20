{ |========================================================================|
  |                                                                        |
  |                  G V S O F T                                           |
  |                  Projet : Paquet GVORPHEUS                             |
  |                  Description : Compteur visuel à pulsions              |
  |                  Unité : GVPulse.pas                                   |
  |                  Ecrit par  : VASSEUR Gilles                           |
  |                  e-mail : g.vasseur58@laposte.net                      |
  |                  Copyright : © G. VASSEUR 2015                         |
  |                  Date:    02-05-2015 18:00:00                          |
  |                  Version : 1.0.0                                       |
  |                                                                        |
  |========================================================================| }

// HISTORIQUE
// 02/05/2015 - 1.0.0 - première version opérationnelle

// GVPULSE - part of GVORPHEUS.LPK
// Copyright © 2015 Gilles VASSEUR
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

unit gvpulse;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, ExtCtrls;

type
  TGVPulseType = (gvpNone, gvpRectangle, gvpFrame, gvpEllipse);

  { TGVPulse }

  TGVPulse = class(TPaintBox)
  private
    fCountDown: Integer;
    fCountElapsed: Integer;
    fDrawColor: TColor;
    fGrowShape: TGVPulseType;
    fOnPulse: TNotifyEvent;
    fOnStart: TNotifyEvent;
    fOnStop: TNotifyEvent;
    fShrinkShape: TGVPulseType;
    fStarted: Boolean;
    fStep: Integer;
    fx1, fy1, fx2, fy2: Integer;
    fGrow: Boolean; // drapeau d'état
    { Private declarations }
    fTimer: TTimer;
    procedure SetCountDown(AValue: Integer);
    procedure SetDrawColor(AValue: TColor);
    procedure SetStarted(AValue: Boolean);
    procedure SetStep(AValue: Integer);
  protected
    { Protected declarations }
    procedure Pulse(Sender: TObject); // activité de dessin
    procedure ElapsedTime; // temps écoulé
    procedure PulseEvent; // pulsation
    procedure StopEvent; // arrêt
    procedure StartEvent; // démarrage
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Clear; // nettoyage
  published
    { Published declarations }
    // pas du dessin
    property Step: Integer read fStep write SetStep default 2;
    // couleur de dessin
    property DrawColor: TColor read fDrawColor write SetDrawColor default clBlue;
    // animation lancée/arrêtée
    property Started: Boolean read fStarted write SetStarted default False;
    // figure grossissante
    property GrowShape: TGVPulseType read fGrowShape write fGrowShape default gvpRectangle;
    // figure rapetissante
    property ShrinkShape: TGVPulseType read fShrinkShape write fShrinkShape default gvpRectangle;
    // compte à rebours
    property CountDown: Integer read fCountDown write SetCountDown;
    // démarrage
    property OnStart: TNotifyEvent read fOnStart write fOnStart;
    // arrêt
    property OnStop: TNotifyEvent read fOnStop write fOnStop;
    // pulsation
    property OnPulse: TNotifyEvent read fOnPulse write fOnPulse;
  end;

procedure Register;

implementation

procedure Register;
begin
  {$I gvpulse_icon.lrs}
  RegisterComponents('GVSoft',[TGVPulse]);
end;

{ TGVPulse }

procedure TGVPulse.SetStep(AValue: Integer);
// *** définit le pas du dessin ***
begin
  if fStep = AValue then // même valeur ?
    Exit; // on sort
  fStep := AValue; // nouvelle valeur
end;

procedure TGVPulse.Pulse(Sender: TObject);
// *** pulsation ***
begin
  ElapsedTime; // compte à rebours
  if not fGrow then
  begin
    dec(fx1,Step);
    dec(fy1,Step);
    inc(fx2,Step);
    inc(fy2,Step);
    case GrowShape of // choix de la forme à dessiner
     gvpEllipse: Canvas.Ellipse(fx1,fy1,fx2,fy2);
     gvpRectangle: Canvas.Rectangle(fx1,fy1,fx2,fy2);
     gvpFrame: Canvas.Frame(fx1,fy1,fx2,fy2);
    end;
    fGrow := not ((fx1 > 0) and (fy1 > 0) and (fx2 > 0) and (fy2 > 0));
  end
  else
  begin
    case ShrinkShape of // choix de la forme à dessiner
     gvpEllipse: Canvas.Ellipse(fx1,fy1,fx2,fy2);
     gvpRectangle: Canvas.Rectangle(fx1,fy1,fx2,fy2);
     gvpFrame: Canvas.Frame(fx1,fy1,fx2,fy2);
    end;
    inc(fx1,Step);
    inc(fy1,Step);
    dec(fx2,Step);
    dec(fy2,Step);
    fGrow := ((fx1 > 0) and (fy1 > 0) and (fx2 > 0) and (fy2 > 0));
  end;
  PulseEvent; // événement notifié
end;

procedure TGVPulse.ElapsedTime;
// *** temps écoulé ***
begin
  if fCountElapsed > 1 then
  begin
    Dec(fCountElapsed, fTimer.Interval);
    if fCountElapsed < 1 then
    begin
      fCountElapsed := 1;
      Started := False; // animation arrêtée
    end;
  end;
end;

procedure TGVPulse.PulseEvent;
// *** événement pulsation ***
begin
  if Assigned(fOnPulse) then
    fOnPulse(Self);
end;

procedure TGVPulse.StopEvent;
// *** événement arrêt ***
begin
  if Assigned(fOnStop) then
    fOnStop(Self);
end;

procedure TGVPulse.StartEvent;
// *** événement démarrage ***
begin
  if Assigned(fOnStart) then
    fOnStart(Self);
end;

procedure TGVPulse.SetDrawColor(AValue: TColor);
// *** définit la couleur de dessin ***
begin
  if fDrawColor = AValue then // même valeur ?
    Exit; // on sort
  fDrawColor := AValue; // nouvelle valeur
  Canvas.Brush.Color:= AValue; // nouvelle couleur effective
  Canvas.Pen.Color:= AValue;
end;

procedure TGVPulse.SetCountDown(AValue: Integer);
// *** compte à rebours ***
begin
  if fCountDown = AValue then // si même valeur
    Exit; // on sort
  fCountDown := AValue; // nouvelle valeur
  fCountElapsed := AValue;
end;

procedure TGVPulse.SetStarted(AValue: Boolean);
// *** démarre/arrête l'animation ***
begin
  if (fStarted = AValue) then // même valeur ?
    Exit; // on sort
  fStarted := AValue; // nouvelle valeur
  fTimer.Enabled := AValue; // valeur effective
  Clear; // on nettoie
  if AValue then // notification
    StartEvent
  else
    StopEvent;
end;

constructor TGVPulse.Create(AOwner: TComponent);
// *** création du composant ***
begin
  inherited Create(AOwner); // on hérite
  fTimer := TTimer.Create(Self); // timer créé
  fTimer.Enabled := False; // pas de timer en cours
  fTimer.OnTimer := @Pulse; // génération du dessin
  Step := 2; // pas par défaut
  fTimer.Interval := 10 * Step; // ms entre deux étapes
  DrawColor := clBlue; // couleur par défaut
  Canvas.Brush.Style := bsSolid; // brosse recouvrante
  Canvas.Pen.Mode := pmNotXor; // crayon en ou exclusif inversé
  GrowShape := gvpRectangle;
  ShrinkShape := gvpRectangle;
  CountDown := 0; // compte à rebours inhibé
end;

destructor TGVPulse.Destroy;
// *** destruction du composant ***
begin
  fTimer.Free; // libération du timer
  inherited Destroy; // on hérite
end;

procedure TGVPulse.Clear;
// *** nettoyage ***
begin
  fCountElapsed := CountDown; // compte à rebours réinitialisé
  fx1 := Width div 2; // valeurs d'origine
  fy1 := Height div 2;
  fx2 := fx1;
  fy2 := fy1;
  Canvas.Brush.Color:= Color;
  Canvas.Clear;
  Canvas.Brush.Color := DrawColor; // nouvelle couleur effective
  Canvas.Pen.Color := DrawColor;
end;

end.
