unit unKraft;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Gauges,math, ComCtrls;

type TDot= record
                x,y,z:real;
                xe,ye,ze:real;
                kraft:real;
//                kutXZ:real;
//                kutYZ:real;
           end;
type Ta2dKasatel= record
                        x1,y1:real;
                        x2,y2:real
                      end;
type Ta3dKasatel= record
                        x1,y1:real;
                        x2,y2:real;
                        z1,z2:real;
                      end;

type TaDot=array of TDot;
type T2dKasatel= array of Ta2dKasatel;

type T3dKasatel= array of Ta3dKasatel;

type
  TfrmKraft = class(TForm)
    pnlMain: TPanel;
    gbDefPos: TGroupBox;
    Label5: TLabel;
    eColDOts: TEdit;
    Label6: TLabel;
    eMu: TEdit;
    Label1: TLabel;
    eRo: TEdit;
    Label2: TLabel;
    PageControl1: TPageControl;
    ts3d: TTabSheet;
    ts2d: TTabSheet;
    Label7: TLabel;
    cbNumPlane: TComboBox;
    sbKasatel2d: TSpeedButton;
    btnGo_Kraft: TBitBtn;
    btnGo_kraft2d: TBitBtn;
    Bevel2: TBevel;
    btnPaint: TBitBtn;
    Progress: TGauge;
    Label9: TLabel;
    eStepX: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    eSTepZ: TEdit;
    eStepY: TEdit;
    eLimStepX: TEdit;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    eLimStepZ: TEdit;
    eLimStepY: TEdit;
    Bevel3: TBevel;
    Label15: TLabel;
    eChange: TEdit;
    Label3: TLabel;
    btnPaintLiteri: TBitBtn;
    cbRandom: TCheckBox;
    sbKasatel3d: TSpeedButton;
    Label8: TLabel;
    eLenKasatel: TEdit;
    btnPaintPOle: TBitBtn;
    btnPaintPole3d: TBitBtn;
    memKrafts: TRichEdit;
    btnExportToMem: TBitBtn;
    TabSheet1: TTabSheet;
    Label4: TLabel;
    eKutXY: TEdit;
    btnKut3d: TBitBtn;
    eStepKut: TEdit;
    Label16: TLabel;
    eKutXZ: TEdit;
    Label17: TLabel;
    procedure btnGo_KraftClick(Sender: TObject);

    procedure btnPaintClick(Sender: TObject);
    procedure btnGo_kraft2dClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure sbKasatel2dClick(Sender: TObject);
    procedure btnPaintLiteriClick(Sender: TObject);
    procedure btnPaintPOleClick(Sender: TObject);
    procedure sbKasatel3dClick(Sender: TObject);
    procedure btnPaintPole3dClick(Sender: TObject);
    procedure btnExportToMemClick(Sender: TObject);
    procedure btnKut3dClick(Sender: TObject);
  private
    { Private declarations }
    _x,_y,_z:real;
  public
    { Public declarations }
    Dots: TaDot;
    _2dKasatel:T2dKasatel;
    _3dKasatel:T3dKasatel;
    coldotsplane:integer;
    colDots:integer;
    Col_2d_Kasatel:integer;
    Col_3d_Kasatel:integer;
    limStepX,limStepY,limStepZ:real;
    stepX, stepY,  stepZ:real;


    procedure SetDots(pcoldots:integer;T2or3d:string;//lim_dots:integer;
                                    StepX,StepY,StepZ,LimStepX,LImStepY,limStepZ:real;randm:boolean);

    procedure SetDotsKut(pcoldots:integer;Step,kutxy,kutxz:real);

    procedure FillDots(T2or3d:string;//lim_dots:integer;

                        StepX,StepY,StepZ,LimStepX,LImStepY,limStepZ:real;randm:boolean);
    procedure FillDotsKut(Step,kutxy,kutxz:real);

    procedure Fill_2d_Kasatel(len:real);
    procedure Fill_3d_Kasatel(len:real);    
  end;

const
   C2d='2d';
   C3d='3d';
var
  frmKraft: TfrmKraft;

implementation

uses Main, unMemKrafts;

{$R *.dfm}
procedure TfrmKraft.Fill_3d_Kasatel(len:real);
var idot:integer;
    x,y,xe,ye,z,ze,fi,alfa,sinfiz,sinfi,sinf,cosf:real;
    b,d,aa,a,aaz,bb,bbz,c,c2,a2,b2,d2:real;

begin
       Col_3d_Kasatel:=0;
       for iDot:=0 to COlDots-1 do  //on dots
       begin
         x:=Dots[iDot].x;
         y:=Dots[iDot].y;
         z:=Dots[iDot].z;
         xe:=Dots[iDot].xe;
         ye:=Dots[iDot].ye;
         ze:=Dots[iDot].ze;

         c:=dots[idot].kraft;
         c2:=len;
         a:=abs(x-xe);
         b:=abs(y-ye);
         d:=abs(z-ze);

         sinf:=a/c;
         cosf:=b/c;

          a2:=sinf*c2;
          b2:=cosf*c2;
          d2:=sqrt(abs(c2*c2 -a2*a2 - b2*b2));


          if x > xe then
          begin
            _3dKasatel[iDOt].x2:=x - a2;
            _3dKasatel[iDOt].x1:=x + a2;
          end
             else
          begin
            _3dKasatel[iDOt].x2:=x + a2;
            _3dKasatel[iDOt].x1:=x - a2;            
          end;

          if y > ye then
          begin
             _3dKasatel[iDOt].y2:=y - b2;
             _3dKasatel[iDOt].y1:=y + b2;             

          end else
          begin
             _3dKasatel[iDOt].y2:=y + b2;
             _3dKasatel[iDOt].y1:=y - b2;             
          end;

          if z > ze then
          begin
            _3dKasatel[iDOt].z2:=z - d2;
            _3dKasatel[iDOt].z1:=z + d2;
          end else
          begin
            _3dKasatel[iDOt].z2:=z + d2;
            _3dKasatel[iDOt].z1:=z - d2;
          end;

     if (x <= 0) and (_3dKasatel[iDOt].x2 <= 0) then       _3dKasatel[iDOt].x2:=abs(x-_3dKasatel[iDOt].x2)+x;
{
         sinfi:=abs(x-xe)/Dots[iDOt].kraft;
         sinfiz:=abs(z-ze)/Dots[iDOt].kraft;

         aa:=sinfi*len/2;
         aaz:=sinfiz*len/2;

         bb:=sqrt(abs((len/2)*(len/2)-aa*aa - aaz*aaz));
         bbz:=sqrt(abs((len/2)*(len/2)-aaz*aaz - aa*aa));


         if ((xe >= x) and (ye >= y) and (ze >= z))
             or            ((xe < x) and (ye < y) and (ze < z))
          then
         begin
           _3dKasatel[iDOt].x1:=x-aa;
           _3dKasatel[iDOt].y1:=y-bb;
           _3dKasatel[iDOt].z1:=z-aaz;


           _3dKasatel[iDOt].x2:=x+aa;
           _3dKasatel[iDOt].y2:=y+bb;
           _3dKasatel[iDOt].z2:=z+aaz;
         end;
         //++++++


         if ((xe >= x) and (ye >= y) and (ze <= z))
             or            ((xe < x) and (ye < y) and (ze > z))
          then
         begin
           _3dKasatel[iDOt].x1:=x-aa;
           _3dKasatel[iDOt].y1:=y-bb;
           _3dKasatel[iDOt].z1:=z+aaz;


           _3dKasatel[iDOt].x2:=x+aa;
           _3dKasatel[iDOt].y2:=y+bb;
           _3dKasatel[iDOt].z2:=z-aaz;
         end;

         //++++++

         if ((xe <= x) and (ye >= y) and (ze >= z)) or
            ((xe > x) and (ye < y) and (ze < z)) then
         begin
           _3dKasatel[iDOt].x1:=x+aa;
           _3dKasatel[iDOt].y1:=y-bb;
           _3dKasatel[iDOt].z1:=z-aaz;

           _3dKasatel[iDOt].x2:=x-aa;
           _3dKasatel[iDOt].y2:=y+bb;
           _3dKasatel[iDOt].z2:=z+aaz;

         end;
         //+++++----
         if ((xe <= x) and (ye >= y) and (ze <= z)) or
            ((xe > x) and (ye < y) and (ze > z)) then
         begin
           _3dKasatel[iDOt].x1:=x+aa;
           _3dKasatel[iDOt].y1:=y-bb;
           _3dKasatel[iDOt].z1:=z+aaz;

           _3dKasatel[iDOt].x2:=x-aa;
           _3dKasatel[iDOt].y2:=y+bb;
           _3dKasatel[iDOt].z2:=z-aaz;

         end;}

         ///+++---

         inc(Col_3d_Kasatel);

{       showmessage('x1='+floatToStr(_2dkasatel[idot].x1));
       showmessage('x2='+floatToStr(_2dkasatel[idot].x2));
       showmessage('y1='+floatToStr(_2dkasatel[idot].y1));
       showmessage('y2='+floatToStr(_2dkasatel[idot].y2));}
       end;

end;
//++++++++++++++++
procedure TfrmKraft.Fill_2d_Kasatel(len:real);
var idot:integer;
    x,y,xe,ye,fi,alfa,omega,sinfi:real;
    b,d,aa,a,bb:real;

begin
       Col_2d_Kasatel:=0;
//       wrong;
       for iDot:=0 to COlDots-1 do  //on dots
       begin
         x:=Dots[iDot].x;
         y:=Dots[iDot].y;
//         z:=Dots[iDot].z;
         xe:=Dots[iDot].xe;
         ye:=Dots[iDot].ye;
//         ze:=Dots[iDot].ze;

{
         b:=Dots[iDot].kraft;

         d:=abs(ye-y);

         fi:=arcsin(d/b);

         alfa:=(pi/2)-fi;

         omega:=(pi/2)-alfa;

         a:=len;

         aa:=a*sin(omega);

         bb:=sqrt(abs(a*a - aa*aa));

         if ((xe > x) and (ye > y)) or
            ((xe < x) and (ye < y)) then
         begin
           _2dKasatel[iDOt].x1:=x+aa;
           _2dKasatel[iDOt].y1:=y-bb;

           _2dKasatel[iDOt].x2:=x-aa;
           _2dKasatel[iDOt].y2:=y+bb;
         end;
         if ((xe < x) and (ye > y)) or
            ((xe > x) and (ye < y)) then
         begin
           _2dKasatel[iDOt].x1:=x-aa;
           _2dKasatel[iDOt].y1:=y-bb;
           _2dKasatel[iDOt].x2:=x+aa;
           _2dKasatel[iDOt].y2:=y+bb;
         end;}
             
           sinfi:=abs(x-xe)/Dots[iDOt].kraft;
           aa:=sinfi*len/2;
           bb:=sqrt(abs((len/2)*(len/2)-aa*aa));
           

         if ((xe >= x) and (ye >= y))
             or            ((xe < x) and (ye < y))
          then
         begin
           _2dKasatel[iDOt].x1:=x-aa;
           _2dKasatel[iDOt].y1:=y-bb;

           _2dKasatel[iDOt].x2:=x+aa;
           _2dKasatel[iDOt].y2:=y+bb;
         end;
         if ((xe <= x) and (ye >= y)) or
            ((xe > x) and (ye < y)) then
         begin
           _2dKasatel[iDOt].x1:=x+aa;
           _2dKasatel[iDOt].y1:=y-bb;
           _2dKasatel[iDOt].x2:=x-aa;
           _2dKasatel[iDOt].y2:=y+bb;
         end;
         inc(Col_2d_Kasatel);

{       showmessage('x1='+floatToStr(_2dkasatel[idot].x1));
       showmessage('x2='+floatToStr(_2dkasatel[idot].x2));
       showmessage('y1='+floatToStr(_2dkasatel[idot].y1));
       showmessage('y2='+floatToStr(_2dkasatel[idot].y2));}
       end;

end;
//---
procedure TfrmKraft.FillDotsKut(Step,kutxy,kutxz:real);
label without_inc,without_inc2;
var i,zz,yy,xx,zm,ym,xm:integer;
    x,y,z,tx,ty,tz,c_sqr,r_sqr,stp:real;

begin
  i:=0;
  randomize;
  x:=Main.Control.plim_x/2;
  y:=Main.Control.plim_y/2;
  z:=Main.Control.plim_z/2;
  tx:=x;
  ty:=y;
  tz:=z;
  stp:=0;
  zm:=Main.Control.plim_z;
  ym:=Main.Control.plim_y;
  xm:=Main.Control.plim_x;

  while i <= coldots-1 do
  begin
//--------------------------
     for zz:=0 to zm-1 do
       for yy:=0 to ym-1 do
         for xx:=0 to xm-1 do
          if Main.Control.grid[xx,yy,zz] <> nil then
             begin
                 c_sqr:=Main.Control.csqr(x,
                        Main.Control.grid[xx,yy,zz].x,
                        y,
                        Main.Control.grid[xx,yy,zz].y,
                        z,
                        Main.Control.grid[xx,yy,zz].z
                        );
                                         // квадрат суммы радисуов двух bliz лижащих частиц
              r_sqr:=sqr(Main.Control.grid[xx,yy,zz].radius);


                                         //po x
              if c_sqr <= r_sqr then      //если залазят на друг др.
              begin
//  showmessage('c='+floatToStr(c_sqr)+ '; r=' +floatToStr(r_sqr));
                goto without_inc;
                break;
              end;
             end;

        DOts[i].x:=x;
        DOts[i].y:=y;
        DOts[i].z:=z;


      inc(i);
    without_inc:

        stp:=stp+step;

        x:=tx+cos(kutxy)*stp;
        y:=ty+sin(kutxy)*stp;
        z:=tz+sin(kutxz)*stp;
//        sqrt(abs(stp*stp-x*x -y*y));
{  showmessage('inc; Step='+FloatToSTr(stp)+#13#10+
        'x='+FloatToSTr(x)+#13#10+
  'y='+FloatToSTr(y)+#13#10+
  'z='+FloatToSTr(z)
  );  }
  end;


end;
///----
procedure TfrmKraft.FillDots(T2or3d:string;
                StepX,StepY,StepZ,
                LimStepX,LImStepY,limStepZ:real;randm:boolean);
label without_inc,without_inc2;
var i,zz,yy,xx,zm,ym,xm:integer;
    x,y,z,c_sqr,r_sqr:real;
begin
  i:=0;
  randomize;

  x:=-limStepX;
  y:=-limStepY;
  z:=0;
  zm:=Main.Control.plim_z;
  ym:=Main.Control.plim_y;
  xm:=Main.Control.plim_x;

 if not randm then
  while i <= coldots-1 do
  begin
//--------------------------
     for zz:=0 to zm-1 do
       for yy:=0 to ym-1 do
         for xx:=0 to xm-1 do
//         showmessage('for');
         if Main.Control.grid[xx,yy,zz] <> nil then
//          if arrbil[xx,yy,zz] then continue else
//           if (xx= xi) and (yy=yi) and (zz=zi)  then continue else
//            if (xx= last_x) and (last_y=yi) and (last_z=zi)  then continue else
             begin

                c_sqr:=Main.Control.csqr(x,
                        Main.Control.grid[xx,yy,zz].x,
                        y,
                        Main.Control.grid[xx,yy,zz].y,
                        z,
                        Main.Control.grid[xx,yy,zz].z
                        );
                                         // квадрат суммы радисуов двух bliz лижащих частиц
              r_sqr:=sqr(Main.Control.grid[xx,yy,zz].radius);


                                         //po x
              if c_sqr <= r_sqr then      //если залазят на друг др.
              begin
//  showmessage('c='+floatToStr(c_sqr)+ '; r=' +floatToStr(r_sqr));
                goto without_inc;
                break;
              end;
             end;

//---------------
    {  if T2or3d<>C2d then
      begin
      if (x < Main.Control.plim_x) and ( x >= 0) and
          (y < Main.Control.plim_y) and (y >= 0) and
          (z < Main.Control.plim_z) and (z >= 0) then
          goto without_inc;

      end
      else
      begin
      if (x < Main.Control.plim_x) and (x >= 0 ) and
          (y < Main.Control.plim_y) and (y >= 0) then
            goto without_inc;
      end; }

        DOts[i].x:=x;
        DOts[i].y:=y;
        if T2or3d<>C2d then
         DOts[i].z:=z else
          DOts[i].z:=0;



      inc(i);
    without_inc:
        x:=x+stepX;
        if x >= limStepX*2 then
        begin
              x:=-limStepX;
              y:=y+STepY;
              if y >= limStepY*2 then
              begin

                 if T2or3d=C2d then
                 begin
                      showmessage('Pik, y='+floatToStr(y)+' >= limSTepY*2='+floatToStr(limStepY*2));
                      LimStepX:=LimStepX+1;
                      LimStepY:=LimStepY+1;

                 end else
                           y:=-limStepY;
                 if T2or3d<>C2d then
                 begin
                    z:=z+stepZ;
                    if z >= limStepZ*2 then
                    begin
    //                  showmessage('Pik!!, z='+floatToStr(z)+' >= limSTepZ*2='+floatToStr(limStepZ*2));
                      LimStepX:=LimStepX+1;
                      LimStepY:=LimStepY+1;
                      LimStepX:=LimStepX+1;
                      LimStepZ:=LimStepZ+1;


    //                  break;
                    end; //> lim
                 end; // <> C2d
              end;  //y >limy



        end;

  end else
  begin
  randomize;
    while i <= coldots-1 do
    begin
//--------------------------
     for zz:=0 to zm-1 do
       for yy:=0 to ym-1 do
         for xx:=0 to xm-1 do
         if Main.Control.grid[xx,yy,zz] <> nil then
//          if arrbil[xx,yy,zz] then continue else
//           if (xx= xi) and (yy=yi) and (zz=zi)  then continue else
//            if (xx= last_x) and (last_y=yi) and (last_z=zi)  then continue else
             begin

                c_sqr:=Main.Control.csqr(x,
                        Main.Control.grid[xx,yy,zz].x,
                        y,
                        Main.Control.grid[xx,yy,zz].y,
                        z,
                        Main.Control.grid[xx,yy,zz].z
                        );
                                         // квадрат суммы радисуов двух bliz лижащих частиц
              r_sqr:=sqr(Main.Control.grid[xx,yy,zz].radius);




                                         //po x
              if c_sqr <= r_sqr then      //если залазят на друг др.
              begin

//  showmessage('c='+floatToStr(c_sqr)+ '; r=' +floatToStr(r_sqr));
                goto without_inc2;
                break;
              end;
             end;

//---------------
     {
      if T2or3d<>C2d then
      begin
      if (x < Main.Control.plim_x) and ( x >= 0) and
          (y < Main.Control.plim_y) and (y >= 0) and
          (z < Main.Control.plim_z) and (z >= 0) then
          goto without_inc2;

      end
      else
      begin
      if (x < Main.Control.plim_x) and (x >= 0 ) and
          (y < Main.Control.plim_y) and (y >= 0) then
            goto without_inc2;
      end;    }

       DOts[i].x:=x;
       DOts[i].y:=y;
       if T2or3d<>C2d then DOts[i].z:=z else  DOts[i].z:=0;



      inc(i);
 without_inc2:
     if random(100) mod 2 = 0 then
      x:=random(trunc(Main.Control.plim_x+LimStepX-1))+random else
        x:=-random(trunc(Main.Control.plim_x+LimStepX/2-1))+random;
     if random(100) mod 2 = 0 then
      y:=random(trunc(Main.Control.plim_y+LimStepY-1))+random else
        y:=-random(trunc(Main.Control.plim_y+LimStepY/2-1))+random;
    if T2or3d<>C2d then
    begin
      if random(100) mod 2 = 0 then
       z:=random(trunc(Main.Control.plim_z+LimStepZ-1))+random else
        z:=-random(trunc(Main.Control.plim_z+LimStepZ*2-1))+random;
    end else z:=0;

    end;
  end;

end;
//-----------
procedure TfrmKraft.SetDotsKut(pcoldots:integer;Step,kutxy,kutxz:real);
begin
  SetLength(Dots,pcoldots);
  SetLength(_2dKasatel,pcoldots);
  SetLength(_3dKasatel,pcoldots);
  coldots:=pcoldots;
  FillDotsKut(Step,kutxy,kutxz);
end;
//-------------------
procedure TfrmKraft.SetDots(pcoldots:integer;T2or3d:string;
                StepX,StepY,StepZ,LimStepX,LImStepY,limStepZ:real;randm:boolean);

begin
  SetLength(Dots,pcoldots);
  SetLength(_2dKasatel,pcoldots);
  SetLength(_3dKasatel,pcoldots);
  coldots:=pcoldots;

  fillDots(T2or3d,StepX,StepY,StepZ,LimStepX,LImStepY,limStepZ,randm);
end;
///---------------
procedure TfrmKraft.btnGo_KraftClick(Sender: TObject);
begin

 memKrafts.Clear;
 SetDots(strToInt(eColDots.text),C3d,//StrToInt(elim_dots.Text),
                                StrToFloat(eStepX.text),
                                StrToFloat(eStepY.text),
                                StrToFloat(eStepZ.text),
                                StrToFloat(eLimStepX.text),
                                StrToFloat(eLimStepY.text),
                                StrToFloat(eLimStepZ.text),cbRandom.Checked);

 with frmMain do
 begin
         SetMu_Ro(StrToFloat(eMu.Text),StrToFloat(eRo.Text));
         GOkraftNew(Main.control,frmKraft.progress,memKrafts,colDots,dots);
 end;

end;



procedure TfrmKraft.btnPaintClick(Sender: TObject);
begin
  close;
  frmMain.PaintDots(dots,frmMain.progress,colDOts,StrToFloat(eChange.text));

end;

procedure TfrmKraft.btnGo_kraft2dClick(Sender: TObject);
begin
 if cbNumPlane.text='' then
 begin
   showmessage('Необходимо выбрать № площадки для 2D!'); 
   exit;
 end;
 memKrafts.Clear;
 SetDots(strToInt(eColDots.text),C2d,
                                StrToFloat(eStepX.text),
                                StrToFloat(eStepY.text),
                                StrToFloat(eStepZ.text),
                                StrToFloat(eLimStepX.text),
                                StrToFloat(eLimStepY.text),
                                StrToFloat(eLimStepZ.text),cbRandom.Checked);

 with frmMain do
 begin
         SetMu_Ro(StrToFloat(eMu.Text),StrToFloat(eRo.Text));
         GOkraft2d(Main.control,frmKraft.progress,StrToInt(cbNumPlane.text)-1,memKrafts,colDots,dots);
 end;

end;
//++++++++++++++++++++++++++++++++++++++++++++
procedure TfrmKraft.FormActivate(Sender: TObject);
var i:integer;
begin
 cbNumPlane.Clear;
 for i:=0 to Main.Control.NPlane-1 do
 cbNumPlane.Items.Add(intToStr(i+1));
 cbNumPlane.ItemIndex:=2;
 eLimSTepX.Text:=intToStr(Main.control.plim_x);
 eLimSTepY.Text:=intToStr(Main.control.plim_x);
 eLimSTepZ.Text:=intToStr(Main.control.plim_x);
end;

procedure TfrmKraft.sbKasatel2dClick(Sender: TObject);
begin

// memKrafts.Clear;
 Fill_2d_Kasatel(StrToFloat(eLenKasatel.text));
 close;
 frmMain.Paint_2d_Kasatel(col_2d_Kasatel,_2dKasatel);

end;

procedure TfrmKraft.btnPaintLiteriClick(Sender: TObject);
begin
 close;
 frmMain.PaintLiteri(colDots,Dots);

end;

procedure TfrmKraft.btnPaintPOleClick(Sender: TObject);
begin
 close;
 frmMain.Paint2dPole;
end;

procedure TfrmKraft.sbKasatel3dClick(Sender: TObject);
begin
 Fill_3d_Kasatel(StrToFloat(eLenKasatel.text));
 close;
 frmMain.Paint_3d_Kasatel(col_3d_Kasatel,_3dKasatel);
end;

procedure TfrmKraft.btnPaintPole3dClick(Sender: TObject);
begin
 close;
 frmMain.Paint3dPole;

end;

procedure TfrmKraft.btnExportToMemClick(Sender: TObject);
var iDot,j:integer;
   skraft,sr:string;

   cx,cy,cz:real;
   R:real;
begin
   cx:=Main.Control.plim_x/2;
   cy:=Main.Control.plim_y/2;
   cz:=Main.Control.plim_z/2;
   frmMemKrafts.SetArrsLen(colDots);
   with frmmemKrafts do
   for iDot:=0 to colDots-1 do
   begin
//    str(DOts[idot].kraft:2:3,skraft);
    arrKrafts[idot].value:=DOts[idot].kraft;
    arrKrafts[idot].idot:=idot;    
//    memKrafts.Lines.Add(intToStr(idot)+'= '+skraft);
    r:=sqrt(sqr(DOts[idot].x-cx)+
            sqr(DOts[idot].y-cy)+
            sqr(DOts[idot].z-cz)
                );
//    str(r:2:3,sr);
//    memDistance.Lines.Add(sr);
    arrDistances[idot].value:=r;
    arrDistances[idot].idot:=idot;    
   end;
frmMemKrafts.btnShow.click;
frmMemKrafts.Show;
end;

procedure TfrmKraft.btnKut3dClick(Sender: TObject);
var kutXY,kutXZ:real;
begin

 memKrafts.Clear;
 kutXY:=pi*StrToFloat(eKutXY.text)/180;
 kutXz:=pi*StrToFloat(eKutXz.text)/180;


 SetDotsKut(strToInt(eColDots.text),StrToFloat(eStepKut.text),kutXY,kutxz);
 with frmMain do
 begin
         SetMu_Ro(StrToFloat(eMu.Text),StrToFloat(eRo.Text));
         GOkraftNew(Main.control,frmKraft.progress,memKrafts,colDots,dots);
 end;

end;

end.
