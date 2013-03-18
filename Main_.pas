{***************************************************************}
{***     ПРИМЕР ГРАФИЧЕСКОГО РЕДАКТОРА НА ОСНОВЕ OpenGL      ***}
{***************************************************************}
{*** Редактор работает с объектами трех типов - параллепипед,***}
{*** сферический объект, цилиндрический объект.              ***}
{*** Всплывающее меню содержит пункты по работе с объектами. ***}
{*** Размещенный объект маркируется при щелчке на нем.       ***}
{*** Маркированный объект перемещается указателем мыши       ***}
{*** (при нажатом Ctrl - по оси Z). Маркеры используются для ***}
{*** изменения размеров объектов.                            ***}
{*** Enter - вывод окна параметров маркированного объекта.   ***}
{*** Home, End - переключение маркированного объекта.        ***}
{***************************************************************}
{*** Автор: Краснов М.В. softgl@chat.ru                      ***}
{*** при участии Осадчук А.В.                                ***}
{*** Нет никаких ограничений на использование данного кода.  ***}
{***************************************************************}

unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, ComCtrls, StdCtrls,  OpenGL, Menus, Splash, Buttons,unControl,unCorpuskul,
  Gauges;

const
  id_TEXT = 1000;
  XTEXT : PChar = 'X';
  YTEXT : PChar = 'Y';
  ZTEXT : PChar = 'Z';
  MaxObjects = 100;
  MAXSELECT = 10;
  // списки
  DRAWCUBE = 1;
  MARKER = 2;
  DRAWSPHERE = 3;
  DRAWCYLINDER = 4;
  startObjects = 16;       // с какого номера начинается нумерация объектов

const
  // цвет букв
  LetterColor : Array[0..3] of GLFloat = (1.0, 0.0, 1.0, 1.0);
  // цвет осей координат
  ColorAxes : Array[0..3] of GLFloat = (1.0, 1.0, 1.0, 0.5);
  // цвет тумана
  ColorFog : Array [0..3] of GLFloat = (0.5, 0.5, 0.5, 1.0);
  // цвет площадки и сетки
  SquareAmbient : Array[0..3] of GLFloat = (0.24725, 0.1995, 0.0745, 1.0);
  SquareDiffuse : Array[0..3] of GLFloat = (0.75164, 0.60648, 0.22648, 1.0);
  SquareSpecular : Array[0..3] of GLFloat = (0.628281, 0.555802, 0.366065, 1.0);
  // источники света
  LightAmbient : Array[0..3] of GLFloat = (0.25, 0.25, 0.25, 1.0);
  LightDiffuse : Array[0..3] of GLFloat = (1.0, 1.0, 1.0, 1.0);
  LightSpecular: Array[0..3] of GLFloat = (1.0, 1.0, 1.0, 1.0);
  LightPosition: Array[0..3] of GLFloat = (0.0, 0.0, 20.0, 1.0);
  LightModelAmbient: Array[0..3] of GLFloat = (0.25, 0.25, 0.25, 1.0);
  // позиция второго источника света
  Light2Position: Array[0..3] of GLFloat = (15.0, 15.0, -5.0, 1.0);
  // цвет маркера
  ColorMarker : Array[0..3] of GLFloat = (1.0, 0.0, 1.0, 1.0);
  // имя файла с параметрами системы
  FileParam = 'ProPer.cfg';

{--- тип рисуемых объектов ---}
type
  kindtype = (Cube, Sphere, Cylinder);
  GLObject = record
    kind : kindtype;
    x, y, z, l, k, h : GLDouble;
    RotX, RotY, RotZ : GLDouble;
    color : Array [0..2] of GLFloat;
  end;

type
  TfrmMain = class(TForm)
    Panel1: TPanel;
    UpDown1: TUpDown;
    Label1: TLabel;
    UpDown2: TUpDown;
    UpDown3: TUpDown;
    UpDown4: TUpDown;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    pmMain: TPopupMenu;
    N1: TMenuItem;
    CheckBox1: TCheckBox;
    UpDown5: TUpDown;
    Label5: TLabel;
    N2: TMenuItem;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    Label6: TLabel;
    UpDown6: TUpDown;
    Label7: TLabel;
    UpDown7: TUpDown;
    UpDown8: TUpDown;
    Label8: TLabel;
    pmSdvig: TPopupMenu;
    N3: TMenuItem;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    pmAngle: TPopupMenu;
    N4: TMenuItem;
    ColorDialog1: TColorDialog;
    SpeedButton3: TSpeedButton;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    N21: TMenuItem;
    N22: TMenuItem;
    N30: TMenuItem;
    N23: TMenuItem;
    N24: TMenuItem;
    N25: TMenuItem;
    N26: TMenuItem;
    N29: TMenuItem;
    N31: TMenuItem;
    N5: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Timer1: TTimer;
    miRunDomize: TMenuItem;
    Progress: TGauge;
    Label9: TLabel;
    eColMol: TEdit;
    Label10: TLabel;
    eColSets: TEdit;
    procedure GLInit;
    procedure ListPrep;
    procedure SetProjection(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SetDCPixelFormat;
    procedure FormDestroy(Sender: TObject);
    procedure UpDown1Changing(Sender: TObject; var AllowChange: Boolean);
    procedure CheckBox1Click(Sender: TObject);
    procedure UpDown5Changing(Sender: TObject; var AllowChange: Boolean);
    procedure Label2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure N2Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Label6MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure N3Click(Sender: TObject);
    procedure Label5MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure N15Click(Sender: TObject);
    procedure N16Click(Sender: TObject);
    procedure N22Click(Sender: TObject);
    procedure N23Click(Sender: TObject);
    procedure N25Click(Sender: TObject);
    procedure N29Click(Sender: TObject);
    procedure Panel1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure N5Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure N13Click(Sender: TObject);
    procedure N14Click(Sender: TObject);
    procedure UpDown3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure UpDown3MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Timer1Timer(Sender: TObject);
    procedure UpDown2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure UpDown2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure UpDown4MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure UpDown4MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure UpDown6MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure UpDown6MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure UpDown7MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure UpDown7MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure UpDown8MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure UpDown8MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure UpDown4MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure miRunDomizeClick(Sender: TObject);
  private
    SplashWindow : TSplashWindow;
  public
    {--- системные переменные ---}
    DC : HDC;
    hrc : HGLRC;
    {--- видовые параметры ---}
    Perspective : GLFloat;                 // перспектива
    znear, zfar : GLFloat;                 // параметры вида
    Left, Right, Top, Bottom : GLFloat;    // параметры вида
    AngX, AngY, AngZ : GLFloat;            // углы поворота по осям
    AddX, AddY, AddZ : GLFloat;            // начальные сдвиги
    {--- рабочие флаги ---}
    flgAxes : Boolean;                     // показывать ли ось
    flgGrid : Boolean;                     // показывать ли сетку
    flgSquare : Boolean;                   // показывать ли площадку
    flgDraging : Boolean;                  // происходит ли буксирование площадки
    flgDragObject : Boolean;               // происходит ли буксирование объекта
    flgFirst : Boolean;                    // совершенно рабочий флаг
    flgMouseMove : Boolean;                // было движение мыши
    flgMoveObject : Boolean;               // происходит перемещение объекта
    flgUpDown2Change : Boolean;            // происходит ли изменение UpDown2
    flgUpDown3Change : Boolean;            // происходит ли изменение UpDown3
    flgUpDown4Change : Boolean;            // происходит ли изменение UpDown4
    flgUpDown6Change : Boolean;            // происходит ли изменение UpDown6
    flgUpDown7Change : Boolean;            // происходит ли изменение UpDown7
    flgUpDown8Change : Boolean;            // происходит ли изменение UpDown8
    {--- система объектов ---}
    objectCount : GLInt;                   // количество объектов
    objects : Array [0..MaxObjects - 1] of GLObject; // массив объектов
    SysFile : String;                      // имя файла системы
    {--- дублирование системы для UnDo ---}
    DobjectCount : GLInt;                  // количество объектов
    Dobjects : Array [0..MaxObjects - 1] of GLObject; // массив объектов
    {--- рабочие переменные системы объектов ---}
    MarkerObject : GLInt;                  // номер помеченного объекта
    PopupObject : GLInt;                   // номер объекта под курсором
    DragingObject : GLInt;                 // номер буксируемого объекта
    {--- для выбора объектов под курсором ---}
    selectBuf : Array [0..MAXSELECT - 1] of GLInt;
    hit : GLInt;
    vp : Array [0..3] of GLInt;
    {--- рабочие параметры текущего вида ---}
    LineLength : GLFloat;                  // длина линий осей
    SquareLength : GLFloat;                // сторона площадки
    PrevX, PrevY : GLInt;                  // координаты на экране
    R, G, B : GLFloat;                     // цвет фона экрана
    DataFile : File of GLFloat;            // файл параметров
    Quadric : GLUQuadricObj ;              // сфера / цилиндр
    function DoSelect(x : GLint; y : GLint) : GLint;
    function Max (a, b : GLFloat) : GLFloat;
    function Min (a, b : GLFloat) : GLFloat;
    procedure Axes (mode : GLenum);
    procedure ColorToGLU (var R, G, B: GLFloat);
    procedure DeleteMarkerObject;
    procedure DrawScene (mode : GLEnum);
    procedure Grid;
    procedure LoadParam;
    procedure LoadSystem;
    procedure MarkerCube (n : GLInt; mode : GLEnum);
    procedure MoveObject (mouseX, mouseY : GLInt);
    procedure ObjectDelete;
    procedure PreOutText;
    procedure ResizeObject (h : GLInt; mouseX, mouseY : GLInt);
    procedure ResizeObjectXYZ (h : GLInt; mouseX, mouseY : GLInt);
    procedure ResizeSquare (h : GLInt; mouseX, mouseY : GLInt);
    procedure Save;
    procedure SaveParam;
    procedure SaveSystem;
    procedure ScreenToSpace (mouseX, mouseY : GLInt; var X, Y : GLFloat);
    procedure Square (mode : GLEnum);
    procedure Start;
    procedure TransformView (h : GLint);
    procedure UnDo;
   protected
    procedure WMRestore (var Msg: TWMSysCommand); message WM_SYSCOMMAND;
    procedure WMPaint(var Msg: TWMPaint); message WM_PAINT;
   end;

var
  frmMain: TfrmMain;
  Control:TControl;
  Radius:real;
implementation

uses ParSdvig;
//, ParAngle, ParObject;

{$R *.DFM}

{**********************************************************************}
{****                   CUSTOM - методы формы                      ****}
{**********************************************************************}

{======================================================================
Стартовая процедура, задает начальные значения параметров}
procedure TfrmMain.Start;
begin
 Left := -0.5;
 Right := 0.5;
 Bottom := -0.5;
 Top := 0.5;
 znear := 1.0;
 zfar := 100.0;
 Perspective := 30.0;
 UpDown1.Position := Round(Perspective);
 AngX := 120.0;
 AngY := 180.0;
 AngZ := 40.0;
 flgAxes := True;            // показывать ли ось
 flgGrid := True;            // показывать ли сетку
 flgSquare := True;          // показывать ли площадку
 CheckBox1.Checked := True;
 N22.Checked := True;        // пункты попап
 N30.Checked := False;
 CheckBox2.Checked := True;
 N23.Checked := True;
 N24.Checked := False;
 CheckBox3.Checked := True;
 N29.Checked := True;
 N31.Checked := False;
 CheckBox4.Checked := True;
 N25.Checked := True;
 N26.Checked := False;
 AddX := 0;
 AddY := 0;
 AddZ := 0;
 linelength := 10.0;         // длина осевых
 squarelength := 10.0;;      // сторона площадки
 UpDown5.Position := round(linelength);
 R := 0;
 G := 0;
 B := 0;
end;

{======================================================================
Пометка маркерами объекта n}
procedure TfrmMain.MarkerCube (n : GLInt; mode : GLEnum);
begin
  glPushMatrix;

  glPushAttrib (GL_ALL_ATTRIB_BITS );
  glMaterialfv (GL_FRONT, GL_AMBIENT_AND_DIFFUSE, @ColorMarker);

  glTranslatef (0.5, 0.0, 0.0);
  If mode = GL_SELECT then glLoadName (8); // XZ внизу
  glCallList (Marker);

  glTranslatef (0.0, 0.0, 1.0);
  If mode = GL_SELECT then glLoadName (9); // XZ вверху
  glCallList (Marker);

  glTranslatef (-0.5, 0.5, 0.0);
  If mode = GL_SELECT then glLoadName (10); // YZ вверху
  glCallList (Marker);

  glTranslatef (0.0, 0.0, -1.0);
  If mode = GL_SELECT then glLoadName (11); // YZ внизу
  glCallList (Marker);

  glTranslatef (0.5, 0.5, 0.0);
  If mode = GL_SELECT then glLoadName (12); // XY внизу
  glCallList (Marker);

  glTranslatef (0.0, 0.0, 1.0);
  If mode = GL_SELECT then glLoadName (13); // XY вверху
  glCallList (Marker);

  glTranslatef (0.5, -0.5, 0.0);
  If mode = GL_SELECT then glLoadName (14); // XYZ вверху
  glCallList (Marker);

  glTranslatef (0.0, 0.0, -1.0);
  If mode = GL_SELECT then glLoadName (15); // XYZ внизу
  glCallList (Marker);

  glPopAttrib;
  glPopMatrix;
end;

{=======================================================================
Перемещение точки зрения}
procedure TfrmMain.TransformView (h : GLint);
begin
  Case h of
  1 : begin
      AngX := 90;
      AngY := -180;
      AngZ := 90;
      end;
  2 : begin
      AngX := 90;
      AngY := 180;
      AngZ := 0;
      end;
  3 : begin
      AngX := 0;
      AngY := 0;
      AngZ := 0;
      end;
  end; // case
end;

{=======================================================================
Выбор объекта под курсором}
function TfrmMain.DoSelect(x : GLInt; y : GLInt) : GLint;
var
  hits : GLInt;
begin
  glSelectBuffer(MAXSELECT, @selectBuf); // создание буфера выбора
  glRenderMode(GL_SELECT);               // режим выбора
  glInitNames;                           // инициализация стека имен
  glPushName(0);                         // помещение имени в стек имен
  glPushMatrix;
  glGetIntegerv(GL_VIEWPORT, @vp);

  glMatrixMode(GL_PROJECTION);
  glLoadIdentity;
  gluPickMatrix(x, frmMain.Height - y, 2, 2, @vp);
  glFrustum (left, right, bottom, top, znear, zfar);

  glMatrixMode(GL_MODELVIEW);

  DrawScene (GL_SELECT);

  glPopMatrix;

  hits := glRenderMode(GL_RENDER);

  If hits <= 0
     then Result := -1
     else Result := selectBuf[(hits-1)*4+3];
end;

{=======================================================================
Подготовка к выводу символов}
procedure TfrmMain.PreOutText;
var
  hFontNew, hOldFont : HFONT;
{$IFNDEF Delphi3}
  agmf : Array [0..255] of TGLYPHMETRICSFLOAT ; // Delphi 3
{$ELSE}
  agmf : Array [0..255] of GLYPHMETRICSFLOAT ;  // Delphi 4
{$ENDIF}
begin
  hFontNew := frmMain.Font.Handle;
  hOldFont := SelectObject (DC, hFontNew);
  wglUseFontOutlines (DC, 0, 255, id_TEXT, 0.0, 0.15, WGL_FONT_POLYGONS, @agmf);
  DeleteObject (SelectObject(DC, hOldFont));
  DeleteObject (SelectObject(DC, hFontNew));
end;

{=======================================================================
Основная процедура рисования}
procedure TfrmMain.DrawScene (mode : GLEnum);
var
  i : GLInt;
begin
  glClearColor (R, G, B, 1.0);
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
  glLoadIdentity;
  glTranslatef(0.0, 0.0, -32.0);

  glRotatef(AngX, 1.0, 0.0, 0.0);
  glRotatef(AngY, 0.0, 1.0, 0.0);
  glRotatef(AngZ, 0.0, 0.0, 1.0);

  glTranslatef(AddX, AddY, AddZ);

  If (mode <> GL_SELECT) and flgGrid then Grid;

  // дальше включается режим выбора объектов
  If flgAxes then Axes (mode);
  If flgSquare then Square (mode);

  // массив объектов
  glPushAttrib (GL_ALL_ATTRIB_BITS );
  glDisable (GL_LIGHT1);
  For i := 1 to objectcount do begin
      glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, @objects[i].color);
      glPushMatrix;
      glTranslatef (objects[i].x, objects[i].y, objects[i].z);
      glScalef (objects[i].l, objects[i].k, objects[i].h);
      glRotatef (objects[i].RotX, 1.0, 0.0, 0.0);
      glRotatef (objects[i].RotY, 0.0, 1.0, 0.0);
      glRotatef (objects[i].RotZ, 0.0, 0.0, 1.0);

      If mode = GL_SELECT then glLoadName (i + startObjects);
      case objects [i].kind of
           Cube : glCallList (DRAWCUBE);
           Sphere : glCallList (DRAWSPHERE);
           Cylinder : glCallList (DRAWCYLINDER);
      end; {case}
      If i = MarkerObject then MarkerCube (i, mode);

      glPopMatrix;
  end;

  glEnable (GL_LIGHT1);
  glPopAttrib;

  SwapBuffers(DC);
end;

{======================================================================
Вывод диалога задания цвета для RGB}
procedure TfrmMain.ColorToGLU (var R, G, B: GLFloat);
begin
  {заполняем цвет диалога}
  ColorDialog1.Color := round(R*255) or (round(G*255) shl 8) or (round(B*255) shl 16);
  If ColorDialog1.Execute then begin
     R := (ColorDialog1.Color and $FF) / 255;
     G := ((ColorDialog1.Color and $FF00) Shr 8) /255;
     B := ((ColorDialog1.Color and $FF0000) Shr 16) /255;
  end;
end;

{======================================================================
Перевод экранных координат в пространственные}
procedure TfrmMain.ScreenToSpace (mouseX, mouseY : GLInt; var X, Y : GLFloat);
var
   x0, xW, y0, yH : GLFloat;
begin
   x0 := 4 * zfar * left / (zfar + znear);   // 0
   xW := 4 * zfar * right / (zfar + znear);  // Width

   y0 := 4 * zfar * top / (zfar + znear);    // 0
   yH := 4 * zfar * bottom / (zfar + znear); // Heigth

   X := x0 + mouseX * (xW - x0) / (frmMain.Width-Panel1.Width);
   Y := y0 + mouseY * (yH - y0) / frmMain.Height;
end;

{======================================================================
Чтение параметров системы из файла}
procedure TfrmMain.LoadParam;
var
  wrk : GLFloat;
begin
  AssignFile (DataFile, FileParam);
  try
  try
  ReSet (DataFile);
  Read (DataFile, znear, zfar, Perspective);
  UpDown1.Position := Round(Perspective);
  Read (DataFile, Left, Right, Top, Bottom);
  Read (DataFile, AngX, AngY, AngZ);
  Read (DataFile, AddX, AddY, AddZ);
  Read (DataFile, SquareLength, LineLength);
  UpDown5.Position := round(linelength);
  Read (DataFile, wrk);
  If wrk = 1.0 then flgAxes := True
               else flgAxes := False;
  CheckBox1.Checked := flgAxes;
  If CheckBox1.Checked then begin
     N22.Checked := True;   // пункты попап
     N30.Checked := False;
     end
     else begin
     N22.Checked := False;  // пункты попап
     N30.Checked := True;
  end;
  // сетка
  Read (DataFile, wrk);
  If wrk = 1.0 then flgGrid := True
               else flgGrid := False;
  CheckBox2.Checked := flgGrid;
  If CheckBox2.Checked then begin
     N23.Checked := True;
     N24.Checked := False;
     end
     else begin
     N23.Checked := False;
     N24.Checked := True;
  end;
  // туман
  Read (DataFile, wrk);
  If wrk = 1.0 then CheckBox3.Checked := True
               else CheckBox3.Checked := False;
  If CheckBox3.Checked then begin
     N29.Checked := True;
     N31.Checked := False;
     glEnable (GL_FOG);
     end
     else begin
     N29.Checked := False;
     N31.Checked := True;
     glDisable (GL_FOG);
  end;
  // площадка
  Read (DataFile, wrk);
  If wrk = 1.0 then flgSquare := True
               else flgSquare := False;
  CheckBox4.Checked := flgSquare;
  If CheckBox4.Checked then begin
     N25.Checked := True;
     N26.Checked := False;
     end
     else begin
     N25.Checked := False;
     N26.Checked := True;
  end;
  Read (DataFile, wrk);
  UpDown2.Increment := Round (wrk);
  UpDown3.Increment := Round (wrk);
  UpDown4.Increment := Round (wrk);
  Read (DataFile, wrk);
  UpDown6.Increment := Round (wrk);
  UpDown7.Increment := Round (wrk);
  UpDown8.Increment := Round (wrk);
  Read (DataFile, R);
  Read (DataFile, G);
  Read (DataFile, B);
  finally
  CloseFile (DataFile);
  end;
  except
  raise
  end;
end;

{======================================================================
Запись параметров системы}
procedure TfrmMain.SaveParam;
var
  wrk : GLFloat;
begin
  AssignFile (DataFile, FileParam);
  try
  try
  Rewrite (DataFile);
  Write (DataFile, znear, zfar, Perspective);
  Write (DataFile, Left, Right, Top, Bottom);
  Write (DataFile, AngX, AngY, AngZ);
  Write (DataFile, AddX, AddY, AddZ);
  Write (DataFile, SquareLength, LineLength);
  If flgAxes then wrk := 1.0
             else wrk := 0.0;
  Write (DataFile, wrk);
  If flgGrid then wrk := 1.0
             else wrk := 0.0;
  Write (DataFile, wrk);
  If CheckBox3.Checked then wrk := 1.0
                       else wrk := 0.0;
  Write (DataFile, wrk);
  If flgSquare then wrk := 1.0
               else wrk := 0.0;
  Write (DataFile, wrk);
  wrk := UpDown2.Increment;
  Write (DataFile, wrk);
  wrk := UpDown6.Increment;
  Write (DataFile, wrk);
  Write (DataFile, R);
  Write (DataFile, G);
  Write (DataFile, B);
  finally
  CloseFile (DataFile);
  end;
  except
  ShowMessage ('Ошибка записи в файл параметров ' + FileParam);
  end;
end;

{======================================================================
Максимум двух чисел}
function TfrmMain.Max (a, b : GLFloat) : GLFloat;
begin
  If a > b then Max := a else Max := b
end;

{======================================================================
Минимум двух чисел}
function TfrmMain.Min (a, b : GLFloat) : GLFloat;
begin
  If a < b then Min := a else Min := b
end;

{======================================================================
Рисование линий осей координат}
procedure TfrmMain.Axes (mode : GLenum);
begin
  glPushMatrix;
  glPushAttrib (GL_ALL_ATTRIB_BITS );

  glMaterialfv (GL_FRONT, GL_AMBIENT_AND_DIFFUSE, @ColorAxes);

  glBegin (GL_LINES);
    glVertex3f (0.0, 0.0, 0.0);
    glVertex3f (linelength, 0.0, 0.0);
    glVertex3f (0.0, 0.0, 0.0);
    glVertex3f (0.0, linelength, 0.0);
    glVertex3f (0.0, 0.0, 0.0);
    glVertex3f (0.0, 0.0, linelength);
  glEnd;

  glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, @LetterColor);

  glTranslatef(linelength + 1.0, 0.0, 0.0);
  glRotatef (90.0, 0.0, 1.0, 0.0);
  glRotatef (90.0, 0.0, 0.0, 1.0);
  If mode = GL_SELECT then glLoadName (1);
  glListBase(id_TEXT);
  glCallLists(1, GL_UNSIGNED_BYTE, XTEXT);

  glPopMatrix;
  glPushMatrix;
  glTranslatef(0.0, linelength + 1.0, 0.0);
  glRotatef (90.0, 1.0, 0.0, 0.0);
  If mode = GL_SELECT then glLoadName (2);
  glListBase(id_TEXT);
  glCallLists(1, GL_UNSIGNED_BYTE, YTEXT);

  glPopMatrix;
  glPushMatrix;
  glTranslatef(0.0, 0.0, linelength + 1.0);
  If mode = GL_SELECT then glLoadName (3);
  glListBase(id_TEXT);
  glCallLists(1, GL_UNSIGNED_BYTE, ZTEXT);

  glPopAttrib;
  glPopMatrix;
end;

{======================================================================
Инициализация списков}
procedure TfrmMain.ListPrep;
begin
  glNewList(DRAWCUBE, GL_COMPILE);
    glBegin(GL_POLYGON);
      glNormal3f(0.5, 0.5, 1.0);
      glVertex3f(1.0, 1.0, 1.0);
      glVertex3f(0.0, 1.0, 1.0);
      glVertex3f(0.0, 0.0, 1.0);
      glVertex3f(1.0, 0.0, 1.0);
    glEnd;

    glBegin(GL_POLYGON);
      glNormal3f(0.5, 0.5, 0.0);
      glVertex3f(1.0, 1.0, 0.0);
      glVertex3f(1.0, 0.0, 0.0);
      glVertex3f(0.0, 0.0, 0.0);
      glVertex3f(0.0, 1.0, 0.0);
    glEnd;

    glBegin(GL_POLYGON);
      glNormal3f(0.0, 0.5, 0.5);
      glVertex3f(0.0, 1.0, 1.0);
      glVertex3f(0.0, 1.0, 0.0);
      glVertex3f(0.0, 0.0, 0.0);
      glVertex3f(0.0, 0.0, 1.0);
    glEnd;

    glBegin(GL_POLYGON);
      glNormal3f(1.0, 0.5, 0.5);
      glVertex3f(1.0, 1.0, 1.0);
      glVertex3f(1.0, 0.0, 1.0);
      glVertex3f(1.0, 0.0, 0.0);
      glVertex3f(1.0, 1.0, 0.0);
    glEnd;

    glBegin(GL_POLYGON);
      glNormal3f(0.5, 1.0, 0.5);
      glVertex3f(0.0, 1.0, 0.0);
      glVertex3f(0.0, 1.0, 1.0);
      glVertex3f(1.0, 1.0, 1.0);
      glVertex3f(1.0, 1.0, 0.0);
    glEnd;

    glBegin(GL_POLYGON);
      glNormal3f(0.5, 0.0, 0.5);
      glVertex3f(0.0, 0.0, 0.0);
      glVertex3f(1.0, 0.0, 0.0);
      glVertex3f(1.0, 0.0, 1.0);
      glVertex3f(0.0, 0.0, 1.0);
    glEnd;
  glEndList;

  glNewList(DRAWSPHERE, GL_COMPILE);
    glTranslatef (0.5, 0.5, 0.5);
    gluSphere(Quadric, 0.5, 50, 50);//
    glTranslatef (-0.5, -0.5, -0.5);
  glEndList;

  glNewList(DRAWCYLINDER, GL_COMPILE);
    glTranslatef (0.5, 0.5, 0.0);
    gluCylinder (Quadric, 0.5, 0.5, 1.0,  50, 50);
    glTranslatef (-0.5, -0.5, 0.0);
  glEndList;

  glNewList(MARKER, GL_COMPILE);
    glBegin(GL_POLYGON);
      glNormal3f(-0.025, -0.025, 0.025);
      glVertex3f(0.025, 0.025, 0.025);
      glVertex3f(-0.025, 0.025, 0.025);
      glVertex3f(-0.025, -0.025, 0.025);
      glVertex3f(0.025, -0.025, 0.025);
    glEnd;

    glBegin(GL_POLYGON);
      glNormal3f(-0.025, -0.025, 0.025);
      glVertex3f(0.025, 0.025, -0.025);
      glVertex3f(0.025, -0.025, -0.025);
      glVertex3f(-0.025, -0.025, -0.025);
      glVertex3f(-0.025, 0.025, -0.025);
    glEnd;

    glBegin(GL_POLYGON);
      glNormal3f(-0.025, -0.025, 0.025);
      glVertex3f(-0.025, 0.025, 0.025);
      glVertex3f(-0.025, 0.025, -0.025);
      glVertex3f(-0.025, -0.025, -0.025);
      glVertex3f(-0.025, -0.025, 0.025);
    glEnd;

    glBegin(GL_POLYGON);
      glNormal3f(0.025, -0.025, 0.025);
      glVertex3f(0.025, 0.025, 0.025);
      glVertex3f(0.025, -0.025, 0.025);
      glVertex3f(0.025, -0.025, -0.025);
      glVertex3f(0.025, 0.025, -0.025);
    glEnd;

    glBegin(GL_POLYGON);
      glNormal3f(-0.025, 0.025, -0.025);
      glVertex3f(-0.025, 0.025, -0.025);
      glVertex3f(-0.025, 0.025, 0.025);
      glVertex3f(0.025, 0.025, 0.025);
      glVertex3f(0.025, 0.025, -0.025);
    glEnd;

    glBegin(GL_POLYGON);
      glNormal3f(-0.025, -0.025, -0.025);
      glVertex3f(-0.025, -0.025, -0.025);
      glVertex3f(0.025, -0.025, -0.025);
      glVertex3f(0.025, -0.025, 0.025);
      glVertex3f(-0.025, -0.025, 0.025);
    glEnd;
  glEndList;
end;

{======================================================================
Рисование сетки}
procedure TfrmMain.Grid;
var
  i, j : GLInt;
begin
  glPushAttrib (GL_ALL_ATTRIB_BITS );

  glMaterialfv(GL_FRONT, GL_AMBIENT, @SquareAmbient);
  glMaterialfv(GL_FRONT, GL_DIFFUSE, @SquareDiffuse);
  glMaterialfv(GL_FRONT, GL_SPECULAR, @SquareSpecular);
  glMaterialf (GL_FRONT, GL_SHININESS, 99.0);

  glEnable (GL_LINE_STIPPLE);
  glLineStipple (1, 4095);

  j := Round (linelength);

  glBegin (GL_LINES);
    For i := 1 to j do begin
      glVertex3f (i, 0.0, 0.0);
      glVertex3f (i, j, 0.0);
      glVertex3f (0.0, i, 0.0);
      glVertex3f (j, i, 0.0); // xy

      glVertex3f (i, 0.0, 0.0);
      glVertex3f (i, 0.0, j);
      glVertex3f (0.0, 0.0, i);
      glVertex3f (j, 0.0, i); // xz

      glVertex3f (0.0, i, 0.0);
      glVertex3f (0.0, i, j);
      glVertex3f (0.0, 0.0, i);
      glVertex3f (0.0, j, i); // yz
    end;
  glEnd;

  glDisable (GL_LINE_STIPPLE);

  glPopAttrib;
end;

{======================================================================
Задаем формат пикселей}
procedure TfrmMain.SetDCPixelFormat;
var
  nPixelFormat: Integer;
  pfd: TPixelFormatDescriptor;
begin
  FillChar(pfd, SizeOf(pfd), 0);

  With pfd do begin
    nSize     := SizeOf(pfd);
    nVersion  := 1;
    dwFlags   := PFD_DRAW_TO_WINDOW or
                 PFD_SUPPORT_OPENGL or
                 PFD_DOUBLEBUFFER;
    iPixelType:= PFD_TYPE_RGBA;
    cColorBits:= 24;
    cDepthBits:= 32;
    iLayerType:= PFD_MAIN_PLANE;
  end;

  nPixelFormat := ChoosePixelFormat(DC, @pfd);
  SetPixelFormat(DC, nPixelFormat, @pfd);

  DescribePixelFormat(DC, nPixelFormat, SizeOf(TPixelFormatDescriptor), pfd);
end;

{======================================================================
Рисование площадки}
procedure TfrmMain.Square (mode : GLEnum);
begin
  glPushAttrib (GL_ALL_ATTRIB_BITS);

  glMaterialfv(GL_FRONT, GL_AMBIENT, @SquareAmbient);
  glMaterialfv(GL_FRONT, GL_DIFFUSE, @SquareDiffuse);
  glMaterialfv(GL_FRONT, GL_SPECULAR, @SquareSpecular);
  glMaterialf (GL_FRONT, GL_SHININESS, 90.2);

  If (mode <> GL_SELECT) then begin
  glBegin(GL_QUADS); // сама площадка
    glNormal3f(squarelength / 2.0, squarelength / 2.0, -1.0);
    glVertex3f(squarelength, squarelength, -1.0);
    glVertex3f(0.0, squarelength, -1.0);
    glVertex3f(0.0, 0.0, -1.0);
    glVertex3f(squarelength, 0.0, -1.0);
  glEnd;
  end;

  {--- ограничивающие линии ---}

  If mode = GL_SELECT then glLoadName (4); // вверху
  glBegin(GL_LINE_STRIP);
    glVertex3f(squarelength, squarelength, -1.0);
    glVertex3f(0.0, squarelength, -1.0);
  glEnd;

  If mode = GL_SELECT then glLoadName (5); // слева
  glBegin(GL_LINE_STRIP);
    glVertex3f(0.0, squarelength, -1.0);
    glVertex3f(0.0, 0.0, -1.0);
  glEnd;

  If mode = GL_SELECT then glLoadName (6); // снизу
  glBegin(GL_LINE_STRIP);
    glVertex3f(0.0, 0.0, -1.0);
    glVertex3f(squarelength, 0.0, -1.0);
  glEnd;

  If mode = GL_SELECT then glLoadName (7); // справо
  glBegin(GL_LINE_STRIP);
    glVertex3f(squarelength, 0.0, -1.0);
    glVertex3f(squarelength, squarelength, -1.0);
  glEnd;

  glPopAttrib;
end;

{======================================================================
Изменение размеров площадки}
procedure TfrmMain.ResizeSquare (h : GLInt; mouseX, mouseY : GLInt);
var
  dX, dY : GLInt;
  WX1, WY1, WX2, WY2, dXS, dYS : GLFloat;
begin
  If PrevX < 0 then begin
     PrevX := mouseX;
     PrevY := mouseY;
     Exit;
  end;

  dX := mouseX - PrevX;
  dY := mouseY - PrevY;

  If not ((dX = 0) and (dY = 0)) then  begin
     ScreenToSpace (PrevX, PrevY, WX1, WY1);
     ScreenToSpace (mouseX, mouseY, WX2, WY2);

     dXS := Max (WX1, WX2) - Min(WX1, WX2);
     dYS := Max (WY1, WY2) - Min(WY1, WY2);

     If h = 5 then // слево
        If dX > 0 then squarelength := squarelength - 10 * dXS
                  else squarelength := squarelength + 10 * dXS;

     If h = 7 then // справо
        If dX > 0 then squarelength := squarelength + 10 * dXS
                  else squarelength := squarelength - 10 * dXS;

     If h = 4 then // сверху
        If dY > 0 then squarelength := squarelength - 10 * dYS
                  else squarelength := squarelength + 10 * dYS;

     If h = 6 then // снизу
        If dY > 0 then squarelength := squarelength + 10 * dYS
                  else squarelength := squarelength - 10 * dYS;

     If squarelength < 0 then squarelength := 0;

     PrevX := mouseX;
     PrevY := mouseY;
     DrawScene (GL_RENDER);
  end;
end;

{=======================================================================
Удаление помеченного объекта}
procedure TfrmMain.DeleteMarkerObject;
var
  i : GLInt;
begin
  Save;
  For i := MarkerObject to objectcount - 1 do
    objects [i] := objects [i + 1];
  MarkerObject := 0;
  objectcount := objectcount - 1;
  SetProjection(nil);
end;

{=======================================================================
Удаление объекта с номером PopupObject}
procedure TfrmMain.ObjectDelete;
var
  i : GLInt;
begin
  Save;
  For i := PopupObject to objectcount - 1 do
    objects [i] := objects [i + 1];
  objectcount := objectcount - 1;
  If MarkerObject > PopupObject then MarkerObject := MarkerObject - 1
     else If MarkerObject = PopupObject then MarkerObject := 0;
  SetProjection(nil);
end;

{=======================================================================
Запись системы}
procedure TfrmMain.SaveSystem;
var
  F : File of GLObject;
  wrkI : GLInt;
begin
  If SysFile = '' then
     If SaveDialog1.Execute then
        SysFile := SaveDialog1.FileName;
  If SysFile = '' then Exit;

  AssignFile (F, SysFile);
  try
  try
    ReWrite (F);
    For wrkI := 1 to objectCount do
        Write (F, objects [wrkI]);
  finally
    CloseFile (F);
  end; // try
  except
    ShowMessage ('Ошибка при записи файла' + SysFile);
  end; //try
  SetProjection(nil);
end;

{=======================================================================
Загрузить систему}
procedure TfrmMain.LoadSystem;
var
  F : File of GLObject;
  wrkI : GLInt;
begin
  If OpenDialog1.Execute
     then SysFile := OpenDialog1.FileName
     else Exit;

  AssignFile (F, SysFile);
  Save;
  wrkI := 0;
  try
  try
    ReSet (F);
    While not EOF(F) do begin
      Inc (wrkI);
      Read (F, objects [wrkI]);
    end;
    ObjectCount := wrkI;
    MarkerObject := 0;
  finally
    CloseFile (F);
  end; // try
  except
    UnDo;
    ShowMessage ('Ошибка чтения файла' + SysFile);
    SysFile := '';
  end; //try
  SetProjection(nil);
end;

{======================================================================
Сохранение текущего состояния системы}
procedure TfrmMain.Save;
var
 wrkI : GLInt;
begin
 DobjectCount := objectCount;           // количество объектов
 For wrkI := 1 to objectCount do        // массив объектов
     Dobjects [wrkI] := objects [wrkI];
 N13.Enabled := True;                   // пункт "Отменить"
end;

{=======================================================================
Восстановление состояния системы}
procedure TfrmMain.UnDo;
var
 wrkI : GLInt;
begin
 objectCount := DobjectCount;     // количество объектов
 For wrkI := 1 to DobjectCount do // массив объектов
     objects [wrkI] := Dobjects [wrkI];
 N13.Enabled := False;            // пункт "Отменить"
 SetProjection(nil);
end;

{======================================================================
Изменение размеров объекта, если смотрим сверху}
procedure TfrmMain.ResizeObject (h : GLInt; mouseX, mouseY : GLInt);
var
  dX, dY : GLInt;
  WX1, WY1, WX2, WY2, dXS, dYS : GLFloat;
begin
  If PrevX < 0 then begin
     PrevX := mouseX;
     PrevY := mouseY;
     Exit;
  end;

  dX := mouseX - PrevX;
  dY := mouseY - PrevY;

  If (dX = 0) and (dY = 0) then Exit;

  ScreenToSpace (PrevX, PrevY, WX1, WY1);
  ScreenToSpace (mouseX, mouseY, WX2, WY2);

  dXS := Max (WX1, WX2) - Min(WX1, WX2);
  dYS := Max (WY1, WY2) - Min(WY1, WY2);

  Case h of
    // слево
    10, 11 : If dX > 0 then begin
                objects [MarkerObject].l  := objects [MarkerObject].l - 5 * dXS;
                objects [MarkerObject].x  := objects [MarkerObject].x + 5 * dXS;
                end
                else begin
                objects [MarkerObject].l  := objects [MarkerObject].l + 5 * dXS;
                objects [MarkerObject].x  := objects [MarkerObject].x - 5 * dXS;
             end;

    // справо
    14, 15 : If dX > 0 then objects [MarkerObject].l  := objects [MarkerObject].l + 10 * dXS
                       else objects [MarkerObject].l  := objects [MarkerObject].l - 10 * dXS;

    // сверху
    12, 13 : If dY > 0 then objects [MarkerObject].k  := objects [MarkerObject].k - 10 * dYS
                       else objects [MarkerObject].k  := objects [MarkerObject].k + 10 * dYS;

    // снизу
    8, 9 :   If dY > 0 then begin
                objects [MarkerObject].y  := objects [MarkerObject].y - 5 * dYS;
                objects [MarkerObject].k  := objects [MarkerObject].k + 5 * dYS;
                end
                else begin
                objects [MarkerObject].y  := objects [MarkerObject].y + 5 * dYS;
                objects [MarkerObject].k  := objects [MarkerObject].k - 5 * dYS;
             end;
  end; {case}

  If objects [MarkerObject].l < 0 then objects [MarkerObject].l := 0.001;
  If objects [MarkerObject].k < 0 then objects [MarkerObject].k := 0.001;

  PrevX := mouseX;
  PrevY := mouseY;
  DrawScene (GL_RENDER);
end;

{======================================================================
Изменение размеров объекта при произвольной точке зрения}
procedure TfrmMain.ResizeObjectXYZ (h : GLInt; mouseX, mouseY : GLInt);
var
  dX, dY : GLInt;
  WX1, WY1, WX2, WY2, dXS, dYS : GLFloat;
begin
  If PrevX < 0 then begin
     PrevX := mouseX;
     PrevY := mouseY;
     Exit;
  end;

  dX := mouseX - PrevX;
  dY := mouseY - PrevY;

  If (dX = 0) and (dY = 0) then Exit;

  ScreenToSpace (PrevX, PrevY, WX1, WY1);
  ScreenToSpace (mouseX, mouseY, WX2, WY2);

  dXS := Max (WX1, WX2) - Min(WX1, WX2);
  dYS := Max (WY1, WY2) - Min(WY1, WY2);

  // 8, 11, 12, 15 - внизу
  // 9, 10, 13, 14 - вверху

  case h of

     9 : begin
         If dX > 0 then begin
               objects [MarkerObject].y  := objects [MarkerObject].y + 5 * dXS;
               objects [MarkerObject].k  := objects [MarkerObject].k - 5 * dXS;
               end
               else begin
               objects [MarkerObject].y  := objects [MarkerObject].y - 5 * dXS;
               objects [MarkerObject].k  := objects [MarkerObject].k + 5 * dXS;
               end;
         If dY > 0 then objects [MarkerObject].h  := objects [MarkerObject].h - 10 * dYS
                   else objects [MarkerObject].h  := objects [MarkerObject].h + 10 * dYS;
         end;

     13: begin
         If dX > 0 then objects [MarkerObject].k  := objects [MarkerObject].k + 10 * dXS
                   else objects [MarkerObject].k  := objects [MarkerObject].k - 10 * dXS;
         If dY > 0 then objects [MarkerObject].h  := objects [MarkerObject].h - 10 * dYS
                   else objects [MarkerObject].h  := objects [MarkerObject].h + 10 * dYS;
         end;

     14: begin
         If dX > 0 then objects [MarkerObject].l  := objects [MarkerObject].l - 10 * dXS
                   else objects [MarkerObject].l  := objects [MarkerObject].l + 10 * dXS;
         If dY > 0 then objects [MarkerObject].h  := objects [MarkerObject].h - 10 * dYS
                   else objects [MarkerObject].h  := objects [MarkerObject].h + 10 * dYS;
         end;

     10: begin
         If dX > 0 then begin
               objects [MarkerObject].x  := objects [MarkerObject].x - 5 * dXS;
               objects [MarkerObject].l  := objects [MarkerObject].l + 5 * dXS;
               end
               else begin
               objects [MarkerObject].x  := objects [MarkerObject].x + 5 * dXS;
               objects [MarkerObject].l  := objects [MarkerObject].l - 5 * dXS;
         end;
         If dY > 0 then objects [MarkerObject].h  := objects [MarkerObject].h - 10 * dYS
                   else objects [MarkerObject].h  := objects [MarkerObject].h + 10 * dYS;
         end;

     12: begin
         If dX > 0 then objects [MarkerObject].k  := objects [MarkerObject].k + 10 * dXS
                   else objects [MarkerObject].k  := objects [MarkerObject].k - 10 * dXS;
         If dY > 0 then begin
               objects [MarkerObject].z  := objects [MarkerObject].z - 5 * dYS;
               objects [MarkerObject].h  := objects [MarkerObject].h + 5 * dYS;
               end
               else begin
               objects [MarkerObject].z  := objects [MarkerObject].z + 5 * dYS;
               objects [MarkerObject].h  := objects [MarkerObject].h - 5 * dYS;
         end;
         end;

     15: begin
         If dX > 0 then objects [MarkerObject].l  := objects [MarkerObject].l - 10 * dXS
                   else objects [MarkerObject].l  := objects [MarkerObject].l + 10 * dXS;
         If dY > 0 then begin
               objects [MarkerObject].z  := objects [MarkerObject].z - 5 * dYS;
               objects [MarkerObject].h  := objects [MarkerObject].h + 5 * dYS;
               end
               else begin
               objects [MarkerObject].z  := objects [MarkerObject].z + 5 * dYS;
               objects [MarkerObject].h  := objects [MarkerObject].h - 5 * dYS;
         end;
         end;

     8 : begin
         If dX > 0 then objects [MarkerObject].l  := objects [MarkerObject].l + 10 * dXS
                   else objects [MarkerObject].l  := objects [MarkerObject].l - 10 * dXS;
         If dY > 0 then begin
               objects [MarkerObject].z  := objects [MarkerObject].z - 5 * dYS;
               objects [MarkerObject].h  := objects [MarkerObject].h + 5 * dYS;
               end
               else begin
               objects [MarkerObject].z  := objects [MarkerObject].z + 5 * dYS;
               objects [MarkerObject].h  := objects [MarkerObject].h - 5 * dYS;
         end;
         end;

     11: begin
         If dX > 0 then objects [MarkerObject].l  := objects [MarkerObject].l - 10 * dXS
                   else objects [MarkerObject].l  := objects [MarkerObject].l + 10 * dXS;
         If dY > 0 then begin
               objects [MarkerObject].z  := objects [MarkerObject].z - 5 * dYS;
               objects [MarkerObject].h  := objects [MarkerObject].h + 5 * dYS;
               end
               else begin
               objects [MarkerObject].z  := objects [MarkerObject].z + 5 * dYS;
               objects [MarkerObject].h  := objects [MarkerObject].h - 5 * dYS;
         end;
         end;

  end; {case}

  If objects [MarkerObject].l < 0 then objects [MarkerObject].l := 0.001;
  If objects [MarkerObject].k < 0 then objects [MarkerObject].k := 0.001;
  If objects [MarkerObject].h < 0 then objects [MarkerObject].h := 0.001;

  PrevX := mouseX;
  PrevY := mouseY;
  DrawScene (GL_RENDER);
end;

{======================================================================
Перемещение объекта}
procedure TfrmMain.MoveObject (mouseX, mouseY : GLInt);
var
  dX, dY : GLInt;
  WX1, WY1, WX2, WY2, dXS, dYS : GLFloat;
begin
  If PrevX < 0 then begin
     PrevX := mouseX;
     PrevY := mouseY;
     Exit;
  end;

  dX := mouseX - PrevX;
  dY := mouseY - PrevY;

  If (dX = 0) and (dY = 0) then Exit;

  ScreenToSpace (PrevX, PrevY, WX1, WY1);
  ScreenToSpace (mouseX, mouseY, WX2, WY2);

  dXS := Max (WX1, WX2) - Min(WX1, WX2);
  dYS := Max (WY1, WY2) - Min(WY1, WY2);

  If HiWord (GetKeyState (VK_CONTROL)) = 0  {Ctrl не нажат}
     then begin
     If dX > 0 then objects [MarkerObject].x  := objects [MarkerObject].x - 10 * dXS
               else objects [MarkerObject].x  := objects [MarkerObject].x + 10 * dXS;
     If dY > 0 then objects [MarkerObject].y  := objects [MarkerObject].y + 10 * dYS
               else objects [MarkerObject].y  := objects [MarkerObject].y - 10 * dYS;
     end
     else  {Ctrl нажат}
     If dY > 0 then objects [MarkerObject].z  := objects [MarkerObject].z - 10 * dYS
               else objects [MarkerObject].z  := objects [MarkerObject].z + 10 * dYS;

  PrevX := mouseX;
  PrevY := mouseY;

  DrawScene (GL_RENDER);
end;

{**********************************************************************}
{****                        МЕТОДЫ ФОРМЫ                          ****}
{**********************************************************************}

{======================================================================
Обработка активизации редактора}
procedure TfrmMain.WMRestore (var Msg: TWMSysCommand);
begin
 inherited;
 SetProjection(nil);
end;

{======================================================================
Инициализация}
procedure TfrmMain.GLInit;
begin
 glEnable(GL_FOG);
 glEnable(GL_NORMALIZE);
 glEnable(GL_DEPTH_TEST);
 glEnable(GL_AUTO_NORMAL);

 glLightfv(GL_LIGHT0, GL_AMBIENT, @LightAmbient);
 glLightfv(GL_LIGHT0, GL_DIFFUSE, @LightDiffuse);
 glLightfv(GL_LIGHT0, GL_SPECULAR, @LightSpecular);
 glLightfv(GL_LIGHT0, GL_POSITION, @LightPosition);

 glLightModelfv(GL_LIGHT_MODEL_AMBIENT, @LightModelAmbient);

 // второй источник света
 glLightfv(GL_LIGHT1, GL_AMBIENT, @LightAmbient);
 glLightfv(GL_LIGHT1, GL_DIFFUSE, @LightDiffuse);
 glLightfv(GL_LIGHT1, GL_SPECULAR, @LightSpecular);
 glLightfv(GL_LIGHT1, GL_POSITION, @Light2Position);

 glEnable(GL_LIGHTING);
 glEnable(GL_LIGHT0);
 glEnable(GL_LIGHT1);
end;

{======================================================================
Изменение размеров окна}
procedure TfrmMain.SetProjection(Sender: TObject);
begin
 flgMouseMove := False;
 glMatrixMode(GL_PROJECTION);
 glLoadIdentity;
 glFrustum (left, right, bottom, top, znear, zfar);
 glViewport(0, 0, frmMain.Width-Panel1.Width, frmMain.Height);
 glMatrixMode(GL_MODELVIEW);
 InvalidateRect(Handle, nil, False);
end;

{======================================================================
Начало работы приложения}
procedure TfrmMain.FormCreate(Sender: TObject);
begin
 SplashWindow := TSplashWindow.Create (nil);
 SplashWindow.Show;
 SplashWindow.Refresh;
 DC := GetDC(Handle);
 SetDCPixelFormat;
 hrc := wglCreateContext(DC);
 wglMakeCurrent(DC, hrc);
 Randomize;
 GLInit;
 // подготовка списков
 PreOutText;
 Quadric := gluNewQuadric;
 gluQuadricDrawStyle(Quadric, GLU_FILL); // Стиль визуализации
 ListPrep;

 // параметры тумана
 glFogi(GL_FOG_MODE, GL_EXP);
 glFogfv(GL_FOG_COLOR, @ColorFog);
 glFogf(GL_FOG_DENSITY, 0.015);

 try
  LoadParam;
 except
  Start;
  N5Click (nil); // запишем параметры
 end;

 objectCount := 0;
 DobjectCount := 0;
 Markerobject := 0;
 PrevX := -100;
 PrevY := -100;
 SysFile := '';
 N13.Enabled := False; // пункт "Отменить"

 SplashWindow.Free;
 SetProjection(nil);
end;

{======================================================================
Аналог события OnPaint}
procedure TfrmMain.WMPaint(var Msg: TWMPaint);
var
  ps : TPaintStruct;
begin
  BeginPaint(Handle, ps);
  DrawScene(GL_RENDER);
  EndPaint(Handle, ps);
end;

{======================================================================
Конец работы приложения}
procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  wglMakeCurrent (0, 0);
  wglDeleteContext (HRC);
  ReleaseDC (Handle, DC);
  glDeleteLists (id_TEXT, 256);
  glDeleteLists (DRAWCUBE, 4);
  gluDeleteQuadric (Quadric);
end;

{=======================================================================
Нажатие кнопки мыши}
procedure TfrmMain.MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  hit := DoSelect (X, Y + 25);
  If Button = mbLeft then
    case hit of
         -1 :    MarkerObject := 0;      // перестать метить объект
         1,2,3 : TransformView (hit);    // буква осей
         4,5,6,7 :// границы площадки разрешаем изменять только при виде сверху
                  If (AngX = 0) and (AngY = 0) then begin
                   flgDraging := True;    // площадка изменяется в размерах
                   DragingObject := hit;
                  end;
         8..15 :  begin                  // один из маркеров
                  Save;
                  flgDragObject := True; // объект изменяется в размерах
                  DragingObject := hit;
                  end;
         else {нажато на объекте}
            Save;
            MarkerObject := hit - startObjects; // пометить объект маркерами
            flgMoveObject := True;              // объект можно передвигать
    end // case
    else  {правая кнопка мыши}
    If hit < startObjects then begin
       N15.Enabled := False;   // "удалить объект"
       N16.Enabled := False;   // "параметры объекта"
       end
       else begin
       PopupObject := hit - startObjects;    // номер объекта под курсором
       N15.Enabled := True;    // "удалить объект"
       N16.Enabled := True;    // "параметры объекта"
  end;
  SetProjection(nil);
end;

{=======================================================================
Перемещение мыши}
procedure TfrmMain.MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  // первое шевеление мышью
  If not flgMouseMove then begin
     flgMouseMove := True;
     Exit;
  end;

  // изменяем в размерах площадку
  If flgDraging then begin
     ResizeSquare (DragingObject, X, Y);
     Exit;
  end;

  // изменяем в размерах объект
  If flgDragObject then begin
     If (AngX = 0) and (AngY = 0) then begin
        ResizeObject (DragingObject, X, Y);
        Exit;
        end
        else begin
        ResizeObjectXYZ (DragingObject, X, Y);
        Exit;
        end;
  end;

  // маркированнный объект перемещается
  If flgMoveObject then begin
     MoveObject (X, Y);
     Exit;
  end;

  // определяем, какой объект под курсором
  hit := DoSelect (X, Y + 25);

  If (AngX = 0) and (AngY = 0) then           // Z
     case hit of
           4, 6, 8, 9, 12, 13 : Cursor := crSizeNS;   // стрелки вверх
           5, 7, 10, 11, 14, 15 : Cursor := crSizeWE; // стрелки вбок
           else
           Cursor := crDefault;      // курсор - обычный
     end // case
     else                            
     case hit of
       8..15 : Cursor := crSizeNS;   // маркеры - стрелки вверх
           else
           Cursor := crDefault;      // курсор - обычный
     end; // case
end;

{=======================================================================
Кнопка мыши отжата}
procedure TfrmMain.MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  PrevX := -100;
  PrevY := -100;
  flgDraging := False;
  flgDragObject := False;
  flgMoveObject := False;
  SetProjection(nil);
end;

{=======================================================================
Нажатие клавиши}
procedure TfrmMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If Key = VK_ESCAPE then begin
     Close;
     Exit;
  end;
  If (Key = VK_DELETE) and (MarkerObject <> 0) then begin
     DeleteMarkerObject;
     Exit;
  end;
  If Key = VK_INSERT then begin
     N2Click(nil);
     Exit;
  end;
  If (Key = VK_RETURN) and (MarkerObject <> 0) then begin
     PopupObject := MarkerObject;
     N16Click (nil);
     Exit;
  end;
  If Key = VK_HOME then begin
     MarkerObject := MarkerObject - 1;
     If MarkerObject < 1 then MarkerObject := objectcount;
     SetProjection(nil);
     Exit;
  end;
  If Key = VK_END then begin
     MarkerObject := MarkerObject + 1;
     If MarkerObject > objectcount then MarkerObject := 1;
     SetProjection(nil);
     Exit;
  end;
end;

{*****************========   UP DOWN    =======************************}

{======================================================================
Расстояние}
procedure TfrmMain.UpDown1Changing(Sender: TObject;
  var AllowChange: Boolean);
begin
  If UpDown1.Position < Perspective then begin
     left := left + 0.025;
     right := right - 0.025;
     top := top - 0.025;
     bottom := bottom + 0.025;
     end
     else If UpDown1.Position > Perspective then begin
     left := left - 0.025;
     right := right + 0.025;
     top := top + 0.025;
     bottom := bottom - 0.025;
  end;
  Perspective := UpDown1.Position;
  SetProjection(nil);
end;

{======================================================================
Нажатие кнопки на "Угол по оси Y"}
procedure TfrmMain.UpDown3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  If MarkerObject = 0 then begin
     If Y < UpDown3.Height / 2
        then AngY := AngY - UpDown3.Increment
        else AngY := AngY + UpDown3.Increment;
     If AngY <= -360 then AngY := AngY + 360 else
        If AngY >= 360 then AngY := AngY - 360;
     end
     else begin
     If Y < UpDown3.Height / 2
        then objects [MarkerObject].RotY := objects [MarkerObject].RotY - UpDown3.Increment
        else objects [MarkerObject].RotY := objects [MarkerObject].RotY + UpDown3.Increment;
     If objects [MarkerObject].RotY <= -360 then objects [MarkerObject].RotY := objects [MarkerObject].RotY + 360
     else
     If objects [MarkerObject].RotY >= 360 then objects [MarkerObject].RotY := objects [MarkerObject].RotY - 360;
  end;
  If not flgFirst then begin
     flgFirst := True;
     Save;
     Timer1.Enabled := True;
     flgUpDown3Change := True;
  end;
  SetProjection(nil);
end;

{======================================================================
Кнопка отжата на "Угол по оси Y"}
procedure TfrmMain.UpDown3MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  flgFirst := False;
  Timer1.Enabled := False;
  flgUpDown3Change := False;
end;

{======================================================================
Кнопка нажата на "Угол по оси X"}
procedure TfrmMain.UpDown2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  If MarkerObject = 0 then begin
     If Y < UpDown2.Height / 2
        then AngX := AngX - UpDown2.Increment
        else AngX := AngX + UpDown2.Increment;
     If AngX <= -360 then AngX := AngX + 360 else
        If AngX >= 360 then AngX := AngX - 360;
     end
     else begin
     If Y < UpDown2.Height / 2
        then objects [MarkerObject].RotX := objects [MarkerObject].RotX - UpDown2.Increment
        else objects [MarkerObject].RotX := objects [MarkerObject].RotX + UpDown2.Increment;
     If objects [MarkerObject].RotX <= -360 then objects [MarkerObject].RotX := objects [MarkerObject].RotX + 360
     else
     If objects [MarkerObject].RotX >= 360 then objects [MarkerObject].RotX := objects [MarkerObject].RotX - 360;
  end;
  If not flgFirst then begin
     flgFirst := True;
     Save;
     flgUpDown2Change := True;
     Timer1.Enabled := True;
  end;
  SetProjection(nil);
end;

{======================================================================
Кнопка отжата на "Угол по оси X"}
procedure TfrmMain.UpDown2MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  flgFirst := False;
  Timer1.Enabled := False;
  flgUpDown2Change := False;
end;

{======================================================================
Кнопка нажата на "Угол по оси Z"}
procedure TfrmMain.UpDown4MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  If MarkerObject = 0 then begin
     If Y < UpDown4.Height / 2
        then AngZ := AngZ - UpDown4.Increment
        else AngZ := AngZ + UpDown4.Increment;
     If AngZ <= -360 then AngZ := AngZ + 360 else
        If AngZ >= 360 then AngZ := AngZ - 360;
     end
     else begin
     If Y < UpDown4.Height / 2
        then objects [MarkerObject].RotZ := objects [MarkerObject].RotZ - UpDown4.Increment
        else objects [MarkerObject].RotZ := objects [MarkerObject].RotZ + UpDown4.Increment;
     If objects [MarkerObject].RotZ <= -360 then objects [MarkerObject].RotZ := objects [MarkerObject].RotZ + 360
     else
     If objects [MarkerObject].RotZ >= 360 then objects [MarkerObject].RotZ := objects [MarkerObject].RotZ - 360;
  end;
  If not flgFirst then begin
     flgFirst := True;
     Save;
     flgUpDown4Change := True;
     Timer1.Enabled := True;
  end;
  SetProjection(nil);
end;

{======================================================================
Кнопка отжата на "Угол по оси Z"}
procedure TfrmMain.UpDown4MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  flgFirst := False;
  Timer1.Enabled := False;
  flgUpDown4Change := False;
end;

{======================================================================
Кнопка нажата на "Сдвиг по оси X"}
procedure TfrmMain.UpDown6MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  If MarkerObject = 0 then begin
     If Y < UpDown6.Height / 2
        then AddX := AddX - UpDown6.Increment
        else AddX := AddX + UpDown6.Increment;
     end
     else begin
     If Y < UpDown6.Height / 2
        then objects [MarkerObject].x := objects [MarkerObject].x - UpDown6.Increment
        else objects [MarkerObject].x := objects [MarkerObject].x + UpDown6.Increment;
  end;
  If not flgFirst then begin
     flgFirst := True;
     Save;
     flgUpDown6Change := True;
     Timer1.Enabled := True;
  end;
  SetProjection(nil);
end;

{======================================================================
Кнопка отжата на "Сдвиг по оси X"}
procedure TfrmMain.UpDown6MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  flgFirst := False;
  Timer1.Enabled := False;
  flgUpDown6Change := False;
end;

{======================================================================
Кнопка нажата на "Сдвиг по оси Y"}
procedure TfrmMain.UpDown7MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  If MarkerObject = 0 then begin
     If Y < UpDown7.Height / 2
        then AddY := AddY - UpDown7.Increment
        else AddY := AddY + UpDown7.Increment;
     end
     else begin
     If Y < UpDown7.Height / 2
        then objects [MarkerObject].y := objects [MarkerObject].y - UpDown7.Increment
        else objects [MarkerObject].y := objects [MarkerObject].y + UpDown7.Increment;
  end;
  If not flgFirst then begin
     flgFirst := True;
     Save;
     flgUpDown7Change := True;
     Timer1.Enabled := True;
  end;
  SetProjection(nil);
end;

{======================================================================
Кнопка отжата на "Сдвиг по оси Y"}
procedure TfrmMain.UpDown7MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  flgFirst := False;
  Timer1.Enabled := False;
  flgUpDown7Change := False;
end;

{======================================================================
Кнопка нажата на "Сдвиг по оси Z"}
procedure TfrmMain.UpDown8MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  If MarkerObject = 0 then begin
     If Y < UpDown8.Height / 2
        then AddZ := AddZ - UpDown8.Increment
        else AddZ := AddZ + UpDown8.Increment;
     end
     else begin
     If Y < UpDown8.Height / 2
        then objects [MarkerObject].z := objects [MarkerObject].z - UpDown8.Increment
        else objects [MarkerObject].z := objects [MarkerObject].z + UpDown8.Increment;
  end;
  If not flgFirst then begin
     flgFirst := True;
     Save;
     flgUpDown8Change := True;
     Timer1.Enabled := True;
  end;
  SetProjection(nil);
end;

{======================================================================
Кнопка отжата на "Сдвиг по оси Z"}
procedure TfrmMain.UpDown8MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  flgFirst := False;
  Timer1.Enabled := False;
  flgUpDown7Change := False;
end;

{======================================================================
Уход указателя с UpDown углов и сдвигов}
procedure TfrmMain.UpDown4MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 If (X < 0) or (X > 10) then begin
    flgUpDown2Change := False;
    flgUpDown3Change := False;
    flgUpDown4Change := False;
    flgUpDown6Change := False;
    flgUpDown7Change := False;
    flgUpDown8Change := False;
    flgFirst := False;
    Timer1.Enabled := False;
 end;
end;

{======================================================================
Длина осевых}
procedure TfrmMain.UpDown5Changing(Sender: TObject;
  var AllowChange: Boolean);
begin
  linelength := UpDown5.Position;
  SetProjection(nil);
end;

{*****************========   CHECKBOX   =======************************}

{======================================================================
Оси}
procedure TfrmMain.CheckBox1Click(Sender: TObject);
begin
  If CheckBox1.Checked then begin
     N22.Checked := True;  // пункты попап
     N30.Checked := False;
     flgAxes := True;
     Label5.Visible := True;
     UpDown5.Visible := True;
     end
     else begin
     N22.Checked := False;  // пункты попап
     N30.Checked := True;
     flgAxes := False;
     Label5.Visible := False;
     UpDown5.Visible := False;
  end;
  SetProjection(nil);
end;

{======================================================================
Cетка}
procedure TfrmMain.CheckBox2Click(Sender: TObject);
begin
  If CheckBox2.Checked then begin
     N23.Checked := True;
     N24.Checked := False;
     flgGrid := True
     end
     else begin
     N23.Checked := False;
     N24.Checked := True;
     flgGrid := False;
  end;
  SetProjection(nil);
end;

{======================================================================
Туман}
procedure TfrmMain.CheckBox3Click(Sender: TObject);
begin
  If CheckBox3.Checked then begin
     N29.Checked := True;
     N31.Checked := False;
     glEnable (GL_FOG);
     end
     else begin
     N29.Checked := False;
     N31.Checked := True;
     glDisable (GL_FOG);
  end;
  SetProjection(nil);
end;

{======================================================================
Площадка}
procedure TfrmMain.CheckBox4Click(Sender: TObject);
begin
  If CheckBox4.Checked then begin
     N25.Checked := True;
     N26.Checked := False;
     flgSquare := True
     end
     else begin
     N25.Checked := False;
     N26.Checked := True;
     flgSquare := False;
  end;
  SetProjection(nil);
end;

{*****************==========   МЕТКИ  =========************************}

{======================================================================
Метки углов}
procedure TfrmMain.Label2MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  If MarkerObject = 0 then begin
     Label2.Hint := FloatToStr(AngX);
     Label3.Hint := FloatToStr(AngY);
     Label4.Hint := FloatToStr(AngZ);
     end
     else begin
     Label2.Hint := FloatToStr(objects[MarkerObject].RotX);
     Label3.Hint := FloatToStr(objects[MarkerObject].RotY);
     Label4.Hint := FloatToStr(objects[MarkerObject].RotZ);
  end;
end;

{======================================================================
Метка длины осевых}
procedure TfrmMain.Label5MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  Label5.Hint := FloatToStr (LineLength)
end;

{======================================================================
Метки сдвигов}
procedure TfrmMain.Label6MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  If MarkerObject = 0 then begin
     Label6.Hint := FloatToStr(AddX);
     Label7.Hint := FloatToStr(AddY);
     Label8.Hint := FloatToStr(AddZ);
     end
     else begin
     Label6.Hint := FloatToStr(objects[MarkerObject].x);
     Label7.Hint := FloatToStr(objects[MarkerObject].y);
     Label8.Hint := FloatToStr(objects[MarkerObject].z);
  end;
end;

{*****************====== SPEEDBUTTON  =========************************}

{======================================================================
Кнопка "Загрузить"}
procedure TfrmMain.SpeedButton1Click(Sender: TObject);
begin
  LoadSystem;
end;

{======================================================================
Кнопка "Освежить"}
procedure TfrmMain.SpeedButton2Click(Sender: TObject);
begin
 SetProjection(nil);
end;

{======================================================================
Кнопка "Записать"}
procedure TfrmMain.SpeedButton3Click(Sender: TObject);
begin
 SaveSystem;
end;

{*****************======== КНОПКИ МЕНЮ =======************************}

{======================================================================
Добавить ящик}
procedure TfrmMain.N2Click(Sender: TObject);
begin

end;

{======================================================================
Параметры сдвига}
procedure TfrmMain.N3Click(Sender: TObject);
begin
  frmParSdvig.Show;
end;

{======================================================================
Параметры углов}
procedure TfrmMain.N4Click(Sender: TObject);
begin

end;

{======================================================================
Записать параметры системы}
procedure TfrmMain.N5Click(Sender: TObject);
begin
 SaveParam;
end;

{======================================================================
Удалить объект}
procedure TfrmMain.N15Click(Sender: TObject);
begin
 ObjectDelete;
end;

{======================================================================
Параметры объекта}
procedure TfrmMain.N16Click(Sender: TObject);
begin

end;

{======================================================================
Вкл - оси}
procedure TfrmMain.N22Click(Sender: TObject);
begin
 CheckBox1.Checked := not CheckBox1.Checked;
 CheckBox1Click (nil);
end;

{======================================================================
Вкл - сетка}
procedure TfrmMain.N23Click(Sender: TObject);
begin
 CheckBox2.Checked := not CheckBox2.Checked;
 CheckBox2Click (nil);
end;

{======================================================================
Вкл - площадка}
procedure TfrmMain.N25Click(Sender: TObject);
begin
 CheckBox4.Checked := not CheckBox4.Checked;
 CheckBox4Click (nil);
end;

{======================================================================
Вкл - туман}
procedure TfrmMain.N29Click(Sender: TObject);
begin
 CheckBox3.Checked := not CheckBox3.Checked;
 CheckBox3Click (nil);
end;

{======================================================================
Параметры системы - загрузить}
procedure TfrmMain.N6Click(Sender: TObject);
begin
 LoadParam;
 SetProjection(nil);
end;

{======================================================================
Цвет фона}
procedure TfrmMain.N8Click(Sender: TObject);
begin
 ColorToGLU(R, G, B);
 SetProjection(nil);
end;

{======================================================================
Добавить параллепипед}
procedure TfrmMain.N10Click(Sender: TObject);
begin
end;

{======================================================================
Добавить сферу}
procedure TfrmMain.N11Click(Sender: TObject);
begin
end;

{======================================================================
Добавить цилиндр}
procedure TfrmMain.N14Click(Sender: TObject);
begin
end;

{======================================================================
Кнопка "Отменить"}
procedure TfrmMain.N13Click(Sender: TObject);
begin
 UnDo;
end;

{*********************======== ПРОЧЕЕ =======**************************}

{======================================================================
Переход курсора на панель}
procedure TfrmMain.Panel1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 flgMouseMove := False;
end;

{======================================================================
Обработка таймера}
procedure TfrmMain.Timer1Timer(Sender: TObject);
var
 Cur: TPoint;
begin
 // Таймер используется, когда кнопка нажата на любом из UpDown
 // сдвига или угла.
 // Работа с UpDown углов и сдвигов прописана вручную, анализируется
 // местонахождение курсора и нажатие кнопки мыши.
 // Этим обеспечивается корректная работа UpDown.
 // Для сравнения UpDown расстояния и длины осевых на первое нажатие
 // срабатывает как нажатие с противоположным действием.
 GetCursorPos (Cur);
 If flgUpDown2Change then begin
    Cur := UpDown2.ScreenToClient (Cur);
    UpDown2MouseDown(nil, mbLeft, [], Cur.X, Cur.Y);
    Exit;
 end;
 If flgUpDown3Change then begin
    Cur := UpDown3.ScreenToClient (Cur);
    UpDown3MouseDown(nil, mbLeft, [], Cur.X, Cur.Y);
    Exit;
 end;
 If flgUpDown4Change then begin
    Cur := UpDown4.ScreenToClient (Cur);
    UpDown4MouseDown(nil, mbLeft, [], Cur.X, Cur.Y);
    Exit;
 end;
 If flgUpDown6Change then begin
    Cur := UpDown6.ScreenToClient (Cur);
    UpDown6MouseDown(nil, mbLeft, [], Cur.X, Cur.Y);
    Exit;
 end;
 If flgUpDown7Change then begin
    Cur := UpDown7.ScreenToClient (Cur);
    UpDown7MouseDown(nil, mbLeft, [], Cur.X, Cur.Y);
    Exit;
 end;
 If flgUpDown8Change then begin
    Cur := UpDown8.ScreenToClient (Cur);
    UpDown8MouseDown(nil, mbLeft, [], Cur.X, Cur.Y);
    Exit;
 end;
end;


procedure TfrmMain.miRunDomizeClick(Sender: TObject);
var lim_x,lim_y,lim_z:integer;
//image:TpaintBox;
xi,yi,zi:integer;
tmpc:TCOlor;
ColSetMol:Integer;
begin
        lim_x:=10;
        lim_y:=10;
        lim_z:=10;
        ColSetMol:=0;
        Control:=TControl.create(lim_x,lim_y,lim_z);
        Control.RunRandomize(1,5*5*5,0.01,progress);
        eColMol.Text:=IntToStr(Control.colMol);
        eColMol.Update;

        frmMain.flgMouseMove := False;

        for zi:=0 to lim_z-1 do
          for yi:=0 to lim_y-1 do
           for xi:=0 to lim_x-1 do
           begin
           if Control.grid[xi,yi,zi] <> nil then
                With frmMain.objects [frmMain.objectcount + 1] do
                begin
                    x :=Control.grid[xi,yi,zi].x ;//StrToFloat (edtX.Text);
                    y :=Control.grid[xi,yi,zi].y;// StrToFloat (edtY.Text);
                    z :=Control.grid[xi,yi,zi].z;//StrToFloat (edtZ.Text);
//                    radius:=Control.grid[xi,yi,zi].radius;
                    l := 1;
                    k := 1;
                    h := 1;

                    kind := Sphere;

                    RotX :=0;// StrToFloat (edtRotX.Text);
                    RotY :=0;// StrToFloat (edtRotY.Text);
                    RotZ :=0;// StrToFloat (edtRotZ.Text);

                    color[0] := (random(100) + 50) / 150.0;
                    color[1] := (random(100) + 50) / 150.0;
                    color[2] := (random(100) + 50) / 150.0;
                    inc(ColSetMol);
                    progress.Progress:=trunc(zi*100/lim_z);
                    Inc (frmMain.objectcount);
                    eColSets.Text:=IntToStr(ColSetMol);
                    eColSets.Update;
//                    showmessage(intToStr(ColSetMol));
                    frmMain.DrawScene (GL_RENDER);
                end;
      end;
  frmMain.Save;

//  Visible := False;
   frmMain.DrawScene (GL_RENDER);



end;

end.
