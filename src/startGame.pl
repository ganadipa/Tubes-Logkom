:- dynamic(dice/2, maxDice/1, tie/1, winner/1).
:- ['database.pl'].

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
    printFirstTurn(Winner).