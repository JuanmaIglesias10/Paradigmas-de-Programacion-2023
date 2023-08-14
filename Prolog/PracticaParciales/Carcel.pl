% guardia(Nombre)
guardia(bennett).
guardia(mendez).
guardia(george).

% prisionero(Nombre, Crimen)
%prisionero(Nombre,narcotrafico[Drogas])
%prisionero(Nombre,homicidio[Victima])
%prisionero(Nombre,robo[Dinero])
prisionero(piper, narcotrafico([metanfetaminas])).
prisionero(alex, narcotrafico([heroina])).
prisionero(alex, homicidio(george)).
prisionero(red, homicidio(rusoMafioso)).
prisionero(suzanne, robo(450000)).
prisionero(suzanne, robo(250000)).
prisionero(suzanne, robo(2500)).
prisionero(dayanara, narcotrafico([heroina, opio])).
prisionero(dayanara, narcotrafico([metanfetaminas])).

%1 Indicar, justificando, si es inversible y, en caso de no serlo,
%  dar ejemplos de las consultas que NO podrían hacerse y corregir la implementación para que se pueda.

% controla(Controlador, Controlado)
controla(piper, alex).
controla(bennett, dayanara).

controla(Guardia, Otro):-
     guardia(Guardia),
     prisionero(Otro,_),              % Ya solucionado el tema de inversibilidad
     not(controla(Otro, Guardia)).

/* Este predicado no es inversible, ya que necesitamos un predicado generador de tipo guardia(Guardia).
no podria hacerse una consulta de tipo controla(Guardia,Otro). Tampoco una consulta del tipo controla(Guardia,alex).
*/

%2

%conflictoDeIntereses/2: relaciona a dos personas distintas (ya sean guardias o prisioneros)
%                        si no se controlan mutuamente y existe algún tercero al cual ambos controlan.

conflictoDeIntereses(UnaPersona,OtraPersona):-
     controla(UnaPersona,Tercero),
     controla(OtraPersona,Tercero),
     not(controla(UnaPersona,OtraPersona)),
     not(controla(OtraPersona,UnaPersona)),
     UnaPersona \= OtraPersona.

%3

peligroso(Preso):-
     prisionero(Preso,_),
     forall(prisionero(Preso,Crimen),esCrimenGrave(Crimen)).

esCrimenGrave(homidicio(_)).

esCrimenGrave(narcotrafico(Drogas)):-
     length(Drogas,NroDeDrogas),
     NroDeDrogas > 4.

esCrimenGrave(narcotrafico(Drogas)):-
     member(metanfetaminas,Drogas).

%4
%Aplica a un prisionero si sólo cometió robos y todos fueron por más de $100.000.

monto(robo(Monto),Monto).

ladronDeGuanteBlanco(Prisionero):-
     prisionero(Prisionero,_),
     forall(prisionero(Prisionero,Crimen),(monto(Crimen,Monto),Monto>100000)).

%5

pena(robo(Monto),Pena):-
     Pena is Monto / 10000.

pena(homicidio(Victima),9):-
     guardia(Victima).

pena(homicidio(Victima),7):-
     not(guardia(Victima)).

pena(narcotrafico(Drogas),Pena):-
     length(Drogas,NroDeDrogas),
     Pena is NroDeDrogas * 2.

condena(Prisionero,Condena):-
     prisionero(Prisionero,_),
     findall(Pena,(prisionero(Prisionero,Crimen), pena(Crimen,Pena)),Penas),
     sum_list(Penas,Condena).

%6

capo(Prisionero):-
     prisionero(Prisionero,_),
     not(controla(_,Prisionero)),
     forall((persona(Persona), Prisionero \= Persona),controlaDirectaOIndirecta(Prisionero,Persona)).

persona(Persona):-
     prisionero(Persona,_).
persona(Persona):-
     guardia(Persona).

controlaDirectaOIndirecta(Prisionero,Persona):-
     controla(Prisionero,Persona).

controlaDirectaOIndirecta(Prisionero,Persona):-
     controla(Prisionero,Tercero),
     controlaDirectaOIndirecta(Tercero,Persona). %Recursividad, no lo van a tomar. 
