:- dynamic(pemilik/1).






kode(a, 'A1').


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