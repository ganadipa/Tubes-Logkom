sum_list_naive(List, Sum) :-
    sum_list_helper(List, 0, Sum).

sum_list_helper([], Sum, Sum).
sum_list_helper([H|T], Acc, Sum) :-
    NewAcc is Acc + H,
    sum_list_helper(T, NewAcc, Sum).

int_validator(Min, Max, Value, String) :-
    (   Value >= Min,
        Value =< Max
    ->  true  
    ;   write(String), nl, fail
    ).

player_validator(Player, String) :-
    (
        \+ player(Player) -> (
            write(String), fail
        ); !
    ),
    total_player(Total),
    (
        Total == 2 -> 
        (   
            (Player == p3; Player == p4) ->  
            (
                write(String),
                fail
            ); true
        ); Total == 3 -> 
        (
            (Player == p4) -> 
            (
                write(String),
                fail
            )
        ;   true
        ); true
    ).

code_validator(Code, String):-
    (
        \+ region(Code) -> (
            write(String),
            fail
        ); true
    ).

print_players_info:-
    write('\n\nPLAYER TURN DETAILS:\n'),
    \+ print_players_info_helper.

print_players_info_helper :-
    player_name(Player, Name),
    format('~w is ~w ', [Player, Name]),
    (
        current_player(Player) -> write('<- Now turn'); true
    ),
    format('~n', []),
    fail.
