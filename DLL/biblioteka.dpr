library biblioteka;



{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }


uses
  System.SysUtils,
  System.Classes;

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


{$R *.res}

procedure przygotuj_rekordy (out czolg: spis; var curr : plista); stdcall;
begin                                         //przygotowuje rekord do zapisu do pliku
    czolg.nazwa:=curr^.dane.nazwa;
    czolg.nacja:=curr^.dane.nacja;
    czolg.typ:=curr^.dane.typ;
    czolg.kaliber:=curr^.dane.kaliber;
    czolg.penetracja:=curr^.dane.penetracja;
    czolg.predkosc:=curr^.dane.predkosc;
    czolg.pancerz:=curr^.dane.pancerz;
    czolg.identyfikator:=curr^.dane.identyfikator;
end;

procedure uzupelnij_pola_do_listy (var czolg: spis; var curr : plista);
begin                                      //zapis do listy wczesniej pobranych pol rekordu
    curr^.dane.nazwa:=czolg.nazwa;
    curr^.dane.nacja:=czolg.nacja;
    curr^.dane.typ:=czolg.typ;
    curr^.dane.kaliber:=czolg.kaliber;
    curr^.dane.penetracja:=czolg.penetracja;
    curr^.dane.predkosc:=czolg.predkosc;
    curr^.dane.pancerz:=czolg.pancerz;
    curr^.dane.identyfikator:=czolg.identyfikator;
end;


procedure usun (var first: plista; var indeks : integer; var kontrola: integer);stdcall;
var                                           //usun
    curr,prev: plista;
begin
    curr:=first;
    if curr<>nil then
    begin

       while (curr^.nastepny<>nil) and (curr^.dane.identyfikator<>indeks)do
       begin
          prev:=curr;
          curr:=curr^.nastepny;
       end;

       if curr^.dane.identyfikator=indeks then
       begin
           if curr<>first then
           begin
               prev^.nastepny:=curr^.nastepny;
               dispose(curr);
           end
           else
           begin
               first:=curr^.nastepny;
               dispose(curr);
           end;
       end;

    end;
    kontrola:=0;
end;


procedure dodaj (var czolg: spis; var wsk : plista; var kontrola: integer);stdcall;
var
    curr,prev: plista;
begin                                           //uzupelnianie listy
    curr:=wsk;
    if wsk=nil then
    begin
      new(wsk);
      wsk^.dane.nazwa:=czolg.nazwa;
      wsk^.dane.nacja:=czolg.nacja;
      wsk^.dane.typ:=czolg.typ;
      wsk^.dane.kaliber:=czolg.kaliber;
      wsk^.dane.penetracja:=czolg.penetracja;
      wsk^.dane.predkosc:=czolg.predkosc;
      wsk^.dane.pancerz:=czolg.pancerz;
      wsk^.dane.identyfikator:=czolg.identyfikator;
      wsk^.nastepny:=nil;
    end

    else
    begin
       if ansicomparestr(czolg.nazwa,curr^.dane.nazwa)<=0 then
       begin
         new(curr);
         uzupelnij_pola_do_listy(czolg,curr);
         curr^.nastepny:=wsk;
         wsk:=curr;
       end

       else
       begin
         while (curr^.nastepny<>nil) and ( ansicomparestr(czolg.nazwa,curr^.nastepny^.dane.nazwa)>0) do
         begin
           prev:=curr;
           curr:=curr^.nastepny;
         end;

         prev:=curr;
         new(curr);
         uzupelnij_pola_do_listy(czolg,curr);
         curr^.nastepny:=prev^.nastepny;
         prev^.nastepny:=curr;
       end;
    end;
    kontrola:=0;
end;

procedure sortuj_wg_nazwy (var wsk: plista; var kontrola: integer); stdcall;
var
    indeks: integer;
    curr, first2: plista;
    czolg: spis;
begin
    indeks:=1;
    curr:=wsk;
    first2:=nil;
    if curr<>nil then
    begin
       repeat
           przygotuj_rekordy(czolg,curr);
           dodaj(czolg,first2,kontrola);
           curr:=curr^.nastepny;
       until curr=nil;
       repeat
           usun(wsk,indeks,kontrola);
           inc(indeks);
       until wsk=nil;
       wsk:=first2;
    end;
end;

procedure sortuj_wg_nacji (var wsk: plista; var kontrola: integer); stdcall;
var
    indeks: integer;
    curr, first2, prev, curr2: plista;
    czolg: spis;
begin
    indeks:=1;
    curr:=wsk;
    first2:=nil;
    if curr<>nil then
    begin
       repeat
           przygotuj_rekordy(czolg,curr);
           curr2:=first2;
           if first2=nil then
           begin
               new(first2);
               first2^.dane.nazwa:=czolg.nazwa;
               first2^.dane.nacja:=czolg.nacja;
               first2^.dane.typ:=czolg.typ;
               first2^.dane.kaliber:=czolg.kaliber;
               first2^.dane.penetracja:=czolg.penetracja;
               first2^.dane.predkosc:=czolg.predkosc;
               first2^.dane.pancerz:=czolg.pancerz;
               first2^.dane.identyfikator:=czolg.identyfikator;
               first2^.nastepny:=nil;
           end

           else
           begin
               if ansicomparestr(czolg.nacja,curr2^.dane.nacja)<=0 then
               begin
                   new(curr2);
                   uzupelnij_pola_do_listy(czolg,curr2);
                   curr2^.nastepny:=first2;
                   first2:=curr2;
               end

               else
               begin
               while (curr2^.nastepny<>nil) and ( ansicomparestr(czolg.nacja,curr2^.nastepny^.dane.nacja)>0) do
               begin
                   prev:=curr2;
                   curr2:=curr2^.nastepny;
               end;

               prev:=curr2;
               new(curr2);
               uzupelnij_pola_do_listy(czolg,curr2);
               curr2^.nastepny:=prev^.nastepny;
               prev^.nastepny:=curr2;
           end;
        end;
        kontrola:=0;
        curr:=curr^.nastepny;
        until curr=nil;

        repeat
             usun(wsk,indeks,kontrola);
             inc(indeks);
        until wsk=nil;
        wsk:=first2;
    end;
end;

procedure sortuj_wg_typu (var wsk: plista; var kontrola: integer); stdcall;
var
    indeks: integer;
    curr, first2, prev, curr2: plista;
    czolg: spis;
begin
    indeks:=1;
    curr:=wsk;
    first2:=nil;
    if curr<>nil then
    begin
       repeat
           przygotuj_rekordy(czolg,curr);

           curr2:=first2;
           if first2=nil then
           begin
               new(first2);
               first2^.dane.nazwa:=czolg.nazwa;
               first2^.dane.nacja:=czolg.nacja;
               first2^.dane.typ:=czolg.typ;
               first2^.dane.kaliber:=czolg.kaliber;
               first2^.dane.penetracja:=czolg.penetracja;
               first2^.dane.predkosc:=czolg.predkosc;
               first2^.dane.pancerz:=czolg.pancerz;
               first2^.dane.identyfikator:=czolg.identyfikator;
               first2^.nastepny:=nil;
           end

           else
           begin
               if ansicomparestr(czolg.typ,curr2^.dane.typ)<=0 then
               begin
                   new(curr2);
                   uzupelnij_pola_do_listy(czolg,curr2);
                   curr2^.nastepny:=first2;
                   first2:=curr2;
               end

               else
               begin
               while (curr2^.nastepny<>nil) and ( ansicomparestr(czolg.typ,curr2^.nastepny^.dane.typ)>0) do
               begin
                   prev:=curr2;
                   curr2:=curr2^.nastepny;
               end;

               prev:=curr2;
               new(curr2);
               uzupelnij_pola_do_listy(czolg,curr2);
               curr2^.nastepny:=prev^.nastepny;
               prev^.nastepny:=curr2;
           end;
        end;
        kontrola:=0;
        curr:=curr^.nastepny;
        until curr=nil;

        repeat
             usun(wsk,indeks,kontrola);
             inc(indeks);
        until wsk=nil;
        wsk:=first2;
    end;
end;

procedure sortuj_wg_kalibru (var wsk: plista; var kontrola: integer);stdcall;
var
    indeks: integer;
    curr, first2, prev, curr2: plista;
    czolg: spis;
begin
    indeks:=1;
    curr:=wsk;
    first2:=nil;
    if curr<>nil then
    begin
       repeat
           przygotuj_rekordy(czolg,curr);

           curr2:=first2;
           if first2=nil then
           begin
               new(first2);
               first2^.dane.nazwa:=czolg.nazwa;
               first2^.dane.nacja:=czolg.nacja;
               first2^.dane.typ:=czolg.typ;
               first2^.dane.kaliber:=czolg.kaliber;
               first2^.dane.penetracja:=czolg.penetracja;
               first2^.dane.predkosc:=czolg.predkosc;
               first2^.dane.pancerz:=czolg.pancerz;
               first2^.dane.identyfikator:=czolg.identyfikator;
               first2^.nastepny:=nil;
           end

           else
           begin
               if strtoint(czolg.kaliber)<=strtoint(curr2^.dane.kaliber) then
               begin
                   new(curr2);
                   uzupelnij_pola_do_listy(czolg,curr2);
                   curr2^.nastepny:=first2;
                   first2:=curr2;
               end

               else
               begin
               while (curr2^.nastepny<>nil) and (strtoint(czolg.kaliber)>strtoint(curr2^.nastepny^.dane.kaliber)) do
               begin
                   prev:=curr2;
                   curr2:=curr2^.nastepny;
               end;

               prev:=curr2;
               new(curr2);
               uzupelnij_pola_do_listy(czolg,curr2);
               curr2^.nastepny:=prev^.nastepny;
               prev^.nastepny:=curr2;
           end;
        end;
        kontrola:=0;
        curr:=curr^.nastepny;
        until curr=nil;

        repeat
             usun(wsk,indeks,kontrola);
             inc(indeks);
        until wsk=nil;
        wsk:=first2;
    end;
end;

procedure sortuj_wg_penetracji (var wsk: plista; var kontrola: integer);stdcall;
var
    indeks: integer;
    curr, first2, prev, curr2: plista;
    czolg: spis;
begin
    indeks:=1;
    curr:=wsk;
    first2:=nil;
    if curr<>nil then
    begin
       repeat
           przygotuj_rekordy(czolg,curr);

           curr2:=first2;
           if first2=nil then
           begin
               new(first2);
               first2^.dane.nazwa:=czolg.nazwa;
               first2^.dane.nacja:=czolg.nacja;
               first2^.dane.typ:=czolg.typ;
               first2^.dane.kaliber:=czolg.kaliber;
               first2^.dane.penetracja:=czolg.penetracja;
               first2^.dane.predkosc:=czolg.predkosc;
               first2^.dane.pancerz:=czolg.pancerz;
               first2^.dane.identyfikator:=czolg.identyfikator;
               first2^.nastepny:=nil;
           end

           else
           begin
               if strtoint(czolg.penetracja)<=strtoint(curr2^.dane.penetracja) then
               begin
                   new(curr2);
                   uzupelnij_pola_do_listy(czolg,curr2);
                   curr2^.nastepny:=first2;
                   first2:=curr2;
               end

               else
               begin
               while (curr2^.nastepny<>nil) and (strtoint(czolg.penetracja)>strtoint(curr2^.nastepny^.dane.penetracja)) do
               begin
                   prev:=curr2;
                   curr2:=curr2^.nastepny;
               end;

               prev:=curr2;
               new(curr2);
               uzupelnij_pola_do_listy(czolg,curr2);
               curr2^.nastepny:=prev^.nastepny;
               prev^.nastepny:=curr2;
           end;
        end;
        kontrola:=0;
        curr:=curr^.nastepny;
        until curr=nil;

        repeat
             usun(wsk,indeks,kontrola);
             inc(indeks);
        until wsk=nil;
        wsk:=first2;
    end;
end;

procedure sortuj_wg_predkosci (var wsk: plista; var kontrola: integer);stdcall;
var
    indeks: integer;
    curr, first2, prev, curr2: plista;
    czolg: spis;
begin
    indeks:=1;
    curr:=wsk;
    first2:=nil;
    if curr<>nil then
    begin
       repeat
           przygotuj_rekordy(czolg,curr);

           curr2:=first2;
           if first2=nil then
           begin
               new(first2);
               first2^.dane.nazwa:=czolg.nazwa;
               first2^.dane.nacja:=czolg.nacja;
               first2^.dane.typ:=czolg.typ;
               first2^.dane.kaliber:=czolg.kaliber;
               first2^.dane.penetracja:=czolg.penetracja;
               first2^.dane.predkosc:=czolg.predkosc;
               first2^.dane.pancerz:=czolg.pancerz;
               first2^.dane.identyfikator:=czolg.identyfikator;
               first2^.nastepny:=nil;
           end

           else
           begin
               if strtoint(czolg.predkosc)<=strtoint(curr2^.dane.predkosc) then
               begin
                   new(curr2);
                   uzupelnij_pola_do_listy(czolg,curr2);
                   curr2^.nastepny:=first2;
                   first2:=curr2;
               end

               else
               begin
               while (curr2^.nastepny<>nil) and (strtoint(czolg.predkosc)>strtoint(curr2^.nastepny^.dane.predkosc)) do
               begin
                   prev:=curr2;
                   curr2:=curr2^.nastepny;
               end;

               prev:=curr2;
               new(curr2);
               uzupelnij_pola_do_listy(czolg,curr2);
               curr2^.nastepny:=prev^.nastepny;
               prev^.nastepny:=curr2;
           end;
        end;
        kontrola:=0;
        curr:=curr^.nastepny;
        until curr=nil;

        repeat
             usun(wsk,indeks,kontrola);
             inc(indeks);
        until wsk=nil;
        wsk:=first2;
    end;
end;




procedure wczytaj_z_pliku (var wsk: plista; var kontrola: integer; var nazwa_pliku: string);stdcall;
var
    indeks: integer;
    czolg: spis;
    plik: file of spis;
    identyfikator: integer;

begin
    indeks:=0;
    identyfikator:=1;
    assignfile(plik,nazwa_pliku);
    reset(plik);
    while indeks<filesize(plik) do
    begin
       read(plik,czolg);
       czolg.identyfikator:=identyfikator;
       dodaj(czolg,wsk,kontrola);
       inc(indeks);
       inc(identyfikator);
    end;
    closefile(plik);
    kontrola:=1;
end;


procedure zapisz_do_pliku (var wsk: plista; var kontrola: integer; var nazwa_pliku: string);stdcall;
var                                         //zapis listy do pliku
    czolg : spis;
    curr: plista;
    plik: file of spis;

begin
    assignfile(plik,nazwa_pliku);
    rewrite(plik);
    curr:=wsk;
         if curr<>nil then
         begin
           repeat
           przygotuj_rekordy(czolg,curr);
           write(plik,czolg);
           curr:=curr^.nastepny;
           until curr=nil;
         end;
    closefile(plik);
    kontrola:=1;
end;


exports
usun name 'usun',
zapisz_do_pliku name 'zapisz_do_pliku',
wczytaj_z_pliku name 'wczytaj_z_pliku',
dodaj name 'dodaj',
sortuj_wg_nazwy name 'sortuj_wg_nazwy',
sortuj_wg_nacji name 'sortuj_wg_nacji',
sortuj_wg_typu name 'sortuj_wg_typu',
sortuj_wg_kalibru name 'sortuj_wg_kalibru',
sortuj_wg_penetracji name 'sortuj_wg_penetracji',
sortuj_wg_predkosci name 'sortuj_wg_predkosci',
przygotuj_rekordy name 'przygotuj_rekordy';

begin
end.
