unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Mask, Vcl.StdCtrls;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    ListBox1: TListBox;
    Button1: TButton;
    Edit1: TEdit;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    MaskEdit1: TMaskEdit;
    Label2: TLabel;
    Edit5: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ComboBox1KeyPress(Sender: TObject; var Key: Char);
    procedure ComboBox2KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}
uses lista_plikowa;


procedure TForm2.Button1Click(Sender: TObject);
var                           // Konczenie edycji po uzupelnieniu pól
    button,indeks,indeks2: integer;
    czolg: spis;
    wyraz1: string;
begin
    if listbox1.Items.Count<>0 then
    begin
        listbox1.items.Clear;
        button:=messagedlg('Czy na pewno chcesz zmieniæ dane w tym wierszu?',mtwarning,[mbYes,mbNo],0);                                              //popupmenu usun
        if button=mrYes then
        begin

            if (edit1.Text='') or (combobox1.Text='') or (combobox2.Text='') or (edit2.Text='') or (edit3.Text='')
            or (edit4.Text='') or (maskedit1.Text='') then
            begin
                showmessage('Nie dodam pustych pól.');
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
                czolg.penetracja:=edit3.text;
                czolg.predkosc:=edit4.text;
                czolg.pancerz:=maskedit1.Text;
                czolg.identyfikator:=strtoint(edit5.text);

                indeks:=strtoint(lista_plikowa.BAZA.Edit1.text);
                usun(first,indeks,kontrola);
                dodaj(czolg,first,kontrola);
                lista_plikowa.BAZA.usun_liste ();
                BAZA.opcje_sortowania();
                edit1.Clear;
                combobox1.text:=combobox1.Items[-1];
                combobox2.text:=combobox2.Items[-1];
                edit2.Clear;
                Edit3.Clear;
                Edit4.Clear;
                maskedit1.Clear;
                Edit5.Clear;
                kontrola:=0;
                BAZA.Button4Click(baza);
            end;
        end;
    end;
    BAZA.Enabled:=true;
    Form2.Hide;
end;

procedure TForm2.ComboBox1KeyPress(Sender: TObject; var Key: Char);
begin
    if (Key>=#48) and (Key<=#57) then Key:=#0;
end;

procedure TForm2.ComboBox2KeyPress(Sender: TObject; var Key: Char);
begin
    if (Key>=#48) and (Key<=#57) then Key:=#0;
end;

procedure TForm2.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
    BAZA.Enabled:=true;
end;

end.
