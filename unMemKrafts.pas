unit unMemKrafts;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Buttons, ExtCtrls, Gauges, TeEngine, Series,
  TeeProcs, Chart;
type Tkraft =record
              value:real;
              idot:integer;
             end;
type
  TfrmMemKrafts = class(TForm)
    PageControl1: TPageControl;
    tsData: TTabSheet;
    memKrafts: TRichEdit;
    pnlTop: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    btnSortByValue_kraft: TBitBtn;
    btnShow: TBitBtn;
    btnSortByIndex_kraft: TBitBtn;
    cboxIndex: TCheckBox;
    btnSortByValue_Distances: TBitBtn;
    btnSortByIndex_Distances: TBitBtn;
    btnSetIndex: TBitBtn;
    memDistance: TRichEdit;
    Splitter1: TSplitter;
    progress: TGauge;
    tsGraph: TTabSheet;
    Chart1: TChart;
    Series1: TLineSeries;
    pnlRight: TPanel;
    btnRun: TBitBtn;
    procedure btnShowClick(Sender: TObject);
    procedure btnSortByValue_kraftClick(Sender: TObject);
    procedure btnSortByIndex_kraftClick(Sender: TObject);
    procedure btnSortByValue_DistancesClick(Sender: TObject);
    procedure btnSortByIndex_DistancesClick(Sender: TObject);
    procedure btnSortAllClick(Sender: TObject);
    procedure btnSetIndexClick(Sender: TObject);
    procedure btnRunClick(Sender: TObject);
  private
    { Private declarations }
    _len:integer;
  public
    { Public declarations }
    arrKrafts: array of Tkraft;
    arrDistances:array of Tkraft;
    procedure SetArrsLen(len:integer);
    procedure ShowKrafts;
    procedure ShowDistances;
  end;

var
  frmMemKrafts: TfrmMemKrafts;

implementation

{$R *.dfm}
procedure TfrmMemKrafts.SetArrsLen(len:integer);
begin
 setLength(arrkrafts,len);
 setLength(arrdistances,len);
 _len:=len;
end;
procedure TfrmMemKrafts.ShowDistances;
var idot:integer;
 sr:string;
begin
   memDistance.Clear;
   for iDot:=0 to _len-1 do
   begin
    str(arrDistances[idot].value:2:3,sr);
    if cboxIndex.Checked then
    begin
      memDistance.Lines.Add(intToStr(arrDistances[idot].idot+1)+'= '+sr);

    end else
    begin
      memDistance.Lines.Add(sr);

    end;

   end;

end;
procedure TfrmMemKrafts.ShowKrafts;
var idot:integer;
 skraft:string;
begin
   memKrafts.Clear;
   for iDot:=0 to _len-1 do
   begin
    str(arrKrafts[idot].value:2:3,skraft);
    if cboxIndex.Checked then
    begin

      memKrafts.Lines.Add(intToStr(arrKrafts[idot].idot+1)+'= '+skraft);
    end else
    begin
      memKrafts.Lines.Add(skraft);

    end;

   end;
end;
//+++++++++++++++++
procedure TfrmMemKrafts.btnShowClick(Sender: TObject);
var idot:integer;
 skraft,sr:string;
begin
   memKrafts.Clear;
   memDistance.Clear;
   for iDot:=0 to _len-1 do
   begin
    str(arrKrafts[idot].value:2:3,skraft);
    str(arrDistances[idot].value:2:3,sr);
    if cboxIndex.Checked then
    begin
      memDistance.Lines.Add(intToStr(arrDistances[idot].idot+1)+'= '+sr);
      memKrafts.Lines.Add(intToStr(arrKrafts[idot].idot+1)+'= '+skraft);
    end else
    begin
      memDistance.Lines.Add(sr);
      memKrafts.Lines.Add(skraft);

    end;

   end;

end;

procedure TfrmMemKrafts.btnSortByValue_kraftClick(Sender: TObject);
var k,i:integer;
   b:real;
   id:integer;
begin
  for k:=_len-1 downto 1 do
  begin
   for i:=0 to k-1 do
    if arrKrafts[i].value > arrKrafts[i+1].value then
    begin
      b:=arrKrafts[i].value;
      id:=arrKrafts[i].idot;
      arrKrafts[i].value:=arrKrafts[i+1].value;
      arrKrafts[i].idot:=arrKrafts[i+1].idot;
      arrKrafts[i+1].value:=b;
      arrKrafts[i+1].idot:=id;
    end;
   progress.Progress:=trunc(100-k*100/(_len-1));
   end;
   progress.Progress:=100;
   ShowKrafts;
end;

procedure TfrmMemKrafts.btnSortByIndex_kraftClick(Sender: TObject);
var k,i:integer;
   b:real;
   id:integer;
begin

  for k:=_len-1 downto 1 do
  begin
   for i:=0 to k-1 do
    if arrKrafts[i].idot > arrKrafts[i+1].idot then
    begin
      b:=arrKrafts[i].value;
      id:=arrKrafts[i].idot;
      arrKrafts[i].value:=arrKrafts[i+1].value;
      arrKrafts[i].idot:=arrKrafts[i+1].idot;
      arrKrafts[i+1].value:=b;
      arrKrafts[i+1].idot:=id;
    end;
   progress.Progress:=trunc(100-k*100/(_len-1));
  end;
   progress.Progress:=100;
   ShowKrafts;
end;

procedure TfrmMemKrafts.btnSortByValue_DistancesClick(Sender: TObject);
var k,i:integer;
   b:real;
   id:integer;
begin
  for k:=_len-1 downto 1 do
  begin
   for i:=0 to k-1 do
    if arrDistances[i].value > arrDistances[i+1].value then
    begin
      b:=arrDistances[i].value;
      id:=arrDistances[i].idot;
      arrDistances[i].value:=arrDistances[i+1].value;
      arrDistances[i].idot:=arrDistances[i+1].idot;
      arrDistances[i+1].value:=b;
      arrDistances[i+1].idot:=id;
    end;
   progress.Progress:=trunc(100-k*100/(_len-1));
  end;
   progress.Progress:=100;
   ShowDistances;


end;

procedure TfrmMemKrafts.btnSortByIndex_DistancesClick(Sender: TObject);
var k,i:integer;
   b:real;
   id:integer;
begin
  for k:=_len-1 downto 1 do
  begin
   for i:=0 to k-1 do
    if arrDistances[i].idot > arrDistances[i+1].idot then
    begin
      b:=arrDistances[i].value;
      id:=arrDistances[i].idot;
      arrDistances[i].value:=arrDistances[i+1].value;
      arrDistances[i].idot:=arrDistances[i+1].idot;
      arrDistances[i+1].value:=b;
      arrDistances[i+1].idot:=id;
    end;
   progress.Progress:=trunc(100-k*100/(_len-1));
  end;
   progress.Progress:=100;
   ShowDistances;

end;

procedure TfrmMemKrafts.btnSortAllClick(Sender: TObject);
var k,i:integer;
   b2,b:real;
   id2,id:integer;
begin
  for k:=_len-1 downto 1 do
  begin
   for i:=0 to k-1 do
    if arrKrafts[i].value > arrKrafts[i+1].value then
    begin
      b:=arrKrafts[i].value;
      id:=arrKrafts[i].idot;
      arrKrafts[i].value:=arrKrafts[i+1].value;
      arrKrafts[i].idot:=arrKrafts[i+1].idot;
      arrKrafts[i+1].value:=b;
      arrKrafts[i+1].idot:=id;
//    if arrDistances[i].value > arrDistances[i+1].value then
//    begin
      b2:=arrDistances[i].value;
      id2:=arrDistances[i].idot;
      arrDistances[i].value:=arrDistances[i+1].value;
      arrDistances[i].idot:=arrDistances[i+1].idot;
      arrDistances[i+1].value:=b2;
      arrDistances[i+1].idot:=id2;
//    end;

    end;
   progress.Progress:=trunc(100-k*100/(_len-1));
   end;
   progress.Progress:=100;
   ShowKrafts;


end;

procedure TfrmMemKrafts.btnSetIndexClick(Sender: TObject);
var k,i:integer;
   b2,b:real;
   id2,id:integer;
begin
  for k:=_len-1 downto 1 do
  begin
   for i:=0 to k-1 do
    if arrDistances[i].value > arrDistances[i+1].value then
    begin
      b:=arrKrafts[i].value;
      id:=arrKrafts[i].idot;
      arrKrafts[i].value:=arrKrafts[i+1].value;
      arrKrafts[i].idot:=arrKrafts[i+1].idot;
      arrKrafts[i+1].value:=b;
      arrKrafts[i+1].idot:=id;

      b2:=arrDistances[i].value;
      id2:=arrDistances[i].idot;
      arrDistances[i].value:=arrDistances[i+1].value;
      arrDistances[i].idot:=arrDistances[i+1].idot;
      arrDistances[i+1].value:=b2;
      arrDistances[i+1].idot:=id2;


    end;
   progress.Progress:=trunc(100-k*100/(_len-1));
   end;
   progress.Progress:=100;
   btnShow.Click;



end;

procedure TfrmMemKrafts.btnRunClick(Sender: TObject);
var i,j:integer;
begin
  Series1.Clear;
  for i:=0 to _len-1 do
  begin
    Series1.AddXY(arrDistances[i].value,arrKrafts[i].value,'',clred);
  end;
end;

end.
