:- dynamic(move_count/1).
/* Inisialisasi kondisi awal */
/* Predikat untuk melakukan pemindahan tentara */
move_count(0).
move(X1, X2, Y) :-
    current_player(Player),
    move_count(Now),
    valid_move(X1, X2, Y, Player),
    transfer_tentara(X1, X2, Y),
    write(Player), write(' memindahkan '), write(Y), write(' tentara dari '), write(X1), write(' ke '), write(X2), nl,
    % update_turn_count(Player),
    print_current_status(X1,X2),
    Next is Now +1
    retract(move_count(_)),
    asserta(move_count(Next)),
    next_player.

check_and_next_player :-
    move_count(3),
    move_count(_),
    retract(move_count(_)),
    asserta(move_count(0)),
    next_player,
    !.
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


/* Predikat untuk mendapatkan pemain selanjutnya */


/* Predikat untuk mencetak status saat ini */
print_current_status(X1,X2) :-
    total_troops(X1, TentaraAU1),
total_troops(X2, TentaraAU2),
write('Jumlah tentara di '), write(X1), write(': '), write(TentaraAU1), nl,
write('Jumlah tentara di '), write(X2), write(': '), write(TentaraAU2), nl.
