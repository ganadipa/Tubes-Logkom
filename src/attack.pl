
% Definisi untuk sum_list
% sum_list([], 0).
% sum_list([X|Xs], Sum) :-
%     sum_list(Xs, RestSum),
%     Sum is X + RestSum.

/* Fase Attack */
attack :-
    current_player(Player),
    write('Sekarang giliran Player '), write(Player), write(' menyerang.'), nl,
    write('/* PETA */'), nl,
    write('Pilihlah daerah yang ingin Anda mulai untuk melakukan penyerangan: '), read(StartRegion),
    valid_start_region(StartRegion, Player),
    region_owner(StartRegion, Player),
    total_troops(StartRegion, StartRegionTentara),
    StartRegionTentara > 1,
    write('Dalam daerah '), write(StartRegion), write(', Anda memiliki sebanyak '), write(StartRegionTentara), write(' tentara.'), nl,
    write('Masukkan banyak tentara yang akan bertempur: '), read(AttackingTroops),
    valid_attacking_troops(AttackingTroops, StartRegionTentara),
    
    write('Player '), write(Player), write(' mengirim sebanyak '), write(AttackingTroops), write(' tentara untuk berperang.'), nl,
    write('/* PETA */'), nl,
    write('Pilihlah daerah yang ingin Anda serang: '), read(TargetRegion),
    valid_target_region(TargetRegion,Player, StartRegion),
    battle(StartRegion, TargetRegion, AttackingTroops).

valid_start_region(Region, Player) :-
    region_owner(Region, Player),
    !.
valid_start_region(_, Player) :-
    write('Daerah tidak valid. Silahkan input kembali.'), nl,
    write('Pilihlah daerah yang ingin Anda mulai untuk melakukan penyerangan: '), read(NewRegion),
    valid_start_region(NewRegion, Player).

valid_attacking_troops(Troops, MaxTroops) :-
    Troops > 0,
    Troops < MaxTroops,
    !.
valid_attacking_troops(_,MaxTroops) :-
    write('Banyak tentara tidak valid. Silahkan input kembali.'), nl,
    write('Masukkan banyak tentara yang akan bertempur: '), read(NewTroops),
    valid_attacking_troops(NewTroops, MaxTroops).

valid_target_region(TargetRegion,Player, StartRegion) :-
    current_player(Player),
    region_owner(TargetRegion, Opponent),
    \+casefire_order_effect(Opponent),
    Opponent \= Player,
    adjacent(StartRegion, TargetRegion),
    !.
valid_target_region(TargetRegion,Player, StartRegion) :-
    current_player(Player),
    region_owner(TargetRegion, Opponent),
    casefire_order_effect(Opponent),
    write('Tidak Bisa Menyerang'),nl,write('wilayah sedang dalam pengaruh CEASEFIRE ORDER'),
    !.   
valid_target_region(_,Player, StartRegion) :-
    write('Daerah yang diserang tidak valid. Silahkan input kembali.'), nl,
    write('Pilihlah daerah yang ingin Anda serang: '), read(NewTargetRegion),
    valid_target_region(NewTargetRegion, StartRegion).

battle(StartRegion, TargetRegion, AttackingTroops) :-
    current_player(Player),
    region_owner(TargetRegion,Opponent),
    write('Perang telah dimulai.'), nl,
    write('Player '), write(Player), nl,
    write('Dadu: '), roll_dice(AttackingTroops, AttackingDice),
    write('Total: '), sum_list(AttackingDice, TotalAttacking), write(TotalAttacking), nl,
    write('Player '), write(Opponent), nl,
    total_troops(TargetRegion,OpponentTroops),
    write('Dadu: '), roll_dice(OpponentTroops, OpponentDice),
    write('Total: '), sum_list(OpponentDice, TotalOpponent), write(TotalOpponent), nl,
    compare_battle_results(TotalAttacking, TotalOpponent, StartRegion, TargetRegion, AttackingTroops).

roll_dice(0, []).
roll_dice(N, [Die|Dice]) :-
    super_soldier_serum_effect(current_player),  % Check for the super_soldier_serum_effect
    Die = 6,  % If in effect, set the die to 6
    M is N - 1,
    roll_dice(M, Dice).
roll_dice(N, [Die|Dice]) :-
    \+ super_soldier_serum_effect(current_player),  % If not in effect
    random(1,7, RandomNumber),  % Generate a random number between 0 and 5
    Die is RandomNumber + 1,  % Adjust the range to 1-6
    M is N - 1,
    roll_dice(M, Dice).


compare_battle_results(AttackingTotal, OpponentTotal, StartRegion, TargetRegion, AttackingTroops) :-
    AttackingTotal > OpponentTotal,
    !,
    
    region_owner(StartRegion,Player),
    region_owner(TargetRegion,Opponent),
    write('Perang telah dimulai.'), nl,
    write('Player '), write(Player), nl,
    write('Dadu: '), roll_dice(AttackingTroops, AttackingDice),
    write_dice_results(AttackingDice),  % Menampilkan hasil dadu
    sum_list(AttackingDice, TotalAttacking), write('Total: '), write(TotalAttacking), nl,
    write('Player '), write(Opponent), nl,
    total_troops(TargetRegion,DefendingTroops),
    write('Dadu: '), roll_dice(DefendingTroops, OpponentDice),
    write_dice_results(OpponentDice),  % Menampilkan hasil dadu lawan
    sum_list(OpponentDice, TotalOpponent), write('Total: '), write(TotalOpponent), nl,
    write('Player '), write(Player), write(' menang! Wilayah '), write(TargetRegion), write(' sekarang dikuasai oleh Player '), write(Player), write('.'), nl,
    write('Silahkan tentukan banyaknya tentara yang menetap di wilayah '), write(TargetRegion), write(': '), read(DefendingTroops),
    valid_defending_troops(DefendingTroops, AttackingTroops),
    transfer_tentara(StartRegion, TargetRegion, DefendingTroops),
    print_current_status(StartRegion,TargetRegion),
    update_after_attack(Player,Opponent).

    /*sekalian tranfer kepemilikan.*/
    
compare_battle_results(_, _, StartRegion, TargetRegion, AttackingTroops) :-
    region_owner(TargetRegion,Opponent),
    retract(total_troops(StartRegion,_)),
    total_troops(StartRegion,X),
    Y is X-AttackingTroops,
    assertz(total_troops(StartRegion,Y)),
    write('Player '), write(Opponent), write(' menang! Sayang sekali penyerangan Anda gagal :('), nl,
    print_current_status(StartRegion,TargetRegion).
write_dice_results([]).
write_dice_results([Die|Dice]) :-
    write('Dadu: '), write(Die), nl,
    write_dice_results(Dice).

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
    (
        remove_player(Player1),
        write('Jumlah wilayah player '),
        write(Name1),
        write(' 0. ')
        ); Total2 == 0 -> (
            remove_player(Player2),
            write('Jumlah wilayah player '),
            write(Name2),
            write(' 0. ')
        );!
    ),

    (
        Total1 == 24 -> (
            write('********************\n*'),
            write(Name1), 
            write(' telah menguasai dunia'),
            write('*\n********************')
        ); Total2 == 24 -> (
            write('********************\n*'),
            write(Name2), 
            write(' telah menguasai dunia'),
            write('*\n********************')
        )
    ).


    


