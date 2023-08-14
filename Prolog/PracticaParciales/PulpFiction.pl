personaje(pumkin,     ladron([licorerias, estacionesDeServicio])).
personaje(honeyBunny, ladron([licorerias, estacionesDeServicio])).
personaje(vincent,    mafioso(maton)).
personaje(jules,      mafioso(maton)).
personaje(marsellus,  mafioso(capo)).
personaje(winston,    mafioso(resuelveProblemas)).
personaje(mia,        actriz([foxForceFive])).
personaje(butch,      boxeador).

pareja(marsellus, mia).
pareja(pumkin,    honeyBunny).

%trabajaPara(Empleador, Empleado)
trabajaPara(marsellus, vincent).
trabajaPara(marsellus, jules).
trabajaPara(marsellus, winston).

%1

esPeligroso(Personaje):-
    personaje(Personaje,_),
    realizaActividadPeligrosa(Personaje),
    tieneEmpleadosPeligrosos(Personaje).

realizaActividadPeligrosa(Personaje):-
    personaje(Personaje,mafioso(maton)).

realizaActividadPeligrosa(Personaje):-
    personaje(Personaje,ladron(Lugares)),
    member(licorerias,Lugares).

tieneEmpleadosPeligrosos(Personaje):-
    trabajaPara(Personaje,Empleado),
    realizaActividadPeligrosa(Empleado).

%2
amigo(vincent, jules).
amigo(jules, jimmie).
amigo(vincent, elVendedor).

duoTemible(Personaje,OtroPersonaje):-
    esPeligroso(Personaje),
    esPeligroso(OtroPersonaje),
    Persona \= OtroPersonaje,
    sonParejaOAmigos(Personaje,OtroPersonaje).

sonParejaOAmigos(Personaje,OtroPersonaje):-
    sonAmigos(Personaje,OtroPersonaje).

sonParejaOAmigos(Personaje,OtroPersonaje):-
    sonPareja(Personaje,OtroPersonaje).

sonAmigos(Personaje,OtroPersonaje):-
    amigo(Personaje,OtroPersonaje).

sonAmigos(Personaje,OtroPersonaje):-
    amigo(OtroPersonaje,Personaje).

sonPareja(Personaje,OtroPersonaje):-
    pareja(Personaje,OtroPersonaje).

sonPareja(Personaje,OtroPersonaje):-
    pareja(OtroPersonaje,Personaje).

%3

%encargo(Solicitante, Encargado, Tarea). 
%las tareas pueden ser cuidar(Protegido), ayudar(Ayudado), buscar(Buscado, Lugar)
encargo(marsellus, vincent,   cuidar(mia)).
encargo(vincent,  elVendedor, cuidar(mia)).
encargo(marsellus, winston, ayudar(jules)).
encargo(marsellus, winston, ayudar(vincent)).
encargo(marsellus, vincent, buscar(butch, losAngeles)).
encargo(marsellus, vincent,   cuidar(butch)).

estaEnProblemas(butch).

estaEnProblemas(Personaje):-
    jefePeligrosoYMandon(Personaje).

estaEnProblemas(Personaje):-
    personaje(Personaje,_),
    buscarUnBoxeador(Personaje).

jefePeligrosoYMandon(Personaje):-
    trabajaPara(Jefe,Personaje),
    esPeligroso(Jefe),
    sonPareja(Jefe,Pareja),
    encargo(Jefe,Personaje,cuidar(Pareja)).

buscarUnBoxeador(Personaje):-
    encargo(_,Personaje,buscar(Boxeador,_)).

%4
sanCayetano(Personaje):-
    loTieneCerca(Personaje,_),
    forall(loTieneCerca(Personaje,OtroPersonaje),encargo(Personaje,OtroPersonaje,_)).

loTieneCerca(Personaje,OtroPersonaje):-
    amigo(Personaje,OtroPersonaje).

loTieneCerca(Personaje,OtroPersonaje):-
    trabajaPara(Personaje,OtroPersonaje).

%5

masAtareado(Personaje):-
    cantidadDeEncargos(Personaje,MayorCantidad),
    forall(cantidadDeEncargos(_,Cantidad), MayorCantidad >= Cantidad).

cantidadDeEncargos(Personaje,Cantidad):-
    encargo(_,Personaje,_),
    findall(Encargo,encargo(_,Personaje,Encargo),Encargos),
    length(Encargos,Cantidad).

%6

personajesRespetables(PersonajesRespetables):-
    findall(Personaje,esRespetable(Personaje),PersonajesRespetables).

esRespetable(Personaje):-
    nivelDeRespeto(Personaje,Nivel),
    Nivel > 9.

nivelDeRespeto(Personaje,Nivel):-
    personaje(Personaje,actriz(ListaDePelis)),
    length(ListaDePelis,Cantidad),
    Nivel is Cantidad / 10.

nivelDeRespeto(Personaje,Nivel):-
    personaje(Personaje,mafioso(TipoDeMafioso)),
    nivelSegunTipoDeMafioso(TipoDeMafioso,Nivel).

nivelSegunTipoDeMafioso(resuelveProblemas,10).
nivelSegunTipoDeMafioso(maton,1).
nivelSegunTipoDeMafioso(capo,20).

%7

%8
caracteristicas(vincent,  [negro, muchoPelo, tieneCabeza]).
caracteristicas(jules,    [tieneCabeza, muchoPelo]).
caracteristicas(marvin,   [negro,tieneCabeza,muchoPelo]).

duoDiferenciable(Personaje, OtroPersonaje) :-
    sonParejaOAmigos(Personaje, OtroPersonaje),
    caracteristicaDePersonajeDiferente(Personaje, OtroPersonaje).

caracteristicaDePersonajeDiferente(Personaje, OtroPersonaje) :-
    caracteristicaDeUnPersonaje(OtroPersonaje, Caracteristica),
    not(caracteristicaDeUnPersonaje(Personaje, Caracteristica)),
    Personaje \= OtroPersonaje.

caracteristicaDePersonajeDiferente(Personaje, OtroPersonaje) :-
    caracteristicaDeUnPersonaje(Personaje, Caracteristica),
    not(caracteristicaDeUnPersonaje(OtroPersonaje, Caracteristica)),
    Personaje \= OtroPersonaje.

caracteristicaDeUnPersonaje(Personaje, Caracteristica) :-
    caracteristicas(Personaje, Caracteristicas),
    member(Caracteristica, Caracteristicas).