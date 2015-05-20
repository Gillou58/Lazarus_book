unit GVWheelPulsar;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, gvpulsar;

type
  TGVWheelPulsar = class(TGVPulse)
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
  {$I gvwheelpulsar_icon.lrs}
  RegisterComponents('GVSoft',[TGVWheelPulsar]);
end;

end.
