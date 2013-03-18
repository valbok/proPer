unit unControl;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,Gauges,
  ExtCtrls, ComCtrls, StdCtrls,  OpenGL, Menus,  Buttons,unCorpuskul
  ;
type kvaziCorp =record
        x,y:real;
        radius:real;
        end;
type TarrinKlaster = record
         x,y,z:integer;
        end;
type _3d= array of array of array of TCorpuskul;
type _3dbool= array of array of array of boolean;
type _2dkc= array of array of kvaziCorp;
type Tplane= array of _2dkc;
type TColMolPlane= array of integer;
//type TPalletka= array of array of array of kvazi
type
  TControl = class
  private
    _grid               :_3d;
    _arr_plane          :TPlane;
    _arr_plane_exist    :boolean;
    arrbil              :_3dbool;
    lim_x,lim_y,lim_z   :integer;
    ln_x,ln_y,ln_z      :integer;
    _grid_exists         :boolean;

    step                :real;
    _step_plane         :real;
    _colMol_Plane       :TCOlMolPlane;                  //в каждой, плайн
    _colMol             :integer;
    _colRes             :integer;
    _otkazov            :integer;
    _glubina            :integer;
    _N                  :Integer;                 //col iteracij
    _ni                 :integer;
    _NPlane             :integer;               //col planes
    { Private declarations }
    procedure check_Susid(var Corpuskul:TCorpuskul;xi,yi,zi:integer;

                                 over: boolean);
    procedure Set000(var x:real);


    procedure fill_arr_Plane(var progress:TGauge;pklaster:boolean);
    procedure create_arr_Plane(radius: real);
    procedure create_arr_Palletka(n: real);

  public
    arrInklaster:array of TarrinKlaster;
    function csqr(x1,x2,y1,y2,z1,z2:real):real;

    constructor create;//(x,y,z:integer);
    destructor destroy; override;
    procedure set_grid(lx,ly,lz:integer;lNx,lny,lnz:integer);
    procedure set_grid_property(value:_3d);

    procedure RunPlane(radius: real; var progress:TGauge; pklaster:boolean);
    procedure RunPalletka(n: real; var resN:integer; var Progress:TGauge);

    property step_plane:real read     _step_plane;
    property NPlane:integer read _NPlane;
    property plim_z:integer read  lim_z;
    property plim_x:integer read  lim_x;
    property plim_y:integer read  lim_y;

    property ni:integer read     _ni;
    property grid:_3d read _grid;// write set_grid_property;
    property arr_plane: Tplane read _arr_plane;
    property arr_plane_exist    :boolean read _arr_plane_exist;
    property colMol:integer read _colMol;
    property colMol_Plane:TColMolPlane read _colMol_Plane;
    property colRes:integer read _colRes;
    property otkazov:integer read _otkazov;
    property glubina:integer read     _glubina;
    property grid_exists:boolean read     _grid_exists;
    procedure RunRandomize(radius:real;var progress:TGauge;
                    over:boolean; var EN:TEDit;
                    var StatusBar:TStatusBar;
                    pcolmol:integer
                     );
    procedure RunRandomize2(radius:real; var progress:TGauge;
                over:boolean
                 );
   function  FindPer(var Corpuskul:TCorpuskul;
                        xi,yi,zi,xm,ym,zm,last_x,last_y,last_z: integer;
                                                   var StatusBar:TStatusBar ): boolean;


    function ZamenaDotNakoma(st :string):string;

    { Public declarations }
  end;

implementation
//-----------------
procedure TControl.set_grid_property(value:_3d);
begin
        _grid:=value;
end;
//-----------
procedure TControl.set_grid(lx,ly,lz:integer;lNx,lny,lnz:integer);
begin
   try

     if _grid_exists then
       _grid:=nil;

       SetLength(_grid,lnx,lny,lnz);

       _grid_exists:=true;
       lim_x:=lx;
       lim_y:=ly;
       lim_z:=lz;
       ln_x:=lnx;
       ln_y:=lny;
       ln_z:=lnz;
   except
       _grid_exists:=false;
   end;
end;
//---------------------
constructor TControl.create;
begin
       inherited Create;
       _arr_plane_exist:=false;
end;
///--------
destructor Tcontrol.destroy;
var     x,y,z:integer;
begin
   try
        for x:=0 to lim_x-1 do
         for y:=0 to lim_y-1 do
           for z:=0 to lim_z-1 do
             _grid[x,y,z].Free;

        _grid:=nil;
   except

    end;
        inherited destroy;
end;
//----------
function TControl.csqr(x1,x2,y1,y2,z1,z2:real):real;
begin
   result:=sqr(x1 - x2) + sqr(y1 - y2) + sqr(z1 - z2);
end;
//---------
procedure TControl.Set000(var x:real);
var tmp: string;
begin
                str(x:2:2,tmp);
                try
                     x:=StrToFloat(ZamenaDotNakoma(tmp));
                except
                    x:=StrToFloat(tmp);
                end;
end;
//-----------------------
function  Tcontrol.FindPer(var Corpuskul:TCorpuskul;
                        xi,yi,zi,xm,ym,zm,last_x,last_y,last_z: integer;
                                                   var StatusBar:TStatusBar  ): boolean;
var xx,yy,zz,g: integer;
        //xi yi zi current pos Corpuskula
    c_sqr,r_sqr:real;

begin
  With Corpuskul do
  begin

     result:=false;
                             //находим выход
     if Corpuskul.x >= lim_x - Corpuskul.Radius then
     begin
       StatusBar.Panels[0].Text:='Бесконечный кластер найден!';
       StatusBar.Panels[1].Text:='Глубина='+intToStr(Glubina+1);
       StatusBar.Refresh;
       result:=true;
       inc(_ColRes);
       g:=0;
       _grid[xi,yi,zi].inklaster:=true;
{       arrInKlaster[_glubina].x:=xi;
       arrInKlaster[_glubina].y:=yi;
       arrInKlaster[_glubina].z:=zi;  }

       arrbil[xi,yi,zi]:=true;
       for zz:=0 to zm do
        for yy:=0 to ym do
          for xx:=0 to xm do
          begin
 //         showmessage('in for');
           if arrbil[xx,yy,zz] then
           begin
               arrInKlaster[g].x:=xx;
               arrInKlaster[g].y:=yy;
               arrInKlaster[g].z:=zz;
               inc(g);
           end;
         end;

       exit;
     end;
//-------
     for zz:=0 to zm do
       for yy:=0 to ym do
         for xx:=0 to xm do
         if _grid[xx,yy,zz] <> nil then
          if arrbil[xx,yy,zz] then continue else
           if (xx= xi) and (yy=yi) and (zz=zi)  then continue else
            if (xi= last_x) and (last_y=yi) and (last_z=zi)  then continue else
             begin

                c_sqr:=csqr(Corpuskul.x,
                        _grid[xx,yy,zz].x,
                        Corpuskul.y,
                        _grid[xx,yy,zz].y,
                        Corpuskul.z,
                        _grid[xx,yy,zz].z
                        );
                                         // квадрат суммы радисуов двух bliz лижащих частиц
              r_sqr:=sqr(Corpuskul.radius+_grid[xx,yy,zz].radius);
                                         //po x
              if c_sqr <= r_sqr then      //если залазят на друг др.
              begin
                 inc(_glubina);
//                showmessage('Glub='+intToSTr(_glubina));

                 arrbil[xi,yi,zi]:=true;

                 _grid[xi,yi,zi].inklaster:=true;
{                 arrInKlaster[_glubina].x:=xi;
                 arrInKlaster[_glubina].y:=yi;      //?????????
                 arrInKlaster[_glubina].z:=zi; }
                if FindPer(_grid[xx,yy,zz],
                        xx,yy,zz,xm,ym,zm,xi,yi,zi, StatusBar) then
                        begin
//                                StatusBar.Panels[1].Text:='Возврат... Глубина='+intToStr(Glubina+1);
//                                StatusBar.Refresh;

                                result:=true;
//                 arrInKlaster[_glubina].x:=xi;
//                 arrInKlaster[_glubina].y:=yi;      //?????????
//                 arrInKlaster[_glubina].z:=zi;
                                
                                exit;

                        end;
                _grid[xi,yi,zi].inklaster:=false;
                dec(_glubina);
              end;
             end;

  end;

end;
//-------------
procedure  Tcontrol.check_Susid(var Corpuskul:TCorpuskul;
                                 xi,yi,zi:integer;
                                 over: boolean
                                 );
label   next,
        nnext,
        CheckAgain;
var     xx,yy,zz,tx,ty,tz:integer;
        c_sqr,r_sqr:real;
        tmp:string;
        tmp_x,tmp_y,tmp_z:real;
        sinfy,sinfz,b,a,d:real;
begin
  if (Corpuskul = nil) then exit;
  with Corpuskul do
  begin
          //check limit oX oY oZ
          //check for null_less
    if x-radius < 0 then x:=radius;
    if y-radius < 0 then y:=radius;
    if z-radius < 0 then z:=radius;
          //... limit x,y,z
    if x+radius > lim_x then x:=lim_x-radius;
    if y+radius > lim_y then y:=lim_y-radius;
    if z+radius > lim_z then z:=lim_z-radius; 

    if over then exit;
    tz:=-1;
    ty:=-1;
    tx:=-1;

//    randomize;
CheckAgain:
    for zz:=0 to zi do  //zi,yi,xi current pos Corpuskul
      for yy:=0 to yi do
        for xx:=0 to xi do
         begin
                if (zz=zi) and (yy=yi) and (xx=xi) then //чтоб себя не сравнивал
                begin
                        break;
                end;
                    if
                   (_grid[xx,yy,zz] = nil)
                                then continue;
                if (zz=tz) and (yy=ty) and (xx=tx) then //чтоб  не сравнивал c которым уже сравнивал
                        break;
                                        //вычисление расстояния по радиусу между молекулами
                c_sqr:=csqr(Corpuskul.x,
                        _grid[xx,yy,zz].x,
                        Corpuskul.y,
                        _grid[xx,yy,zz].y,
                        Corpuskul.z,
                        _grid[xx,yy,zz].z
                        );
                                         // квадрат суммы радисуов двух bliz лижащих частиц
             r_sqr:=sqr(Corpuskul.radius+_grid[xx,yy,zz].radius);
                                         //po x
             if c_sqr < r_sqr then      //если залазят на друг др.
             begin

              b:=abs(y - _grid[xx,yy,zz].y);
              sinfy:=b/c_sqr;
                   //   Set000(sinfy);
              b:=sinfy* (Corpuskul.radius+_grid[xx,yy,zz].radius);

              d:=abs(z - _grid[xx,yy,zz].z);
              sinfz:=d/c_sqr;
                     // Set000(sinfz);
              d:=sinfz* (radius+_grid[xx,yy,zz].radius);

              a:=sqrt(  abs(
                        sqr(radius+_grid[xx,yy,zz].radius)
                        -sqr(b)
                        -sqr(d))
                        );
              if _grid[xx,yy,zz].y > y then
                _grid[xx,yy,zz].y:=y+b else
                _grid[xx,yy,zz].y:=y-b;
              if _grid[xx,yy,zz].x > x then
                _grid[xx,yy,zz].x:=x+a else
                _grid[xx,yy,zz].x:=x-a;
               if _grid[xx,yy,zz].z > z then
                _grid[xx,yy,zz].z:=z+d else
                _grid[xx,yy,zz].z:=z-d;

{              tmp_x:=_grid[xx,yy,zz].x;
              tmp_y:=_grid[xx,yy,zz].y;
              tmp_z:=_grid[xx,yy,zz].z;
              Set000(tmp_x);
              Set000(tmp_y);
              Set000(tmp_z);
              _grid[xx,yy,zz].x:=tmp_x;
              _grid[xx,yy,zz].y:=tmp_y;
              _grid[xx,yy,zz].z:=tmp_z;}



               c_sqr:=(csqr(x,
                        _grid[xx,yy,zz].x,
                          y,
                        _grid[xx,yy,zz].y,
                        z,
                        _grid[xx,yy,zz].z
                        ));
                                         // квадрат суммы радисуов двух bliz лижащих частиц
             r_sqr:=sqr(radius+_grid[xx,yy,zz].radius);
            if c_sqr < r_sqr
             then
             begin
//                     showmessage('C='+floatToStr(c_sqr));
//                     showmessage('r='+floatToStr(r_sqr));
             end;
//               fuck off nigger????????????????
              {  if x > _grid[xx,yy,zz].x then
                _grid[xx,yy,zz].x:= x - sqrt(
                                        abs(
                                                sqr(_grid[xx,yy,zz].radius+Radius)
                                                -
                                                sqr(_grid[xx,yy,zz].y-y)
                                                -
                                                sqr(_grid[xx,yy,zz].z-z)
                                             ))
                else
                _grid[xx,yy,zz].x:= x + sqrt(
                        abs(
                                sqr(_grid[xx,yy,zz].radius+Radius)
                                -
                                sqr(_grid[xx,yy,zz].y-y)
                                -
                                sqr(_grid[xx,yy,zz].z-z)
                             ));
                str(_grid[xx,yy,zz].x:2:2,tmp);
                try
                     _grid[xx,yy,zz].x:=StrToFloat(ZamenaDotNakoma(tmp));
                except
                    _grid[xx,yy,zz].x:=StrToFloat(tmp);
                end;


                check_Susid(_grid[xx,yy,zz],
                                 xx,yy,zz,
                                 over
                                 );  }


              {
                _grid[xx,yy,zz].z:=
                                (_grid[xx,yy,zz].z-
                                _grid[xx,yy,zz].radius+Radius)
                                          + random(
                                                trunc(
                                                      2*(_grid[xx,yy,zz].radius+Radius)
                                                   //  -_grid[xx,yy,zz].radius
                                                   ));//+_grid[xx,yy,zz].radius;

                _grid[xx,yy,zz].y:=
                                _grid[xx,yy,zz].y-
                                _grid[xx,yy,zz].radius+Radius
                                          + random(
                                                trunc(
                                                      2*(_grid[xx,yy,zz].radius+Radius)
                                                     // -_grid[xx,yy,zz].radius
                                                     )
                                                   );//+_grid[xx,yy,zz].radius;
             str(_grid[xx,yy,zz].z:2:2,tmp);
             try
                    _grid[xx,yy,zz].z:=StrToFloat(ZamenaDotNakoma(tmp));
             except
                    _grid[xx,yy,zz].z:=StrToFloat(tmp);
             end;
             str(_grid[xx,yy,zz].y:2:2,tmp);
             try
                    _grid[xx,yy,zz].y:=StrToFloat(ZamenaDotNakoma(tmp));
             except
                    _grid[xx,yy,zz].y:=StrToFloat(tmp);
             end;

                if _grid[xx,yy,zz].x > x then
                      _grid[xx,yy,zz].x:=sqrt(
                                abs(
                                sqr(_grid[xx,yy,zz].radius +Radius)-
                                sqr(_grid[xx,yy,zz].y-y)-
                                sqr(_grid[xx,yy,zz].z-z)
                                )
                                )+ x
                else
                        _grid[xx,yy,zz].x:=sqrt(
                                abs(
                                sqr(_grid[xx,yy,zz].radius +Radius)-
                                sqr(_grid[xx,yy,zz].y)-
                                sqr(_grid[xx,yy,zz].z)
                                )
                                )-x;


                str(_grid[xx,yy,zz].x:2:2,tmp);
                try
                     _grid[xx,yy,zz].x:=StrToFloat(ZamenaDotNakoma(tmp));
                except
                    _grid[xx,yy,zz].x:=StrToFloat(tmp);
                end;
                if (_grid[xx,yy,zz].x > lim_x-_grid[xx,yy,zz].radius) then
                        (_grid[xx,yy,zz].x:=lim_x-_grid[xx,yy,zz].radius);
                {if (_grid[xx,yy,zz].x > lim_x-_grid[xx,yy,zz].radius)
                        or
                   (_grid[xx,yy,zz].y > lim_y-_grid[xx,yy,zz].radius)
                        or
                   (_grid[xx,yy,zz].z > lim_z-_grid[xx,yy,zz].radius)
                   then
                   _grid[xx,yy,zz].Free
                else}

                check_Susid(_grid[xx,yy,zz],
                                 xx,yy,zz,
                                 over
                                 );


//                  exit;

             end;
{        if c_sqr < r_sqr then
        begin
                Corpuskul.Free;
                inc(_otkazov);
                exit;
        end; }
        goto nnext;
next:
        begin
            tx:=xx;             //????
            ty:=yy;
            tz:=zz;
           goto CheckAgain;
        end;

nnext:
        end;

end;
end;
//------------------------
procedure TControl.RunRandomize(radius:real;var progress:TGauge;
                over:boolean; var EN:TEDIT;
                var StatusBar:TStatusBar;
                pcolmol:integer
                 );
                        //N is col round
                label lcMOl;
var     x,y,z,c_sqr,r_sqr:real;
        xi,yi,zi,xi2,yi2,zi2,colnakl,
        zz,yy,xx:integer;
        tmp:string;
        res:boolean;            //if claster was finded
begin

        if not _grid_exists then exit;
        if (lim_X=0) or (lim_y=0) or (lim_z=0) then exit;
        randomize;
        _ni:=0;
        xi:=0;
        yi:=0;
        zi:=0;
//        step:=pstep;
        res:=false;
//        _N:=Np;
        _colMol:=0;
        _otkazov:=0;
        _colres:=0;
        colnakl:=0;
        _glubina:=0;
        arrbil:=nil;
        if ln_x <  lim_x then ln_x:=lim_x;
        if ln_y <  lim_y then ln_y:=lim_y;
        if ln_z <  lim_z then ln_z:=lim_z;
        statusBar.Panels[0].Text:='Поиск бесконечного кластера...';
        StatusBar.Refresh;
        setLength(arrbil,ln_x,ln_y,ln_z);

        setlength(arrInKlaster,ln_x*ln_y*ln_z);
        while not res do
        begin
                        //create random x,y,z
                    x:=random+random(lim_x)+0.0000001;


                    y:=random+random(lim_y)+0.0000001;


                    z:=random+random(lim_z)+0.0000001;


             _grid[xi,yi,zi]:=TCorpuskul.Create;
             _grid[xi,yi,zi].radius:=radius;
             _grid[xi,yi,zi].x:=x;
             _grid[xi,yi,zi].y:=y;
             _grid[xi,yi,zi].z:=z;


                                //xi,yi,zi - pos corp in massive
             check_susid(_grid[xi,yi,zi],xi,yi,zi,Over);     // main proc
             if _ni >= pcolmol then
//             if _ni* radius*2 >= lim_x-1 then
     //поиск первого
             for zz:=0 to zi do
               for yy:=0 to yi do
                 for xx:=0 to xi do
                  if _grid[xx,yy,zz] <> nil then
                  if _grid[xx,yy,zz].x = _grid[xx,yy,zz].radius then
                    begin
                       if findPEr(_grid[xx,yy,zz],xx,yy,zz,xi,yi,zi,0,0,0,statusBar) then
                       begin
                        res:=true;
                        messageDLG('Бесконечный кластер найден!'+#13#10+
                                        'N = '+intToStr(ni+1)+';'+#13#10+
                                        'Глубина = '+IntToStr(_Glubina+1),mtInformation,[mbOk],0);
                       goto lcMOl;
                       end;{ else
                       begin
                           StatusBar.Panels[0].Text:='Бесконечный кластер не найден!';
                           StatusBar.Panels[1].Text:='';
                           StatusBar.Refresh;
                       end;}

                        arrbil:=nil;
                        setLength(arrbil,ln_x,ln_y,ln_z);

                    end;


             inc(xi);
             if xi > ln_x-1 then
             begin
                xi:=0;
                inc(yi);
                if yi> ln_y-1 then
                begin
                        yi:=0;
                        inc(zi);
                        if zi>ln_z-1 then
                        begin
                                
                                break;
                        end;


                end;

             end;
        progress.Progress:=trunc(zi*100/(ln_z-1));

        inc(_ni);
        eN.text:=IntToStr(_ni+1);
        eN.Update;


        end;
        progress.Progress:=100;
        statusBar.Panels[0].Text:='Бесконечный кластер НЕ найден!!';
        StatusBar.Panels[1].Text:='';
lcMOl:
//------------------------------------- Подсчёт молекул
    for zi:=0 to Ln_z-1 do
      for yi:=0 to ln_y-1 do
        for xi:=0 to ln_x-1 do
         begin
            if _grid[xi,yi,zi] <> nil then
              inc(_colmOl);
              progress.Progress:=trunc(zi*100/lim_z);
         end;
     progress.Progress:=100;

      //поиск первого

     exit;


//-- проверка есть ли молекулы с повторяющимся координатами
    for zi:=0 to lim_z-1 do
      for yi:=0 to lim_y-1 do
       for xi:=0 to lim_x-1 do
         begin
            if _grid[xi,yi,zi] <> nil then
               for zi2:=0 to Lim_z-1 do
                 for yi2:=0 to lim_y-1 do
                   for xi2:=0 to lim_x-1 do
                   begin
                    if _grid[xi2,yi2,zi2] <> nil then
                    if (xi<>xi2) and (yi<>yi2) and (zi<>zi2) then
                      if (_grid[xi,yi,zi].x =_grid[xi2,yi2,zi2].x) and
                              (_grid[xi,yi,zi].y =_grid[xi2,yi2,zi2].y) and
                              (_grid[xi,yi,zi].z =_grid[xi2,yi2,zi2].z)
                       then
                      showmessage('Povtor x='+FloatToStr(_grid[xi,yi,zi].x)+#13#10+
                                   'xi='+intToStr(xi)+#13#10+
                                   'yi='+intToStr(yi)+#13#10+
                                   'zi='+intToStr(zi)+#13#10);

                   end;
              progress.Progress:=trunc(zi*100/lim_z);
         end;
     progress.Progress:=100;

//-- проверка есть li накладывание
    for zi:=0 to lim_z-1 do
      for yi:=0 to lim_y-1 do
       for xi:=0 to lim_x-1 do
         begin
            if _grid[xi,yi,zi] <> nil then
               for zi2:=0 to Lim_z-1 do
                 for yi2:=0 to lim_y-1 do
                   for xi2:=0 to lim_x-1 do
                      begin
                    if (xi<>xi2) and (yi<>yi2) and (zi<>zi2) then
                       if _grid[xi2,yi2,zi2] <> nil then
                       begin
                      c_sqr:=csqr(_grid[xi2,yi2,zi2].x,
                        _grid[xi,yi,zi].x,
                        _grid[xi2,yi2,zi2].y,
                        _grid[xi,yi,zi].y,
                        _grid[xi2,yi2,zi2].z,
                        _grid[xi,yi,zi].z
                        );
                                         // квадрат суммы радисуов двух bliz лижащих частиц
              r_sqr:=sqr(_grid[xi2,yi2,zi2].radius+_grid[xi,yi,zi].radius);
              if c_sqr < r_sqr then      //если залазят на друг др.
              begin
               inc(colNakl);
           //    check_susid(_grid[xi2,yi2,zi2],xi,yi,zi,Over);     // main proc
              end;

             end;
              progress.Progress:=trunc(zi*100/lim_z);
              end;
         end;
     progress.Progress:=100;
     showmessage('Nakl='+intToStr(trunc(colnakl/2)));

end;
procedure TControl.fill_arr_Plane(var progress:TGauge;pklaster:boolean);
var  xi,yi,zi,ii   :integer;
        s:real;
begin
   s:=0;//step_plane;
   ii:=0;
   while ii<= _NPlane-1 do  /// look on plane
   begin

    for zi:=0 to ln_z-1 do
      for yi:=0 to ln_y-1 do
       for xi:=0 to ln_x-1 do

       begin
         if _grid[xi,yi,zi] <> nil then
         if (_grid[xi,yi,zi].inklaster) then
         begin
//          if pklaster then
           begin

              if abs(_grid[xi,yi,zi].z- s) < _grid[xi,yi,zi].radius  then
              begin
                 _arr_plane[ii][xi,yi].x:=_grid[xi,yi,zi].x;
                 _arr_plane[ii][xi,yi].y:=_grid[xi,yi,zi].y;
                 _arr_plane[ii][xi,yi].radius:=sqrt(abs(
                                            sqr(_grid[xi,yi,zi].radius)-
                                            sqr(_grid[xi,yi,zi].z
                                                    -s
                                                    )

                                            ));
    //             showmessage(floatToStr(_arr_plane[ii][xi,yi].radius));
                 inc(_colMol_Plane[ii]);
              end;
          end;{ else
              if abs(_grid[xi,yi,zi].z- s) < _grid[xi,yi,zi].radius  then
              begin
                 _arr_plane[ii][xi,yi].x:=_grid[xi,yi,zi].x;
                 _arr_plane[ii][xi,yi].y:=_grid[xi,yi,zi].y;
                 _arr_plane[ii][xi,yi].radius:=sqrt(abs(
                                            sqr(_grid[xi,yi,zi].radius)-
                                            sqr(_grid[xi,yi,zi].z
                                                    -s
                                                    )

                                            ));
    //             showmessage(floatToStr(_arr_plane[ii][xi,yi].radius));
                 inc(_colMol_Plane[ii]);
              end;}


          end;
         end;
    s:=s+step_plane;
//    if s> lim_z then exit;
    inc(ii);
    progress.Progress:=trunc(ii*100/_NPlane);
   end;
end;
//*************************
procedure TControl.RunPalletka(n: real;  var resN:integer; var Progress:TGauge);
label exitFor;
var ii,xi,yi,zi:integer;
    xp,yp,zp:real;
begin
   xp:=n;
   yp:=n;
   zp:=n;
 //  resN:=0;
 if n =0 then exit;
   while zp <= lim_z do
   begin
{    for zi:=0 to ln_z-1 do
      for yi:=0 to ln_y-1 do
       for xi:=0 to ln_x-1 do}
   for ii:=0 to _glubina do

       begin

         if _grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z] <> nil then
         if _grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].inklaster then
         begin
                       //------------kuti
{         with _grid[xi,yi,zi] do
         begin
            if x+xp > lim_x then continue;
            if x-xp < lim_x then continue;
            if y+yp > lim_y then continue;
            if y-yp < lim_y then continue;
            if z+zp > lim_z then continue;
            if z-zp < lim_z then continue;
         end;}

            if (abs(_grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].x - xp) < _grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].radius)  and
               (abs(_grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].y - yp) < _grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].radius) and
               (abs(_grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].z - zp) < _grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].radius)
               then
               begin
                 inc(resN);
                 goto exitFor;
//                 continue;
               end;

            if (abs(_grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].x - xp) < _grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].radius)  and
               (abs(_grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].y - yp) < _grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].radius) and
               (abs(_grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].z - zp-n) < _grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].radius)
               then
               begin
                 inc(resN);
                 goto exitFor;
//                 continue;
               end;

             if (abs(_grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].x - xp) < _grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].radius)  and
               (abs(_grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].y - yp-n) < _grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].radius) and
               (abs(_grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].z - zp) < _grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].radius)
               then
               begin
                 inc(resN);
                 goto exitFor;
//                 continue;
               end;

             if (abs(_grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].x - xp) < _grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].radius)  and
               (abs(_grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].y - yp-n) < _grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].radius) and
               (abs(_grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].z - zp-n) < _grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].radius)
               then
               begin
                 inc(resN);
                 goto exitFor;
//                 continue;
               end;

            if (abs(_grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].x - xp-n) < _grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].radius)  and
               (abs(_grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].y - yp) < _grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].radius) and
               (abs(_grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].z - zp) < _grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].radius)
               then
               begin
                 inc(resN);
                 goto exitFor;
//                 continue;
               end;

            if (abs(_grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].x - xp-n) < _grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].radius)  and
               (abs(_grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].y - yp) < _grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].radius) and
               (abs(_grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].z - zp-n) < _grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].radius)
               then
               begin
                 inc(resN);
                 goto exitFor;
//                 continue;
               end;

             if (abs(_grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].x - xp-n) < _grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].radius)  and
               (abs(_grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].y - yp-n) < _grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].radius) and
               (abs(_grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].z - zp) < _grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].radius)
               then
               begin
                 inc(resN);
                 goto exitFor;
//                 continue;
               end;

            if (abs(_grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].x - xp-n) < _grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].radius)  and
               (abs(_grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].y - yp-n) < _grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].radius) and
               (abs(_grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].z - zp-n) < _grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].radius)
               then
               begin
                 inc(resN);
                 goto exitFor;
//                 continue;
               end;
                        //--------------------- end kuti
                        // storoni
            if (_grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].x < xp) and
               (_grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].x > xp-n) then
            if (abs(_grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].y - yp) < _grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].radius) and
               (abs(_grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].z - zp) < _grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].radius)
               then
               begin
                 inc(resN);
                 goto exitFor;
//                 continue;
               end;

            if (_grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].y < yp) and
               (_grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].y > yp-n) then
            if (abs(_grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].x - xp) < _grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].radius) and
               (abs(_grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].z - zp) < _grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].radius)
               then
               begin
                 inc(resN);
                 goto exitFor;
//                 continue;
               end;

            if (_grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].z < zp) and
               (_grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].z > zp-n) then
            if (abs(_grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].y - yp) < _grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].radius) and
               (abs(_grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].x - xp) < _grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].radius)
               then
               begin
                 inc(resN);
                 goto exitFor;
//                 continue;
               end;
                           //--end storoni
            if (_grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].x < xp) and
               (_grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].x > xp-n) and
               (_grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].y < yp) and
               (_grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].y > yp-n) and
               (_grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].z < zp) and
               (_grid[arrInklaster[ii].x,arrInklaster[ii].y,arrInklaster[ii].z].z > zp-n)
               then
               begin
                 inc(resN);
                 goto exitFor;
//                 continue;
               end;

         end;            // end <> nil
       end;             //end for

exitFor:
       xp:=xp+n;

       if xp > lim_x then
       begin
         xp:=0;
         yp:=yp+n;
//          showmessage('inc y='+floatToStr(yp));
         if yp > lim_y then
         begin
           yp:=0;
           zp:=zp+n;
//          showmessage('+++++++++++++++++++++++++++++++++++++++inc z='+ floatToStr(zp));
           if zp > lim_z then
           begin
            zp:=0;
            break;
           end;
         end;
       end;             //end if x
    progress.Progress:=trunc(zp*100/lim_z);
    end;                //end while
  progress.Progress:=100;
end;

//------------------------
procedure TControl.RunPlane(radius: real; var progress:TGauge;pklaster:boolean);
begin
     create_arr_Plane(radius);
     fill_arr_Plane(progress,pklaster);
end;
//
procedure TControl.create_arr_Palletka(n: real);
var r:real;
begin

   r:=lim_z/step_plane;

   _NPlane:=trunc(r);
   if _arr_plane_exist then
   begin
      _arr_plane:=nil;
      _ColMol_Plane:=nil;
   end;
   SetLength(_arr_plane,_NPlane,ln_x,ln_y);
   SetLength(_ColMol_Plane,_NPlane);
   _arr_plane_exist:=true;
//   _colMol_Plane:=0;
end;

//-------------------------------------
procedure TControl.create_arr_Plane(radius: real);
var r:real;
begin
   _step_plane:=2*radius/3;
   r:=lim_z/step_plane;

   _NPlane:=trunc(r);
   if _arr_plane_exist then
   begin
      _arr_plane:=nil;
      _ColMol_Plane:=nil;
   end;
   SetLength(_arr_plane,_NPlane,ln_x,ln_y);
   SetLength(_ColMol_Plane,_NPlane);
   _arr_plane_exist:=true;
//   _colMol_Plane:=0;
end;
//------------------------
procedure TControl.RunRandomize2(radius:real;var progress:TGauge;
                over:boolean
                 );
var     x,y,z,c_sqr,r_sqr:real;
        xi,yi,zi,xi2,yi2,zi2,ni,colnakl:integer;
        tmp:string;

begin
        if not _grid_exists then exit;
        if (lim_X=0) or (lim_y=0) or (lim_z=0) then exit;
        ni:=0;
        xi:=0;
        yi:=0;
        zi:=0;
//        while ni <= N-1 do
        begin

             x:=1;
             y:=1;
             z:=1;

             _grid[xi,yi,zi]:=TCorpuskul.Create;
             _grid[xi,yi,zi].radius:=radius;
             _grid[xi,yi,zi].x:=x;
             _grid[xi,yi,zi].y:=y;
             _grid[xi,yi,zi].z:=z;

             inc(xi);
             _grid[xi,yi,zi]:=TCorpuskul.Create;
             _grid[xi,yi,zi].radius:=radius;
             x:=1;
             y:=1;
             z:=3;
             _grid[xi,yi,zi].x:=x;
             _grid[xi,yi,zi].y:=y;
             _grid[xi,yi,zi].z:=z;

             inc(ni);
        end;



end;

function TControl.ZamenaDotNakoma(st :string):string;
var i: integer;
const  arr: set of char =['0'..'9','.'];
begin
     result:='';
     for i:=1 to length(st) do
     begin
      if not (st[i] in arr) then
        continue;


      if st[i]='.' then
         result:=result+',' else
           result:=result+st[i];
     end;
end;
end.

