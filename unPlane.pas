unit unPlane;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls,unControl, StdCtrls, Buttons;

type
  TfrmPlane = class(TForm)
    pnlMain: TPanel;
    gbPlanes: TGroupBox;
    lbPlanes: TListBox;
    btnPaint: TBitBtn;
    Label1: TLabel;
    eAllPlanes: TEdit;
    sbSelectAll: TSpeedButton;
    procedure FormActivate(Sender: TObject);
    procedure btnCreatePlaneClick(Sender: TObject);
    procedure sbSelectAllClick(Sender: TObject);
    procedure btnPaintClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPlane: TfrmPlane;

implementation

uses Main;

{$R *.dfm}

procedure TfrmPlane.FormActivate(Sender: TObject);
var i:integer;
begin
 eAllPlanes.Text:=intToStr(Main.Control.NPlane);
 lbPlanes.Clear;
 for i:=0 to Main.Control.NPlane-1 do
 lbPlanes.Items.Add(intToStr(i+1));
 lbPlanes.SelectAll;
end;

procedure TfrmPlane.btnCreatePlaneClick(Sender: TObject);
var radius:real;
begin
end;

procedure TfrmPlane.sbSelectAllClick(Sender: TObject);
begin
  lbPlanes.SelectAll;
end;

procedure TfrmPlane.btnPaintClick(Sender: TObject);
var     i:integer;
        n:string;
begin
 if lbPlanes.SelCount =0 then exit;
 close;

 with frmMain do
 begin
        n:=Ern.Text;
        ObjectCount:=0;
        for i:=0 to lbPlanes.Items.Count-1 do
        begin
        if lbPlanes.Selected[i] then
          PaintPlane(Control,eColSets,progress,i);
          Ern.Text:=intToStr(trunc(i*100/(lbPlanes.Items.Count)))+'%';
          eRn.Update;

        end;

        sbRefresh.Click;
        Ern.Text:=n;
 end;

end;

end.
