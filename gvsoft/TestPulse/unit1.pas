unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  gvpulse;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    GVPulse1: TGVPulse;
    GVPulse2: TGVPulse;
    GVPulse3: TGVPulse;
    GVPulse4: TGVPulse;
    GVPulse5: TGVPulse;
    GVPulse6: TGVPulse;
    procedure Button1Click(Sender: TObject);
    procedure GVPulse1Click(Sender: TObject);
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
  gvPulse2.Started:= not gvPulse2.Started;
  gvPulse3.Started:= not gvPulse3.Started;
  gvPulse4.Started:= not gvPulse4.Started;
  gvPulse5.Started:= not gvPulse5.Started;
  gvPulse6.Started:= not gvPulse6.Started;
end;

procedure TForm1.GVPulse1Click(Sender: TObject);
begin
  (Sender as TGVPulse).Started := not (Sender as TGVPulse).Started;
end;

end.

