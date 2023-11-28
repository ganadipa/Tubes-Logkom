% Buat testing aja

% :- initialization(consult('database.pl')).

% :- initialization(assertz(current_player(p1))).
% :- initialization(assertz(player_name(p1, 'Azmi'))).
% :- initialization(assertz(region_owner(na1, p1))).
% :- initialization(assertz(total_additional_troops(p1, 5))).


draft(Region, Troops) :-
    current_player(Player),
    player_name(Player, PlayerName),
    region_owner(Region, Owner),
    code(Region, Code),
    (
        Player \= Owner -> (
            format('Player ~w tidak memiliki wilayah ~w.\n', [PlayerName, Code]),
            fail
        ) ; !
    ),
    total_additional_troops(Player, TotalAdditionalTroops),
    (
        Troops > TotalAdditionalTroops -> (
            format('Pasukan ~w tidak mencukupi.\n', [PlayerName]),
            format('Jumlah pasukan tambahan: ~w\n', [TotalAdditionalTroops]),
            format('Jumlah pasukan yang diminta: ~w\n', [Troops]),
            write('Draft tidak jadi dilakukan.\n'),
            fail
        ) ; !
    ),
    TroopsLeft is TotalAdditionalTroops - Troops,
    update_additional_troops(Player, TroopsLeft),
    total_troops(Region, InitialTroops),
    TroopsNow is InitialTroops + Troops,
    retract(total_troops(Region, _)),
    assertz(total_troops(Region, TroopsNow)).