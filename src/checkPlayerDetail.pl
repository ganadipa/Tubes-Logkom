
checkPlayerDetail(Player):-
    player_to_string(Player, String),
    write('\nPLAYER '),
    write(String),
    write('\n\n'),

    player_name(Player, Nama),
    write('Nama                   :  '),
    write(Nama),

    write('\nBenua                  :  '),
    writeBenua(Player),

    write('\nTotal Wilayah          :  '),
    region_owned_length(Player, TotalWilayah),
    write(TotalWilayah),


    write('\nTotal Tentara Aktif    :  '),
    total_troops_owned(Player, TotalActiveTroops),
    write(TotalActiveTroops),


    write('\nTotal Tentara Tambahan :  '),
    total_additional_troops(Player, TotalAdditionalTroops),
    write(TotalAdditionalTroops).