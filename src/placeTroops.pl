placeTroops(Region, TroopCount) :-
    total_additional_troops(Player, Remaining),
    int_validator(0, Remaining, TroopCount, 'Invalid number.'),
    code_validator(Region, 'Invalid code.'),

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
    format('Giliran ~w untuk meletakkan tentaranya\n', [NextPlayer]),
    
    (
        total_additional_troops(p1, _)  -> 
            (
                total_additional_troops(p1, Count1),
                Sum1 is Count1
            ); Sum1 is 0
    ),
    (
        total_additional_troops(p2, _)  -> 
            (
                total_additional_troops(p2, Count2),
                Sum2 is Count2 + Sum1
            ); Sum2 is Sum1
    ),
    (
        total_additional_troops(p3, _)  -> 
            (
                total_additional_troops(p3, Count3),
                Sum3 is Count3 + Sum2
            ); Sum3 is Sum2
    ),
    (
        total_additional_troops(p4, _)  -> 
            (
                total_additional_troops(p4, Count4),
                Sum4 is Count4 + Sum3
            ); Sum4 is Sum3
    ),

    (
        
        ((Sum4) == 0)  -> (endTurn); next_player
    )
    .

