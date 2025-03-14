% test(a1).
% test(a2).
% test(a3).

% test_take(L) :-
%     (
%         (test(L)) -> (
%             X = L
%         ) ; (
%             X = no
%         )
%     ),
%     format('X is ~w\n', [X]).

takeLocation(Region) :-
    !,
    (
        (region(Region)) -> (
            !
        ) ; (
            write('Wilayah tidak eksis.\n'),
            fail
        )
    ),
    (
        (region_owner(Region, _)) -> (
            write('Wilayah sudah dikuasai. Tidak bisa mengambil.\n'),
            fail
        ) ; !
    ),
    current_player(Player),
    assertz(region_owner(Region, Player)),
    write('Wilayah berhasil dipilih.\n'),

    retract(total_troops(Region, _)),
    assertz(total_troops(Region, 1)),

    retract(total_additional_troops(Player, OldAdditionalTroops)),
    NewAdditionalTroops is OldAdditionalTroops - 1,
    assertz(total_additional_troops(Player, NewAdditionalTroops)),


    next_player,
    current_player(NewPlayer),
    player_name(NewPlayer, NewPlayerName),
    format('Giliran Player ~w\n', [NewPlayerName]),
    findall(X, region_owner(X, _), L),
    length(L, Length),
    !,
    (
        (Length == 24) -> (
            write('Semua wilayah sudah diambil.\n'),
            fail
        ) ; !
    ).

% % nextTurn adalah fungsi yang mengganti giliran pemain dengan pemain selanjutnya
% nextTurn :-
%     turn(Current),
%     retract(turn(Current)),
%     assertz(turn(Current)),
%     turn(Next),
%     findall(R, region(R), Regions),
%     length(Regions, N),
%     (   N =:= 0
%     ->  write('Seluruh wilayah telah diambil pemain.'), nl,
%         write('Memulai pembagian sisa tentara.'), nl
%     ;   write('Giliran '), write(Next), write(' untuk memilih wilayahnya.'), nl
%     ).

% % takeLocation(Loc) adalah fungsi yang memungkinkan pemain untuk mengambil wilayah Loc

% takeLocation(Loc) :-
%     region(Loc),
%     turn(Player),
%     \+ region_owner(Loc, _),
%     asserta(region_owner(Loc, Player)),
%     code(Loc, X),
%     write(Player), write(' mengambil wilayah '), write(X), nl,
%     nextTurn,
%     !.

% takeLocation(Loc) :-
%     region(Loc),
%     region_owner(Loc, _),
%     turn(Player),
%     write('Wilayah sudah dikuasai. Tidak bisa mengambil.'), nl,
%     write('Giliran '), write(Player), write(' untuk memilih wilayahnya.'), nl,
%     !.

% takeLocation(Loc) :-
%     \+ region(Loc),
%     turn(Player),
%     write('Wilayah tidak ada. Silakan pilih wilayah yang valid.'), nl,
%     write('Giliran '), write(Player), write(' untuk memilih wilayahnya.'), nl,
%     !.
