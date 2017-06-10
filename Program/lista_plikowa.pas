unit lista_plikowa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids, Vcl.Menus,
  Vcl.Mask, Vcl.Imaging.jpeg, Vcl.ExtCtrls, StrUtils;

type plista = ^element;

      spis = record
        nazwa: string[25];
        nacja: string[20];
        typ: string[20];
        kaliber: string[5];
        penetracja: string[5];
        predkosc: string[5];
        pancerz: string[12];
        identyfikator: integer;
        end;

      element = record
        dane: spis;
        nastepny: plista;

  end;

type
  TBAZA = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    StringGrid1: TStringGrid;
    PopupMenu1: TPopupMenu;
    Usu1: TMenuItem;
    Edytuj1: TMenuItem;
    Label16: TLabel;
    MainMenu1: TMainMenu;
    Opcje1: TMenuItem;
    Usu2: TMenuItem;
    Edytuj2: TMenuItem;
    Zapiszdopliku1: TMenuItem;
    Image1: TImage;
    Usuplik1: TMenuItem;
    FileOpenDialog1: TFileOpenDialog;
    o1: TMenuItem;
    Wybierzzdjcie1: TMenuItem;
    FileOpenDialog2: TFileOpenDialog;
    FileSaveDialog1: TFileSaveDialog;
    Zapiszjako1: TMenuItem;
    Wybierzzdjcie2: TMenuItem;
    Otwrz1: TMenuItem;
    FileOpenDialog3: TFileOpenDialog;
    Sortujwedug1: TMenuItem;
    Nazwa1: TMenuItem;
    Nacja1: TMenuItem;
    yp1: TMenuItem;
    Kaliber1: TMenuItem;
    Penetracja1: TMenuItem;
    Prdkomax1: TMenuItem;
    Pancerz1: TMenuItem;
    Edit2: TEdit;
    Label1: TLabel;
    Okno1: TMenuItem;
    Penyekran1: TMenuItem;
    Zmianarozmiaru1: TMenuItem;
    Button3: TButton;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Button4: TButton;
    Edit3: TEdit;
    Edit4: TEdit;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    RadioButton5: TRadioButton;
    Label2: TLabel;
    RozmiarDomylny1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Usu1Click(Sender: TObject);
    procedure Edytuj1Click(Sender: TObject);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
    procedure Usu2Click(Sender: TObject);
    procedure Edytuj2Click(Sender: TObject);
    procedure Zapiszdopliku1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Usuplik1Click(Sender: TObject);
    procedure Wybierzzdjcie1Click(Sender: TObject);
    procedure FileOpenDialog1FileOkClick(Sender: TObject; var CanClose: Boolean);
    procedure FileOpenDialog2FileOkClick(Sender: TObject;var CanClose: Boolean);
    procedure FileOpenDialog3FileOkClick(Sender: TObject; var CanClose: Boolean);
    procedure Otwrz1Click(Sender: TObject);
    procedure FileSaveDialog1FileOkClick(Sender: TObject;var CanClose: Boolean);
    procedure Zapiszjako1Click(Sender: TObject);
    procedure Nazwa1Click(Sender: TObject);
    procedure Nacja1Click(Sender: TObject);
    procedure yp1Click(Sender: TObject);
    procedure Edit2KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Penyekran1Click(Sender: TObject);
    procedure Zmianarozmiaru1Click(Sender: TObject);
    procedure Kaliber1Click(Sender: TObject);
    procedure Penetracja1Click(Sender: TObject);
    procedure Prdkomax1Click(Sender: TObject);
    procedure StringGrid1FixedCellClick(Sender: TObject; ACol, ARow: Integer);
    procedure Button3Click(Sender: TObject);
    procedure ComboBox1KeyPress(Sender: TObject; var Key: Char);
    procedure ComboBox2KeyPress(Sender: TObject; var Key: Char);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure ComboBox1Select(Sender: TObject);
    procedure ComboBox2Select(Sender: TObject);
    procedure RadioButton3Click(Sender: TObject);
    procedure RadioButton4Click(Sender: TObject);
    procedure RadioButton5Click(Sender: TObject);
    procedure Edit3KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit4KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure RozmiarDomylny1Click(Sender: TObject);

  private
    { Private declarations }

  public
  procedure wyswietl (first: plista);
  procedure edytuj (curr: plista);
  procedure do_grida (wiersz: integer);
  procedure czyszczenie_grida();
  procedure uniwersalne_usuwanie(indeks: integer);
  procedure uniwersalne_edytowanie(indeks: integer);
  procedure usun_liste ();
  procedure filtrowanie (filter: integer);
  procedure filtrowanie2 (filter: integer);
  procedure opcje_sortowania();
  procedure opcje_sortowania2();
    { Public declarations }
  end;

var
    BAZA: TBAZA;
    plik : file of spis;
    curr,curr2,first,prev,wsk,first3: plista;
    kontrola,identyfikator,kontrola2,licznik_grida,sortowanie: integer;   //1 decyduje czy zamknac program (brak zapisu)
    czolg_usun,czolg: spis;                       //3 do zwiekszania rozmiaru grida na pocztaku
    nazwa_pliku: string;               //2 decyduje o przywroceniu usunietego rekordu

    procedure zapisz_do_pliku(var wsk: plista; var kontrola: integer; var nazwa_pliku: string); stdcall external 'biblioteka.dll' name 'zapisz_do_pliku';
    procedure wczytaj_z_pliku(var wsk: plista; var kontrola: integer; var nazwa_pliku: string); stdcall external 'biblioteka.dll' name 'wczytaj_z_pliku';
    procedure dodaj(var czolg: spis; var wsk: plista; var kontrola: integer); stdcall external 'biblioteka.dll' name 'dodaj';
    procedure usun(var first: plista; var indeks: integer; var kontrola: integer); stdcall external 'biblioteka.dll' name 'usun';
    procedure sortuj_wg_nazwy(var wsk: plista; var kontrola: integer); stdcall external 'biblioteka.dll' name 'sortuj_wg_nazwy';
    procedure sortuj_wg_nacji(var wsk: plista; var kontrola: integer); stdcall external 'biblioteka.dll' name 'sortuj_wg_nacji';
    procedure sortuj_wg_typu(var wsk: plista; var kontrola: integer); stdcall external 'biblioteka.dll' name 'sortuj_wg_typu';
    procedure sortuj_wg_kalibru(var wsk: plista; var kontrola: integer); stdcall external 'biblioteka.dll' name 'sortuj_wg_kalibru';
    procedure sortuj_wg_penetracji(var wsk: plista; var kontrola: integer); stdcall external 'biblioteka.dll' name 'sortuj_wg_penetracji';
    procedure sortuj_wg_predkosci(var wsk: plista; var kontrola: integer); stdcall external 'biblioteka.dll' name 'sortuj_wg_predkosci';
    procedure przygotuj_rekordy(var czolg: spis; var curr: plista); stdcall external 'biblioteka.dll' name 'przygotuj_rekordy';
implementation


{$R *.dfm}
uses unit1,unit2;


procedure TBAZA.czyszczenie_grida();
var  indeks, indeks2 : integer;
begin
    for indeks := 1 to stringgrid1.ColCount do
    for indeks2 := 1 to stringgrid1.RowCount do
      stringgrid1.Cells[indeks,indeks2]:='';
end;

procedure TBAZA.opcje_sortowania();
begin
    if sortowanie=1 then
    begin
        sortuj_wg_nazwy(first,kontrola);
        wyswietl(first);
    end;
    if sortowanie=2 then
    begin
        sortuj_wg_nacji(first,kontrola);
        wyswietl(first);
    end;
    if sortowanie=3 then
    begin
        sortuj_wg_typu(first,kontrola);
        wyswietl(first);
    end;
    if sortowanie=4 then
    begin
        sortuj_wg_kalibru(first,kontrola);
        wyswietl(first);
    end;
    if sortowanie=5 then
    begin
        sortuj_wg_penetracji(first,kontrola);
        wyswietl(first);
    end;
    if sortowanie=6 then
    begin
        sortuj_wg_predkosci(first,kontrola);
        wyswietl(first);
    end;
end;

procedure TBAZA.opcje_sortowania2();
begin
    if sortowanie=1 then
    begin
        sortuj_wg_nazwy(first3,kontrola);
        wyswietl(first3);
    end;
    if sortowanie=2 then
    begin
        sortuj_wg_nacji(first3,kontrola);
        wyswietl(first3);
    end;
    if sortowanie=3 then
    begin
        sortuj_wg_typu(first3,kontrola);
        wyswietl(first3);
    end;
    if sortowanie=4 then
    begin
        sortuj_wg_kalibru(first3,kontrola);
        wyswietl(first3);
    end;
    if sortowanie=5 then
    begin
        sortuj_wg_penetracji(first3,kontrola);
        wyswietl(first3);
    end;
    if sortowanie=6 then
    begin
        sortuj_wg_predkosci(first3,kontrola);
        wyswietl(first3);
    end;
end;


procedure TBAZA.filtrowanie (filter: integer);
begin
    usun_liste();
    curr:=first;
    while curr<>nil do
    begin
        if curr^.dane.nacja=combobox1.items[filter] then
        begin
            przygotuj_rekordy(czolg,curr);
            dodaj(czolg,first3,kontrola);
        end;
        curr:=curr^.nastepny;
    end;
    wyswietl(first3);
end;


procedure TBAZA.filtrowanie2 (filter: integer);
begin
    usun_liste();
    curr:=first;
    while curr^.nastepny<>nil do
    begin
        if curr^.dane.typ=combobox2.items[filter] then
        begin
            przygotuj_rekordy(czolg,curr);
            dodaj(czolg,first3,kontrola);
        end;
        curr:=curr^.nastepny;
    end;
    wyswietl(first3);
end;


procedure TBAZA.usun_liste ();
var indeks2: integer;            //usuwanie listy wyszkuaj/filtruj
begin
    if first3<>nil then
    begin
        indeks2:=1;
    repeat
        usun(first3,indeks2,kontrola);
        inc(indeks2);
    until first3=nil;
    end;
    edit2.Text:='';
end;

procedure TBAZA.do_grida (wiersz: integer);
var  kolumna: integer;                                 // wrzucenie do grida danych
begin
    if wiersz=stringgrid1.RowCount then stringgrid1.RowCount:=stringgrid1.RowCount+1;

    stringgrid1.Cells[0,wiersz]:='Czolg'+inttostr(wiersz);

    kolumna:=1;
    stringgrid1.Cells[kolumna,wiersz]:=curr^.dane.nazwa;
    inc(kolumna);
    stringgrid1.Cells[kolumna,wiersz]:=curr^.dane.nacja;
    inc(kolumna);
    stringgrid1.Cells[kolumna,wiersz]:=curr^.dane.typ;
    inc(kolumna);
    stringgrid1.Cells[kolumna,wiersz]:=curr^.dane.kaliber;
    inc(kolumna);
    stringgrid1.Cells[kolumna,wiersz]:=curr^.dane.penetracja;
    inc(kolumna);
    stringgrid1.Cells[kolumna,wiersz]:=curr^.dane.predkosc;
    inc(kolumna);
    stringgrid1.Cells[kolumna,wiersz]:=curr^.dane.pancerz;
end;



procedure TBAZA.Edit2KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var                                             // wyszukiwanie rekordow
    wyraz: string;
    indeks: integer;
begin
    indeks:=1;
    radiobutton1.Checked:=false;
    radiobutton2.Checked:=false;
    radiobutton3.Checked:=false;
    radiobutton4.Checked:=false;
    radiobutton5.Checked:=false;
    combobox1.text:=combobox1.Items[-1];
    combobox2.text:=combobox2.Items[-1];
    edit3.Clear;
    edit4.Clear;
    edit3.Enabled:=false;
    edit4.Enabled:=false;
    combobox1.Enabled:=false;
    combobox2.Enabled:=false;
    if (edit2.Text='') then
    begin
        if first3<>nil then
        begin
            repeat
                usun(first3,indeks,kontrola);
                inc(indeks);
            until first3=nil;
        end;
        wyswietl(first)
    end
    else
    begin
        if first3<>nil then
        begin
            repeat
                usun(first3,indeks,kontrola);
                inc(indeks);
            until first3=nil;
        end;
        curr:=first;
        wyraz:=edit2.Text;
        while curr<>nil do
        begin
            if (AnsiContainsText(curr^.dane.nazwa,wyraz)) or (AnsiContainsText(curr^.dane.nacja,wyraz)) or (AnsiContainsText(curr^.dane.typ,wyraz)) or (AnsiContainsText(curr^.dane.kaliber,wyraz)) or (AnsiContainsText(curr^.dane.penetracja,wyraz)) or (AnsiContainsText(curr^.dane.predkosc,wyraz)) or (AnsiContainsText(curr^.dane.pancerz,wyraz)) then
            begin
                przygotuj_rekordy(czolg,curr);
                dodaj(czolg,first3,kontrola);
            end;
            curr:=curr^.nastepny;
        end;
        opcje_sortowania2();
    end;
end;

procedure TBAZA.Edit3KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin                                                // filter pol liczbowych 1 edit
    if (edit3.Text<>'') and (edit4.Text<>'') then
    begin
        if radiobutton3.Checked then
        begin
            usun_liste();
            curr:=first;
            while curr<>nil do
            begin
                if (strtoint(curr^.dane.kaliber)>=strtoint(edit3.text)) and (strtoint(curr^.dane.kaliber)<=strtoint(edit4.text)) then
                begin
                    przygotuj_rekordy(czolg,curr);
                    dodaj(czolg,first3,kontrola);
                end;
                curr:=curr^.nastepny;
            end;
            opcje_sortowania2();
        end;
        if radiobutton4.Checked then
        begin
            usun_liste();
            curr:=first;
            while curr<>nil do
            begin
                if (strtoint(curr^.dane.penetracja)>=strtoint(edit3.text)) and (strtoint(curr^.dane.penetracja)<=strtoint(edit4.text)) then
                begin
                    przygotuj_rekordy(czolg,curr);
                    dodaj(czolg,first3,kontrola);
                end;
                curr:=curr^.nastepny;
            end;
            opcje_sortowania2();
        end;

        if radiobutton5.Checked then
        begin
            usun_liste();
            curr:=first;
            while curr<>nil do
            begin
                if (strtoint(curr^.dane.predkosc)>=strtoint(edit3.text)) and (strtoint(curr^.dane.predkosc)<=strtoint(edit4.text)) then
                begin
                    przygotuj_rekordy(czolg,curr);
                    dodaj(czolg,first3,kontrola);
                end;
                curr:=curr^.nastepny;
            end;
            opcje_sortowania2();
        end;
    end;
end;

procedure TBAZA.Edit4KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin                                                     //filter 2 edit
    if (edit3.Text<>'') and (edit4.Text<>'') then
    begin
        if radiobutton3.Checked then
        begin
            usun_liste();
            curr:=first;
            while curr<>nil do
            begin
                if (strtoint(curr^.dane.kaliber)>=strtoint(edit3.text)) and (strtoint(curr^.dane.kaliber)<=strtoint(edit4.text)) then
                begin
                    przygotuj_rekordy(czolg,curr);
                    dodaj(czolg,first3,kontrola);
                end;
                curr:=curr^.nastepny;
            end;
            opcje_sortowania2();
        end;
        if radiobutton4.Checked then
        begin
            usun_liste();
            curr:=first;
            while curr<>nil do
            begin
                if (strtoint(curr^.dane.penetracja)>=strtoint(edit3.text)) and (strtoint(curr^.dane.penetracja)<=strtoint(edit4.text)) then
                begin
                    przygotuj_rekordy(czolg,curr);
                    dodaj(czolg,first3,kontrola);
                end;
                curr:=curr^.nastepny;
            end;
            opcje_sortowania2();
        end;

        if radiobutton5.Checked then
        begin
            usun_liste();
            curr:=first;
            while curr<>nil do
            begin
                if (strtoint(curr^.dane.predkosc)>=strtoint(edit3.text)) and (strtoint(curr^.dane.predkosc)<=strtoint(edit4.text)) then
                begin
                    przygotuj_rekordy(czolg,curr);
                    dodaj(czolg,first3,kontrola);
                end;
                curr:=curr^.nastepny;
            end;
            opcje_sortowania2();
        end;
    end;
end;

procedure zachowaj_usuniete (curr: plista);
begin                                       // spisanie rekordu przed usunieciem
       czolg_usun.nazwa:=curr^.dane.nazwa;
       czolg_usun.nacja:=curr^.dane.nacja;
       czolg_usun.typ:=curr^.dane.typ;
       czolg_usun.kaliber:=curr^.dane.kaliber;
       czolg_usun.penetracja:=curr^.dane.penetracja;
       czolg_usun.predkosc:=curr^.dane.predkosc;
       czolg_usun.pancerz:=curr^.dane.pancerz;
       czolg_usun.identyfikator:=curr^.dane.identyfikator;
       kontrola2:=1;
end;


procedure TBAZA.uniwersalne_usuwanie(indeks: integer);
var
    indeks2,licznik: integer;
begin
    licznik:=1;
    if first3=nil then curr:=first
    else curr:=first3;
    if curr<>nil then
    begin
        while (curr^.nastepny<>nil) and (licznik<indeks)do
        begin
            curr:=curr^.nastepny;
            inc(licznik);
        end;
        indeks:=curr^.dane.identyfikator;
        zachowaj_usuniete(curr);
        usun(first,indeks,kontrola);
    end;
    usun_liste();
    wyswietl(first);
end;


procedure TBAZA.uniwersalne_edytowanie(indeks: integer);
var
    licznik: integer;
begin
    licznik:=1;
    if first3=nil then curr:=first
    else curr:=first3;
    if curr<>nil then
    begin
        while (curr^.nastepny<>nil) and (licznik<indeks)do
        begin
            curr:=curr^.nastepny;
            inc(licznik);
        end;
        edit1.Text:=inttostr(curr^.dane.identyfikator);
        edytuj(curr);
    end;
end;


procedure TBAZA.edytuj (curr : plista);
begin                                   // spisanie danych z danego rekordu
    unit2.Form2.Edit1.text:=curr^.dane.nazwa;
    unit2.Form2.ComboBox1.text:=curr^.dane.nacja;
    unit2.Form2.ComboBox2.text:=curr^.dane.typ;
    unit2.Form2.Edit2.text:=curr^.dane.kaliber;
    unit2.Form2.Edit3.text:=curr^.dane.penetracja;
    unit2.Form2.Edit4.text:=curr^.dane.predkosc;
    unit2.Form2.MaskEdit1.text:=curr^.dane.pancerz;
    unit2.Form2.edit5.text:=inttostr(curr^.dane.identyfikator);
end;


procedure TBAZA.wyswietl (first: plista);
var  wiersz: integer;                                     //wyswietla aktualny stan listy
begin
    curr:=first;
    wiersz:=1;
    czyszczenie_grida();
    if curr<>nil then
    begin
       repeat
          inc(licznik_grida);
          do_grida(wiersz);
          curr:=curr^.nastepny;
          inc(wiersz);
       until curr=nil;
    end;
end;


procedure TBAZA.Button1Click(Sender: TObject);
begin                               //dodanie do listy elementow z editow
    form1.Show;
    BAZA.Enabled:=false;
end;


procedure TBAZA.Button2Click(Sender: TObject);
var indeks2: integer;
begin                                             // przywracanie usunietego rekordu
    if kontrola2=1 then
    begin
        dodaj(czolg_usun,first,kontrola);
        usun_liste();
        opcje_sortowania();
        kontrola2:=2;
        if stringgrid1.Height<450 then stringgrid1.Height:=stringgrid1.Height+24;
        Button4Click(baza);
    end;
end;

procedure TBAZA.Button3Click(Sender: TObject);
begin
    radiobutton1.Checked:=false;
    radiobutton2.Checked:=false;
    radiobutton3.Checked:=false;
    radiobutton4.Checked:=false;
    radiobutton5.Checked:=false;
    combobox1.text:=combobox1.Items[-1];
    combobox2.text:=combobox2.Items[-1];
    edit3.Clear;
    edit4.Clear;
    edit3.Enabled:=false;
    edit4.Enabled:=false;
    combobox1.Enabled:=false;
    combobox2.Enabled:=false;
    usun_liste();
    wyswietl(first);
end;

procedure TBAZA.Button4Click(Sender: TObject);
begin
    radiobutton1.Checked:=false;
    radiobutton2.Checked:=false;
    radiobutton3.Checked:=false;
    radiobutton4.Checked:=false;
    radiobutton5.Checked:=false;
    combobox1.text:=combobox1.Items[-1];
    combobox2.text:=combobox2.Items[-1];
    edit3.Clear;
    edit4.Clear;
    edit3.Enabled:=false;
    edit4.Enabled:=false;
    combobox1.Enabled:=false;
    combobox2.Enabled:=false;
    usun_liste();
    wyswietl(first);
end;

procedure TBAZA.ComboBox1KeyPress(Sender: TObject; var Key: Char);
var button: integer;                                     //zabezpiecznie przed pisaniem cmb1
begin
    button:=messagedlg('Wybierz pole z rozsuwanej listy',mtinformation,[mbYes],0);
    Key:=#0;
end;

procedure TBAZA.ComboBox1Select(Sender: TObject);
begin                                //wybranie filtrowania wg nacji
    filtrowanie(combobox1.ItemIndex);
end;

procedure TBAZA.ComboBox2KeyPress(Sender: TObject; var Key: Char);
var button: integer;                          //zabezpiecznie przed pisaniem cmb2
begin
    button:=messagedlg('Wybierz pole z rozsuwanej listy',mtinformation,[mbYes],0);
    Key:=#0;
end;

procedure TBAZA.ComboBox2Select(Sender: TObject);
begin                                  //wybranie filtrowania wg typu
    filtrowanie2(combobox2.ItemIndex);
end;

procedure TBAZA.Wybierzzdjcie1Click(Sender: TObject);
begin                                            // Tmenu zdjecie
    fileopendialog1.Execute;
end;

procedure TBAZA.FileOpenDialog1FileOkClick(Sender: TObject; var CanClose: Boolean);
begin                                                        // zaladowanie obrazka
    image1.Picture.LoadFromFile(fileopendialog1.FileName);
end;

procedure TBAZA.FileOpenDialog2FileOkClick(Sender: TObject; var CanClose: Boolean);
begin                                                     //przypisanie nazwy pliku ktory otworzy sie na poczatku programu
    nazwa_pliku:=fileopendialog2.FileName;
end;

procedure TBAZA.Otwrz1Click(Sender: TObject);
begin                                      // otwarcie wybranego pliku
    fileopendialog3.Execute;
end;


procedure TBAZA.Penyekran1Click(Sender: TObject);
begin                                      //pelny ekran
    BAZA.Align:=alClient;
    BAZA.BorderStyle:=bssingle;
    BAzA.WindowState:=wsNormal;
end;

procedure TBAZA.Zmianarozmiaru1Click(Sender: TObject);
begin                                             //mozliwosc zmiany rozmiaru okienka
    BAZA.Align:=alNone;
    BAZA.BorderStyle:=bsSizeable;
    BAZA.ClientHeight:=690;
    BAZA.ClientWidth:=1240;
end;

procedure TBAZA.RozmiarDomylny1Click(Sender: TObject);
begin
    BAZA.Align:=alNone;
    BAZA.BorderStyle:=bssingle;
    BAZA.ClientHeight:=706;
    BAZA.ClientWidth:=1270;
end;

procedure TBAZA.RadioButton1Click(Sender: TObject);
begin
    usun_liste();
    wyswietl(first3);                                         //uruchamianie filtru nacji
    combobox1.Enabled:=true;
    combobox2.text:=combobox2.Items[-1];
    combobox2.Enabled:=false;
end;

procedure TBAZA.RadioButton2Click(Sender: TObject);
begin
    usun_liste();
    wyswietl(first3);                                      //uruchamianie filtru typu
    combobox2.Enabled:=true;
    combobox1.text:=combobox1.Items[-1];
    combobox1.Enabled:=false;
end;

procedure TBAZA.RadioButton3Click(Sender: TObject);
begin
    usun_liste();
    wyswietl(first3);                                //uruchamianie filtru kalibru
    edit3.Enabled:=true;
    edit4.Enabled:=true;
    edit3.Clear;
    edit4.Clear;
    combobox2.text:=combobox2.Items[-1];
    combobox2.Enabled:=false;
    combobox1.text:=combobox1.Items[-1];
    combobox1.Enabled:=false;
end;

procedure TBAZA.RadioButton4Click(Sender: TObject);
begin
    usun_liste();
    wyswietl(first3);                               //uruchamianie filtru peny
    edit3.Enabled:=true;
    edit4.Enabled:=true;
    edit3.Clear;
    edit4.Clear;
    combobox2.text:=combobox2.Items[-1];
    combobox2.Enabled:=false;
    combobox1.text:=combobox1.Items[-1];
    combobox1.Enabled:=false;
end;

procedure TBAZA.RadioButton5Click(Sender: TObject);
begin
    usun_liste();
    wyswietl(first3);                           //uruchamianie filtru predkosci
    edit3.Enabled:=true;
    edit4.Enabled:=true;
    edit3.Clear;
    edit4.Clear;
    combobox2.text:=combobox2.Items[-1];
    combobox2.Enabled:=false;
    combobox1.text:=combobox1.Items[-1];
    combobox1.Enabled:=false;
end;


procedure TBAZA.FileOpenDialog3FileOkClick(Sender: TObject; var CanClose: Boolean);
var indeks,licznik: integer;
begin
    Button4Click(baza);                                 // otwarcie pliku podczas programu
    nazwa_pliku:=fileopendialog3.FileName;
    indeks:=1;
    licznik_grida:=1;
    if first<>nil then
    begin
        repeat
            usun(first,indeks,kontrola);
            inc(indeks);
        until first=nil;
    end;
    wczytaj_z_pliku(first,kontrola,nazwa_pliku);
    wyswietl(first);
    for licznik := 1 to licznik_grida do
    if stringgrid1.Height<450 then stringgrid1.Height:=stringgrid1.Height+24;
end;

procedure TBAZA.Zapiszdopliku1Click(Sender: TObject);
var button: integer;
begin
    if not fileexists(nazwa_pliku) then         //zapis do pliku wczesniej juz wybranego pliku
    begin
        zapisz_do_pliku(first,kontrola,nazwa_pliku);
        button:=messagedlg('Plik nie istnieje. Zaraz zostanie stworzony, a dane tam zapisane',mtinformation,[mbYes],0);
        button:=messagedlg('Plik zapisano pomyœlnie',mtinformation,[mbYes],0);
    end
    else
    begin
        zapisz_do_pliku(first,kontrola,nazwa_pliku);
        button:=messagedlg('Plik zapisano pomyœlnie',mtinformation,[mbYes],0);
    end;
end;


procedure TBAZA.Zapiszjako1Click(Sender: TObject);
begin                                          // zapis do wybranego pliku
    filesavedialog1.Execute;
end;


procedure TBAZA.FileSaveDialog1FileOkClick(Sender: TObject; var CanClose: Boolean);
var button: integer;
begin                                                 //przypisanie nazwy pliku do zapisu
    nazwa_pliku:=filesavedialog1.FileName;
    if canclose then
    begin
        zapisz_do_pliku(first,kontrola,nazwa_pliku);
        button:=messagedlg('Plik zapisano pomyœlnie',mtinformation,[mbYes],0);
    end;
end;

procedure TBAZA.Usuplik1Click(Sender: TObject);
var button: integer;                             // usun dany plik
begin
    if fileexists(nazwa_pliku) then
    begin
        button:=messagedlg('Czy na pewno chcesz usun¹æ ten plik? Ten proces jest nieodwracalny!!!',mtWarning,[mbYes,mbNo],0);
        if button=mrYes then
        begin
            DeleteFile(nazwa_pliku);
            messagedlg('Plik zosta³ usuniêty pomyœlnie.',mtinformation,[mbYes],0);
        end;
    end
    else  messagedlg('Plik nie istnieje.',mtinformation,[mbYes],0);
end;


procedure TBAZA.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var button,button2: integer;          //koniec programu przycisk X
begin
    if kontrola=0 then
    begin
        button:=messagedlg('Nie zapisa³eœ danych do pliku, czy chcesz to TERAZ zrobiæ?',mtwarning,[mbYes,mbNo,mbCancel],0);
        if button=mrYes then
        begin
            zapisz_do_pliku(first,kontrola,nazwa_pliku);
            button2:=messagedlg('Czy na pewno chcesz wyjœæ?',mtInformation,[mbYes,mbNo],0);
            if (button2=mrYes) then application.Terminate;
        end;
        if button=mrNo then
        begin
            button2:=messagedlg('Czy na pewno chcesz wyjœæ?',mtInformation,[mbYes,mbNo],0);
            if (button2=mrYes) then application.Terminate;
        end;
        if button=mrCancel then abort;
        abort;
    end
    else
    begin
        button2:=messagedlg('Czy na pewno chcesz wyjœæ?',mtInformation,[mbYes,mbNo],0);
        if (button2=mrYes) then application.Terminate;
        abort;
    end;
end;

procedure TBAZA.FormCreate(Sender: TObject);
var                                   //stworzenie pliku lub wczytanie z niego zawartosci
    licznik: integer;                               //all w momencie startu
    czolg: spis;

begin
    kontrola:=1;
    kontrola2:=2;
    fileopendialog2.Execute;
    licznik_grida:=1;
    sortowanie:=1;

    stringgrid1.Cells[1,0]:='Nazwa';
    stringgrid1.Cells[2,0]:='Nacja';
    stringgrid1.Cells[3,0]:='Typ';
    stringgrid1.Cells[4,0]:='Kaliber';
    stringgrid1.Cells[5,0]:='Penetracja';
    stringgrid1.Cells[6,0]:='Prêdkoœæ max';
    stringgrid1.Cells[7,0]:='Pancerz P / B / T';


if nazwa_pliku='' then
begin
    assignfile(plik,'czolgi_tymczasowe.dat');
    rewrite(plik);
    closefile(plik);
    nazwa_pliku:='czolgi_tymczasowe.dat';
end
else
    wczytaj_z_pliku(first,kontrola,nazwa_pliku);
    wyswietl(first);
    identyfikator:=stringgrid1.RowCount;
    for licznik := 1 to licznik_grida do
    if stringgrid1.Height<450 then stringgrid1.Height:=stringgrid1.Height+24;

end;


procedure TBAZA.Nazwa1Click(Sender: TObject);
var indeks2: integer;                         //sortowanie wg nazwy
begin
    sortuj_wg_nazwy(first,kontrola);
    Button4Click(baza);
    sortowanie:=1;
end;

procedure TBAZA.Nacja1Click(Sender: TObject);
var indeks2: integer;
begin                                      //sortowanie wg nacji
    sortuj_wg_nacji(first,kontrola);
    Button4Click(baza);
    sortowanie:=2;
end;


procedure TBAZA.yp1Click(Sender: TObject);
var indeks2: integer;
begin                                       // sortowanie wg typu
    sortuj_wg_typu(first,kontrola);
    Button4Click(baza);
    sortowanie:=3;
end;

procedure TBAZA.Kaliber1Click(Sender: TObject);
var indeks2: integer;
begin                                      //sortowanie wg kalibru
    sortuj_wg_kalibru(first,kontrola);
    Button4Click(baza);
    sortowanie:=4;
end;

procedure TBAZA.Penetracja1Click(Sender: TObject);
var indeks2: integer;
begin                                      //sortowanie wg peny
    sortuj_wg_penetracji(first,kontrola);
    Button4Click(baza);
    sortowanie:=5;
end;

procedure TBAZA.Prdkomax1Click(Sender: TObject);
var indeks2: integer;
begin                                      //sortowanie wg predkosci
    sortuj_wg_predkosci(first,kontrola);
    Button4Click(baza);
    sortowanie:=6;
end;


procedure TBAZA.StringGrid1FixedCellClick(Sender: TObject; ACol, ARow: Integer);
var kolumna: integer;
begin
    kolumna:=ACol;
    if kolumna=1 then
    begin
        sortuj_wg_nazwy(first,kontrola);
        Button4Click(baza);
        sortowanie:=1;
    end;
    if kolumna=2 then
    begin
        sortuj_wg_nacji(first,kontrola);
        Button4Click(baza);
        sortowanie:=2;
    end;
    if kolumna=3 then
    begin
        sortuj_wg_typu(first,kontrola);
        Button4Click(baza);
        sortowanie:=3;
    end;
    if kolumna=4 then
    begin
        sortuj_wg_kalibru(first,kontrola);
        Button4Click(baza);
        sortowanie:=4;
    end;
    if kolumna=5 then
    begin
        sortuj_wg_penetracji(first,kontrola);
        Button4Click(baza);
        sortowanie:=5;
    end;
    if kolumna=6 then
    begin
        sortuj_wg_predkosci(first,kontrola);
        Button4Click(baza);
        sortowanie:=6;
    end;
end;

procedure TBAZA.StringGrid1SelectCell(Sender: TObject ;ACol, ARow: Integer; var CanSelect: Boolean);
begin                                // moment klikniecia na stringgrida
    edit1.text:=inttostr(ARow);
end;



procedure TBAZA.Usu1Click(Sender: TObject);
var indeks, button: integer;                   // nowe usuwanie uniwersalne z wyszukiwaniem
begin                                                    //popupmenu usun
    if ((first<>nil) and ((not radiobutton1.checked)and(not radiobutton2.checked)and(not radiobutton3.checked)and(not radiobutton4.checked)and(not radiobutton5.checked)) and (edit2.Text='')) or ((first3<>nil) and ((radiobutton1.Checked)or(radiobutton2.Checked)or(radiobutton3.Checked)or(radiobutton4.Checked)or(radiobutton5.Checked))) or ((first<>nil) and ((not radiobutton1.checked)and(not radiobutton2.checked)and(not radiobutton3.checked)and(not radiobutton4.checked)and(not radiobutton5.checked)) and (edit2.Text<>'') and (first3<>nil)) then
    begin
        if edit1.Text<>'' then
        begin
            button:=messagedlg('Czy na pewno chcesz usun¹æ ten wiersz?',mtwarning,[mbYes,mbNo],0);                                              //popupmenu usun
            if button=mrYes then
            begin
                indeks:=strtoint(edit1.text);
                uniwersalne_usuwanie(indeks);
                if (stringgrid1.Height>200) and (stringgrid1.RowCount<21) then stringgrid1.Height:=stringgrid1.Height-24;
                stringgrid1.RowCount:=stringgrid1.RowCount-1;
                Button4Click(baza);
            end;
            edit1.text:='';
        end
    else button:=messagedlg('¯eby usun¹æ wiersz, musisz najpierw go wybraæ.',mtInformation,[mbYes],0);
    end;
end;

procedure TBAZA.Usu2Click(Sender: TObject);
var button,indeks: integer;                  //uniwersalne usuwanie wiersza Tmenu na górze
begin
    if ((first<>nil) and ((not radiobutton1.checked)and(not radiobutton2.checked)and(not radiobutton3.checked)and(not radiobutton4.checked)and(not radiobutton5.checked)) and (edit2.Text='')) or ((first3<>nil) and ((radiobutton1.Checked)or(radiobutton2.Checked)or(radiobutton3.Checked)or(radiobutton4.Checked)or(radiobutton5.Checked))) or ((first<>nil) and ((not radiobutton1.checked)and(not radiobutton2.checked)and(not radiobutton3.checked)and(not radiobutton4.checked)and(not radiobutton5.checked)) and (edit2.Text<>'') and (first3<>nil)) then
    begin
        if edit1.Text<>'' then
        begin
            button:=messagedlg('Czy na pewno chcesz usun¹æ ten wiersz?',mtwarning,[mbYes,mbNo],0);
            if button=mrYes then
            begin
                indeks:=strtoint(edit1.text);
                uniwersalne_usuwanie(indeks);
                if (stringgrid1.Height>200) and (stringgrid1.RowCount<21) then stringgrid1.Height:=stringgrid1.Height-24;
                stringgrid1.RowCount:=stringgrid1.RowCount-1;
                Button4Click(baza);
            end;
            edit1.text:='';
        end
    else button:=messagedlg('¯eby usun¹æ wiersz, musisz najpierw go wybraæ.',mtInformation,[mbYes],0);
    end;
end;


procedure TBAZA.Edytuj1Click(Sender: TObject);
var button,indeks: integer;                    //popupmenu edytuj
begin
try
    if ((first<>nil) and ((not radiobutton1.checked)and(not radiobutton2.checked)and(not radiobutton3.checked)and(not radiobutton4.checked)and(not radiobutton5.checked)) and (edit2.Text='')) or ((first3<>nil) and ((radiobutton1.Checked)or(radiobutton2.Checked)or(radiobutton3.Checked)or(radiobutton4.Checked)or(radiobutton5.Checked))) or ((first<>nil) and ((not radiobutton1.checked)and(not radiobutton2.checked)and(not radiobutton3.checked)and(not radiobutton4.checked)and(not radiobutton5.checked)) and (edit2.Text<>'') and (first3<>nil)) then
    begin
        unit2.form2.listbox1.Items.Clear;
        unit2.Form2.listbox1.items.add(edit1.Text);
        indeks:=strtoint(edit1.text);
        uniwersalne_edytowanie(indeks);
        BAZA.Enabled:=false;
        Form2.Show;
    end;
except
    button:=messagedlg('¯eby zmieniæ dane w tym wierszu, musisz najpierw go wybraæ.',mtInformation,[mbYes],0);
end;
end;


procedure TBAZA.Edytuj2Click(Sender: TObject);
var button,indeks: integer;                    //edytowanie wiersza Tmenu na górze
begin
try
    if ((first<>nil) and ((not radiobutton1.checked)and(not radiobutton2.checked)and(not radiobutton3.checked)and(not radiobutton4.checked)and(not radiobutton5.checked)) and (edit2.Text='')) or ((first3<>nil) and ((radiobutton1.Checked)or(radiobutton2.Checked)or(radiobutton3.Checked)or(radiobutton4.Checked)or(radiobutton5.Checked))) or ((first<>nil) and ((not radiobutton1.checked)and(not radiobutton2.checked)and(not radiobutton3.checked)and(not radiobutton4.checked)and(not radiobutton5.checked)) and (edit2.Text<>'') and (first3<>nil)) then
    begin
        unit2.form2.listbox1.Items.Clear;
        unit2.Form2.listbox1.items.add(edit1.Text);
        indeks:=strtoint(edit1.text);
        uniwersalne_edytowanie(indeks);
        BAZA.Enabled:=false;
        Form2.Show;
    end;
except
    button:=messagedlg('¯eby zmieniæ dane w tym wierszu, musisz najpierw go wybraæ.',mtInformation,[mbYes],0);
end;
end;



end.
