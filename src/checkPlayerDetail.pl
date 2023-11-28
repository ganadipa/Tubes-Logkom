

player_to_string(p2, 'P2').

player_name(p2, 'Fio').

writeBenua(Player) :-
    findall(Continent, 
            (region_owner(Player, Region), from_continent(Region, Continent)), 
            ContinentsList),
    sort(ContinentsList, UniqueContinents),
    print_continents(UniqueContinents).

print_continents([]).
print_continents([H|T]) :-
    continent_to_string(H, String),
    write(String), write(', '),
    print_continents(T).

region_owned_length(Player, Length):-
    findall(Region, region_owner(Player, Region), Regions),
    length(Regions, Length).

total_troops_owned(Player, Total) :-
    findall(Troops, 
            (region_owner(Player, Region), total_troops(Region, Troops)), 
            TroopsList),
    sum_list(TroopsList, Total).


checkPlayerDetail(Player):-
    player_to_string(Player, String),
    write('\nPLAYER '),
    write(String),
    write('\n\n'),

    player_name(Player, Nama),
    write('Nama                   :  '),
    write(Nama),

    write('\nBenua                  :  '),
    writeBenua(Nama),

    write('\nTotal Wilayah          :  '),
    region_owned_length(Nama, TotalWilayah),
    write(TotalWilayah),


    write('\nTotal Tentara Aktif    :  '),
    total_troops_owned(Nama, TotalActiveTroops),
    write(TotalActiveTroops),


    write('\nTotal Tentara Tambahan :  '),
    total_additional_troops(Player, TotalAdditionalTroops),
    write(TotalAdditionalTroops).