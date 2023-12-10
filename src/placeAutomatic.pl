iterate_and_place([], _, _).
iterate_and_place([Code | Rest], Number, Remainder) :-
    ( 
        Remainder > 0 -> 
        TroopsToPlace is Number + 1, 
        NewRemainder is Remainder - 1
    ; 
        TroopsToPlace = Number, 
        NewRemainder = Remainder
    ),
    placeTroops_quietly(Code, TroopsToPlace),
    iterate_and_place(Rest, Number, NewRemainder).

placeAutomatic:-
    current_player(Player),
    findall(Code, region_owner(Code, Player), CodeList),

    retract(total_additional_troops(Player, Remaining)),
    assertz(total_additional_troops(Player, 0)),

    length(CodeList, Length),

    Number is Remaining//Length,
    Remainder is Remaining - (Number*Length),
    
    iterate_and_place(CodeList, Number, Remainder),
    
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
        
        ((Sum4) == 0)  -> (endTurn); true
    ),
    next_player.

placeTroops_quietly(Region, TroopCount) :-
    current_player(Player),
    total_troops(Region, TotalTroops),
    
    player_name(Player, Name),

    NewTotalTroops is TotalTroops + TroopCount,
    format('\n~w berhasil meletakkan ~w di wilayah ~w, sehingga total ~w berada di wilayah ini.', [Name, TroopCount, Region, NewTotalTroops]),

    retract(total_troops(Region, _)),    
    assertz(total_troops(Region, NewTotalTroops))
    .

