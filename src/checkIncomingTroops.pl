/* checkIncomingTroops(p2).*/
checkIncomingTroops(Player):-
    write('\nNama                                 :  '),
    player_name(Player, Name),
    write(Name)

    write('\nTotal wilayah                        :  '),
    region_owned_length(Nama, TotalWilayah),
    write(TotalWilayah),

    write('\nJumlah tentara tambahan dari wilayah :  '),


    write('\nBonus                                :  '),
    write('\nBonus                                :  '),
    write('\nBonus                                :  '),

    
    write('\nTotal tentara tambahan               :  '),
    total_additional_troops(Player, TotalAdditionalTroops),
    write(TotalAdditionalTroops).

:- initialization(checkIncomingTroops(p2)).