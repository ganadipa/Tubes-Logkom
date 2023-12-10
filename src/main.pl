% Database
:- initialization(consult('database.pl')).

% Map
:- initialization(consult('displayMap.pl')).


% Initiating

:- initialization(consult('startGame.pl')).
:- initialization(consult('takeLocation.pl')).
:- initialization(consult('placeTroops.pl')).
:- initialization(consult('placeAutomatic.pl')).

% % Turn

:- initialization(consult('endTurn.pl')).
:- initialization(consult('draft.pl')).
:- initialization(consult('move.pl')).
:- initialization(consult('attack.pl')).
:- initialization(consult('risk.pl')).


% Wilayah dan Player
:- initialization(consult('wilayah.pl')).
:- initialization(consult('checkIncomingTroops.pl')).
:- initialization(consult('checkLocationDetail.pl')).
:- initialization(consult('checkPlayerDetail.pl')).
:- initialization(consult('checkPlayerTerritories.pl')).

% Other

:- initialization(consult('next_player.pl')).
:- initialization(consult('utils.pl')).

