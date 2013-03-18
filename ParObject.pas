unit ParObject;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Main, OpenGL, ExtCtrls;

type
  TfrmParObject = class(TForm)
    edtX: TEdit;
    Label1: TLabel;
    edtY: TEdit;
    Label2: TLabel;
    edtZ: TEdit;
    Label3: TLabel;
    btnOk: TButton;
    edtL: TEdit;
    Label4: TLabel;
    edtK: TEdit;
    Label5: TLabel;
    edtH: TEdit;
    Label6: TLabel;
    btnCOlor: TButton;
    cmbKind: TComboBox;
    edtRotZ: TEdit;
    edtRotY: TEdit;
    edtRotX: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    procedure btnOkClick(Sender: TObject);
    procedure edtXKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCOlorClick(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
  protected
    procedure WindowMoving (var Msg: TWMSysCommand); message WM_SYSCOMMAND;
    procedure WindowMove (var Msg: TWMMove); message WM_MOVE;
  end;

var
  frmParObject: TfrmParObject;

implementation

{$R *.DFM}

procedure TfrmParObject.btnOkClick(Sender: TObject);
begin
  With frmMain.objects [frmMain.PopupObject] do begin
    x := StrToFloat (edtX.Text)-k/2;
    y := StrToFloat (edtY.Text)-k/2;

    if frmMain.objects [frmMain.PopupObject].h <> minh then
                    z := StrToFloat (edtZ.Text)-k/2 else
         z := StrToFloat (edtZ.Text);

    l := StrToFloat (edtL.Text);
    k := StrToFloat (edtK.Text);
    h := StrToFloat (edtH.Text);

    RotX := StrToFloat (edtRotX.Text);
    RotY := StrToFloat (edtRotY.Text);
    RotZ := StrToFloat (edtRotZ.Text);

    Case cmbKind.ItemIndex of
         0 : kind := Cube;
         1 : kind := Sphere;
         2 : kind := Cylinder;
         else If cmbKind.Text = 'Параллепипед'
            then kind := Cube
            else
            If cmbKind.Text = 'Сфера' then kind := Sphere
            else kind := Cylinder;
    end;

  end;
  frmParObject.Visible := False;
  frmMain.SetProjection (nil);
end;

procedure TfrmParObject.edtXKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If Key = VK_ESCAPE then Close;
  If Key = VK_RETURN then BtnOk.OnClick (nil);
end;

procedure TfrmParObject.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmMain.SetProjection (nil);
end;

procedure TfrmParObject.btnCOlorClick(Sender: TObject);
begin
 frmMain.ColorToGlu (frmMain.objects [frmMain.PopupObject].color [0],
                   frmMain.objects [frmMain.PopupObject].color [1],
                   frmMain.objects [frmMain.PopupObject].color [2])
end;

procedure TfrmParObject.WindowMoving (var Msg: TWMSysCommand);
begin
 inherited;
 frmMain.SetProjection (nil);
end;

procedure TfrmParObject.WindowMove (var Msg: TWMMove);
begin
 inherited;
 frmMain.SetProjection (nil);
end;

procedure TfrmParObject.FormDeactivate(Sender: TObject);
begin
 Close
end;

procedure TfrmParObject.FormResize(Sender: TObject);
begin
 frmMain.flgMouseMove := False;
 frmMain.DrawScene (GL_RENDER);
end;

procedure TfrmParObject.FormShow(Sender: TObject);
begin
 frmMain.SetProjection (nil);

 edtH.Text := FloatToStr (frmMain.objects [frmMain.PopupObject].h);
 edtK.Text := FloatToStr (frmMain.objects [frmMain.PopupObject].k);
 edtL.Text := FloatToStr (frmMain.objects [frmMain.PopupObject].l);

 edtX.Text := FloatToStr (frmMain.objects [frmMain.PopupObject].x+
                        frmMain.objects [frmMain.PopupObject].k/2);
 edtY.Text := FloatToStr (frmMain.objects [frmMain.PopupObject].y+
                        frmMain.objects [frmMain.PopupObject].k/2);
 if frmMain.objects [frmMain.PopupObject].h <> minh then
      edtZ.Text := FloatToStr (frmMain.objects [frmMain.PopupObject].z+
                        frmMain.objects [frmMain.PopupObject].k/2) else
       edtZ.Text := FloatToStr (frmMain.objects [frmMain.PopupObject].z);

 edtRotX.Text := FloatToStr (frmMain.objects [frmMain.PopupObject].RotX);
 edtRotY.Text := FloatToStr (frmMain.objects [frmMain.PopupObject].RotY);
 edtRotZ.Text := FloatToStr (frmMain.objects [frmMain.PopupObject].RotZ);
 Case frmMain.objects [frmMain.PopupObject].kind of
    Cube : cmbKind.ItemIndex := 0;
    Sphere : cmbKind.ItemIndex := 1;
    Cylinder : cmbKind.ItemIndex := 2;
 end;
end;



end.
