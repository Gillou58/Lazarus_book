{ |========================================================================|
  |                                                                        |
  |                  G V S O F T                                           |
  |                  Projet : Paquet GVORPHEUS                             |
  |                  Description : objets visuels à pulsions               |
  |                  Unité : GVPulsar.pas                                  |
  |                  Ecrit par  : VASSEUR Gilles                           |
  |                  e-mail : g.vasseur58@laposte.net                      |
  |                  Copyright : © G. VASSEUR 2015                         |
  |                  Date:    04-05-2015 18:00:00                          |
  |                  Version : 1.0.0                                       |
  |                                                                        |
  |========================================================================| }

// HISTORIQUE
// 03/05/2015 - 1.0.0 - première version opérationnelle

// GVPULSAR - part of GVORPHEUS.LPK
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

unit gvpulsar;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ExtCtrls, Graphics, LResources, Types;

type
  // types de dessins
  TGVPulsarType = (gvpNone, gvpRectangle, gvpFrame, gvpEllipse);

  { TGVCustomPulsar }

  TGVCustomPulsar = class(TPanel)
  strict private
    fCountDown: Integer; // compte à rebours (0 = infini)
    fCountElapsed: Integer; // décompte en cours
    fOnPulse: TNotifyEvent; // notification d'une pulsation
    fOnStart: TNotifyEvent; // notification du démarrage
    fOnStop: TNotifyEvent; // notification d'arrêt
    fStarted: Boolean; // arrêt/marche
    procedure SetCountDown(AValue: Integer);
    procedure SetStarted(AValue: Boolean); // arrêt/marche
  private
    fOnReverseGrowth: TNotifyEvent;
    fPenWidth: Integer;
    fTimer: TTimer; // timer pour les pulsations
    function GetInterval: Cardinal;
    procedure SetInterval(AValue: Cardinal);
    procedure SetOnReverseGrowth(AValue: TNotifyEvent);
    procedure SetPenWidth(AValue: Integer);
  protected
    procedure Pulse(Sender: TObject); virtual; // dessin de la pulsation
    procedure ElapsedTime; virtual; // temps écoulé
    procedure PulseEvent; virtual; // pulsation
    procedure StopEvent; virtual; // arrêt
    procedure StartEvent; virtual; // démarrage
    procedure GrowthEvent; virtual; // grossissement
    // taille par défaut
    class function GetControlClassDefaultSize: TSize; override;
  public
    constructor Create(AOwner: TComponent); override; // constructeur
    destructor Destroy; override; // destructeur
    procedure Clear; virtual; // nettoyage
    // animation lancée/arrêtée
    property Started: Boolean read fStarted write SetStarted default False;
    // compte à rebours
    property CountDown: Integer read fCountDown write SetCountDown;
    // intervalle entre deux pulsations
    property Interval: Cardinal read GetInterval write SetInterval default 5;
    // taille du crayon
    property PenWidth: Integer read fPenWidth write SetPenWidth default 1;
    // démarrage
    property OnStart: TNotifyEvent read fOnStart write fOnStart;
    // arrêt
    property OnStop: TNotifyEvent read fOnStop write fOnStop;
    // pulsation
    property OnPulse: TNotifyEvent read fOnPulse write fOnPulse;
    // changement : grossissement/amoindrissement
    property OnReverseGrowth: TNotifyEvent read fOnReverseGrowth write SetOnReverseGrowth;
  end;

  { TGVPulse }

  TGVPulse = class(TGVCustomPulsar)
  strict private
    fDrawColor: TColor; // couleur de dessin
    fGrowShape: TGVPulsarType; // type de forme grossissante
    fShrinkShape: TGVPulsarType; // type de forme rapetissante
    fStep: Integer; // pas entre deux formes
    fx1, fy1, fx2, fy2: Integer; // coordonnées de la forme
    fGrow: Boolean; // drapeau d'état grossissant/rapetissant
    procedure SetDrawColor(AValue: TColor);
    procedure SetGrow(AValue: Boolean);
    procedure SetStep(AValue: Integer);
  protected
    procedure Pulse(Sender: TObject); override; // dessin de la pulsation
    // drapeau de grossissement
    property Grow: Boolean read fGrow write SetGrow;
  public
    constructor Create(AOwner: TComponent); override; // construction
    procedure Clear; override; // nettoyage
  published
    // pas du dessin
    property Step: Integer read fStep write SetStep default 2;
    // couleur de dessin
    property DrawColor: TColor read fDrawColor write SetDrawColor default clBlue;
    // figure grossissante
    property GrowShape: TGVPulsarType read fGrowShape write fGrowShape default gvpRectangle;
    // figure rapetissante
    property ShrinkShape: TGVPulsarType read fShrinkShape write fShrinkShape default gvpRectangle;
    // propriétés héritées à rendre disponibles dans l'éditeur
    property Started;
    property CountDown;
    property OnStart;
    property OnStop;
    property OnPulse;
    property OnReverseGrowth;
    property Interval;
    property PenWidth;
  end;

  { TGVWaitingPanel }

  TGVWaitingPanel = class(TGVCustomPulsar)
  strict private
    fShape: TGVPulsarType; // type de forme
    fActiveFrame: Integer; // élément actif
    fWidth, fHeight: Integer; // largeur et hauteur d'un élément
    fActiveColor: TColor; // couleur de l' élément actif
    fInactiveColor: TColor; // couleur des éléments inactifs
    fInactiveBorderColor: TColor; // couleur de bord pour éléments inactifs
    fActiveBorderColor: TColor; // couleur de bord pour élément actif
    fNbOfItems: Integer; // nombre d'éléments
    procedure SetActiveBorderColor(AValue: TColor);
    procedure SetActiveColor(AValue: TColor);
    procedure SetInactiveBorderColor(AValue: TColor);
    procedure SetInactiveColor(AValue: TColor);
    procedure SetNbOfItems(AValue: Integer);
    procedure SetShape(AValue: TGVPulsarType);
  protected
    procedure Pulse(Sender: TObject); override; // dessin de la pulsation
  public
    constructor Create(AOwner: TComponent); override; // constructeur
  published
    // nombre d'éléments
    property NbOfItems: Integer read fNbOfItems write SetNbOfItems default 5;
    // couleur active
    property ActiveColor: TColor read fActiveColor write SetActiveColor default clBlue;
    // couleur inactive
    property InactiveColor: TColor read fInactiveColor write SetInactiveColor default clAqua;
    // couleur de bordure active
    property ActiveBorderColor: TColor read fActiveBorderColor write SetActiveBorderColor default clBlack;
    // couleur de bordure inactive
    property InactiveBorderColor: TColor read fInactiveBorderColor write SetInactiveBorderColor default clNone;
    // type de dessin
    property Shape: TGVPulsarType read fShape write SetShape default gvpRectangle;
    // propriétés héritées à rendre disponibles dans l'éditeur
    property Started;
    property CountDown;
    property OnStart;
    property OnStop;
    property OnPulse;
    property OnReverseGrowth;
    property Interval;
    property PenWidth;
  end;

  { TGVPiePulsar }

  TGVPiePulsar = class(TGVCustomPulsar)
  strict private
    fPieColor: TColor;
    fStep: Integer; // pas de dessin
    fCount: Integer; // compteur en cours
    procedure SetPieColor(AValue: TColor);
    procedure SetStep(AValue: Integer);
  protected
    procedure Pulse(Sender: TObject); override; // dessin de la pulsation
  public
    constructor Create(AOwner: TComponent); override; // constructeur
    procedure Clear; override; // nettoyage
  published
    // pas du dessin
    property Step: Integer read fStep write SetStep default 1;
    // couleur du dessin
    property PieColor: TColor read fPieColor write SetPieColor default clBlue;
    property Started;
    property CountDown;
    property OnStart;
    property OnStop;
    property OnPulse;
    property OnReverseGrowth;
    property Interval;
    property PenWidth;
  end;

  { TGVWheelPulsar }

  TGVWheelPulsar = class(TGVPiePulsar)
  strict private
    fWheelColor: TColor;
    procedure SetWheelColor(AValue: TColor);
  protected
    procedure Pulse(Sender: TObject); override; // dessin de la pulsation
  public
    constructor Create(AOwner: TComponent); override; // constructeur
  published
    // couleur de la roue
    property WheelColor: TColor read fWheelColor write SetWheelColor default clAqua;
  end;

procedure Register;

implementation

procedure Register;
// *** composants enregistrés ***
begin
  {$I gvpulse_icon.lrs}
  {$I gvwaitingpanel_icon.lrs}
  {$I gvpiepulsar_icon.lrs}
  {$I gvwheelpulsar_icon.lrs}
  RegisterComponents('GVSoft',[TGVPulse, TGVWaitingPanel, TGVPiePulsar,
    TGVWheelPulsar]);
end;

{ TGVWheelPulsar }

procedure TGVWheelPulsar.SetWheelColor(AValue: TColor);
// *** couleur de la roue ***
begin
  if fWheelColor = AValue then // même couleur ?
    Exit; // on sort
  fWheelColor := AValue; // nouvelle valeur
end;

constructor TGVWheelPulsar.Create(AOwner: TComponent);
// *** constructeur ***
begin
  inherited Create(AOwner); // on hérite
  WheelColor := clAqua; // couleur par défaut
end;

procedure TGVWheelPulsar.Pulse(Sender: TObject);
// *** activité ***
begin
  inherited Pulse(Sender); // on hérite
  Canvas.Brush.Color:= WheelColor; // couleur de la roue
  // dessin rond central
  Canvas.Ellipse(Width div 4, Height div 4, 3 * (Width div 4), 3 * (Height div 4));
end;

{ TGVPiePulsar }

procedure TGVPiePulsar.SetStep(AValue: Integer);
// *** pas du dessin ***
begin
  if fStep = AValue then // même valeur ?
    Exit; // on sort
  fStep := AValue; // nouvelle valeur
end;

procedure TGVPiePulsar.SetPieColor(AValue: TColor);
// *** couleur du dessin ***
begin
  if fPieColor = AValue then // même couleur
    Exit; // on sort
  fPieColor := AValue; // nouvelle couleur
end;

procedure TGVPiePulsar.Pulse(Sender: TObject);
// *** activité ***
var
  LX, LY: Integer;
begin
  inherited Pulse(Sender); // on hérite
  Inc(fCount, Step); // intervalle en cours
  if (fCount >= 100) then // limite à 100
  begin
    fCount := 0;
    GrowthEvent; // signale le retour à zéro
  end;
  Lx := round((Width div 2) * cos((fCount/100) * 2 * pi));
  Ly := round((Height div 2) * sin((fCount/100) * 2 * pi));
  Canvas.Brush.Color := Color;
  Canvas.Clear;
  Repaint;
  Canvas.Brush.Color := PieColor; // couleur de dessin
  Canvas.Pie(0, 0, Width, Height, Width , Height div 2,
    (Width div 2) + Lx, (Height div 2) + Ly);
end;

constructor TGVPiePulsar.Create(AOwner: TComponent);
// *** construction ***
begin
  inherited Create(AOwner); // on hérite
  Step := 1; // pas par défaut
  PieColor := clBlue; // couleur par défault
end;

procedure TGVPiePulsar.Clear;
// *** nettoyage ***
begin
  inherited Clear; // on hérite
  fCount := 0; // compteur à zéro
end;

{ TGVWaitingPanel }

procedure TGVWaitingPanel.SetActiveBorderColor(AValue: TColor);
// *** couleur de bordure active ***
begin
  if fActiveBorderColor = AValue then // même valeur ?
    Exit; // on sort
  fActiveBorderColor := AValue; // nouvelle valeur
end;

procedure TGVWaitingPanel.SetActiveColor(AValue: TColor);
// *** couleur active ***
begin
  if fActiveColor = AValue then // la même ?
    Exit; // on sort
  fActiveColor := AValue; // nouvelle couleur
end;

procedure TGVWaitingPanel.SetInactiveBorderColor(AValue: TColor);
// *** couleur de bordure inactive ***
begin
  if fInactiveBorderColor = AValue then // même valeur ?
    Exit; // on sort
  fInactiveBorderColor := AValue; // nouvelle valeur
end;

procedure TGVWaitingPanel.SetInactiveColor(AValue: TColor);
// *** couleur inactive ***
begin
  if fInactiveColor = AValue then // la même ?
    Exit; // on sort
  fInactiveColor := AValue; // nouvelle valeur
end;

procedure TGVWaitingPanel.SetNbOfItems(AValue: Integer);
// *** définit le nombre d'éléments affichés ***
begin
  if fNbOfItems = AValue then // même valeur
    Exit; // sortie
  fNbOfItems := AValue; // nouvelle valeur
end;

procedure TGVWaitingPanel.SetShape(AValue: TGVPulsarType);
// *** définit la forme à dessiner ***
begin
  if fShape = AValue then // la même ?
    Exit; // on sort
  fShape := AValue; // nouvelle valeur
end;

procedure TGVWaitingPanel.Pulse(Sender: TObject);
// *** activité ***
var
  Li: Integer;
begin
  inherited Pulse(Sender); // on hérite
  fHeight := (ClientHeight div 4); // hauteur pour dessiner
  fWidth := (ClientWidth div (2 * NbOfItems + 1)); // largeur pour dessiner
  Inc(fActiveFrame); // calcul de l'élément actif
  if fActiveFrame > NbOfItems then
  begin
    fActiveFrame := 0;
    GrowthEvent; // signale le retour à zéro
  end;
  with Canvas do
  begin
    for Li := 0 to NbOfItems * 2 do // on balaie les éléments
    begin
      if (Li div 2) = fActiveFrame then // actif ?
      begin
        Brush.Color := ActiveColor;
        Pen.Color := ActiveBorderColor;
      end
      else  // inactif ?
      begin
        Brush.Color := InactiveColor;
        Pen.Color := InactiveBorderColor;
      end;
      if Odd(Li) then // ménage des espaces
        case Shape of // dessin suivant la forme voulue
          gvpRectangle: Rectangle(Li * fWidth, fHeight, (Li + 1) * fWidth, fHeight * 3);
          gvpEllipse: Ellipse(Li * fWidth, fHeight, (Li + 1) * fWidth, fHeight * 3);
          gvpFrame: Frame(Li * fWidth, fHeight, (Li + 1) * fWidth, fHeight * 3);
        end;
    end;
  end;
end;

constructor TGVWaitingPanel.Create(AOwner: TComponent);
// *** constructeur ***
begin
  inherited Create(AOwner); // on hérite
  NbOfItems := 5; // nombre d'éléments par défaut
  ActiveColor := clBlue; // couleurs par défaut
  InactiveColor := clAqua;
  ActiveBorderColor := clBlack;
  InactiveBorderColor := clNone;
  Shape := gvpRectangle; // forme par défaut
  fActiveFrame := -1; // forme active de début
end;

{ TGVPulse }

procedure TGVPulse.SetDrawColor(AValue: TColor);
// *** définit la couleur de dessin ***
begin
  if fDrawColor = AValue then // même valeur ?
    Exit; // on sort
  fDrawColor := AValue; // nouvelle valeur
  Canvas.Brush.Color:= AValue; // nouvelle couleur effective
  Canvas.Pen.Color:= AValue;
end;

procedure TGVPulse.SetGrow(AValue: Boolean);
// *** drapeau de grossissement ***
begin
  if fGrow = AValue then // même valeur ?
    Exit; // on sort
  fGrow := AValue; // nouvelle valeur
  GrowthEvent; // notification du changement
end;

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
  inherited Pulse(Sender); // on hérite
  if not Grow then // on grossit
  begin
    Dec(fx1,Step);
    Dec(fy1,Step);
    Inc(fx2,Step);
    Inc(fy2,Step);
    case GrowShape of // choix de la forme à dessiner
      gvpEllipse: Canvas.Ellipse(fx1,fy1,fx2,fy2);
      gvpRectangle: Canvas.Rectangle(fx1,fy1,fx2,fy2);
      gvpFrame: Canvas.Frame(fx1,fy1,fx2,fy2);
    end;
    Grow := not ((fx1 > 0) and (fy1 > 0) and (fx2 > 0) and (fy2 > 0));
  end
  else // on rapetisse
  begin
    case ShrinkShape of // choix de la forme à dessiner
      gvpEllipse: Canvas.Ellipse(fx1,fy1,fx2,fy2);
      gvpRectangle: Canvas.Rectangle(fx1,fy1,fx2,fy2);
      gvpFrame: Canvas.Frame(fx1,fy1,fx2,fy2);
    end;
    Inc(fx1,Step);
    Inc(fy1,Step);
    Dec(fx2,Step);
    Dec(fy2,Step);
    Grow := ((fx1 > 0) and (fy1 > 0) and (fx2 > 0) and (fy2 > 0));
  end;
end;

constructor TGVPulse.Create(AOwner: TComponent);
// *** construction ***
begin
  inherited Create(AOwner); // on hérite
  Step := 2; // pas par défaut
  DrawColor := clBlue; // couleur par défaut
  Canvas.Brush.Style := bsSolid; // brosse recouvrante
  Canvas.Pen.Mode := pmNotXor; // crayon en ou exclusif inversé
  GrowShape := gvpRectangle;
  ShrinkShape := gvpRectangle;
end;

procedure TGVPulse.Clear;
// *** nettoyage ***
begin
  inherited Clear; // on hérite
  fx1 := Width div 2; // valeurs d'origine pour dessiner
  fy1 := Height div 2;
  fx2 := fx1;
  fy2 := fy1;
  Canvas.Brush.Color := DrawColor; // nouvelle couleur effective de dessin
  Canvas.Pen.Color := DrawColor;
end;

{ TGVCustomPulsar }

procedure TGVCustomPulsar.SetCountDown(AValue: Integer);
// *** compte à rebours ***
begin
  if fCountDown = AValue then // si même valeur
    Exit; // on sort
  fCountDown := AValue; // nouvelle valeur
  fCountElapsed := AValue; // décompte en accord (en millisecondes)
end;

procedure TGVCustomPulsar.SetStarted(AValue: Boolean);
// *** démarre/arrête l'animation ***
begin
  if (fStarted = AValue) then // même valeur ?
    Exit; // ne rien faire
  fStarted := AValue; // nouvelle valeur
  fTimer.Enabled := AValue; // valeur effective
  Clear; // nettoyage
  if AValue then // notification de l'état
    StartEvent // démarrage
  else
    StopEvent; // arrêt
end;

function TGVCustomPulsar.GetInterval: Cardinal;
// *** valeur de l'intervalle entre deux pulsations ***
begin
  Result := fTimer.Interval;
end;

procedure TGVCustomPulsar.SetInterval(AValue: Cardinal);
// *** définit l'intervalle entre deux pulsations ***
begin
  fTimer.Interval := AValue;
end;

procedure TGVCustomPulsar.SetOnReverseGrowth(AValue: TNotifyEvent);
// *** inversion expansion/compression ***
begin
  if fOnReverseGrowth = AValue then // même valeur ?
    Exit; // on sort
  fOnReverseGrowth := AValue; // nouvelle valeur
end;

procedure TGVCustomPulsar.SetPenWidth(AValue: Integer);
// *** taille du crayon ***
begin
  if fPenWidth = AValue then // même valeur ?
    Exit; // on sort
  fPenWidth := AValue; // nouvelle valeur
  Canvas.Pen.Width := fPenWidth; // taille du crayon
end;

procedure TGVCustomPulsar.Pulse(Sender: TObject);
// *** pulsation ***
begin
  ElapsedTime; // compte à rebours
end;

procedure TGVCustomPulsar.ElapsedTime;
// *** temps écoulé ***
begin
  if fCountElapsed > 1 then // compte à rebours ?
  begin
    Dec(fCountElapsed, fTimer.Interval); /// on soustrait le temps écoulé
    if fCountElapsed < 1 then // temps écoulé ?
    begin
      fCountElapsed := 1; // au minimum
      Started := False; // animation arrêtée
    end;
  end;
end;

procedure TGVCustomPulsar.PulseEvent;
// *** événement pulsation ***
begin
  if Assigned(fOnPulse) then // si gestionnaire assigné
    fOnPulse(Self); // on l'exécute
end;

procedure TGVCustomPulsar.StopEvent;
// *** événement arrêt ***
begin
  if Assigned(fOnStop) then // si gestionnaire assigné
    fOnStop(Self); // on l'exécute
end;

procedure TGVCustomPulsar.StartEvent;
// *** événement démarrage ***
begin
  if Assigned(fOnStart) then // si gestionnaire assigné
    fOnStart(Self); // on l'exécute
end;

procedure TGVCustomPulsar.GrowthEvent;
// *** événement expansion/compression ***
begin
  if Assigned(fOnReverseGrowth) then // si gestionnaire assigné
    fOnReverseGrowth(Self); // on l'exécute
end;

class function TGVCustomPulsar.GetControlClassDefaultSize: TSize;
// *** taille par défaut ***
begin
  Result.CX := 105;
  Result.CY := 105;
end;

constructor TGVCustomPulsar.Create(AOwner: TComponent);
// *** création du composant ***
begin
  inherited Create(AOwner); // on hérite
  fTimer := TTimer.Create(Self); // timer créé
  fTimer.Enabled := False; // timer inactif par défaut
  fTimer.Interval := 5; // intervalle par défaut
  fTimer.OnTimer := @Pulse; // génération du dessin
  CountDown := 0; // compte à rebours inhibé par défaut
  PenWidth := 1; // taille du crayon par défaut
  // nouvelle taille
  with GetControlClassDefaultSize do
    SetBounds(0, 0, CX, CY);
end;

destructor TGVCustomPulsar.Destroy;
// *** destruction du composant ***
begin
  fTimer.Free; // libération du timer
  inherited Destroy; // on hérite
end;

procedure TGVCustomPulsar.Clear;
// *** nettoyage ***
begin
  fCountElapsed := CountDown; // compte à rebours réinitialisé
  Canvas.Brush.Color:= Color; // brosse par défaut
  Canvas.Clear; // on nettoie la surface
end;

end.

