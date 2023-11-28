% Berisi semua function helper yang berkaitan dengan wilayah.

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

writeTetangga(X) :-
    tetangga(X, FirstNeighbor),
    write(FirstNeighbor),
    writeRestNeighbors(X, FirstNeighbor),
    write('.').

writeRestNeighbors(X, PrevNeighbor) :-
    tetangga(X, Neighbor),
    Neighbor \= PrevNeighbor,
    write(', '),
    write(Neighbor),
    fail.

writeRestNeighbors(_, _).

regions_owned_in_continent(PlayerName, Continent, Count) :-
    findall(Region, 
            (region_owner(PlayerName, Region), from_continent(Region, Continent)), 
            Regions),
    length(Regions, Count).

writeRegionsOwned(Name, Continent):-
    findall(Code, (from_continent(Code, Continent), region_owner(Name, Code)) ,CodeList),
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
    