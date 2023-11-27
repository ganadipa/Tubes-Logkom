% pemindahan_tentara.pl
% not completed karena masih perlu digabung dengan inisiasi
% Rule untuk pemindahan tentara
move(X1, X2, Y) :-
    player(Player, _), % Memastikan ada pemain dengan nama Player
    milik_pemain(Player, X1), % Memastikan X1 adalah wilayah pemain
    milik_pemain(Player, X2), % Memastikan X2 adalah wilayah pemain
    jumlah_tentara(X1, JumlahAwal), % Mendapatkan jumlah tentara di wilayah asal
    JumlahAwal >= Y + 1, % Pastikan jumlah tentara cukup untuk dipindahkan
    Y >= 1, % Pastikan jumlah tentara yang ingin dipindahkan valid
    batas_pemindahan(Batas), % Mendapatkan batas maksimum pemindahan per turn
    count_pemindahan(Player, Pemindahan), % Mendapatkan jumlah pemindahan yang sudah dilakukan
    Pemindahan < Batas, % Pastikan jumlah pemindahan masih kurang dari batas maksimum
    JumlahAkhir is JumlahAwal - Y,
    retract(jumlah_tentara(X1, JumlahAwal)), % Update jumlah tentara di wilayah asal
    asserta(jumlah_tentara(X1, 1)), % Sisakan 1 tentara di wilayah asal
    retract(jumlah_tentara(X2, JumlahX2)), % Update jumlah tentara di wilayah tujuan
    JumlahTujuan is JumlahX2 + Y,
    asserta(jumlah_tentara(X2, JumlahTujuan)), % Tambah tentara di wilayah tujuan
    retract(count_pemindahan(Player, Pemindahan)), % Update jumlah pemindahan yang sudah dilakukan
    PemindahanBaru is Pemindahan + 1,
    asserta(count_pemindahan(Player, PemindahanBaru)), % Tambah jumlah pemindahan yang sudah dilakukan
    write(Player), write(' memindahkan '), write(Y),
    write(' tentara dari '), write(X1),
    write(' ke '), write(X2), write('.'), nl,
    write('Jumlah tentara di '), write(X1), write(': 1'), nl,
    write('Jumlah tentara di '), write(X2), write(': '), write(JumlahTujuan), nl.

% Rule untuk menangani kasus jumlah tentara tidak valid
move(X1, X2, Y) :-
    player(Player, _),
    milik_pemain(Player, X1),
    milik_pemain(Player, X2),
    jumlah_tentara(X1, JumlahAwal),
    JumlahAwal < Y + 1,
    write('Tentara tidak mencukupi. Pemindahan dibatalkan.'), nl.

% Rule untuk menangani kasus wilayah tidak valid
move(X1, X2, Y) :-
    player(Player, _),
    \+ milik_pemain(Player, X1),
    write(Player), write(' tidak memiliki wilayah '), write(X1),
    write('. Pemindahan dibatalkan.'), nl.

% Rule untuk menangani kasus pemain melebihi batas maksimum pemindahan per turn
move(X1, X2, Y) :-
    player(Player, _),
    milik_pemain(Player, X1),
    milik_pemain(Player, X2),
    jumlah_tentara(X1, JumlahAwal),
    JumlahAwal >= Y + 1,
    Y >= 1,
    batas_pemindahan(Batas),
    count_pemindahan(Player, Pemindahan),
    Pemindahan >= Batas,
    write('Pemindahan melebihi batas maksimum per turn. Pemindahan dibatalkan.'), nl.
