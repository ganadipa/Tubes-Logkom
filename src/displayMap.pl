displayMap :-
    total_troops(na1, TNA1),
    total_troops(na2, TNA2),

    total_troops(na5, TNA5),
    total_troops(e1, TE1),
    total_troops(e2, TE2),
    total_troops(a1, TA1),
    total_troops(a2, TA2),
    total_troops(a3, TA3),

    total_troops(na3, TNA3),
    total_troops(na4, TNA4),
    

    total_troops(e3, TE3),
    total_troops(e4, TE4),

    total_troops(e5, TE5),
    total_troops(a4, TA4),
    total_troops(a5, TA5),

    total_troops(sa1, TSA1),

    total_troops(af2, TAF2),
    total_troops(a6, TA6),
    total_troops(a7, TA7),

    total_troops(sa2, TSA2),
    total_troops(af1, TAF1),

    total_troops(af3, TAF3),

    total_troops(au1, TAU1),
    total_troops(au2, TAU2),

    write('#################################################################################################\n'),
    write('#         North America         #        Europe         #                 Asia                  #\n'),
    write('#                               #                       #                                       #\n'),
   format('#     [NA1(~w)]-[NA2(~w)]       #                       #                                       #\n', [TNA1, TNA2]),
   format('---------|         |----[NA5(~w)]----[E1(~w)]-[E2[~w]]---------[A1(~w)] [A2(~w)] [A3(~w)]-------#\n', [TNA5, TE1, TE2, TA1, TA2, TA3]),
   format('#     [NA3(~w)]-[NA4(~w)]       #      |        |       #        |        |        |            #\n', [TNA3, TNA4]),
   format('#        |                      #    [E3(~w)]-[E4(~w)]  ####     |        |        |            #\n', [TE3, TE4]),
   format('#########|#######################      |        |-[E5(~w)]-----[A4(~w)]---+------[A5(~w)]       #\n', [TE5, TA4, TA5]),
    write('#        |                      #######|########|###########              |                     #\n'),
   format('#     [SA1(~w)]                 #      |        |          #              |                     #\n', [TSA1]),
   format('#        |                      #      |     [AF2(~w)]     #            [A6(~w)]-[A7(~w)]       #\n', [TAF2, TA6, TA7]),
   format('#   |-[SA2(~w)]---------------------[AF1(~w)]---|          #              |                     #\n', [TSA2, TAF1]),
    write('#   |                           #               |          ###############|######################\n'),
   format('#   |                           #            [AF3(~w)]     #              |                     #\n', [TAF3]),
   format('----|                           #                          #           [AU1(~w)]-[AU2(~w)]-------\n', [TAU1, TAU2]),
    write('#                               #                          #                                    #\n'),
    write('#         South America         #        Africa            #              Australia             #\n'),
    write('#################################################################################################\n').