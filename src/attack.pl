
% Definisi untuk sum_list
sum_list([], 0).
sum_list([X|Xs], Sum) :-
    sum_list(Xs, RestSum),
    Sum is X + RestSum.

/* Fase Attack */
attack :-
    current_player(Player),
    write('Sekarang giliran Player '), write(Player), write(' menyerang.'), nl,
    write('/* PETA */'), nl,
    write('Pilihlah daerah yang ingin Anda mulai untuk melakukan penyerangan: '), read(StartRegion),
    valid_start_region(StartRegion, Player),
    pemilik_wilayah(Player, StartRegion),
    total_tentara(StartRegion, StartRegionTentara),
    StartRegionTentara > 1,
    write('Dalam daerah '), write(StartRegion), write(', Anda memiliki sebanyak '), write(StartRegionTentara), write(' tentara.'), nl,
    write('Masukkan banyak tentara yang akan bertempur: '), read(AttackingTroops),
    valid_attacking_troops(AttackingTroops, StartRegionTentara),
    write('Player '), write(Player), write(' mengirim sebanyak '), write(AttackingTroops), write(' tentara untuk berperang.'), nl,
    write('/* PETA */'), nl,
    write('Pilihlah daerah yang ingin Anda serang: '), read(TargetRegion),
    valid_target_region(TargetRegion, StartRegion),
    battle(StartRegion, TargetRegion, AttackingTroops).

valid_start_region(Region, Player) :-
    pemilik_wilayah(Player, Region),
    !.
valid_start_region(_, Player) :-
    write('Daerah tidak valid. Silahkan input kembali.'), nl,
    write('Pilihlah daerah yang ingin Anda mulai untuk melakukan penyerangan: '), read(NewRegion),
    valid_start_region(NewRegion, Player).

valid_attacking_troops(Troops, MaxTroops) :-
    Troops > 0,
    Troops < MaxTroops,
    !.
valid_attacking_troops(_, MaxTroops) :-
    write('Banyak tentara tidak valid. Silahkan input kembali.'), nl,
    write('Masukkan banyak tentara yang akan bertempur: '), read(NewTroops),
    valid_attacking_troops(NewTroops, MaxTroops).

valid_target_region(TargetRegion, StartRegion) :-
    current_player(Player),
    pemilik_wilayah(Opponent, TargetRegion),
    Opponent \= Player,
    tetangga(StartRegion, TargetRegion),
    !.
valid_target_region(_, StartRegion) :-
    write('Daerah yang diserang tidak valid. Silahkan input kembali.'), nl,
    write('Pilihlah daerah yang ingin Anda serang: '), read(NewTargetRegion),
    valid_target_region(NewTargetRegion, StartRegion).

battle(StartRegion, TargetRegion, AttackingTroops) :-
    current_player(Player),
    pemilik_wilayah(Opponent,TargetRegion),
    write('Perang telah dimulai.'), nl,
    write('Player '), write(Player), nl,
    write('Dadu: '), roll_dice(AttackingTroops, AttackingDice),
    write('Total: '), sum_list(AttackingDice, TotalAttacking), write(TotalAttacking), nl,
    write('Player '), write(Opponent), nl,
    write('Dadu: '), roll_dice(total_troops(TargetRegion), OpponentDice),
    write('Total: '), sum_list(OpponentDice, TotalOpponent), write(TotalOpponent), nl,
    compare_battle_results(TotalAttacking, TotalOpponent, StartRegion, TargetRegion, AttackingTroops).

roll_dice(0, []).
roll_dice(N, [Die|Dice]) :-
    random_between(1, 6, Die),
    M is N - 1,
    roll_dice(M, Dice).

compare_battle_results(AttackingTotal, OpponentTotal, StartRegion, TargetRegion, AttackingTroops) :-
    AttackingTotal > OpponentTotal,
    !,
    write('Player '), write(Player), write(' menang! Wilayah '), write(TargetRegion), write(' sekarang dikuasai oleh Player '), write(Player), write('.'), nl,
    write('Silahkan tentukan banyaknya tentara yang menetap di wilayah '), write(TargetRegion), write(': '), read(DefendingTroops),
    valid_defending_troops(DefendingTroops, AttackingTroops),
    transfer_tentara(StartRegion, TargetRegion, DefendingTroops),
    print_current_status(StartRegion,TargetRegion).
compare_battle_results(_, _, StartRegion, TargetRegion, _) :-
    write('Player '), write(Opponent), write(' menang! Sayang sekali penyerangan Anda gagal :('), nl,
    print_current_status(StartRegion,TargetRegion).

valid_defending_troops(Troops, AttackingTroops) :-
    Troops >= 1,
    Troops =< AttackingTroops,
    !.
valid_defending_troops(_, AttackingTroops) :-
    write('Banyak tentara tidak valid. Silahkan input kembali.'), nl,
    write('Silahkan tentukan banyaknya tentara yang menetap di wilayah: '), read(NewTroops),
    valid_defending_troops(NewTroops, AttackingTroops).

% print_current_status(StartRegion,TargetRegion) :-
%     total_tentara(StartRegion, TentaraAU1),
%     total_tentara(TargetRegion, TentaraAU2),
%     write('Jumlah tentara di AU1: '), write(TentaraAU1), nl,
%     write('Jumlah tentara di AU2: '), write(TentaraAU2), nl.


remove_player(Player):-
    retract(total_player(N)), 
    N1 is N - 1,              
    asserta(total_player(N1)),
    retract(is_dead(Player, _)),
    asserta(is_dead(Player, 1)).



update_after_attack(Player1, Player2):-
    player_name(Player1, Name1),
    player_name(Player2, Name2),
    total_regions_owned(Name1, Total1),
    total_regions_owned(Name2, Total2),

    (Total1 == 0 -> 
    (remove_player(Player1));!)
    


