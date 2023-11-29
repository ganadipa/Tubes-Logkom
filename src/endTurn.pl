endTurn :-
    retract(move_count(_)),
    assertz(move_count(0)),
    current_player(OldPlayer),
    player_name(OldPlayer, OldPlayerName),
    format('Player ~w mengakhiri giliran.\n\n', [OldPlayerName]),
    next_player,
    current_player(NewPlayer),
    player_name(NewPlayer, NewPlayerName),
    format('Sekarang giliran Player ~w!\n', [NewPlayerName]),
    region_owned_length(NewPlayer, TotalRegion),

    region_owner(na1, ONA1),
    region_owner(na2, ONA2),
    region_owner(na3, ONA3),
    region_owner(na4, ONA4),
    region_owner(na5, ONA5),

    region_owner(sa1, OSA1),
    region_owner(sa2, OSA2),

    region_owner(e1, OE1),
    region_owner(e2, OE2),
    region_owner(e3, OE3),
    region_owner(e4, OE4),
    region_owner(e5, OE5),

    region_owner(af1, OAF1),
    region_owner(af2, OAF2),
    region_owner(af3, OAF3),

    region_owner(a1, OA1),
    region_owner(a2, OA2),
    region_owner(a3, OA3),
    region_owner(a4, OA4),
    region_owner(a5, OA5),
    region_owner(a6, OA6),
    region_owner(a7, OA7),

    region_owner(au1, OAU1),
    region_owner(au2, OAU2),

    TotalRegionPerTwo is TotalRegion // 2,

    bonus_from_continent(north_america, B_NA),
    bonus_from_continent(south_america, B_SA),
    bonus_from_continent(africa, B_AF),
    bonus_from_continent(asia, B_AS),
    bonus_from_continent(australia, B_AU),
    bonus_from_continent(europe, B_EU),

    
    (
        (NewPlayer == ONA1, ONA1 == ONA2, ONA2 == ONA3, ONA3 == ONA4, ONA4 == ONA5) -> (
            NA_Bonus is B_NA
        ) ; (
            NA_Bonus is 0
        )
    ),
    (   (NewPlayer == OSA1, OSA1 == OSA2) -> (
            SA_Bonus is B_SA,
            write('Bonus is here!!\n\n')
        ) ; (
            SA_Bonus is 0
        )
    ),
    (   (NewPlayer == OE1, OE1 == OE2, OE2 == OE3, OE3 == OE4, OE4 == OE5) -> (
            EU_Bonus is B_EU
        ) ; (
            EU_Bonus is 0
        )
    ),  
    (   
        (NewPlayer == OAF1, OAF1 == OAF2, OAF2 == OAF3) -> (
            AF_Bonus is B_AF
        ) ; (
            AF_Bonus is 0
        )
    ),
    (
        (NewPlayer == OA1, OA1 == OA2, OA2 == OA3, OA3 == OA4, OA4 == OA5, OA5 == OA6, OA6 == OA7) -> (
            AS_Bonus is B_AS
        ) ; (
            AS_Bonus is 0
        )
    ),
    (
        (NewPlayer == OAU1, OAU1 == OAU2) -> (
            AU_Bonus is B_AU
        ) ; (
            AU_Bonus is 0
        )
    ),
    !,
    (
        (supply_chain_issue_effect(NewPlayer)) -> (
            write('Anda terkena Supply Chain Issue. Anda tidak akan mendapatkan tentara tambahan pada giliran berikutnya.\n'),
            retract(supply_chain_issue_effect(NewPlayer)),
            fail
        ) ; !
    ),
    (
        (auxiliary_troops_effect(NewPlayer)) -> (
            write('Anda terkena auxiliary troops effect. Anda akan mendapatkan 2 kali lipat.\n'),
            retract(auxiliary_troops_effect(NewPlayer)),
            TotalAdditionalTroops is 2 * (TotalRegionPerTwo + NA_Bonus + SA_Bonus + EU_Bonus + AF_Bonus + AS_Bonus + AU_Bonus)
        ) ; (
            TotalAdditionalTroops is (TotalRegionPerTwo + NA_Bonus + SA_Bonus + EU_Bonus + AF_Bonus + AS_Bonus + AU_Bonus)
        )
    ),
    format('Player ~w mendapat ~w tentara tambahan.\n', [NewPlayerName, TotalAdditionalTroops]),
    total_additional_troops(NewPlayer, OldAdditionalTroops),
    NewAdditionalTroops is OldAdditionalTroops + TotalAdditionalTroops,
    update_additional_troops(NewPlayer, NewAdditionalTroops).