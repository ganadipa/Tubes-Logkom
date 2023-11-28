sum_list(List, Sum) :-
    sum_list_helper(List, 0, Sum).

sum_list_helper([], Sum, Sum).
sum_list_helper([H|T], Acc, Sum) :-
    NewAcc is Acc + H,
    sum_list_helper(T, NewAcc, Sum).