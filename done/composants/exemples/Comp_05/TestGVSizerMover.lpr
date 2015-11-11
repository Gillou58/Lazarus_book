program TestGVSizerMover;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, main,
  { you can add units after this }
  GetText, Translations;

{$R *.res}

procedure TranslateLCL;
// *** traduction ***
var
  Lang, DefLang: string;
begin
  Lang := '';
  DefLang := '';
  GetLanguageIDs({%H-}Lang, {%H-}DefLang);
  TranslateUnitResourceStrings('LCLStrConsts',
      'lclstrconsts.fr.po', Lang, DefLang);
end;

begin
  RequireDerivedFormResource := True;
  TranslateLCL; // traduction
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.

