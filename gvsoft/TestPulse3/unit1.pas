unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, DateTimePicker, Forms, Controls, Graphics,
  Dialogs, StdCtrls, ExtCtrls, Spin, gvpulsar;

type

  { TForm1 }

  TForm1 = class(TForm)
    GVPiePulsar1: TGVPiePulsar;
    GVPulse1: TGVPulse;
    GVWaitingPanel1: TGVWaitingPanel;
    GVWheelPulsar1: TGVWheelPulsar;
    pb: TPaintBox;
    SpinEdit1: TSpinEdit;
    procedure SpinEdit1Change(Sender: TObject);
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

procedure TForm1.SpinEdit1Change(Sender: TObject);
var
  X, Y: Integer;
begin
  x := round((pb.width div 2 * cos((spinedit1.value/100) * 2 * pi)));
  y := round((pb.width div 2 * sin((spinedit1.value/100) * 2 * pi)));
  pb.Canvas.Brush.Color:=clDefault;
  pb.Canvas.Clear;
  pb.Canvas.Brush.Color:=clBlue;
  pb.Canvas.Pie(0, 0, pb.width, pb.width, pb.width, pb.width div 2, (pb.width div 2) + x, (pb.width div 2) + y);
end;

end.

