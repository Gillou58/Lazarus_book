unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ComCtrls, ExtCtrls, ColorBox, gvsizermover;

type

  { TfrmMain }

  TfrmMain = class(TForm)
    btnMove: TButton;
    Button1: TButton;
    btnHandles: TButton;
    btnNo: TButton;
    CheckBox1: TCheckBox;
    ColorBox1: TColorBox;
    Edit1: TEdit;
    GroupBox1: TGroupBox;
    GVSizerMover1: TGVSizerMover;
    Image1: TImage;
    Panel1: TPanel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    StatusBar: TStatusBar;
    tbSize: TTrackBar;
    procedure btnMoveClick(Sender: TObject);
    procedure btnHandlesClick(Sender: TObject);
    procedure ColorBox1Change(Sender: TObject);
    procedure Edit1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure GVSizerMover1Change(Sender: TObject);
    procedure tbSizeChange(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.lfm}

{ TfrmMain }

procedure TfrmMain.btnMoveClick(Sender: TObject);
// *** activation/désactivation des mouvements ***
begin
  GVSizerMover1.Enabled := not GVSizerMover1.Enabled;
  btnHandles.Enabled := GVSizerMover1.Enabled;
  if not GVSizerMover1.Enabled then
    Statusbar.Panels[0].Text := 'Attente...'
  else
    Statusbar.Panels[0].Text := 'Mouvement...'
end;

procedure TfrmMain.btnHandlesClick(Sender: TObject);
// *** poignées visibles/invisibles lors des déplacements
begin
  GVSizerMover1.HandlesOnMove := not GVSizerMover1.HandlesOnMove;
end;

procedure TfrmMain.ColorBox1Change(Sender: TObject);
// *** changement de couleur des poignées ***
begin
  GVSIzerMover1.HandlesColor := ColorBox1.Selected;
end;

procedure TfrmMain.Edit1Click(Sender: TObject);
// *** clic sur contrôle ***
begin
  Statusbar.Panels[1].Text := 'Clic sur : ' + Sender.ClassName;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
// *** création de la fiche ***
begin
  GVSizerMover1.Add(Button1);
  GVSizerMover1.Add(CheckBox1);
  GVSizerMover1.Add(Edit1);
  GVSizerMover1.Add(GroupBox1);
  GVSizerMover1.Add(Image1);
  GVSizerMover1.Add(Panel1);
end;

procedure TfrmMain.GVSizerMover1Change(Sender: TObject);
// *** changement ***
begin
  with Statusbar.Panels[1] do
    Text := format('X : %d Y : %d', [(Sender as TControl).Left, (Sender as TControl).Top]);
end;

procedure TfrmMain.tbSizeChange(Sender: TObject);
// *** taille des poignées ***
begin
  GVSizerMover1.HandlesSize := tbSize.Position + 2;
end;

end.

