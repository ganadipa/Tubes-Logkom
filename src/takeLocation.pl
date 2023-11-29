:- include('start_game.pl').

% nextTurn adalah fungsi yang mengganti giliran pemain dengan pemain selanjutnya
nextTurn :-
    turn(Current),
    retract(turn(Current)),
    assertz(turn(Current)),
    turn(Next),
    findall(R, region(R), Regions),
    length(Regions, N),
    (   N =:= 0
    ->  write('Seluruh wilayah telah diambil pemain.'), nl,
        write('Memulai pembagian sisa tentara.'), nl
    ;   write('Giliran '), write(Next), write(' untuk memilih wilayahnya.'), nl
    ).

% takeLocation(Loc) adalah fungsi yang memungkinkan pemain untuk mengambil wilayah Loc

takeLocation(Loc) :-
    region(Loc),
    turn(Player),
    \+ region_owner(Loc, _),
    asserta(region_owner(Loc, Player)),
    code(Loc, X),
    write(Player), write(' mengambil wilayah '), write(X), nl,
    nextTurn,
    !.

takeLocation(Loc) :-
    region(Loc),
    region_owner(Loc, _),
    turn(Player),
    write('Wilayah sudah dikuasai. Tidak bisa mengambil.'), nl,
    write('Giliran '), write(Player), write(' untuk memilih wilayahnya.'), nl,
    !.

takeLocation(Loc) :-
    \+ region(Loc),
    turn(Player),
    write('Wilayah tidak ada. Silakan pilih wilayah yang valid.'), nl,
    write('Giliran '), write(Player), write(' untuk memilih wilayahnya.'), nl,
    !.
