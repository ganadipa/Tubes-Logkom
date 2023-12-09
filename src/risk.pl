
/* Fase Risk */
risk :-
    current_player(Player),
    has_risk_card(Player),
    write('Anda sudah memiliki risk card pada giliran ini.'), nl,
    !.

risk :-
    current_player(Player),
    random_risk_card(Card),
    assertz(has_risk_card(Player)),
    write('Player '), write(Player), write(' mendapatkan risk card '), write(Card), write('.'), nl,
    apply_risk_effect(Card),
    print_risk_effect(Card).

random_risk_card(Card) :-
    risk_cards(Cards),
    random_member(Card, Cards).

apply_risk_effect('CEASEFIRE ORDER') :-
    assertz(casefire_order_effect(current_player)).
    % retract(allowed_moves(Player, _)),
    % assertz(allowed_moves(Player, 0)),
    % retract(allowed_moves(_, _)),
    % assertz(allowed_moves(_, 0)).

apply_risk_effect('SUPER SOLDIER SERUM') :-
    assertz(super_soldier_serum_effect(current_player)).

% di endturn
apply_risk_effect('AUXILIARY TROOPS') :-
    current_player(Player),
    assertz(auxiliary_troops_effect(Player)).

apply_risk_effect('REBELLION') :-
    current_player(Player),
    random_owned_region(Player, Region),
    pemain_lawan(Player, Opponent),
    change_region_owner(Region, Player, Opponent),
    write('Terjadi pemberontakan di wilayah '), write(Region),
    write('. Wilayah tersebut beralih ke kekuasaan Player '), write(Opponent), write('.'), nl.

apply_risk_effect('DISEASE OUTBREAK') :-
    current_player(Player),
    assertz(disease_outbreak_effect(Player)).

apply_risk_effect('SUPPLY CHAIN ISSUE') :-
    current_player(Player),
    assertz(supply_chain_issue_effect(Player)).

pemain_lawan(Player, Opponent) :-
    findall(O, (player(O), O \= Player,is_dead(O,X),X\=1), Opponents),
    length(Opponents, NumOpponents),
    NumOpponents > 0,
    NumOpponent is NumOpponents+1,
    random(1, NumOpponent, RandomIndex),
    nth1(RandomIndex, Opponents, Opponent).

change_region_owner( R , P , O ):-
    retract(region_owner(R,P)),
    assertz(region_owner(R,O)).
random_owned_region(Player, Region) :-
    findall(R, region_owner(R, Player), OwnedRegions),
    length(OwnedRegions, NumOwnedRegions),
    NumOwnedRegions > 0,
    integer(NumOwnedRegions), 
    NumOwnedRegion is NumOwnedRegions+1,% Ensure NumOwnedRegions is an integer
    random(1, NumOwnedRegion, RandomIndex),
    nth1(RandomIndex, OwnedRegions, Region).

print_risk_effect('CEASEFIRE ORDER') :-
    write('Hingga giliran berikutnya, wilayah pemain tidak dapat diserang oleh lawan.'), nl.

print_risk_effect('SUPER SOLDIER SERUM') :-
    write('Hingga giliran berikutnya, semua hasil lemparan dadu saat penyerangan dan pertahanan akan bernilai 6.'), nl.

print_risk_effect('AUXILIARY TROOPS') :-
    write('Pada giliran berikutnya, tentara tambahan yang didapatkan pemain akan bernilai 2 kali lipat.'), nl.


print_risk_effect('DISEASE OUTBREAK') :-
    write('Hingga giliran berikutnya, semua hasil lemparan dadu saat penyerangan dan pertahanan akan bernilai 1.'), nl.

print_risk_effect('SUPPLY CHAIN ISSUE') :-
    write('Pemain tidak mendapatkan tentara tambahan pada giliran berikutnya.'), nl.

% random_owned_region(Player, Region) :-
%     findall(R, (region(R), pemilik_wilayah(Player, R)), Regions),
%     random_member(Region, Regions).
random_member(X, List) :-
    length(List, Length),
    Length > 0,
    random(1, Length, Index),
    nth1(Index, List, X).

risk_cards(['CEASEFIRE ORDER', 'SUPER SOLDIER SERUM', 'AUXILIARY TROOPS', 'REBELLION', 'DISEASE OUTBREAK', 'SUPPLY CHAIN ISSUE']).
