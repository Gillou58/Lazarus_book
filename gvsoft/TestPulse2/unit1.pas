unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  gvpulsar, GVGradient, gvsizermover;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    GVGradient1: TGVGradient;
    GVPulse1: TGVPulse;
    GVSizerMover1: TGVSizerMover;
    GVWaitingPanel1: TGVWaitingPanel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
   gvPulse1.Started:= not gvPulse1.Started;
   gvWaitingPanel1.Started:= not gvWaitingPanel1.Started;
   gvPulse1.Clear;
   GVWaitingPanel1.Clear;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin

end;

end.

