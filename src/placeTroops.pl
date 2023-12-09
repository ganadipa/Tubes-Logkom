placeTroops(Region, TroopCount) :-
    total_additional_troops(Player, Remaining),
    int_validator(0, Remaining, TroopCount, 'Ngaco troopcountnya'),
    
    current_player(Player),
    region_owner(Region, RegionOwner),
    !,
    (
        (Player \= RegionOwner) -> (
            write('Wilayah tersebut dimiliki pemain lain.\n'),
            fail
        ) ; !
    ),

    format('~w meletakkan ~w tentara di wilayah ~w.\n', [Player, TroopCount, Region]),
    total_troops(Region, TotalTroops),


    NewTotalTroops is TotalTroops + TroopCount,
    RemainingTroops is Remaining - TroopCount,
    !,
    (
        (RemainingTroops < 0) -> (
            write('Tentara kurang.\n'),
            fail
        ) ; !
    ),

    retract(total_troops(Region, _)),    
    assertz(total_troops(Region, NewTotalTroops)),

    retract(total_additional_troops(Player, _)),
    assertz(total_additional_troops(Player, RemainingTroops)),


    format('Terdapat ~w tentara yang tersisa.\n', [RemainingTroops]),
    next_player,
    current_player(NextPlayer),
    format('Giliran ~w untuk meletakkan tentaranya\n', [NextPlayer]).