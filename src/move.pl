:-initialization(consult('database.pl')).
/* Inisialisasi kondisi awal */
/* Predikat untuk melakukan pemindahan tentara */
move(X1, X2, Y) :-
    current_player(Player),
    valid_move(X1, X2, Y, Player),
    transfer_tentara(X1, X2, Y),
    write(Player), write(' memindahkan '), write(Y), write(' tentara dari '), write(X1), write(' ke '), write(X2), nl,
    % update_turn_count(Player),
    print_current_status(X1,X2).

/* Predikat untuk validasi pemindahan tentara */
valid_move(X1, X2, Y, Player) :-
    region_owner(Player, X1),
    region_owner(Player, X2),
    total_troops(X1, TotalTentaraX1),
    Y > 0,
    Y < TotalTentaraX1.
     % Memastikan setidaknya satu tentara tersisa di wilayah asal
valid_move(X1, X2, Y, _) :-
    total_troops(X1, TotalTentaraX1),
    Y >= TotalTentaraX1,
    write('Tentara tidak cukup untuk pemindahan.'),
    nl, write('Pemindahan dibatalkan.'), nl, !, fail.
valid_move(X1, X2, _, Player) :-
    \+ region_owner(Player, X1),
    \+ region_owner(Player, X2),
    write(Player), write(' tidak memiliki wilayah '), write(X1), write(' dan '), write(X2),
    nl, write('Pemindahan dibatalkan.'), nl, !, fail.

/* Exception jika player tidak memiliki X1 */
valid_move(X1, _, _, Player) :-
    \+ region_owner(Player, X1),
    write(Player), write(' tidak memiliki wilayah '), write(X1),
    nl, write('Pemindahan dibatalkan.'), nl, !, fail.

/* Exception jika player tidak memiliki X2 */
valid_move(_, X2, _, Player) :-
    \+ region_owner(Player, X2),
    write(Player), write(' tidak memiliki wilayah '), write(X2),
    nl, write('Pemindahan dibatalkan.'), nl, !, fail.
/* Predikat untuk mentransfer tentara dari X1 ke X2 */
transfer_tentara(X1, X2, Y) :-
    total_troops(X1, TotalTentaraX1),
    total_troops(X2, TotalTentaraX2),
    TotalTentaraX2_new is Y +TotalTentaraX2,
    TotalTentaraX1_new is TotalTentaraX1-Y,
    retract(total_troops(X1, _)),
    retract(total_troops(X2, _)),
    asserta(total_troops(X1, TotalTentaraX1_new)),
    asserta(total_troops(X2, TotalTentaraX2_new)).

players([fio,opponent]).
% /* Predikat untuk mengupdate jumlah pemindahan yang diizinkan dalam satu giliran */
update_turn_count(Player) :-
    turn_count(CurrentTurn),
    players(Players),
    next_player(Player, Players, NextPlayer),
    NextTurn is (CurrentTurn + 1) mod length(Players),
    retract(turn_count(CurrentTurn)),
    asserta(turn_count(NextTurn)),
    retract(current_player(Player)),
    asserta(current_player(NextPlayer)).

next_player(Player, [Player | Rest], Next) :- 
    append(Rest, [Player], Next).

/* Predikat untuk mendapatkan pemain selanjutnya */


/* Predikat untuk mencetak status saat ini */
print_current_status(X1,X2) :-
    total_troops(X1, TentaraAU1),
total_troops(X2, TentaraAU2),
write('Jumlah tentara di '), write(X1), write(': '), write(TentaraAU1), nl,
write('Jumlah tentara di '), write(X2), write(': '), write(TentaraAU2), nl.
