unit ParSdvig;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls;

type
  TfrmParSdvig = class(TForm)
    TrackBar1: TTrackBar;
    Label1: TLabel;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmParSdvig: TfrmParSdvig;

implementation

uses Main;

{$R *.DFM}

procedure TfrmParSdvig.Button1Click(Sender: TObject);
begin
 frmMain.upDown6.Increment := TrackBar1.Position;
 frmMain.UpDown7.Increment := TrackBar1.Position;
 frmMain.UpDown8.Increment := TrackBar1.Position;
 frmParSdvig.Visible := False;
 frmMain.SetProjection(nil);
end;

procedure TfrmParSdvig.FormShow(Sender: TObject);
begin
 TrackBar1.Position := frmMain.upDown6.Increment;
end;

end.
