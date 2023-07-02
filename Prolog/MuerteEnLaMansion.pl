%Base De Conocimientos

mata(Persona , tiaAgatha):-
    vive(Persona , mansionDreadbury),
    odia(Persona , tiaAgatha),
    not( masRicoQue(Persona , tiaAgatha)).

persona(tiaAgatha).
persona(charles).
persona(mayordomo).

vive(tiaAgatha , mansionDreadbury).
vive(mayordomo , mansionDreadbury).
vive(charles   , mansionDreadbury).

odia(tiaAgatha , charles).
odia(charles   , mayordomo).
odia(charles   , tiaAgatha).
odia(mayordomo , charles).

masRicoQue(mayordomo , tiaAgatha).


%  1a
% Consulta utilizada: 