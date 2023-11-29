
checkPlayerTerritories(Player):-
    player_name(Player, Name),
    write('Nama               :  '),
    write(Name),

    regions_owned_in_continent(Name, south_america, Count1), 
    (
        Count1 \= 0 -> (
            write('\n\nBenua Amerika Selatan ('),
            write(Count1), write('/2)'),
            writeRegionsOwned(Name, south_america)
        ); !
    ),

    regions_owned_in_continent(Name, north_america, Count2), 
    (
        Count2 \= 0 -> (
            write('\n\nBenua Amerika Utara ('),
            write(Count2), write('/4)'),
            writeRegionsOwned(Name, north_america)
        ); !
    ),

    regions_owned_in_continent(Name, asia, Count3), 
    (
        Count3 \= 0 -> 
        (
            write('\n\nBenua Asia ('),
            write(Count3), write('/7)'),
            writeRegionsOwned(Name, asia)
        ); !
    ),

    regions_owned_in_continent(Name, australia, Count4), 
    (
        Count4 \= 0 -> 
        (
            write('\n\nBenua Australia ('),
            write(Count4), write('/2)'),
            writeRegionsOwned(Name, australia)
        ); !
    ),

    regions_owned_in_continent(Name, europe, Count5), 
    (
        Count5 \= 0 -> 
        (
            write('\n\nBenua Eropa ('),
            write(Count5), write('/5)'),
            writeRegionsOwned(Name, europe)
        ); !
    ),

    regions_owned_in_continent(Name, africa, Count6), 
    (
        Count6 \= 0 -> 
        (
            write('\n\nBenua Afrika ('),
            write(Count6), write('/3)'),
            writeRegionsOwned(Name, africa)
        ); !
    ).













:- initialization(main).