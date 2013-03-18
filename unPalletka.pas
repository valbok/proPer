unit unPalletka;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Gauges, TeEngine, Series, TeeProcs,
  Chart,main, Grids, ComCtrls;

type
  TfrmPalletka = class(TForm)
    pnlMain: TPanel;
    Progress: TGauge;
    Bevel1: TBevel;
    btnGo: TBitBtn;
    gbDefPos: TGroupBox;
    Label6: TLabel;
    Label1: TLabel;
    eStep: TEdit;
    eN1: TEdit;
    gbResults: TGroupBox;
    eOutN: TEdit;
    Label3: TLabel;
    eD: TEdit;
    Label5: TLabel;
    Label7: TLabel;
    eBegin: TEdit;
    ProgressInner: TGauge;
    PageControl1: TPageControl;
    tsGraffik: TTabSheet;
    Chart: TChart;
    Series2: TLineSeries;
    tsGrid: TTabSheet;
    grid: TStringGrid;
    eB: TEdit;
    Label8: TLabel;
    Anim: TAnimate;
    eN2: TEdit;
    Label2: TLabel;
    sbGO: TSpeedButton;
    Bevel2: TBevel;
    Label4: TLabel;
    Series1: TPointSeries;
    procedure btnGoClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure sbGOClick(Sender: TObject);
  private
    { Private declarations }
    procedure Palletka_by_lim(inn:Currency;lim:real);    
  public
    { Public declarations }
  end;

var
  frmPalletka: TfrmPalletka;

implementation

{$R *.dfm}
procedure TfrmPalletka.Palletka_by_lim(inn:Currency;lim:real);
var i,resN,xn,yn:integer;
    step:real;
    a,b,v1,v2,r0,r1,pn: real;
    mxn,myn:array {[1..50000]}of real;   //look this
    lnN,ln_n:real;
    sd,sb:string;
begin
  setlength(mxn,main.Control.plim_x*
                main.Control.plim_y*
                main.Control.plim_z);
  setlength(myn,main.Control.plim_x*
                main.Control.plim_y*
                main.Control.plim_z);

  step:=StrToFloat(eStep.text);
  if step=0 then exit;
  anim.Active:=true;
  Series1.clear;
  Series2.clear;
  grid.RowCount:=2;
  Progress.Progress:=0;
  eOutN.Text:='0';
  eD.Text:='0';
  xn:=1; yn:=1;
  v1:=0; v2:=0; r0:=0; r1:=0;
// memo1.clear;
//  for i:=1 to Main.control.plim_z  do
  while inN <= lim do
  begin
    ResN:=0;

    Main.control.RunPalletka(inN,  resN ,progressInner);


   if inn > 0 then
     if (resN > 0.0) then
     begin

                          //kobzar begin
        lnN:=ln(resN);
        ln_n:=ln(inn);
        mxn[xn]:=ln_n;
        myn[yn]:=lnN;

        Series1.AddXY(ln(inN),ln(ResN),'',clRed);
        grid.Cells[0,xn]:=floattostr(inN);
        grid.Cells[1,xn]:=floattostr(ln_n);
        grid.Cells[2,xn]:=inttostr(REsN);
        grid.Cells[3,xn]:=floattostr(lnN);
        grid.rowcount:=grid.rowcount+1;
        grid.Update;

        v1:=v1+ln_n;
        v2:=v2+sqr(ln_n);

        r0:=r0+lnN;
        r1:=r1+(ln_n*lnN);
                          //kobzar  end
        eOUTn.text:=intToStr(resN);
        eOutN.update;



       end;

    inN:=inN+step;
    inc(xn);
    inc(yn);

    Chart.Update;
//  showmessage('d='+floatToStr(d)+#13#10+        'col='+floatToStr(col));

    progress.Progress:=trunc(inn*100/Main.control.plim_z);
  end;                    //end of while

 pn:=xn-1;                //хн -кол рёбер
 grid.rowcount:=grid.rowcount-1;


  a:=(pn*r1-r0*v1)/(pn*v2-sqr(v1));
  b:=(r0*v2-r1*v1)/(pn*v2-sqr(v1));
  str(abs(a):2:3,sd);
  str(b:2:3,sb);
  eD.text:=sd;
  eB.text:=sb;
  for i:=1 to (xn-1) do
    Series2.AddXY(mxn[i],(a*mxn[i]+b),'',clGreen);


  progress.Progress:=100;
  anim.Active:=false;
end;
//--------
procedure TfrmPalletka.btnGoClick(Sender: TObject);
var  inN:Currency;
begin
  inN:=StrToFloat(eBegin.text);
  Palletka_by_lim(inn,Main.control.plim_z);
end;

procedure TfrmPalletka.FormActivate(Sender: TObject);
begin
 en2.Text:=intToStr(Main.control.plim_x);
 grid.Cells[0,0]:='n';
 grid.Cells[1,0]:='ln(n)';
 grid.Cells[2,0]:='N';
 grid.Cells[3,0]:='ln(N)';
 
end;

procedure TfrmPalletka.sbGOClick(Sender: TObject);
var inn:currency;
    lim:real;
begin
  inn:=StrToFloat(en1.Text);
  inn:=exp(inn);
  lim:=strToFloat(en2.Text);
  lim:=exp(lim);
  Palletka_by_lim(inn,lim);
end;

end.
