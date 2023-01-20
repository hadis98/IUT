% Tic tac toe program witten in prolog. 
% It uses the minimax algorithm.

play :- initConfig, playGame([0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]).

initConfig :-
  write('The numbers representation are as follows:\n0 - Blank\n1 - User\n2 - Computer\nType a period after every input you give.'),
  nl,
  showBoard([0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]).

playGame(Board) :- win(Board, 1), write('User won!').
playGame(Board) :- win(Board, 2), write('Computer won!').
playGame(Board) :- not(areMovesLeft(Board)), write('Draw!'). 
playGame(Board) :- write('Enter row number: '), read(Row), write('Enter column number: '), read(Column), EnteredIndex is Column + (Row-1)*4,
  userMove(Board, EnteredIndex, Newboard), 
  showBoard(Newboard),
  orespond(Newboard, Newboard2), 
  showBoard(Newboard2),
  playGame(Newboard2).

showBoard([A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,Q]) :- write([A,B,C,D]),nl,write([E,F,G,H]),nl,
 write([I,J,K,L]),nl,write([M,N,O,Q]),nl.

win(Board, P) :- rowwin(Board, P).
win(Board, P) :- colwin(Board, P).
win(Board, P) :- diagwin(Board, P).

rowwin(Board, P) :- Board = [P,P,P,P,_,_,_,_,_,_,_,_,_,_,_,_].
rowwin(Board, P) :- Board = [_,_,_,_,P,P,P,P,_,_,_,_,_,_,_,_].
rowwin(Board, P) :- Board = [_,_,_,_,_,_,_,_,P,P,P,P,_,_,_,_].
rowwin(Board, P) :- Board = [_,_,_,_,_,_,_,_,_,_,_,_,P,P,P,P].

colwin(Board, P) :- Board = [P,_,_,_,P,_,_,_,P,_,_,_,P,_,_,_].
colwin(Board, P) :- Board = [_,P,_,_,_,P,_,_,_,P,_,_,_,P,_,_].
colwin(Board, P) :- Board = [_,_,P,_,_,_,P,_,_,_,P,_,_,_,P,_].
colwin(Board, P) :- Board = [_,_,_,P,_,_,_,P,_,_,_,P,_,_,_,P].

diagwin(Board, P) :- Board = [P,_,_,_,_,P,_,_,_,_,P,_,_,_,_,P].
diagwin(Board, P) :- Board = [_,_,_,P,_,_,P,_,_,P,_,_,P,_,_,_].



orespond(Board,Board) :- not(areMovesLeft(Board)).

orespond(Board,Newboard) :- MI is 0, Best is -1000,
playIndex(Board, 0, MI, Best, Ans), A is (Ans+1),!,
computerMove(Board, A, Newboard).


playIndex(Board, 16, MI, Best, Ans) :- Ans is MI, !.
playIndex(Board, I, MI, Best, Ans) :-  nth0(I, Board, El), El=0, I2 is I+1, computerMove(Board, I2, Newboard), minimax(Newboard, 1, V),  (V > Best -> NewBest is V, NewMI is I; NewBest is Best , NewMI is MI), playIndex(Board, I2, NewMI, NewBest, Ans),!.
playIndex(Board, I, MI, Best, Ans) :-  nth0(I, Board, El), not(El=0), NI is I + 1, playIndex(Board, NI, MI, Best, Ans).


userMove([0,B,C,D,E,F,G,H,I,J,K,L,M,N,O,Q], 1, [1,B,C,D,E,F,G,H,I,J,K,L,M,N,O,Q]).
userMove([A,0,C,D,E,F,G,H,I,J,K,L,M,N,O,Q], 2, [A,1,C,D,E,F,G,H,I,J,K,L,M,N,O,Q]).
userMove([A,B,0,D,E,F,G,H,I,J,K,L,M,N,O,Q], 3, [A,B,1,D,E,F,G,H,I,J,K,L,M,N,O,Q]).
userMove([A,B,C,0,E,F,G,H,I,J,K,L,M,N,O,Q], 4, [A,B,C,1,E,F,G,H,I,J,K,L,M,N,O,Q]).
userMove([A,B,C,D,0,F,G,H,I,J,K,L,M,N,O,Q], 5, [A,B,C,D,1,F,G,H,I,J,K,L,M,N,O,Q]).
userMove([A,B,C,D,E,0,G,H,I,J,K,L,M,N,O,Q], 6, [A,B,C,D,E,1,G,H,I,J,K,L,M,N,O,Q]).
userMove([A,B,C,D,E,F,0,H,I,J,K,L,M,N,O,Q], 7, [A,B,C,D,E,F,1,H,I,J,K,L,M,N,O,Q]).
userMove([A,B,C,D,E,F,G,0,I,J,K,L,M,N,O,Q], 8, [A,B,C,D,E,F,G,1,I,J,K,L,M,N,O,Q]).
userMove([A,B,C,D,E,F,G,H,0,J,K,L,M,N,O,Q], 9, [A,B,C,D,E,F,G,H,1,J,K,L,M,N,O,Q]).
userMove([A,B,C,D,E,F,G,H,I,0,K,L,M,N,O,Q], 10,[A,B,C,D,E,F,G,H,I,1,K,L,M,N,O,Q]).
userMove([A,B,C,D,E,F,G,H,I,J,0,L,M,N,O,Q], 11,[A,B,C,D,E,F,G,H,I,J,1,L,M,N,O,Q]).
userMove([A,B,C,D,E,F,G,H,I,J,K,0,M,N,O,Q], 12,[A,B,C,D,E,F,G,H,I,J,K,1,M,N,O,Q]).
userMove([A,B,C,D,E,F,G,H,I,J,K,L,0,N,O,Q], 13,[A,B,C,D,E,F,G,H,I,J,K,L,1,N,O,Q]).
userMove([A,B,C,D,E,F,G,H,I,J,K,L,M,0,O,Q], 14,[A,B,C,D,E,F,G,H,I,J,K,L,M,1,O,Q]).
userMove([A,B,C,D,E,F,G,H,I,J,K,L,M,N,0,Q], 15,[A,B,C,D,E,F,G,H,I,J,K,L,M,N,1,Q]).
userMove([A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,0], 16,[A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,1]).
userMove(Board, N, Board) :- write('Illegal move.'), nl.


computerMove([0,B,C,D,E,F,G,H,I,J,K,L,M,N,O,Q], 1, [2,B,C,D,E,F,G,H,I,J,K,L,M,N,O,Q]).
computerMove([A,0,C,D,E,F,G,H,I,J,K,L,M,N,O,Q], 2, [A,2,C,D,E,F,G,H,I,J,K,L,M,N,O,Q]).
computerMove([A,B,0,D,E,F,G,H,I,J,K,L,M,N,O,Q], 3, [A,B,2,D,E,F,G,H,I,J,K,L,M,N,O,Q]).
computerMove([A,B,C,0,E,F,G,H,I,J,K,L,M,N,O,Q], 4, [A,B,C,2,E,F,G,H,I,J,K,L,M,N,O,Q]).
computerMove([A,B,C,D,0,F,G,H,I,J,K,L,M,N,O,Q], 5, [A,B,C,D,2,F,G,H,I,J,K,L,M,N,O,Q]).
computerMove([A,B,C,D,E,0,G,H,I,J,K,L,M,N,O,Q], 6, [A,B,C,D,E,2,G,H,I,J,K,L,M,N,O,Q]).
computerMove([A,B,C,D,E,F,0,H,I,J,K,L,M,N,O,Q], 7, [A,B,C,D,E,F,2,H,I,J,K,L,M,N,O,Q]).
computerMove([A,B,C,D,E,F,G,0,I,J,K,L,M,N,O,Q], 8, [A,B,C,D,E,F,G,2,I,J,K,L,M,N,O,Q]).
computerMove([A,B,C,D,E,F,G,H,0,J,K,L,M,N,O,Q], 9, [A,B,C,D,E,F,G,H,2,J,K,L,M,N,O,Q]).
computerMove([A,B,C,D,E,F,G,H,I,0,K,L,M,N,O,Q], 10,[A,B,C,D,E,F,G,H,I,2,K,L,M,N,O,Q]).
computerMove([A,B,C,D,E,F,G,H,I,J,0,L,M,N,O,Q], 11,[A,B,C,D,E,F,G,H,I,J,2,L,M,N,O,Q]).
computerMove([A,B,C,D,E,F,G,H,I,J,K,0,M,N,O,Q], 12,[A,B,C,D,E,F,G,H,I,J,K,2,M,N,O,Q]).
computerMove([A,B,C,D,E,F,G,H,I,J,K,L,0,N,O,Q], 13,[A,B,C,D,E,F,G,H,I,J,K,L,2,N,O,Q]).
computerMove([A,B,C,D,E,F,G,H,I,J,K,L,M,0,O,Q], 14,[A,B,C,D,E,F,G,H,I,J,K,L,M,2,O,Q]).
computerMove([A,B,C,D,E,F,G,H,I,J,K,L,M,N,0,Q], 15,[A,B,C,D,E,F,G,H,I,J,K,L,M,N,2,Q]).
computerMove([A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,0], 16,[A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,2]).


areMovesLeft(Board) :- member(0, Board).

evaluate(Board, 1, 10) :- rowwin(Board, 1),!.
evaluate(Board, 1, -10) :- rowwin(Board, 2),!.
evaluate(Board, 1, 10) :- colwin(Board, 1),!.
evaluate(Board, 1, -10) :- colwin(Board, 2),!.
evaluate(Board, 1, 10) :- diagwin(Board, 1),!.
evaluate(Board, 1, -10) :- diagwin(Board, 2),!.

evaluate(Board, 2, -10) :- rowwin(Board, 1),!.
evaluate(Board, 2, 10) :- rowwin(Board, 2),!.
evaluate(Board, 2, -10) :- colwin(Board, 1),!.
evaluate(Board, 2, 10) :- colwin(Board, 2),!.
evaluate(Board, 2, -10) :- diagwin(Board, 1),!.
evaluate(Board, 2, 10) :- diagwin(Board, 2),!.

evaluate(Board, N, 0).

minimax(Board, P, V) :- evaluate(Board, 2, A), not(A=0), V is A, !.
minimax(Board, P, V) :- not(areMovesLeft(Board)), V is 0, !.

%************************* minimizer move *************************

scanAllEl(Board, 1, 16, Best, Ans) :- Ans is Best, !.
minimax(Board, 1, V) :-  Best is 1000,
scanAllEl(Board, 1, 0, Best, Ans),
V is Ans,!.

scanAllEl(Board, 1, I, Best, Ans) :- nth0(I, Board, El),
El=0,
I2 is I+1,
userMove(Board, I2, Newboard),
minimax(Newboard, 2, V),
NewBest is min(Best, V),
scanAllEl(Board, 1, I2, NewBest, Ans).
scanAllEl(Board, 1, I, Best, Ans) :- nth0(I, Board, El),
not(El=0),
NI is I+1,
scanAllEl(Board, 1, NI, Best, Ans).

% *************************maximizer move *****************************
scanAllEl(Board, 2, 16, Best, Ans) :- Ans is Best,!.
minimax(Board, 2, V) :-  Best is -1000, scanAllEl(Board, 2, 0, Best, Ans), V is Ans,!.
scanAllEl(Board, 2, I, Best, Ans) :- nth0(I, Board, El),
El=0,
I2 is I+1,
computerMove(Board, I2, Newboard), 
minimax(Newboard, 1, V),
NewBest is max(Best, V), 
scanAllEl(Board, 2, I2, NewBest, Ans).
scanAllEl(Board, 2, I, Best, Ans) :- nth0(I, Board, El),
not(El=0), NI is I+1,
scanAllEl(Board, 2, NI, Best, Ans).