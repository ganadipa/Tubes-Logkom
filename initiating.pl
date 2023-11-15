:- dynamic(player/2).
:- dynamic(turn/1).
:- dynamic(troops/2).
:- dynamic(owned/2).
:- dynamic(placed/2).

startGame :-
    repeat,
    write('Masukkan jumlah pemain: '),
    read(N),
    (N >= 2, N =< 4, !, initGame(N), playGame;
     write('Mohon masukkan angka antara 2 - 4.\n'),
     fail).

initGame(N) :-
    retractall(player(_, _)),
    retractall(turn(_)),
    retractall(troops(_, _)),
    retractall(owned(_, _)),
    retractall(placed(_, _)),
    retractall(initTroops(_)),
    asserta(turn(1)),
    initPlayers(N),
    rollDiceForPlayers.

initPlayers(N) :-
    initPlayers(1, N).

initPlayers(Current, N) :-
    Current =< N,
    write('Masukkan nama pemain '), write(Current), write(': '),
    read(Name),
    asserta(player(Current, Name)),
    asserta(troops(Current, 0)),
    Next is Current + 1,
    initPlayers(Next, N).
