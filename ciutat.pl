% MARC NAVARRO AMENGUAL & JOAN MATEU SOCIAS PALMER

% exemples d'execució:

    % 2x2 ciutats([2,1], [1,2], [2,1], [1,2]).
    % 4x4 ciutats([2,2,1,3], [3,1,3,2], [3,1,2,2], [2,3,1,2]).
    % 5x5 ciutats([2,2,2,2,1],[4,3,2,1,5],[5,1,2,3,4],[1,2,2,2,2]).

ciutats(C1,C2,F1,F2):-
    length(F1,N1),
    length(C1,N2),
    max(N1,N2,N3),
    mirarFiles(C1,C2,N2,N3,L1),
    transposar(N1,0,N1,L1,L2),
    mirarFiles(F1,F2,N1,N3,L2),   
    %invertir(L1,SOL),
    escriureSolucio(L1).    


%fucio que ens permet escriure la solucio per pantalla
escriureSolucio([]).
escriureSolucio([X | L]):-
    write(X),nl,
    escriureSolucio(L).


% funcio que mira els elements candidats que podiren anar a les files, fent us de permuta
mirarFiles(_,_,0,_,[]).
mirarFiles([X | C1],[Y | C2],NFILA,VALORMAX,[AUX | L3]) :-     
    generar_llista(VALORMAX, LLISTA),
    permuta(LLISTA, AUX),
    comprovarPermutacions(X,Y,AUX),    
    CONT is NFILA-1,
    mirarFiles(C1,C2,CONT,VALORMAX,L3).


% funcio permuta 
permuta([],[]).
permuta([X|Y],Z) :- permuta(Y,L),
insereix(X,L,Z).
insereix(E,L,[E|L]).
insereix(E,[X|Y],[X|Z]) :- insereix(E,Y,Z).


% funcio que mos retorna quins des dos elements donats es el mes gran
max(A,B,C):- C = A, A>B.
max(_,B,C):- C = B.


% funcio que ens permet generar llistes de N elements
generar_llista(0, []).
generar_llista(N, [N|T]) :-
    N > 0,
    N1 is N - 1,
    generar_llista(N1, T).   


% funcio que ens permet comprovar si les permutacions compleixen amb les condicions de vista
comprovarPermutacions(X,Y,L1) :-   
    comprovarVisio(0,L1,V1), V1 =:= X,    
    invertir(L1, L2),
    comprovarVisio(0,L2,V2), V2 =:= Y.


% funcio que ens permet invertir una llista
invertir([X],[X]).
invertir([X|L1],L2) :- 
    invertir(L1,L3),
    append(L3,[X],L2).


% funcio que ens permet veure quants edificis es poden veure desde una part de la llista
comprovarVisio(_, [], 0).
comprovarVisio(MAX, [X | L], S) :-
    MAX > X, 
    comprovarVisio(MAX, L, S).
comprovarVisio(MAX, [X | L], S) :-
    X > MAX,
    comprovarVisio(X, L, S1),
    S is S1 + 1.


%funcio que realitza la transposada duna matriu
transposar(_,_,0,_,[]).
transposar(MAX,POSICIO,N,L,[AUX | L3]):- 
    N1 is N-1,
    N2 is 1+POSICIO,
    generarColumna(L,N2,MAX,AUX),
    transposar(MAX,N2,N1,L,L3).


% funcio que ens permet generar una columna de la matriu
generarColumna(_,_,0,[]).
generarColumna([X | L],POSICIO,N,[E | L1]):-
    N1 is N-1,
    element_a(X,POSICIO,E),
    generarColumna(L,POSICIO,N1,L1).
    

% funcio que ens permet obtenir un element duna llista donada una posicio
element_a([E|_], 1, E).
element_a([_|C], POSICIO, E) :-
    POSICIO > 1,
    CONT is POSICIO - 1,
    element_a(C, CONT, E).