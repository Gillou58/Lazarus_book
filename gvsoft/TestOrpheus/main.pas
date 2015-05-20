unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, GVGradient, gvpulsar, gvurllabel, gvsimplequestion, gvsizermover;

resourcestring
  C_Yes = 'OUI a été cliqué.';
  C_No = 'NON a été cliqué.';

type
  { TMainForm }

  TMainForm = class(TForm)
    Button1: TButton;
    Button2: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    ComboBox1: TComboBox;
    Edit1: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GVGradient1: TGVGradient;
    GVGradient2: TGVGradient;
    GVGradient3: TGVGradient;
    GVGradient4: TGVGradient;
    GVPiePulsar1: TGVPiePulsar;
    GVPiePulsar2: TGVPiePulsar;
    GVPiePulsar3: TGVPiePulsar;
    GVPulse1: TGVPulse;
    GVPulse2: TGVPulse;
    GVPulse3: TGVPulse;
    GVSizerMover1: TGVSizerMover;
    GVUrlLabel1: TGVUrlLabel;
    GVWaitingPanel1: TGVWaitingPanel;
    GVWaitingPanel2: TGVWaitingPanel;
    GVWheelPulsar1: TGVWheelPulsar;
    GVYesNoBitBtns1: TGVYesNoBitBtns;
    GVYesNoButtons1: TGVYesNoButtons;
    GVYesNoImages1: TGVYesNoImages;
    GVYesNoQuestion1: TGVYesNoQuestion;
    Image1: TImage;
    Label1: TLabel;
    lblChoice: TLabel;
    Panel1: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure GVPulse3ReverseGrowth(Sender: TObject);
    procedure GVWheelPulsar1ReverseGrowth(Sender: TObject);
    procedure GVYesNoQuestion1ValueChange(Sender: TObject);
  private
    { private declarations }
    procedure Reverse;
  public
    { public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.lfm}

{ TMainForm }

procedure TMainForm.FormCreate(Sender: TObject);
begin
  GVSizerMover1.Add(Button1);
  GVSizerMover1.Add(CheckBox1);
  GVSizerMover1.Add(ComboBox1);
  GVSizerMover1.Add(Edit1);
  GVSizerMover1.Add(Image1);
  GVSizerMover1.Enabled := True;
  Reverse;
end;

procedure TMainForm.GVPulse3ReverseGrowth(Sender: TObject);
begin
  GVPulse3.Step := GVPulse3.Step + 1;
  if GVPulse3.Step > 10 then
    GVPulse3.Step := 1;
end;

procedure TMainForm.GVWheelPulsar1ReverseGrowth(Sender: TObject);
begin
  if GVWheelPulsar1.Color = clAqua then
    GVWheelPulsar1.Color := clBlue
  else
    GVWheelPulsar1.Color := clAqua;
end;

procedure TMainForm.GVYesNoQuestion1ValueChange(Sender: TObject);
begin
  if (Sender as TGVSimpleQuestion).YesAnswer then
    lblChoice.Caption := C_Yes
  else
    lblChoice.Caption := C_No;
end;

procedure TMainForm.Reverse;
begin
  GVPiePulsar1.Started := not GVPiePulsar1.Started;
  GVPiePulsar2.Started := not GVPiePulsar2.Started;
  GVPiePulsar3.Started := not GVPiePulsar3.Started;
  GVPulse1.Started := not GVPulse1.Started;
  GVPulse2.Started := not GVPulse2.Started;
  GVPulse3.Started := not GVPulse3.Started;
  GVWaitingPanel1.Started := not GVWaitingPanel1.Started;
  GVWaitingPanel2.Started := not GVWaitingPanel2.Started;
  GVWheelPulsar1.Started := not GVWheelPulsar1.Started;
end;

end.

