unit Splash;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TfrmSPlash = class(TForm)
    pnlMain: TPanel;
    Label1: TLabel;
    Image1: TImage;
    Bevel1: TBevel;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSPlash: TfrmSPlash;
const
  ver=' ProPer ver 5.06 build 1';
implementation

{$R *.DFM}

procedure TfrmSPlash.FormActivate(Sender: TObject);
begin
 Label1.Caption:=Label1.Caption+ver;
 Bevel1.Width:=label1.Width+label1.Left-Bevel1.Left+5;
end;

end.
