:- dynamic(pemilik/1).
:- ['database.pl'].






kode(a, 'A1').


nama(a, 'Indonesia').

tetangga(a, 'A').
tetangga(a, 'B').
tetangga(a, 'C').

pemilik(a, 'Azmi').
total_tentara(a, 100).

total_wilayah(a)


player_to_string(p2, 'P2').




pemain(p2, 'Azmi').

checkPlayerDetail(Player):-
    player_to_string(Player, String),
    write('\nPLAYER '),
    write(String),
    write('\n\n'),

    pemain(Player, Nama),
    write('Nama                   :  '),
    write(Nama),
    write('\nBenua                  :  '),
    write('\nTotal Wilayah          :  '),
    write('\nTotal Tentara Aktif    :  '),
    write('\nTotal Tentara Tambahan :  ').
    



main:-
    write('\n\nCheck Location\n'),
    checkLocationDetail(a),
    write('\n\nCheck Player\n'),
    checkPlayerDetail(p2),
    write('\n\n...').


:- initialization(main).