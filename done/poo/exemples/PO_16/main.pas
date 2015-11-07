unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs;

type

  { TMainForm }

  TMainForm = class(TForm)
  private
    fMyFirstProp: Integer;
    procedure SetMyFirstProp(AValue: Integer);
    public
      constructor Create(AOwner: TComponent); override;
    published
      property MyFirstProp: Integer read fMyFirstProp write SetMyFirstProp default 4;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.lfm}

{ TMainForm }

procedure TMainForm.SetMyFirstProp(AValue: Integer);
begin
  fMyFirstProp := AValue;
end;

constructor TMainForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fMyFirstProp := 4;
end;


end.

