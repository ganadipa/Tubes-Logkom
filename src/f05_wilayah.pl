:- dynamic(pemilik/1).




kode(na1, 'NA1').
kode(na2, 'NA2').
kode(na3, 'NA3').
kode(na4, 'NA4').

kode(sa1, 'SA1').
kode(sa2, 'SA2').

kode(af1, 'AF1').
kode(af2, 'AF2').
kode(af3, 'AF3').

kode(af1, 'AF1').
kode(af2, 'AF2').
kode(af3, 'AF3').

kode(a1, 'A1').
kode(a2, 'A2').
kode(a3, 'A3').
kode(a4, 'A4').
kode(a5, 'A5').
kode(a6, 'A6').
kode(a7, 'A7').

kode(au1, 'AU1').
kode(au2, 'AU2').

kode(e1, 'E1').
kode(e2, 'E2').
kode(e3, 'E3').
kode(e4, 'E4').
kode(e5, 'E5').

kode(a, 'A1').

benua(na1, 'Amerika Utara').
benua(na2, 'Amerika Utara').
benua(na3, 'Amerika Utara').
benua(na4, 'Amerika Utara').

benua(sa1, 'Amerika Selatan').
benua(sa2, 'Amerika Selatan').

benua(af1, 'Afrika').
benua(af2, 'Afrika').
benua(af3, 'Afrika').

benua(au1, 'Australia').
benua(au2, 'Australia').

benua(a1, 'Asia').
benua(a2, 'Asia').
benua(a3, 'Asia').
benua(a4, 'Asia').
benua(a5, 'Asia').
benua(a6, 'Asia').
benua(a7, 'Asia').

benua(e1, 'Eropa').
benua(e2, 'Eropa').
benua(e3, 'Eropa').
benua(e4, 'Eropa').
benua(e5, 'Eropa').

nama(na1, 'Greenland').
nama(na1, 'Kanada').
nama(na1, 'Mexico').
nama(na1, 'Amerika Serikat').

nama(a, 'Indonesia').

tetangga(a, 'A').
tetangga(a, 'B').
tetangga(a, 'C').

pemilik(a, 'Azmi').
total_tentara(a, 100).



writeTetangga(X) :-
    tetangga(X, FirstNeighbor),
    write(FirstNeighbor),
    writeRestNeighbors(X, FirstNeighbor),
    write('.').

writeRestNeighbors(X, PrevNeighbor) :-
    tetangga(X, Neighbor),
    Neighbor \= PrevNeighbor,
    write(', '),
    write(Neighbor),
    fail.

writeRestNeighbors(_, _).

player_to_string(p2, 'P2').


checkLocationDetail(Kode):-

    write('Kode              :  '),
    kode(Kode, X),
    write(X),
    write('\nNama              :  '),
    nama(Kode,Y),
    write(Y),
    write('\nPemilik           :  '),
    pemilik(Kode,Z),
    write(Z),
    write('\nTotal Tentara     :  '),
    total_tentara(Kode, W),
    write(W),
    write('\nTetangga          :  '),
    writeTetangga(Kode).

pemain(p2, 'Azmi').

checkPlayerDetail(Player):-
    player_to_string(Player, String)
    write('\nPLAYER '),
    write(String),
    write('\n\n'),

    pemain(Player, Nama),
    write('Nama                   :  '),
    write(Nama),
    write('\nBenua                  :  '),
    write('\nTotal Wilayah          :  '),
    write('\nTotal Tentara Aktif    :  '),
    write('\nTotal Tentara Tambahan :  '),
    



main:-
    write('\nCheck Location\n'),
    checkLocationDetail(a),
    write('\nCheck Player\n'),
    checkPlayerDetail(p2),
    write('...').


:- initialization(main).