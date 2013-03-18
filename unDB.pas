unit unDB;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DB, DBTables, ComCtrls, Grids, DBGrids, DBCtrls,
  StdCtrls, Mask, Menus;

type
  TfrmDB = class(TForm)
    pnlMain: TPanel;
    pc: TPageControl;
    tsAddStatiskiks: TTabSheet;
    tsViewStatistiks: TTabSheet;
    pnlBotData: TPanel;
    MainMenu: TMainMenu;
    Settings: TMenuItem;
    mmiOpen: TMenuItem;
    mmiClose: TMenuItem;
    DBGrid1: TDBGrid;
    dbeD: TDBEdit;
    dbeN: TDBEdit;
    dbeGlubina: TDBEdit;
    dbePPorog: TDBEdit;
    dbeM: TDBEdit;
    dbeA: TDBEdit;
    dbeB: TDBEdit;
    Bevel1: TBevel;
    DBNavigator: TDBNavigator;
    StatusBar: TStatusBar;
    Label1: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label2: TLabel;
    Label7: TLabel;
    Label4: TLabel;
    procedure SettingsClick(Sender: TObject);
    procedure mmiOpenClick(Sender: TObject);
    procedure mmiCloseClick(Sender: TObject);
    procedure dbeGlubinaExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
var
  frmDB: TfrmDB;

implementation
uses unDM;
{$R *.dfm}

procedure TfrmDB.SettingsClick(Sender: TObject);
begin
   mmiOpen.Enabled:=not dm.db.Connected;
   mmiCLose.Enabled:=dm.db.Connected;

end;

procedure TfrmDB.mmiOpenClick(Sender: TObject);
begin
//  dm.db.Connected:=true;
  dm.qStatistiks.Open;
  {  dm.qTypef.Active:=true;
  dm.qDATA.Active:=true;
           }
end;

procedure TfrmDB.mmiCloseClick(Sender: TObject);
begin
  dm.db.Connected:=false;
end;

procedure TfrmDB.dbeGlubinaExit(Sender: TObject);
begin
  dbePPorog.Text:=floatToStr(
  StrToFloat(dbeGlubina.Text)/StrToFloat(dbeN.Text));
end;

end.
