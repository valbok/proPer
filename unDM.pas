unit unDM;

interface

uses
  SysUtils, Classes, DB, DBTables,Graphics;

type
  TDM = class(TDataModule)
    DB: TDatabase;
    tblStatistiks: TTable;
    qStatistiks: TQuery;
    usStatistiks: TUpdateSQL;
    dsStatistiks: TDataSource;
    procedure dbAfterConnect(Sender: TObject);
    procedure dbAfterDisconnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
const disconnected='Disconnected';
       Connected='Connected to STATISTIKA';

var
  DM: TDM;

implementation




uses unDB;

{$R *.dfm}

procedure TDM.dbAfterConnect(Sender: TObject);
begin
  frmDB.StatusBar.Panels[0].Text:=Connected;
end;

procedure TDM.dbAfterDisconnect(Sender: TObject);
begin
        frmDB.StatusBar.Panels[0].text:=disconnected;


end;

end.
