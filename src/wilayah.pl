% Berisi semua function helper yang berkaitan dengan wilayah.

writeBenua(Player) :-
    findall(Continent, 
            (region_owner(Region, Player), from_continent(Region, Continent)), 
            ContinentsList),
    sort(ContinentsList, UniqueContinents),
    print_continents(UniqueContinents).

print_continents([]).
print_continents([H|T]) :-
    continent_to_string(H, String),
    write(String), write(', '),
    print_continents(T).

region_owned_length(Player, Length):-
    findall(Region, region_owner(Region, Player), Regions),
    length(Regions, Length).

total_troops_owned(Player, Total) :-
    findall(Troops, 
            (region_owner(Region, Player), total_troops(Region, Troops)), 
            TroopsList),
    sum_list(TroopsList, Total).

writeTetangga(X) :-
    adjacent(X, FirstNeighbor),
    write(FirstNeighbor),
    writeRestNeighbors(X, FirstNeighbor),
    write('.'), !.

writeRestNeighbors(X, PrevNeighbor) :-
    adjacent(X, Neighbor),
    Neighbor \= PrevNeighbor,
    write(', '),
    write(Neighbor),
    fail.

writeRestNeighbors(_, _).

regions_owned_in_continent(PlayerName, Continent, Count) :-
    findall(Region, 
            (region_owner(Region, PlayerName), from_continent(Region, Continent)), 
            Regions),
    length(Regions, Count).

writeRegionsOwned(Player, Continent):-
    findall(Code, (from_continent(Code, Continent), region_owner(Code, Player)), CodeList),
    writeRegionInfo(CodeList).

writeRegionInfo([]).
writeRegionInfo([H|T]):-
    write('\n\n'),
    code(H, Kode),
    write(Kode),
    write('\nNama            :  '),
    region_name(H, RegionName),
    write(RegionName),
    write('\nJumlah Tentara  :  '),
    total_troops(H, Troops),
    write(Troops),
    write('\n'),
    writeRegionInfo(T).

total_regions_owned(Name, Total):-
    regions_owned_in_continent(Name, south_america, Count1),
    regions_owned_in_continent(Name, north_america, Count2),
    regions_owned_in_continent(Name, asia, Count3),
    regions_owned_in_continent(Name, australia, Count4),
    regions_owned_in_continent(Name, europe, Count5),
    regions_owned_in_continent(Name, africa, Count6),
    Total is Count1 + Count2 + Count3 + Count4 + Count5 + Count6.

    