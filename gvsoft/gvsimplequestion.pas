{ |========================================================================|
  |                                                                        |
  |                  G V S O F T                                           |
  |                  Projet : Paquet GVORPHEUS                             |
  |                  Description : Questions de type Oui/Non               |
  |                  Unité : GVSimpleQuestion.pas                          |
  |                  Ecrit par  : VASSEUR Gilles                           |
  |                  e-mail : g.vasseur58@laposte.net                      |
  |                  Copyright : © G. VASSEUR 2015                         |
  |                  Date:    25-03-2015 18:00:00                          |
  |                  Version : 1.0.0                                       |
  |                                                                        |
  |========================================================================| }

// HISTORIQUE
// 24/03/2015 - 1.0.0 - première version opérationnelle

// GVSIMPLEQUESTION - part of GVORPHEUS.LPK
// Copyright (C) 2015 Gilles VASSEUR
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

unit gvsimplequestion;

{$mode objfpc}{$H+}

interface
uses
  Classes, SysUtils, LResources, Controls, StdCtrls, Buttons, ExtCtrls;

const
  C_YesValue = 1; // valeur d'un oui
  C_Padding = 5; // espace minimum

resourcestring
  CGV_Yes = 'Oui';
  CGV_No ='Non';

type

 {TGVSimpleQuestion }

 TGVSimpleQuestion = class(TGroupbox)
 private
   fOnValueChange: TNotifyEvent;
   fPadding: Integer;
   fVertical: Boolean;
   fYesAnswer: Boolean;
   fYesValue: Integer;
   procedure SetPadding(AValue: Integer);
   procedure SetYesValue(AValue: Integer);
 protected
   procedure NewValue(Sender: TObject); virtual; // un bouton a été cliqué
   procedure ValueChange; virtual; // gestionnaire de changement
 public
   constructor Create(AOwner: Tcomponent); override; // constructeur
   property YesAnswer: Boolean read fYesAnswer; // réponse "oui" ?
 published
   // changement de valeur
   property OnValueChange: TNotifyEvent read fOnValueChange write fOnValueChange;
   // valeur de "oui"
   property YesValue: Integer read fYesValue write SetYesValue default C_YesValue;
   // espacement
   property Padding: Integer read fPadding write SetPadding default C_Padding;
end;

 { TGVYesNoQuestion }

  TGVYesNoQuestion = class(TGVSimpleQuestion)
    private
      fRadioButton1, fRadioButton2: TRadioButton;
    public
      constructor Create(AOwner: TComponent); override; // constructeur
    published
      property RadioButton1: TRadioButton read fRadioButton1; // bouton 1
      property RadioButton2: TRadioButton read fRadioButton2; // bouton 2
  end;

  { TGVYesNoButtons }

  TGVYesNoButtons = class(TGVSimpleQuestion)
  private
    fButton1, fButton2: TButton;
  public
    constructor Create(AOwner: TComponent); override; // constructeur
  published
    property Button1: TButton read fButton1; // bouton 1
    property Button2: TButton read fButton2; // bouton 2
  end;

  { TGVYesNoBitBtns }

  TGVYesNoBitBtns = class(TGVSimpleQuestion)
  private
    fButton1, fButton2: TBitBtn;
  public
    constructor Create(AOwner: TComponent); override; // constructeur
  published
    property BitBtn1: TBitBtn read fButton1; // bouton 1
    property BitBtn2: TBitBtn read fButton2; // bouton 2
  end;

  { TGVYesNoImages }

  TGVYesNoImages = class(TGVSimpleQuestion)
  private
    fButton1, fButton2: TImage;
  public
    constructor Create(AOwner: TComponent); override; // constructeur
  published
    property Button1: TImage read fButton1; // bouton 1
    property Button2: TImage read fButton2; // bouton 2
  end;

 procedure Register;

implementation

procedure Register;
// *** enregistrement des composants ***
begin
  {$I gvyesnoquestion_icon.lrs}
  {$I gvyesnobuttons_icon.lrs}
  {$I gvyesnoimages_icon.lrs}
  {$I gvyesnobitbtns_icon.lrs}
  RegisterComponents('GVSoft',[TGVYesNoQuestion, TGVYesNoButtons,
    TGVYesNoBitBtns, TGVYesNoImages]);
end;

{ TGVYesNoImages }

constructor TGVYesNoImages.Create(AOwner: TComponent);
// *** création ***
begin
  inherited Create(AOwner);
  // premier bouton
  fButton1 := TImage.Create(Self); // création de l'étiquette
  fButton1.Name := 'Image1';
  fButton1.SetSubComponent(True); // sous-composant enregistré
  fButton1.Parent := Self; // parent attaché
  fButton1.Tag := YesValue;
  fButton1.Align := alLeft; // alignement à gauche
  // pas de suppression possible depuis le concepteur
  fButton1.ControlStyle := fButton1.ControlStyle - [csNoDesignSelectable];
  fButton1.OnClick := @NewValue; // clic sur le bouton
  // second bouton
  fButton2 := TImage.Create(Self); // création de l'étiquette
  fButton2.Name := 'Image2';
  fButton2.SetSubComponent(True); // sous-composant enregistré
  fButton2.Parent := Self; // parent attaché
  fButton2.Align := alRight; // alignement à gauche
  // pas de suppression possible depuis le concepteur
  fButton2.ControlStyle := fButton2.ControlStyle - [csNoDesignSelectable];
  fButton2.OnClick := @NewValue; // changement du bouton
end;

{ TGVYesNoBitBtns }

constructor TGVYesNoBitBtns.Create(AOwner: TComponent);
// *** création ***
begin
  inherited Create(AOwner);
  // premier bouton
  fButton1 := TBitBtn.Create(Self); // création de l'étiquette
  fButton1.Name := 'BitBtn1';
  fButton1.SetSubComponent(True); // sous-composant enregistré
  fButton1.Parent := Self; // parent attaché
  fButton1.Kind := bkYes; // valeur "oui" de retour
  fButton1.Caption := CGV_Yes; // valeur "oui" pour le libellé
  fButton1.Default := True; // valeur par défaut
  fButton1.Tag := YesValue; // valeur numérique de "oui"
  fButton1.Align := alLeft; // alignement à gauche
  fButton1.OnClick := @NewValue; // clic sur le bouton
  // pas de suppression possible depuis le concepteur
  fButton1.ControlStyle := fButton1.ControlStyle - [csNoDesignSelectable];
  // second bouton
  fButton2 := TBitBtn.Create(Self); // création de l'étiquette
  fButton2.Name := 'BitBtn2';
  fButton2.SetSubComponent(True); // sous-composant enregistré
  fButton2.Parent := Self; // parent attaché
  fButton2.Kind := bkNo; // valeur "non" de retour
  fButton2.Caption := CGV_No; // valeur "non" pour le libellé
  fButton2.Align := alRight; // alignement à droite
  // pas de suppression possible depuis le concepteur
  fButton2.ControlStyle := fButton2.ControlStyle - [csNoDesignSelectable];
  fButton2.OnClick := @NewValue; // changement du bouton
end;

{ TGVYesNoButtons }

constructor TGVYesNoButtons.Create(AOwner: TComponent);
// *** création ***
begin
  inherited Create(AOwner);
  // premier bouton
  fButton1 := TButton.Create(Self); // création de l'étiquette
  fButton1.Name := 'Button1';
  fButton1.SetSubComponent(True); // sous-composant enregistré
  fButton1.Parent := Self; // parent attaché
  fButton1.Caption := CGV_Yes; // valeur "oui" pour le libellé
  fButton1.Tag := YesValue;
  fButton1.Align := alLeft; // alignement à gauche
  // pas de suppression possible depuis le concepteur
  fButton1.ControlStyle := fButton1.ControlStyle - [csNoDesignSelectable];
  fButton1.OnClick := @NewValue; // clic sur le bouton
  // second bouton
  fButton2 := TButton.Create(Self); // création de l'étiquette
  fButton2.Name := 'Button2';
  fButton2.SetSubComponent(True); // sous-composant enregistré
  fButton2.Parent := Self; // parent attaché
  fButton2.Caption := CGV_No; // valeur "non" pour le libellé
  fButton2.Align := alRight; // alignement à droite
  // pas de suppression possible depuis le concepteur
  fButton2.ControlStyle := fButton2.ControlStyle - [csNoDesignSelectable];
  fButton2.OnClick := @NewValue; // changement du bouton
end;

{ TGVYesNoQuestion }

constructor TGVYesNoQuestion.Create(AOwner: TComponent);
// *** création ***
begin
  inherited Create(AOwner);
  // premier bouton radio
  fRadioButton1 := TRadioButton.Create(Self); // création de l'étiquette
  fRadioButton1.Name := 'RadioButton1';
  fRadioButton1.SetSubComponent(True); // sous-composant enregistré
  fRadioButton1.Parent := Self; // parent attaché
  fRadioButton1.Caption := CGV_Yes; // valeur "oui" pour le libellé
  fRadioButton1.Tag := YesValue; // valeur numérique héritée de "oui"
  fRadioButton1.Align := alLeft; // alignement à gauche
  // pas de suppression possible depuis le concepteur
  fRadioButton1.ControlStyle := fRadioButton1.ControlStyle - [csNoDesignSelectable];
  fRadioButton1.OnClick := @NewValue; // changement du bouton
  // second bouton radio
  fRadioButton2 := TRadioButton.Create(Self); // création de l'étiquette
  fRadioButton2.Name := 'RadioButton2';
  fRadioButton2.SetSubComponent(True); // sous-composant enregistré
  fRadioButton2.Parent := Self; // parent attaché
  fRadioButton2.Caption := CGV_No; // valeur "non" pour le libellé
  fRadioButton2.Align := alRight; // alignement à droite
  // pas de suppression possible depuis le concepteur
  fRadioButton1.ControlStyle := fRadioButton1.ControlStyle - [csNoDesignSelectable];
  fRadioButton2.OnClick := @NewValue; // changement du bouton
end;

{ TGVSimpleQuestion }

procedure TGVSimpleQuestion.SetYesValue(AValue: Integer);
// *** valeur numérique de "oui" ***
begin
  if fYesValue = AValue then // valeur inchangée ?
    Exit; // on sort
  fYesValue := AValue; // nouvelle valeur
end;

procedure TGVSimpleQuestion.SetPadding(AValue: Integer);
// *** espace minimum entre les éléments ***
begin
  if fPadding = AValue then // pas de changement ?
    Exit; // on sort
  fPadding := AValue; // nouvelle valeur
  // *** réglage des alignements ***
  ChildSizing.VerticalSpacing := fPadding;
  ChildSizing.LeftRightSpacing := fPadding;
  ChildSizing.TopBottomSpacing := fPadding;
  Repaint;
end;

procedure TGVSimpleQuestion.NewValue(Sender: TObject);
// *** un bouton a été cliqué ***
begin
  fYesAnswer := ((Sender as TControl).Tag = YesValue); // bouton "oui" ?
  ValueChange; // changement notifié
end;

procedure TGVSimpleQuestion.ValueChange;
// *** notification de changement ***
begin
  if Assigned(fOnValueChange) then // gestionnaire affecté ?
    fOnValueChange(Self); // on l'exécute
end;

constructor TGVSimpleQuestion.Create(AOwner: Tcomponent);
// *** création du composant ***
begin
  inherited Create(AOwner);
  YesValue := C_YesValue; // valeur par défaut de "oui"
  Padding := C_Padding; // bordure minimale
  AutoSize := False; // pas de dimensions automatiques
end;



end.

