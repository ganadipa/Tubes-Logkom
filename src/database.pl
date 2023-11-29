player_to_string(p1, 'P1').
player_to_string(p2, 'P2').
player_to_string(p3, 'P3').
player_to_string(p4, 'P4').

% region
region(na1).
region(na2).
region(na3).
region(na4).
region(na5).

region(sa1).
region(sa2).

region(e1).
region(e2).
region(e3).
region(e4).
region(e5).

region(af1).
region(af2).
region(af3).

region(a1).
region(a2).
region(a3).
region(a4).
region(a5).
region(a6).
region(a7).

region(au1).
region(au2).

continent(north_america).
continent(europe).
continent(asia).
continent(south_america).
continent(africa).
continent(australia).

from_continent(na1,north_america).
from_continent(na2,north_america).
from_continent(na3,north_america).
from_continent(na4,north_america).
from_continent(na5,north_america).

from_continent(sa1,south_america).
from_continent(sa2,south_america).

from_continent(e1,europe).
from_continent(e2,europe).
from_continent(e3,europe).
from_continent(e4,europe).
from_continent(e5,europe).

from_continent(af1,africa).
from_continent(af2,africa).
from_continent(af3,africa).

from_continent(a1,asia).
from_continent(a2,asia).
from_continent(a3,asia).
from_continent(a4,asia).
from_continent(a5,asia).
from_continent(a6,asia).
from_continent(a7,asia).

from_continent(au1,australia).
from_continent(au2,australia).

adjacent(na4,na2).
adjacent(na3,na4).
adjacent(na2,na4).
adjacent(na4,na3).
adjacent(na1,na2).
adjacent(na2,na1).
adjacent(na3,na1).
adjacent(na1,na3).
adjacent(na4,na5).
adjacent(na5,na4).
adjacent(na5,na2).
adjacent(na2,na5).
adjacent(e1,na5).
adjacent(na5,e1).
adjacent(sa1,na3).
adjacent(na3,sa1).
adjacent(sa2,sa1).
adjacent(sa1,sa2).
adjacent(sa2,af1).
adjacent(af1,sa2).
adjacent(af1,af3).
adjacent(af3,af1).
adjacent(af1,af2).
adjacent(af2,af1).
adjacent(af2,af3).
adjacent(af3,af2).
adjacent(e3, af1).
adjacent(af1,e3).
adjacent(e1,e3).
adjacent(e3,e1).
adjacent(e1,e2).
adjacent(e2,e1).
adjacent(af2,e4).
adjacent(e4,af2).
adjacent(af2,e5).
adjacent(e5,af2).
adjacent(e4,e5).
adjacent(e5,e4).
adjacent(e2,e4).
adjacent(e4,e2).
adjacent(e2,a1).
adjacent(a1,e2).
adjacent(a4,e5).
adjacent(e5,a4).
adjacent(e2,a1).
adjacent(a1,e2).
adjacent(a1,a4).
adjacent(a4,a1).
adjacent(a4,a5).
adjacent(a5,a4).
adjacent(a5,a3).
adjacent(a3,a5).
adjacent(a5,a2).
adjacent(a2,a5).
adjacent(a4,a2).
adjacent(a2,a4).
adjacent(a2,a6).
adjacent(a6,a2).
adjacent(a4,a6).
adjacent(a6,a4).
adjacent(a5,a6).
adjacent(a6,a5).
adjacent(a6,a7).
adjacent(a7,a6).
adjacent(a3,na1).
adjacent(a3,na3).
adjacent(na1,a3).
adjacent(na3,a3).
adjacent(a6,au1).
adjacent(au1,a6).
adjacent(au1,au2).
adjacent(au2,au1).
adjacent(au2,sa2).
adjacent(sa2,au2).

code(na1, 'NA1').
code(na2, 'NA2').
code(na3, 'NA3').
code(na4, 'NA4').
code(na5, 'NA5').

code(sa1, 'SA1').
code(sa2, 'SA2').

code(af1, 'AF1').
code(af2, 'AF2').
code(af3, 'AF3').

code(a1, 'A1').
code(a2, 'A2').
code(a3, 'A3').
code(a4, 'A4').
code(a5, 'A5').
code(a6, 'A6').
code(a7, 'A7').

code(au1, 'AU1').
code(au2, 'AU2').

code(e1, 'E1').
code(e2, 'E2').
code(e3, 'E3').
code(e4, 'E4').
code(e5, 'E5').

continent_to_string(north_america, 'North America').
continent_to_string(south_america, 'South America').
continent_to_string(europe, 'Europe').
continent_to_string(africa, 'Africa').
continent_to_string(asia, 'Asia').
continent_to_string(australia, 'Australia').

region_name(na1, 'Greenland').
region_name(na2, 'Ontario').
region_name(na3, 'Yucatan'). 
region_name(na4, 'California').
region_name(na5, 'Quebec').

region_name(sa1, 'Amazonas').     
region_name(sa2, 'Patagonia').

region_name(e1, 'Tuscany').
region_name(e2, 'Bavaria').
region_name(e3, 'Cornwall').
region_name(e4, 'Normandy').
region_name(e5, 'Friesland').

region_name(af1, 'Gauteng').      
region_name(af2, 'Lagos').        
region_name(af3, 'Casablanca').   

region_name(a1, 'Bali').          
region_name(a2, 'Phuket').        
region_name(a3, 'Jeju').          
region_name(a4, 'Hokkaido').      
region_name(a5, 'Kyoto').      
region_name(a6, 'Rajasthan').      
region_name(a7, 'Siem Reap').      

region_name(au1, 'Queensland').   
region_name(au2, 'South Island').

bonus_from_continent(north_america, 4).
bonus_from_continent(south_america, 2).
bonus_from_continent(africa, 3).
bonus_from_continent(asia, 7).
bonus_from_continent(australia, 2).
bonus_from_continent(europe, 5).


player(p1).
player(p2).
player(p3).
player(p4).

:- dynamic(is_dead / 2).

:- initialization(assertz(is_dead(p1, 0))).
:- initialization(assertz(is_dead(p2, 0))).
:- initialization(assertz(is_dead(p3, 0))).
:- initialization(assertz(is_dead(p4, 0))).

:- dynamic(total_player / 1).

:- dynamic(current_player / 1).

:- dynamic(player_name / 2).
% Fungsi pembantu dynamic player name.
add_player_name(Player, Name) :-
    assertz(player_name(Player, Name)).

:- dynamic(region_owner / 2).

:- dynamic(total_troops / 2).

:- dynamic(total_additional_troops / 2).

% Fungsi pembantu dynamic total_additional_troops.
add_additional_troops(Player, Number) :-
    assertz(total_additional_troops(Player, Number)).

update_additional_troops(Player, Number) :-
    retract(total_additional_troops(Player, _)),
    assertz(total_additional_troops(Player, Number)).

remove_additional_troops(Player) :-
    retract(total_additional_troops(Player, _)).

query_additional_troops(Player, Troops) :-
    total_additional_troops(Player, Troops).

list_all_additional_troops :-
    findall((Player, Troops), total_additional_troops(Player, Troops), AllTroops),
    print_all_additional_troops(AllTroops).

print_all_additional_troops([]).
print_all_additional_troops([(Player, Troops)|T]) :-
    write(Player), write(': '), write(Troops), nl,
    print_all_additional_troops(T).

:- dynamic(turn_count / 1).

:- dynamic(allowed_moves / 2).

:- initialization(assertz(total_troops(na1, 0))).
:- initialization(assertz(total_troops(na2, 0))).
:- initialization(assertz(total_troops(na3, 0))).
:- initialization(assertz(total_troops(na4, 0))).
:- initialization(assertz(total_troops(na5, 0))).

:- initialization(assertz(total_troops(sa1, 0))).
:- initialization(assertz(total_troops(sa2, 0))).

:- initialization(assertz(total_troops(e1, 0))).
:- initialization(assertz(total_troops(e2, 0))).
:- initialization(assertz(total_troops(e3, 0))).
:- initialization(assertz(total_troops(e4, 0))).
:- initialization(assertz(total_troops(e5, 0))).

:- initialization(assertz(total_troops(af1, 0))).
:- initialization(assertz(total_troops(af2, 0))).
:- initialization(assertz(total_troops(af3, 0))).

:- initialization(assertz(total_troops(a1, 0))).
:- initialization(assertz(total_troops(a2, 0))).
:- initialization(assertz(total_troops(a3, 0))).
:- initialization(assertz(total_troops(a4, 0))).
:- initialization(assertz(total_troops(a5, 0))).
:- initialization(assertz(total_troops(a6, 0))).
:- initialization(assertz(total_troops(a7, 0))).

:- initialization(assertz(total_troops(au1, 0))).
:- initialization(assertz(total_troops(au2, 0))).


% :- initialization(assertz(total_additional_troops(na1, 0))).
% :- initialization(assertz(total_additional_troops(na2, 0))).
% :- initialization(assertz(total_additional_troops(na3, 0))).
% :- initialization(assertz(total_additional_troops(na4, 0))).
% :- initialization(assertz(total_additional_troops(na5, 0))).

% :- initialization(assertz(total_additional_troops(sa1, 0))).
% :- initialization(assertz(total_additional_troops(sa2, 0))).

% :- initialization(assertz(total_additional_troops(e1, 0))).
% :- initialization(assertz(total_additional_troops(e2, 0))).
% :- initialization(assertz(total_additional_troops(e3, 0))).
% :- initialization(assertz(total_additional_troops(e4, 0))).
% :- initialization(assertz(total_additional_troops(e5, 0))).

% :- initialization(assertz(total_additional_troops(af1, 0))).
% :- initialization(assertz(total_additional_troops(af2, 0))).
% :- initialization(assertz(total_additional_troops(af3, 0))).

% :- initialization(assertz(total_additional_troops(a1, 0))).
% :- initialization(assertz(total_additional_troops(a2, 0))).
% :- initialization(assertz(total_additional_troops(a3, 0))).
% :- initialization(assertz(total_additional_troops(a4, 0))).
% :- initialization(assertz(total_additional_troops(a5, 0))).
% :- initialization(assertz(total_additional_troops(a6, 0))).
% :- initialization(assertz(total_additional_troops(a7, 0))).

% :- initialization(assertz(total_additional_troops(au1, 0))).
% :- initialization(assertz(total_additional_troops(au2, 0))).

:- dynamic(has_risk_card/2).

:- dynamic(isDisease/1).
:- dynamic(has_risk_card/2).
:- dynamic(casefire_order_effect/1).
:- dynamic(super_soldier_serum_effect/1).
:- dynamic(auxiliary_troops_effect/1).
:- dynamic(disease_outbreak_effect/1).
:- dynamic(supply_chain_issue_effect/1).