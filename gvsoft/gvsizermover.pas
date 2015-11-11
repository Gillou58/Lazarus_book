{ |========================================================================|
  |                                                                        |
  |                  G V S O F T                                           |
  |                  Projet : Paquet GVORPHEUS                             |
  |                  Description : Taille et déplacement à l'exécution     |
  |                  Unité : GVSizerMover.pas                              |
  |                  Ecrit par  : VASSEUR Gilles                           |
  |                  e-mail : g.vasseur58@laposte.net                      |
  |                  Copyright : © G. VASSEUR 2015                         |
  |                  Date:    21-04-2015 18:00:00                          |
  |                  Version : 1.0.0                                       |
  |                                                                        |
  |========================================================================| }

// HISTORIQUE
// 21/04/2015 - 1.0.0 - première version opérationnelle

// GVSIZERMOVER - part of GVORPHEUS.LPK
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

unit gvsizermover;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs,
  Contnrs, ExtCtrls, LCLIntf;

const
  CHSize = 6; // taille par défaut des poignées
  CHColor = clBlue; // couleur par défaut des poignées

type
  // classe pour récupérer les méthodes protégées
  TMoveControl = class(TControl)
  end;

  // type tableau de méthodes pour la sauvegarde
  TMethods = array of TMethod;

  { TGVSizerMover }

  TGVSizerMover = class(TComponent)
  strict private
    fEnabled: Boolean; // drapeau actif/inactif
    fHandlesColor: TColor;
    fHandlesOnMove: Boolean; // visibilité des poignées en mouvement
    fHandlesSize: Integer; // taille des poignées
    fOnChange: TNotifyEvent; // changement notifié
    fMoving: Boolean; // drapeau de déplacement
    fControls: TComponentList; // contrôles déplaçables
    fHandles: TObjectList; // liste des zones de saisie
    fGettingHandle: Boolean; // poignées en cours ?
    fOldPos: TPoint; // ancienne position d'un contrôle
    fCurrentControl: TMoveControl; // contrôle en cours
    // stockage des méthodes
    fOnClickMethods : TMethods;
    fOnChangeMethods : TMethods;
    fMouseDownMethods : TMethods;
    fMouseMoveMethods : TMethods;
    fMouseUpMethods : TMethods;
    // actions de la souris sur les poignées
    procedure HandleMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure HandleMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure HandleMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure SetHandles(AroundControl: TMoveControl); // poignées autour
    procedure SetEnabled(AValue: Boolean); // activation/désactivation
    procedure SetHandlesColor(AValue: TColor);
    procedure SetHandlesOnMove(AValue: Boolean); // visibles/invisibles en déplacement ?
    procedure SetHandlesSize(AValue: Integer); // taille des poignées
    procedure SetHandlesVisible(AValue: Boolean); // visibilité des poignées
  protected
    procedure Change; // changement
  public
    constructor Create(AOwner: TComponent); override; // constructeur
    destructor Destroy; override; // destructeur
    procedure Add(AControl: TControl); // ajout d'un contrôle
    property Moving: Boolean read fMoving; // en mouvement ?
    property Enabled: Boolean read fEnabled write SetEnabled; // actif ?
  published
    property OnChange: TNotifyEvent read fOnChange write fOnChange;
    property HandlesOnMove: Boolean read fHandlesOnMove write SetHandlesOnMove;
    property HandlesSize: Integer read fHandlesSize write SetHandlesSize default CHSize;
    property HandlesColor: TColor read fHandlesColor write SetHandlesColor default CHColor;
    procedure ControlMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ControlMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure ControlMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  end;

procedure Register;

implementation

uses
  TypInfo;

procedure Register;
begin
  {$I gvsizermover_icon.lrs}
  RegisterComponents('GVSoft',[TGVSizerMover]);
end;

{ TGVSizerMover }

procedure TGVSizerMover.HandleMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
// *** souris cliquée sur poignée ***
begin
  if Enabled and (Sender is TControl) then // actif et un contrôle ?
  begin
    fGettingHandle := True; // poignées actives
    // capture des messages de la souris
    TMoveControl(Sender).MouseCapture := True;
    // enregistrement de la position du curseur
    GetCursorPos(fOldPos);
  end;
end;

procedure TGVSizerMover.HandleMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
// *** redimensionnement ***
var
  LNewPos, LPoint: TPoint;
  LOldRect: TRect;
begin
  if fGettingHandle then // poignées actives ?
  begin
    with TMoveControl(Sender) do // contrôle en cours
    begin
      GetCursorPos(LNewPos); // nouvelle position du curseur
      with fCurrentControl do // contrôle enregistré
      begin //redimensionnement
        // point en cours
        LPoint := Parent.ScreenToClient(Mouse.CursorPos);
        // rectangle en cours
        LOldRect := BoundsRect;
        case fHandles.IndexOf(TMoveControl(Sender)) of // quelle poignée ?
          0: begin
               LOldRect.Left := LPoint.X;
               LOldRect.Top := LPoint.Y;
             end;
          1: LOldRect.Top := LPoint.Y;
          2: begin
               LOldRect.Right := LPoint.X;
               LOldRect.Top := LPoint.Y;
             end;
          3: LOldRect.Right := LPoint.X;
          4: begin
               LOldRect.Right := LPoint.X;
               LOldRect.Bottom := LPoint.Y;
             end;
          5: LOldRect.Bottom := LPoint.Y;
          6: begin
               LOldRect.Left := LPoint.X;
               LOldRect.Bottom := LPoint.Y;
             end;
          7: LOldRect.Left := LPoint.X;
        end;
        SetBounds(LOldRect.Left, LOldRect.Top,LOldRect.Right -
          LOldRect.Left, LOldRect.Bottom - LOldRect.Top);
      end;
      // nouvelle position
      Left := Left - fOldPos.X + LNewPos.X;
      Top := Top - fOldPos.Y + LNewPos.Y;
      fOldPos := LNewPos;
    end;
    // affichage des poignées
    SetHandles(fCurrentControl);
  end;
end;

procedure TGVSizerMover.HandleMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
// *** relâchement du bouton de la souris ***
begin
  if fGettingHandle then // poignées actives ?
  begin
    Screen.Cursor := crDefault; // curseur par défaut
    TMoveControl(Sender).MouseCapture := False; // capture libérée
    TMoveControl(Sender).Repaint; // contrôle redessiné
    fGettingHandle := False; // fin de l'activité des poignées
  end;
end;

procedure TGVSizerMover.SetHandles(AroundControl: TMoveControl);
// *** poignées autour du contrôle ***
var
  Li,LTop,LLeft: Integer;
  LTopLeft: TPoint;
begin
  fCurrentControl := nil; // pas de composant en cours
  for Li := 0 to 7 do // on balaie les poignées à dessiner
  begin
    with AroundControl do // contrôle à entourer
    begin
      // calcul des emplacements de base
      case Li of
        0: begin
             LTop := Top - (HandlesSize - 1);
             LLeft := Left - (HandlesSize - 1);
           end;
        1: begin
             LTop := Top - (HandlesSize - 1);
             LLeft := (Width div 2) + Left - ((HandlesSize div 2) - 1);
           end;
        2: begin
             LTop := Top - (HandlesSize - 1);
             LLeft := Left + Width - 1;
           end;
        3: begin
             LTop := (Height div 2) + Top - ((HandlesSize div 2) - 1);
             LLeft := Left + Width - 1;
           end;
        4: begin
             LTop := Top + Height - 1;
             LLeft := Left + Width - 1;
           end;
        5: begin
             LTop := Top + Height - 1;
             LLeft := (Width div 2) + Left - ((HandlesSize div 2) - 1);
           end;
        6: begin
             LTop := Top + Height - 1;
             LLeft := Left - (HandlesSize - 1);
           end;
        7: begin
             LTop := (Height div 2) + Top - ((HandlesSize div 2) - 1);
             LLeft := Left - (HandlesSize - 1);
           end;
      end;
      // point supérieur gauche
      LTopLeft := Parent.ClientToScreen(Point(LLeft,LTop));
    end;
    with TPanel(fHandles[Li]) do // panneau placé
    begin
      Parent := AroundControl.Parent; // pour l'affichage
      LTopLeft := Parent.ScreenToClient(LTopLeft); // coordonnées locales
      Top := LTopLeft.Y; // emplacement réel
      Left := LTopLeft.X;
    end;
  end;
  fCurrentControl := AroundControl; // composant en cours
  SetHandlesVisible(True); // les poignées sont visibles
end;

procedure TGVSizerMover.SetEnabled(AValue: Boolean);
// *** composant actif ? ***
var
  Li: Integer;
  LOldM, LNewM, LNilM: TMethod;
begin
  if fEnabled = AValue then // même valeur ?
    Exit; // on sort
  fEnabled := AValue; // nouvelle valeur
  if Enabled then
  begin
    fOnClickMethods := nil; // nettoyage des tableaux de méthodes
    fOnChangeMethods := nil;
    fMouseDownMethods := nil;
    fMouseMoveMethods := nil;
    fMouseUpMethods := nil;
    LNilM.Data := nil; // méthode à nil
    LNilM.Code := nil;
    // longueur des tableaux dynamiques
    SetLength(fOnClickMethods, fControls.Count);
    SetLength(fOnChangeMethods, fControls.Count);
    SetLength(fMouseDownMethods, fControls.Count);
    SetLength(fMouseMoveMethods, fControls.Count);
    SetLength(fMouseUpMethods, fControls.Count);
    // inversion des méthodes concernant la souris
    for Li := 0 to (fControls.Count - 1) do
    begin
      // OnClick
      LOldM := GetMethodProp(TControl(fControls[Li]), 'OnClick');
      fOnClickMethods[Li].Code := LOldM.Code;
      fOnClickMethods[Li].Data := LOldM.Data;
      SetMethodProp(TControl(fControls[Li]), 'OnClick', LNilM);
      // OnChange
      if IsPublishedProp(TControl(fControls[Li]), 'OnChange') then
      begin
        LOldM := GetMethodProp(TControl(fControls[Li]), 'OnChange');
        fOnChangeMethods[Li].Code := LOldM.Code;
        fOnChangeMethods[Li].Data := LOldM.Data;
        SetMethodProp(TControl(fControls[Li]), 'OnChange', LNilM);
      end;
      // OnMouseDown
      LOldM := GetMethodProp(TControl(fControls[Li]), 'OnMouseDown');
      fMouseDownMethods[Li].Code := LOldM.Code;
      fMouseDownMethods[Li].Data := LOldM.Data;
      LNewM.Code := Self.MethodAddress('ControlMouseDown');
      LNewM.Data := Pointer(Self);
      SetMethodProp(TControl(fControls[Li]), 'OnMouseDown', LNewM);
      // OnMouseMove
      LOldM := GetMethodProp(TControl(fControls[Li]), 'OnMouseMove');
      fMouseMoveMethods[Li].Code := LOldM.Code;
      fMouseMoveMethods[Li].Data := LOldM.Data;
      LNewM.Code := Self.MethodAddress('ControlMouseMove');
      LNewM.Data := Pointer(Self);
      SetMethodProp(TControl(fControls[Li]), 'OnMouseMove', LNewM);
      // OnMouseUp
      LOldM := GetMethodProp(TControl(fControls[Li]), 'OnMouseUp');
      fMouseUpMethods[Li].Code := LOldM.Code;
      fMouseUpMethods[Li].Data := LOldM.Data;
      LNewM.Code := Self.MethodAddress('ControlMouseUp');
      LNewM.Data := Pointer(Self);
      SetMethodProp(TControl(fControls[Li]), 'OnMouseUp', LNewM);
    end;
  end
  else
  begin
    // récupération des anciennes valeurs
    for Li := 0 to (fControls.Count - 1) do
    begin
      // OnClick
      LOldM.Code := fOnClickMethods[Li].Code;
      LOldM.Data := fOnClickMethods[Li].Data;
      SetMethodProp(TControl(fControls[Li]), 'OnClick', LOldM);
      // OnChange
      if IsPublishedProp(TControl(fControls[Li]), 'OnChange') then
      begin
        LOldM.Code := fOnChangeMethods[Li].Code;
        LOldM.Data := fOnChangeMethods[Li].Data;
        SetMethodProp(TControl(fControls[Li]), 'OnChange', LOldM);
      end;
      // OnMouseDown
      LOldM.Code := fMouseDownMethods[Li].Code;
      LOldM.Data := fMouseDownMethods[Li].Data;
      SetMethodProp(TControl(fControls[Li]), 'OnMouseDown', LOldM);
      // OnMouseMove
      LOldM.Code := fMouseMoveMethods[Li].Code;
      LOldM.Data := fMouseMoveMethods[Li].Data;
      SetMethodProp(TControl(fControls[Li]), 'OnMouseMove', LOldM);
      // OnMouseUp
      LOldM.Code := fMouseUpMethods[Li].Code;
      LOldM.Data := fMouseUpMethods[Li].Data;
      SetMethodProp(TControl(fControls[Li]), 'OnMouseUp', LOldM);
    end;
    SetHandlesVisible(False); // poignées invisibles
  end;
end;

procedure TGVSizerMover.SetHandlesColor(AValue: TColor);
// *** couleur des poignées ***
var
  Li: Integer;
begin
  if fHandlesColor = AValue then // pas de changement ?
    Exit; // on sort
  fHandlesColor := AValue; // nouvelle valeur
  for Li := 0 to 7 do // on balaie les poignées
    TMoveControl(fHandles[Li]).Color := AValue;
end;

procedure TGVSizerMover.SetHandlesOnMove(AValue: Boolean);
// *** poignées visibles lors d'un déplacement ? ***
begin
  if fHandlesOnMove= AValue then // valeur inchangée ?
    Exit; // on sort
  fHandlesOnMove := AValue; // nouvelle valeur
end;

procedure TGVSizerMover.SetHandlesSize(AValue: Integer);
// *** taille des poignées ***
var
  Li: Integer;
begin
  if fHandlesSize = AValue then // même valeur ?
    Exit; // on sort
  fHandlesSize := AValue; // nouvelle valeur
  if Enabled then
    SetHandlesVisible(False);
  for Li := 0 to 7 do // on balaie les poignées
  begin
    TMoveControl(fHandles[Li]).Height := AValue; // hauteur
    TMoveControl(fHandles[Li]).Width := AValue; // largeur
  end;
end;

procedure TGVSizerMover.SetHandlesVisible(AValue: Boolean);
// *** visibilité des poignées ***
var
  Li: Integer;
begin
  for Li := 0 to 7 do // on balaie les poignées
    TMoveControl(fHandles[Li]).Visible := AValue; // visibilité fixée
end;

procedure TGVSizerMover.Change;
// *** changement notifié ***
begin
  if Assigned(fOnChange) then
    fOnChange(fCurrentControl);
end;

constructor TGVSizerMover.Create(AOwner: TComponent);
// *** création du composant ***
var
  Li: Integer;
  LPanel: TPanel;
begin
  inherited Create(AOwner);
  fHandles := TObjectList.Create(False);
  fControls := TComponentList.Create(False);
  fHandlesSize := CHSize; // taille par défaut des poignées
  fHandlesColor := CHColor; // couleur par défaut des poignées
  for Li := 0 to 7 do // on balaie les poignées
  begin
    LPanel := TPanel.Create(Self); // on crée le panneau
    with LPanel do // traitement
    begin
      Name := 'Handle' + IntToStr(Li); // nom unique
      BevelOuter := bvNone; // plat
      Caption := EmptyStr;
      Color := fHandlesColor; // couleur par défaut
      Width := HandlesSize; // taille
      Height := HandlesSize;
      Visible := False; // invisible par défaut
      case Li of  // curseur adapté
        0,4: Cursor := crSizeNWSE;
        1,5: Cursor := crSizeNS;
        2,6: Cursor := crSizeNESW;
        3,7: Cursor := crSizeWE;
      end;
      // gestionnaires suivant l'état de la souris
      OnMouseDown := @HandleMouseDown;
      OnMouseMove := @HandleMouseMove;
      OnMouseUp := @HandleMouseUp;
    end;
    fHandles.Add(LPanel); // on l'ajoute à la liste des noeuds
  end;
end;

destructor TGVSizerMover.Destroy;
// *** destruction ***
begin
  fControls.Free;
  fHandles.Free;
  inherited Destroy;
end;

procedure TGVSizerMover.Add(AControl: TControl);
// *** ajout d'un contrôle ***
begin
  fControls.Add(AControl);
end;

procedure TGVSizerMover.ControlMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
// *** souris cliquée sur contrôle ***
begin
  if Enabled and (Sender is TControl) then // actif et un contrôle ?
  begin
    fMoving := True; // déplacement
    // capture des messages de la souris
    TMoveControl(Sender).MouseCapture := True;
    // contrôle devant les autres contrôles
    TMoveControl(Sender).BringToFront;
    // enregistrement de la position du curseur
    GetCursorPos(fOldPos);
    // poignées dessinées
    SetHandles(TMoveControl(Sender));
  end;
end;

procedure TGVSizerMover.ControlMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
// *** déplacement du contrôle ***
var
  LNewPos, LFrmPoint: TPoint;
begin
  if Moving then
  begin
    with TControl(Sender) do
    begin
      GetCursorPos(LNewPos);
      if ssShift in Shift then // taille si touche majuscules
      begin
        Screen.Cursor := crSizeNWSE;
        LFrmPoint := ScreenToClient(Mouse.CursorPos);
        Width := LFrmPoint.X;
        Height := LFrmPoint.Y;
      end
      else // déplacement
      begin
        Screen.Cursor := crSize;
        Left := Left - fOldPos.X + LNewPos.X;
        Top := Top - fOldPos.Y + LNewPos.Y;
        fOldPos := LNewPos;
      end;
    end;
    Change; // changement notifié
    if HandlesOnMove then
      SetHandles(TMoveControl(Sender)) // poignées visibles
    else
      SetHandlesVisible(False); // poignées invisibles
  end;
end;

procedure TGVSizerMover.ControlMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
// *** fin de clic sur contrôle ***
begin
  if Moving then
  begin
    Screen.Cursor := crDefault; // curseur normal
    ReleaseCapture; // souris libérée
    fMoving := False; // fin du mouvement
    if not HandlesOnMove then // poignées à dessiner ?
      SetHandles(TMoveControl(Sender)); // on les dessine
  end;
end;

end.
