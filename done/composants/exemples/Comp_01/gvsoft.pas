{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit gvsoft;

interface

uses
  GVUrlLabel, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('GVUrlLabel', @GVUrlLabel.Register);
end;

initialization
  RegisterPackage('gvsoft', @Register);
end.
