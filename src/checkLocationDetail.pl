:- ['wilayah.pl'].
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