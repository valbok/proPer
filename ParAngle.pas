unit ParAngle;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls;

type
  TfrmParAngle = class(TForm)
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
  frmParAngle: TfrmParAngle;

implementation

uses Main;

{$R *.DFM}

procedure TfrmParAngle.Button1Click(Sender: TObject);
begin
 frmMain.UpDown2.Increment := TrackBar1.Position;
 frmMain.UpDown3.Increment := TrackBar1.Position;
 frmMain.UpDown4.Increment := TrackBar1.Position;
 frmParAngle.Visible := False;
 frmMain.SetProjection(nil);
end;

procedure TfrmParAngle.FormShow(Sender: TObject);
begin
 TrackBar1.Position := frmMain.UpDown2.Increment;
end;

end.
