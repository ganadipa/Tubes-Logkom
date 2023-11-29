:- dynamic(dice/2, maxDice/1, tie/1, winner/1, turn/1, sum_troops/2).
:- include('next_player.pl').

% validasi jumlah pemain
readPlayers(N) :-
    repeat,
    write('Masukkan jumlah pemain: '),
    read(N),
    (between(2, 4, N), !;
     write('Mohon masukkan angka antara 2 - 4.\n'),
     fail).

% inisialisasi pemain
initPlayers(Current, N) :-
    Current > N, !.
initPlayers(Current, N) :-
    Current =< N,
    readPlayerName(Current),
    Next is Current + 1,
    initPlayers(Next, N).

% baca nama pemain
readPlayerName(Current) :-
    format('Masukkan nama pemain ~w: ', [Current]),
    read(Name),
    asserta(player_name(Current, Name)).

% kocok dadu
rollDiceForPlayers :-
    findall(Name, player_name(_, Name), Names),
    reverse(Names, ReversedNames),
    rollDiceForPlayers(ReversedNames).

rollDiceForPlayers([]).
rollDiceForPlayers([Player | Rest]) :-
    random(1, 13, DiceRoll),
    asserta(dice(Player, DiceRoll)),
    format('~w melempar dadu dan mendapatkan ~w.\n', [Player, DiceRoll]),
    rollDiceForPlayers(Rest),
    updateMaxDice(DiceRoll),
    updateTie(Player, DiceRoll).

% cek jika ada dadu terbesar yang sama
checkTie :-
    findall(Player, tie(Player), Ties),
    length(Ties, N),
    N = 1,
    Ties = [Winner],
    asserta(winner(Winner)).

% nilai dadu maksimal
updateMaxDice(DiceRoll) :-
    maxDice(Max),
    DiceRoll > Max,
    retract(maxDice(Max)),
    asserta(maxDice(DiceRoll)), !.
updateMaxDice(DiceRoll) :-
    maxDice(Max),
    DiceRoll =< Max, !.
updateMaxDice(DiceRoll) :-
    asserta(maxDice(DiceRoll)).

% cek dadu seri
updateTie(Player, DiceRoll) :-
    maxDice(Max),
    DiceRoll = Max,
    retractall(tie(_)),
    asserta(tie(Player)), !.
updateTie(_, _).

% urutan pemain
sortPlayers :-
    findall(Dice-Name, dice(Name, Dice), Pairs),
    keysort(Pairs, NewPairs),
    reverse(NewPairs, SortedPairs),
    findall(Winner, winner(Winner), Winners),
    (Winners = [SingleWinner] -> Winner = SingleWinner; Winner = Winners),
    write('\n'),
    write('Urutan pemain berdasarkan nilai dadu: '),
    printPlayerNames(SortedPairs, Winner),
    write('\n'),
    setTurns(SortedPairs).

% print urutan pemain dan urutan pertama
printPlayerNames([], Winner) :-
    write('.\n'),
    write(Winner), write(' dapat mulai terlebih dahulu.'), write('\n').

printPlayerNames([_Dice-Name | Tail], Winner) :-
    format('~w', [Name]),
    (Tail == [] -> write(''); write(' - ')),
    printPlayerNames(Tail, Winner).

% print jumlah tentara
printTroops :-
    findall(Name, player_name(_, Name), Players),
    length(Players, NumPlayers),
    calculateTroops(NumPlayers, Troops),
    format('Setiap pemain mendapatkan ~w Troops.', [Troops]).

% print first turn
printFirstTurn(Winner) :-
    format('Giliran ~w untuk memilih wilayahnya.', [Winner]).

calculateTroops(2, 24).
calculateTroops(3, 16).
calculateTroops(4, 12).

% printTurns adalah fungsi yang mencetak daftar giliran pemain
printTurns :-
    findall(Name, turn(Name), Turns),
    write('Daftar giliran pemain: '),
    printList(Turns).

% printList adalah fungsi bantuan yang mencetak daftar dengan koma
printList([]) :- nl.
printList([X]) :- write(X), nl.
printList([X|Xs]) :- write(X), write(', '), printList(Xs).

% fungsi start game
startGame :-
    readPlayers(N),
    initPlayers(1, N),
    write('\n'),
    rollDiceForPlayers,
    checkTie,
    sortPlayers,
    printTroops,
    write('\n'),
    findall(Winner, winner(Winner), Winners),
    (Winners = [SingleWinner] -> Winner = SingleWinner; Winner = Winners),
    assertz(current_player(Winner)),
    printFirstTurn(Winner).

% fungsi tambahan untuk mengatur giliran pemain secara dinamis

% setTurns(Pairs) adalah fungsi yang menetapkan giliran pemain berdasarkan urutan Pairs
setTurns([]) :- !.
setTurns([_Dice-Name | Rest]) :-
    assertz(turn(Name)),
    setTurns(Rest).

% nextTurn adalah fungsi yang mengganti giliran pemain dengan pemain selanjutnya
nextTurn :-
    turn(Current),
    retract(turn(Current)),
    assertz(turn(Current)),
    turn(Next),
    findall(R, region(R), Regions),
    length(Regions, N),
    (   N =:= 0
    ->  write('Seluruh wilayah telah diambil pemain.'), nl,
        write('Memulai pembagian sisa tentara.'), nl
    ;   write('Giliran '), write(Next), write(' untuk memilih wilayahnya.'), nl
    ).



% takeLocation(Loc) adalah fungsi yang memungkinkan pemain untuk mengambil wilayah Loc

takeLocation(Loc) :-
    region(Loc),
    turn(Player),
    \+ region_owner(Loc, _),
    asserta(region_owner(Loc, Player)),
    code(Loc, X),
    write(Player), write(' mengambil wilayah '), write(X), nl,
    nextTurn,
    !.

takeLocation(Loc) :-
    region(Loc),
    region_owner(Loc, _),
    turn(Player),
    write('Wilayah sudah dikuasai. Tidak bisa mengambil.'), nl,
    write('Giliran '), write(Player), write(' untuk memilih wilayahnya.'), nl,
    !.

placeTroops(RegionCode, TroopCount) :-
    current_player(Player),
    format('~w meletakkan ~w tentara di wilayah ~w.~n', [Player, TroopCount, RegionCode]),
    total_troops(RegionCode, TotalTroops),
    NewTotalTroops is TotalTroops + TroopCount,
    retract(total_troops(RegionCode, _)),    
    assertz(total_troops(RegionCode, NewTotalTroops)),
    RemainingTroops is 24 - NewTotalTroops,
    format('Terdapat ~w tentara yang tersisa.~n', [RemainingTroops]),
    next_player,
    current_player(NextPlayer),
    format('Giliran ~w untuk meletakkan tentaranya', NextPlayer).





    
    


