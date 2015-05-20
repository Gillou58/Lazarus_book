unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ColorBox,
  StdCtrls, gvgradient;

type

  { TMainForm }

  TMainForm = class(TForm)
    ColorBox1: TColorBox;
    ColorBox2: TColorBox;
    GVGradient1: TGVGradient;
    Label1: TLabel;
    Label2: TLabel;
    procedure ColorBox1Change(Sender: TObject);
    procedure ColorBox2Change(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.lfm}

{ TMainForm }

procedure TMainForm.ColorBox1Change(Sender: TObject);
begin
  GVGradient1.BeginColor := ColorBox1.Selected;
end;

procedure TMainForm.ColorBox2Change(Sender: TObject);
begin
  GVGradient1.EndColor := ColorBox2.Selected;
end;

end.

