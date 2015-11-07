{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit gvsoft;

interface

uses
  gvurllabel, GVGradient, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('gvurllabel', @gvurllabel.Register);
  RegisterUnit('GVGradient', @GVGradient.Register);
end;

initialization
  RegisterPackage('gvsoft', @Register);
end.
