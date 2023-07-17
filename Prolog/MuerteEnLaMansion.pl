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
odia(tiaAgatha , tiaAgatha).
odia(charles   , mayordomo).
odia(mayordomo , charles).
odia(mayordomo , tiaAgatha).

masRicoQue(mayordomo , tiaAgatha).

/*
 1a
   Consulta utilizada: ?- mata(Persona,tiaAgatha).
 1b
   Respuesta: Persona = charles.

 2
   ?- odia(Persona,milhouse).
       false.

   ?- odia(charles,Quien).
   Quien = mayordomo ;
   Quien = tiaAgatha.

   ?- odia(Quien,tiaAgatha).
    Quien = charles.

   ?- odia(Odiador,Odiado).
   Odiador = tiaAgatha,
   Odiado = charles ;
   Odiador = charles,
   Odiado = mayordomo ;
   Odiador = charles,
   Odiado = tiaAgatha ;
   Odiador = mayordomo,
   Odiado = charles.

   ?- odia(mayordomo,_).
       true.
*/