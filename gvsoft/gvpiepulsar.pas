unit GVPiePulsar;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, gvpulsar;

type
  TGVPiePulsar = class(TGVWaitingPanel)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
  published
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  {$I gvpiepulsar_icon.lrs}
  RegisterComponents('GVSoft',[TGVPiePulsar]);
end;

end.
