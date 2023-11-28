


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

checkLocationDetail(Kode):-

    write('Kode              :  '),
    code(Kode, X),
    write(X),
    write('\nNama              :  '),
    region_name(Kode,Y),
    write(Y),
    write('\nPemilik           :  '),
    region_owner(Kode,Z),
    write(Z),
    write('\nTotal Tentara     :  '),
    total_troops(Kode, W),
    write(W),
    write('\nTetangga          :  '),
    writeTetangga(Kode).