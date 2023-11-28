:- ['database.pl'].










main:-
    write('\n\nCheck Location\n'),
    checkLocationDetail(a),
    write('\n\nCheck Player\n'),
    checkPlayerDetail(p2),
    write('\n\n...').


:- initialization(main).