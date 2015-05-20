{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit gvorpheus;

interface

uses
  gvsimplequestion, gvurllabel, gvsizermover, GVGradient, gvpulsar, 
  LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('gvsimplequestion', @gvsimplequestion.Register);
  RegisterUnit('gvurllabel', @gvurllabel.Register);
  RegisterUnit('gvsizermover', @gvsizermover.Register);
  RegisterUnit('GVGradient', @GVGradient.Register);
  RegisterUnit('gvpulsar', @gvpulsar.Register);
end;

initialization
  RegisterPackage('gvorpheus', @Register);
end.
