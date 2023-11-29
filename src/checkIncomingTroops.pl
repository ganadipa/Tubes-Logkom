
/* checkIncomingTroops(p2).*/
checkIncomingTroops(Player):-
    write('\nNama                                 :  '),
    player_name(Player, Name),
    write(Name),

    write('\nTotal wilayah                        :  '),
    region_owned_length(Nama, TotalWilayah),
    write(TotalWilayah),

    write('\nJumlah tentara tambahan dari wilayah :  '),
    TroopsFromRegion is TotalWilayah//2,
    write(TroopsFromRegion),


    regions_owned_in_continent(Name, south_america, Count1), 
    (
        Count1 == 2 -> (
            write('\nBonus Benua Amerika Selatan: '),
            bonus_from_continent(south_america, Bonus1),
            write(Bonus1)
        ); !
    ),

    regions_owned_in_continent(Name, north_america, Count2), 
    (
        Count2 == 4 -> (
            write('\nBonus Benua Amerika Utara: '),
            bonus_from_continent(north_america, Bonus2),
            write(Bonus2)
        ); !
    ),

    regions_owned_in_continent(Name, africa, Count3), 
    (
        Count3 == 3 -> (
            write('\nBonus Benua Africa: '),
            bonus_from_continent(africa, Bonus3),
            write(Bonus3)
        ); !
    ),

    regions_owned_in_continent(Name, asia, Count4), 
    (
        Count4 == 7 -> (
            write('\nBonus Benua Asia: '),
            bonus_from_continent(asia, Bonus4),
            write(Bonus4)
        ); !
    ),

    regions_owned_in_continent(Name, australia, Count5), 
    (
        Count5 == 2 -> (
            write('\nBonus Benua Australia: '),
            bonus_from_continent(australia, Bonus5),
            write(Bonus5)
        ); !
    ),

    regions_owned_in_continent(Name, europe, Count6), 
    (
        Count6 == 5 -> (
            write('\nBonus Benua Eropa: '),
            bonus_from_continent(europe, Bonus6),
            write(Bonus6)
        ); !
    ),


    write('\nTotal tentara tambahan               :  '),
    total_additional_troops(Player, TotalAdditionalTroops),
    write(TotalAdditionalTroops).