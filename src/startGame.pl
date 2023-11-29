:- dynamic(dice/2, maxDice/1, tie/1, winner/1).

% validasi jumlah pemain
readPlayers(N) :-
    repeat,
    write('Masukkan jumlah pemain: '),
    read(N),
    (between(2, 4, N), !;
     write('Mohon masukkan angka antara 2 - 4.\n'),
     fail),
    retractall(total_player(_)),
    asserta(total_player(N)).


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
    (   Current == 1 ->
        retractall(player_name(p1, _)),
        asserta(player_name(p1, Name))
    ;   Current == 2 ->
        retractall(player_name(p2, _)),
        asserta(player_name(p2, Name))
    ;   Current == 3 ->
        retractall(player_name(p3, _)),
        asserta(player_name(p3, Name))
    ;   Current == 4 ->
        retractall(player_name(p4, _)),
        asserta(player_name(p4, Name))
    ).

% kocok dadu
rollDiceForPlayers :-
    findall(Name, player_name(_, Name), Names),
    reverse(Names, ReversedNames),
    rollDiceForPlayers(ReversedNames).

rollDiceForPlayers([]).
rollDiceForPlayers([Player | Rest]) :-
    random(1, 7, DiceRoll1),
    random(1, 7, DiceRoll2),
    DiceRoll is DiceRoll1 + DiceRoll2,
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
    write('\n').

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

% fungsi start game
startGame :-
    retractall(player_name(_,_)),
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
    printFirstTurn(Winner),
    player_name(Player, Winner),
    assertz(current_player(Player)),
    calculateTroops(N, TotalAdditionalTroops),
    assertz(total_additional_troops(p1, TotalAdditionalTroops)),
    (
        (N >= 2) -> (
            assertz(total_additional_troops(p2, TotalAdditionalTroops))
        ) ; !
    ),
    (
        (N >= 3) -> (
            assertz(total_additional_troops(p3, TotalAdditionalTroops))
        ) ; !
    ),
    (
        (N >= 4) -> (
            assertz(total_additional_troops(p4, TotalAdditionalTroops))
        ) ; !
    ).
