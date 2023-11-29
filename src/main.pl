% Database

:- initialization(consult('database.pl')).


% Initiating

:- initialization(consult('startGame.pl')).
:- initialization(consult('takeLocation.pl')).
:- initialization(consult('placeTroops.pl')).
:- initialization(consult('placeAutomatic.pl')).
% % :- initialization(consult('takeLocation.pl')).

% % Turn

% :- initialization(consult('endTurn.pl')).
% :- initialization(consult('draft.pl')).
% :- initialization(consult('move.pl')).
% :- initialization(consult('attack.pl')).
% :- initialization(consult('risk.pl')).


% Other

:- initialization(consult('next_player.pl')).
