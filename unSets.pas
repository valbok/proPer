unit unSets;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons;

type
  TfrmSets = class(TForm)
    pnlMain: TPanel;
    gbLim: TGroupBox;
    eLim_x: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    eLim_y: TEdit;
    Label3: TLabel;
    eLim_z: TEdit;
    Label4: TLabel;
    eRadius: TEdit;
    btnOk: TBitBtn;
    cbOver: TCheckBox;
    eLn_x: TEdit;
    eLn_y: TEdit;
    eLn_z: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label5: TLabel;
    eSetColMol: TEdit;
    procedure btnOkClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure eLim_xExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    lim_x,lim_y,lim_z,N:integer;
    ln_x,ln_y,ln_z:integer;
    colmol:integer;    
    Radius,Step:Real;
    Over:Boolean;

    procedure SetColMol;
  end;

var
  frmSets: TfrmSets;
  Canceled:Boolean=true;
implementation

uses Main;

{$R *.dfm}

procedure TfrmSets.btnOkClick(Sender: TObject);
begin
   try
     StrToInt(eSetColMol.Text);
   except
    SetColMol;
//    showmessage(intToStr(colmol));
   end;
   colmol:=StrToInt(eSetColMol.Text);
   lim_x:=StrToInt(eLim_x.Text);
   lim_y:=StrToInt(eLim_y.Text);
   lim_z:=StrToInt(eLim_z.Text);
   ln_x:=StrToInt(eLn_x.Text);
   ln_y:=StrToInt(eLn_y.Text);
   ln_z:=StrToInt(eLn_z.Text);
   if (lim_x > ln_x) or
      (lim_y > ln_y) or
      (lim_z > ln_z) then
   begin
    messageDlg('Необходимо чтобы ширина/длина/высота была меньше чем её запас!',mtError,[mbOk],0);
    exit;
   end;
   Radius:=StrToFloat(eRadius.Text);


   Over:=cbOver.Checked;
   Canceled:=false;

   Close;
end;

procedure TfrmSets.FormActivate(Sender: TObject);
begin
  Canceled:=true;
end;
//++++++++++++++++++++++++
procedure TfrmSets.SetColMol;
var
  limx:integer;
  radius:real;
begin
 try
  limx:=StrToInt(eLim_x.Text);

  radius:=StrToFloat(eRadius.text);
  colmol:=round(limx/(radius*2));

  eSetColMol.Text:=intToStr(colmol);
 except
     eSetColMol.Text:='NAN';
 end;
end;

procedure TfrmSets.eLim_xExit(Sender: TObject);
begin
  SetColMol;
end;

end.
