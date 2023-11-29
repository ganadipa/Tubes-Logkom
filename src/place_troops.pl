placeTroops(RegionCode, TroopCount) :-
    current_player(Player),
    format('~w meletakkan ~w tentara di wilayah ~w.~n', [Player, TroopCount, RegionCode]),
    total_troops(RegionCode, TotalTroops),
    NewTotalTroops is TotalTroops + TroopCount,
    retract(total_troops(RegionCode, _)),    
    assertz(total_troops(RegionCode, NewTotalTroops)),
    RemainingTroops is 24 - NewTotalTroops,
    format('Terdapat ~w tentara yang tersisa.~n', [RemainingTroops]),
    next_player,
    current_player(NextPlayer),
    format('Giliran ~w untuk meletakkan tentaranya', NextPlayer).