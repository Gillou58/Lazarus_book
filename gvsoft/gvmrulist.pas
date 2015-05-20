{ |========================================================================|
  |                                                                        |
  |                  G V S O F T                                           |
  |                  Projet : Paquet GVORPHEUS                             |
  |                  Description : Gestion avec listes "Most Recent Used"  |
  |                  Unité : gvmrulist.pas                                 |
  |                  Ecrit par  : VASSEUR Gilles                           |
  |                  e-mail : g.vasseur58@laposte.net                      |
  |                  Copyright : © G. VASSEUR 2015                         |
  |                  Date:    26-03-2015 18:00:00                          |
  |                  Version : 1.0.0                                       |
  |                                                                        |
  |========================================================================| }

// HISTORIQUE
// 19/03/2015 - 1.0.0 - première version opérationnelle

// GVMRU - part of GVORPHEUS.LPK
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

unit gvmrulist;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

const
  C_MaxEntries = 8; // nombre d'entrées par défaut

type

  { TGVMruList }

  TGVMruList = class(TComponent)
    private
      fMaxItems: Integer; // nombre maximum d'éléments
      fItemsList, fValuesList: TStringList; // listes de travail
      fSection: string;
      fWithValue: Boolean; // valeur associée ?
      function GetItem(N: Integer): string;
      function GetValue(N: Integer): string;
      procedure SetItem(const N: Integer; AValue: string);
      procedure SetMaxItems(AValue: Integer);
      procedure SetSection(AValue: string);
      procedure SetValue(const N: Integer; AValue: string);
      procedure SetWithValue(AValue: Boolean);
    public
      constructor Create(AOwner: TComponent); override; // création
      destructor Destroy; override; // destruction
      procedure Clear; // nettoyage
      procedure Add(const AItem: string; AValue: string = ''); // ajout d'un élément
      function Delete(N: Integer): Boolean; overload; // supression d'un élément
      function Delete(const AValue: string): Boolean; overload;
      // valeur à partir d'un élément
      function GetValueFromItem(N: Integer): string;
      // récupération de toutes les valeurs
      function GetAllValues: TStrings;
      function Count: Integer; // nombre d'éléments
      // chargement à partir d'un fichier INI
      procedure LoadFromIni(const FileName: string);
      // enregistrement dans un fichier INI
      procedure SaveToIni(const FileName: string);
      // accès à une valeur associée
      property Value[N: Integer]: string read GetValue write SetValue;
      // accès à un élément
      property Item[N: Integer]: string read GetItem write SetItem; default;
    published
      // nombre maximum d'éléments
      property MaxItems: Integer read fMaxItems write SetMaxItems default C_MaxEntries;
      // valeur associée aux éléments ?
      property WithValue: Boolean read fWithValue write SetWithValue default False;
      // section de sauvegarde
      property Section: string read fSection write SetSection;
  end;

  procedure Register;

implementation

uses
  IniFiles, LResources;
  
const
  C_Section = 'MRU'; // section par défaut pour la sauvegarde
  C_ItemsNum = 'ItemsNum'; // variable pour le nombre d'entrées
  C_ItemD = 'Item%d'; // variable pour lecture INI
  C_ValueD = 'Value%d'; // variable pour lecture INI

resourcestring
  EBadRange = '%d n''est pas dans l''intervalle %d..%d.';
  EBadNumber = 'La valeur doit être strictement supérieure à 0.';
  EReadFileError = 'Impossible de lire le fichier %s qui contient les options.';
  EWriteFileError = 'Impossible d''écrire le fichier %s qui contient les options;';

procedure Register;
begin
  {$I gvmrulist_icon.lrs}
  RegisterComponents('GVSoft',[TGVMruList]);
end;

{ TGVMruList }

function TGVMruList.GetItem(N: Integer): string;
// *** renvoie l'élément N ***
begin
  if (N > 0) and (N < Count) then // dans le bon intervalle ?
    Result := fItemsList[N] // résultat affecté
  else
    // ### erreur : intervalle non respecté ###
    raise ERangeError.CreateFmt(EBadRange, [N, 1, Count - 1]);
end;

function TGVMruList.GetValue(N: Integer): string;
// *** renvoie la valeur N ***
begin
  if (N > 0) and (N < Count) then // dans le bon intervalle ?
    Result := fValuesList[N] // résultat affecté
  else
    // ### erreur : intervalle non respecté ###
    raise ERangeError.CreateFmt(EBadRange, [N, 1, Count - 1]);
end;

procedure TGVMruList.SetItem(const N: Integer; AValue: string);
// *** fixe l'élément N ***
begin
  if (N > 0) and (N < Count) then // dans le bon intervalle ?
    fItemsList[N] := Trim(AValue) // paramètre affecté
  else
    // ### erreur : intervalle non respecté ###
    raise ERangeError.CreateFmt(EBadRange, [N, 1, Count - 1]);
end;

procedure TGVMruList.SetMaxItems(AValue: Integer);
// *** nombre maximum d'éléments ***
begin
  if fMaxItems = AValue then // même valeur ?
    Exit; // on sort
  if AValue > 0 then // au moins un élément ?
    fMaxItems := AValue // on enregistre la nouvelle valeur
  else
    // ### erreur : entier strictement supérieur à 0 attendu ###
    raise EIntError.CreateFmt(EBadNumber, [AValue]);
end;

procedure TGVMruList.SetSection(AValue: string);
// *** section de sauvegarde ***
begin
  if fSection = AValue then // pas de changement ?
    Exit; // on sort
  fSection := AValue; // nouvelle valeur de la section
end;

procedure TGVMruList.SetValue(const N: Integer; AValue: string);
// *** fixe la valeur N ***
begin
  if (N > 0) and (N < Count) then // dans le bon intervalle ?
    fValuesList[N] := Trim(AValue) // paramètre affecté
  else
    // ### erreur : intervalle non respecté ###
    raise ERangeError.CreateFmt(EBadRange, [N, 1, Count - 1]);
end;

procedure TGVMruList.SetWithValue(AValue: Boolean);
// *** éléments accompagnés d'une valeur d'affichage ? ***
begin
  if fWithValue = AValue then // même valeur ?
    Exit; // on sort
  fWithValue := AValue; // nouvelle valeur
end;

constructor TGVMruList.Create(AOwner: TComponent);
// *** création de la liste ***
begin
  inherited Create(AOwner); // on hérite
  fItemsList := TStringList.Create; // listes de travail créées
  fValuesList := TStringList.Create;
  fMaxItems := C_MaxEntries; // nombre maximum d'éléments par défaut
  fSection := C_Section; // section du fichier INI
end;

destructor TGVMruList.Destroy;
// *** destruction de l'objet ***
begin
  fItemsList.Free; // listes de travail libérées
  fValuesList.Free;
  inherited Destroy; // on hérite
end;

procedure TGVMruList.Clear;
// *** nettoyage de la liste ***
begin
  fItemsList.Clear; // listes de travail nettoyées
  fValuesList.Clear;
end;

procedure TGVMruList.Add(const AItem: string; AValue: string);
// *** ajout d'une paire de valeurs ***
var
  Li: Integer;
  LFlag: Boolean;
begin
  LFlag := False; // pas d'élément semblable par défaut
  fItemsList.BeginUpdate; // début de la mise à jour
  fValuesList.BeginUpdate;
  try
   for Li := 0 to Count - 1 do // on balaie la liste
     if AnsiSameText(Trim(AItem), fItemsList[Li]) then // élément déjà prsent ?
      begin
        LFlag := True; // on a trouvé une correspondance
        fItemsList.Exchange(0, Li); // élément replacé en première place
        fValuesList.Exchange(0, Li); // idem pour les valeurs
        Break; // on interrompt la boucle
      end;
    if Not LFlag then // pas de correspondance trouvée ?
    begin
      if (Count = MaxItems) then // pas de place ?
      begin
        fItemsList.Delete(Count - 1); // élément le plus ancien supprimé
        fValuesList.Delete(Count - 1); // idem pour la valeur associée
      end;
      fItemsList.Insert(0, Trim(AItem)); // ajout d'un élément
      fValuesList.Insert(0, Trim(AValue)); // et de la valeur associée
    end;
  finally
    fItemsList.EndUpdate; // fin de la mise à jour
    fValuesList.EndUpdate;
  end;
end;

function TGVMruList.Delete(N: Integer): Boolean;
// *** supression d'un élément par numéro ***
begin
  Result := (N > 0) and (N < Count); // dans le bon intervalle ?
  if Result then // OK ?
  begin
    // on supprime les éléments
    fItemsList.Delete(N);
    fValuesList.Delete(N);
  end;
end;

function TGVMruList.Delete(const AValue: string): Boolean;
// *** suppression d'un élément par nom ***
var
  Li: Integer;
begin
  Result := False; // on suppose une erreur
  for Li := 0 to Count - 1 do
    if AnsiSameText(Trim(AValue), fItemsList[li]) then // même texte ?
    begin
      Result := Delete(Li); // on supprime
      Break; // on sort
    end;
end;

function TGVMruList.GetValueFromItem(N: Integer): string;
// *** renvoie la valeur à partir d'un élément ***
begin
  if (N > 0) and (N < Count) then // dans les limites ?
  begin
    if WithValue then // valeur associée ?
      // on renvoie cette valeur associée
      Result := fValuesList[N]
    else
      Result := fItemsList[N]; // élément renvoyé sinon
  end
  else
    // ### erreur : intervalle non respecté ###
    raise ERangeError.CreateFmt(EBadRange, [N, 1, Count - 1]);
end;

function TGVMruList.GetAllValues: TStrings;
// *** récupération de toutes les valeurs ***
var
  LSt: string;
begin
  Result.Clear; // on efface la liste de sortie
  if WithValue then // valeur associée ?
  begin
    for LSt in fValuesList do // on balaie les valeurs
      Result.Append(LSt) // on renvoie cette valeur associée
  end
  else
  begin
    for Lst in fItemsList do // on balaie les éléments
      Result.Append(Lst); // élément renvoyé sinon
  end;
end;

function TGVMruList.Count: Integer;
// *** renvoie le nombre d'éléments de la liste ***
begin
  Result := fItemsList.Count;
end;

procedure TGVMruList.LoadFromIni(const FileName: string);
// *** chargement à partir d'un fichier INI ***
var
  LIniFile: TIniFile;
  LEntries, Li: Integer;
begin
  fItemsList.BeginUpdate; // mise à jour
  fValuesList.BeginUpdate;
  LIniFile := TIniFile.Create(FileName);
  try
    Clear; // on nettoie les listes
    // on lit le nombre d'entrées disponibles
    try
      LEntries := LIniFile.ReadInteger(Section, C_ItemsNum, -1);
      if LEntries <> - 1 then // des entrées lisibles ?
      begin
        for Li := 1 to (LEntries * 2) do // on lit les données
          Add(LIniFile.ReadString(Section, Format(C_ItemD, [Li]), EmptyStr),
            LIniFile.ReadString(Section, Format(C_ValueD, [Li]), EmptyStr));
      end;
    except
      // ### erreur de lecture du fichier ###
      raise EInOutError.CreateFmt(EReadFileError, [FileName]);
    end;
  finally
    LIniFile.Free; // fichier libéré
    fItemsList.EndUpdate; // mise à jour achevée
    fValuesList.EndUpdate;
  end;
end;

procedure TGVMruList.SaveToIni(const FileName: string);
// *** enregistrement dans un fichier INI ***
var
  Li: Integer;
  LIniFile: TIniFile;
begin
  LIniFile := TIniFile.Create(FileName); // création du fichier
  try
    try
      LIniFile.EraseSection(Section); // section effacée
      // nombre d'éléments à enregistrer
      LIniFile.WriteInteger(Section, C_ItemsNum, Count);
      for Li := 1 to Count do // on balaie les données
      begin
        // on enregistre les données
        LIniFile.WriteString(Section, Format(C_ItemD, [Li]), fItemsList[Li - 1]);
        LIniFile.WriteString(Section, Format(C_ValueD, [Li]), fValuesList[Li - 1]);
      end;
    except
      // ### erreur d'écriture du fichier ###
      raise EInOutError.CreateFmt(EWriteFileError, [FileName]);
    end;
  finally
    LIniFile.Free; // libération du fichier
  end;
end;


end.

