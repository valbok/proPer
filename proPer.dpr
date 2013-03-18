program proPer;

uses
  Forms,
  Main in 'Main.pas' {frmMain},
  Splash in 'Splash.pas' {frmSPlash},
  ParObject in 'ParObject.pas' {frmParObject},
  unSets in 'unSets.pas' {frmSets},
  unCorpuskul in 'unCorpuskul.pas',
  unControl in 'unControl.pas',
  unPlane in 'unPlane.pas' {frmPlane},
  unKraft in 'unKraft.pas' {frmKraft},
  unPalletka in 'unPalletka.pas' {frmPalletka},
  unMemKrafts in 'unMemKrafts.pas' {frmMemKrafts},
  unDB in 'unDB.pas' {frmDB},
  unDM in 'unDM.pas' {DM: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmParObject, frmParObject);
  Application.CreateForm(TfrmSets, frmSets);
  Application.CreateForm(TfrmPlane, frmPlane);
  Application.CreateForm(TfrmKraft, frmKraft);
  Application.CreateForm(TfrmPalletka, frmPalletka);
  Application.CreateForm(TfrmMemKrafts, frmMemKrafts);
  Application.CreateForm(TfrmDB, frmDB);
  Application.CreateForm(TDM, DM);
  Application.Run;
end.
