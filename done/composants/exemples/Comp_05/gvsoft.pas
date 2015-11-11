{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit gvsoft;

interface

uses
  gvurllabel, gvgradient, gvsizermover, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('gvurllabel', @gvurllabel.Register);
  RegisterUnit('gvgradient', @gvgradient.Register);
  RegisterUnit('gvsizermover', @gvsizermover.Register);
end;

initialization
  RegisterPackage('gvsoft', @Register);
end.
