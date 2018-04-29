mother(M,C):- parent(M,C), female(M). %check parents of C and bind to M or F, then check gender of M or F.
father(F,C):- parent(F,C), male(F).

spouse(X,Y):- married(X,Y). %check married both directions
spouse(X,Y):- married(Y,X).

child(C,P) :- parent(P,C).  %child if P is parent
son(S,P) :- parent(P,S), male(S). %same as above but check gender of S or P
daughter(D,P) :- parent(P,D), female(D).

sibling(X,Y) :- parent(P,Y), parent(P,X), not(X=Y). %if parents of X and Y are the same and X is not also Y since everyone has themselves as a match here
brother(B,Y) :- sibling(B,Y), male(B).  %same as above but check gender of B or S.
sister(S,Y) :- sibling(S,Y), female(S).

uncle(U,Y) :- parent(P,Y), brother(U,P).  %by blood, bind parent to P, check brother/sister of P
aunt(A,Y) :- parent(P,Y), sister(P,A).
uncle(U,Y) :- parent(P,Y), sibling(P,S), spouse(S,U), male(U).  %by marriage, bind parent to P, check siblings of P, bind to S, check spouse of S, bind to A or U, check gender of A or U.
aunt(A,Y) :- parent(P,Y), sibling(P,S), spouse(S,A), female(A).

cousin(C,Y) :- uncle(U,Y), child(C,U).  %either aunt or uncle would work here, bind uncel to U, check children of U.

grandparent(GP,Y) :- parent(P,Y), parent(GP,P). %bind parent of Y to P, check parent of P, bind to GP.
grandfather(GF,Y) :- grandparent(GF,Y), male(GF). %same as above but check gender of GP.
grandmother(GM,Y) :- grandparent(GM,Y), female(GM).
grandchild(GC,Y) :- grandparent(Y,GC).  %grandchild if Y is grandparent

%lifespan is a helper rule for the older and younger rules
lifespan(X,L) :- born(X,B), died(X,D), L is D-B, !.
lifespan(X,L) :- born(X,B), L is 2018-B.

older(X,Y) :- lifespan(X,L1), lifespan(Y,L2), L1>L2.  %get lifespans of X and Y, bind to L1 or L2, compare L1 and L2, if comparison is true, X is older, otherwise X is younger

younger(X,Y) :- older(Y,X). %X is younger if Y is older.

regentWhenBorn(X,Y) :- born(Y,D1), reigned(X,D2,D3), D2 =< D1, D1 < D3. %get year born of Y, bind to D1, get time X reigned, bind start and end year to D2 and D3, compare D1 to D2 and D3.
                                                                        %if D1 is between D2 and D3, X was regent when Y was born

ancestor(A,Y) :- parent(A,Y).  %ancestors are parents and
ancestor(A,Y) :- parent(P,Y), ancestor(A,P).  %ancestors of parents, (i.e. parents of parents).

descendant(D,Y) :- child(D,Y).  %descendants are children and
descendant(D,Y) :- child(C,Y), descendant(D,C). %descendants of children, (i.e. children of children).
