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
    next_player.

placeTroops_quietly(Region, TroopCount) :-
    current_player(Player),
    total_troops(Region, TotalTroops),
    
    player_name(Player, Name),

    NewTotalTroops is TotalTroops + TroopCount,
    format('\n~w berhasil meletakkan ~w di wilayah ~w, sehingga total ~w berada di wilayah ini.', [Name, TroopCount, Region, NewTotalTroops]),

    retract(total_troops(Region, _)),    
    assertz(total_troops(Region, NewTotalTroops)).
