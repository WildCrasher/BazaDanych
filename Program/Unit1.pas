unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Mask, Vcl.StdCtrls;


type
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    ComboBox1: TComboBox;
    Button2: TButton;
    ComboBox2: TComboBox;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    MaskEdit1: TMaskEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Button2Click(Sender: TObject);
    procedure ComboBox1KeyPress(Sender: TObject; var Key: Char);
    procedure ComboBox2KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
implementation

{$R *.dfm}
uses lista_plikowa;


procedure TForm1.Button1Click(Sender: TObject);
var                                   //dodanie do listy elementow z editow
    wyraz1: string;
    czolg: spis;
    indeks2: integer;
begin
    if (edit1.Text='') or (combobox1.Text='') or (combobox2.Text='') or (Edit2.Text='') or (Edit3.Text='')
    or (Edit4.Text='') or (maskedit1.Text='') then
    begin
        showmessage('Któreœ pole zapewne jest puste, uzupe³nij je.');
    end
    else
    begin
        wyraz1:=edit1.Text;
        wyraz1:=Trim(wyraz1);
        wyraz1:=UpperCase(wyraz1[1])+wyraz1;
        Delete(wyraz1, 2, 1);
        czolg.nazwa:=wyraz1;

        wyraz1:=combobox1.Text;
        wyraz1:=Trim(wyraz1);
        wyraz1:=UpperCase(wyraz1[1])+wyraz1;
        Delete(wyraz1, 2, 1);
        czolg.nacja:=wyraz1;

        wyraz1:=combobox2.Text;
        wyraz1:=Trim(wyraz1);
        wyraz1:=UpperCase(wyraz1[1])+wyraz1;
        Delete(wyraz1, 2, 1);
        czolg.typ:=wyraz1;

        czolg.kaliber:=edit2.text;
        czolg.penetracja:=Edit3.Text;
        czolg.predkosc:=edit4.Text;
        czolg.pancerz:=maskedit1.text;
        czolg.identyfikator:=identyfikator;
        dodaj(czolg,first,kontrola);
        lista_plikowa.BAZA.usun_liste ();
        kontrola:=0;
        BAZA.opcje_sortowania();
        BAZA.enabled:=true;
        form1.Hide;
        inc(identyfikator);
        if lista_plikowa.BAZA.stringgrid1.Height<450 then lista_plikowa.BAZA.stringgrid1.Height:=lista_plikowa.BAZA.stringgrid1.Height+24;
        BAZA.Button4Click(baza);
     end;
end;


procedure TForm1.Button2Click(Sender: TObject);
begin                                 //czyszczenie editow
    edit1.Clear;
    combobox1.text:=combobox1.Items[-1];
    combobox2.text:=combobox2.Items[-1];
    edit2.Clear;
    Edit3.Clear;
    Edit4.Clear;
    maskedit1.Clear;
end;


procedure TForm1.ComboBox1KeyPress(Sender: TObject; var Key: Char);
begin
    if (Key>=#48) and (Key<=#57) then Key:=#0;
end;

procedure TForm1.ComboBox2KeyPress(Sender: TObject; var Key: Char);
begin
    if (Key>=#48) and (Key<=#57) then Key:=#0;
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
    BAZA.Enabled:=true;
end;


end.
