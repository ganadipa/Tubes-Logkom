next_player :-
    current_player(Player),
    total_player(N),
    retractall(current_player(_)),
    (
        N == 2 -> (
            (Player == p1) -> (
                assertz(current_player(p2))
            ) ; (Player == p2) -> (
                assertz(current_player(p1))
            ) ; !
        ) ; (N == 3) -> (
            (Player == p1) -> (
                assertz(current_player(p2))
            ) ; (Player == p2) -> (
                assertz(current_player(p3))
            ) ; (Player == p3) -> (
                assertz(current_player(p1))
            ) ; !
        ) ; (N == 4) -> (
            (Player == p1) -> (
                assertz(current_player(p2))
            ) ; (Player == p2) -> (
                assertz(current_player(p3))
            ) ; (Player == p3) -> (
                assertz(current_player(p4))
            ) ; (Player == p4) -> (
                assertz(current_player(p1))
            ) ; !
        ) ; !
    ),
    current_player(NewPlayer),
    is_dead(NewPlayer, IsDead),
    (
        (IsDead == 1) -> (
            next_player
        ) ; !
    ).
    % ,
    % print_players_info.





% test_player :-
%     assertz(total_player(3)).
%     assertz(player_name(p1, 'azmi')),
%     assertz(player_name(p2, 'randy')),
%     assertz(player_name(p3, 'emery')),
%     assertz(current_player(p1)),
%     assertz(is_dead(p2, 1)).


    