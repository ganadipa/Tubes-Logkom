
checkPlayerTerritories(Player):-
    player_name(Player, Name),
    write('Nama               :  '),
    write(Name),

    regions_owned_in_continent(Player, south_america, Count1), 
    (
        Count1 \= 0 -> (
            write('\n\nBenua Amerika Selatan ('),
            write(Count1), write('/2)'),
            writeRegionsOwned(Player, south_america)
        ); !
    ),

    regions_owned_in_continent(Player, north_america, Count2), 
    (
        Count2 \= 0 -> (
            write('\n\nBenua Amerika Utara ('),
            write(Count2), write('/5)'),
            writeRegionsOwned(Player, north_america)
        ); !
    ),

    regions_owned_in_continent(Player, asia, Count3), 
    (
        Count3 \= 0 -> 
        (
            write('\n\nBenua Asia ('),
            write(Count3), write('/7)'),
            writeRegionsOwned(Player, asia)
        ); !
    ),

    regions_owned_in_continent(Player, australia, Count4), 
    (
        Count4 \= 0 -> 
        (
            write('\n\nBenua Australia ('),
            write(Count4), write('/2)'),
            writeRegionsOwned(Player, australia)
        ); !
    ),

    regions_owned_in_continent(Player, europe, Count5), 
    (
        Count5 \= 0 -> 
        (
            write('\n\nBenua Eropa ('),
            write(Count5), write('/5)'),
            writeRegionsOwned(Player, europe)
        ); !
    ),

    regions_owned_in_continent(Player, africa, Count6), 
    (
        Count6 \= 0 -> 
        (
            write('\n\nBenua Afrika ('),
            write(Count6), write('/3)'),
            writeRegionsOwned(Player, africa)
        ); !
    ).