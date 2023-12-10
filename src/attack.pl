
% Definisi untuk sum_list
% sum_list([], 0).
% sum_list([X|Xs], Sum) :-
%     sum_list(Xs, RestSum),
%     Sum is X + RestSum.

/* Fase Attack */
attack :-
    current_player(Player),
    player_name(Player, Name),
    write('Sekarang giliran Player '), write(Name), write(' menyerang.'), nl,
    displayMap,
    write('Pilihlah daerah yang ingin Anda mulai untuk melakukan penyerangan: '), read(StartRegion),
    valid_start_region(StartRegion, Player, ValidatedStartRegion),

    
    total_troops(ValidatedStartRegion, StartRegionTentara),
    validate_jumlah_tentara(StartRegionTentara),

    write('Dalam daerah '), write(ValidatedStartRegion), write(', Anda memiliki sebanyak '), write(StartRegionTentara), write(' tentara.'), nl,


    write('Masukkan banyak tentara yang akan bertempur: '), read(AttackingTroops),
    valid_attacking_troops(AttackingTroops, StartRegionTentara, ValidatedAttackingTroops),
    

    write('Player '), write(Player), write(' mengirim sebanyak '), write(ValidatedAttackingTroops), write(' tentara untuk berperang.'), nl, nl,

    displayMap,
    
    write('Pilihlah daerah yang ingin Anda serang: '), read(TargetRegion),
    valid_target_region(TargetRegion, Player, ValidatedStartRegion),
    battle(ValidatedStartRegion, TargetRegion, ValidatedAttackingTroops).

valid_start_region(Region, Player, Validated) :-
    (
        \+ region_owner(Region, Player) -> 
            (write('Daerah tidak valid (atau bukan milik anda). Silahkan input kembali.'), nl,
            write('Pilihlah daerah yang ingin Anda mulai untuk melakukan penyerangan: '), 
            read(NewRegion),
            valid_start_region(NewRegion, Player, NewValidated),
            write(NewValidated),
            V = NewValidated
            
            
            );
        V = Region, !
    ),
    Validated = V.


% valid_start_region(_, Player) :-
%    write('Daerah tidak valid. Silahkan input kembali.'), nl,
%    write('Pilihlah daerah yang ingin Anda mulai untuk melakukan penyerangan: '), read(NewRegion),
%    valid_start_region(NewRegion, Player).

valid_attacking_troops(Troops, MaxTroops, Validated) :-
    (
        \+ (Troops > 0, Troops < MaxTroops) -> 
        (
            write('Banyak tentara tidak valid. Silahkan input kembali.'), nl,
            write('Masukkan banyak tentara yang akan bertempur: '), read(NewTroops), valid_attacking_troops(NewTroops, MaxTroops, NewValidated),
            V = NewValidated
        );
            V = Troops, !
    ),
    Validated = V.


validate_jumlah_tentara(StartRegionTentara):-
    (
        StartRegionTentara == 1 -> 
        write('Tidak bisa menggunakan daerah ini karena jumlah tentara di daerah ini hanya 1.'), fail;!
    ).

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
        write('\n\nJumlah wilayah player milik '),
        write(Name1),
        write(' adalah sebanyak 0. \n'),
        write(Name1),
        write(' keluar dari permainan.')
        ); Total2 == 0 -> (
            remove_player(Player2),
            write('Jumlah wilayah player milik '),
            write(Name2),
            write(' adalah sebanyak 0. \n'),
            write(Name2),
            write(' keluar dari permainan.\n')
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


    


