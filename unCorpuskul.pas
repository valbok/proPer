unit unCorpuskul;

interface

type
  TCorpuskul = class
  private
     _radius:   real;                   //1..
     _x,_y,_z:     real;
     _inklaster:boolean;

    { Private declarations }
  public
         procedure set_radius(value: real);
         procedure set_x(value:real);
         procedure set_y(value:real);
         procedure set_z(value:real);
         procedure set_inklaster(value:boolean);
         constructor create;
         property radius:real read _radius  write set_radius;
         property x:real read _x write set_x;
         property y:real read _y write set_y;
         property z:real read _z write set_z;
         property inklaster:boolean read _inklaster write set_inklaster;
    { Public declarations }
  end;

implementation
constructor TCorpuskul.create;
begin
 inherited;
 _inklaster:=false;
end;
procedure TCorpuskul.set_radius(value: real);
begin
        _radius:=value;
end;
//
procedure Tcorpuskul.set_inklaster(value:boolean);
begin
 _inklaster:=value;
end;
procedure Tcorpuskul.set_x(value:real);
begin
 _x:=value;
end;
procedure Tcorpuskul.set_y(value:real);
begin
 _y:=value;
end;
procedure Tcorpuskul.set_z(value:real);
begin
 _z:=value;
end;

end.
