%herramientasRequeridas(TareaDeLimpieza,[Herramientas]).
herramientasRequeridas(ordenarCuarto, [aspiradora(100), trapeador, plumero]).
herramientasRequeridas(limpiarTecho, [escoba, pala]).
herramientasRequeridas(cortarPasto, [bordedadora]).
herramientasRequeridas(limpiarBanio, [sopapa, trapeador]).
herramientasRequeridas(encerarPisos, [lustradpesora, cera, aspiradora(300)]).

%1

tiene(egon,aspiradora(200)).
tiene(egon,trapeador).
tiene(peter,trapeador).
tiene(winston,varitaDeNeutrones).

%2

tieneLoNecesario(Integrante,aspiradora(PotenciaRequerida)):-
    tiene(Integrante,aspiradora(Potencia)),
    Potencia >= PotenciaRequerida.   % Solo inversible respecto al integrante (enunciado especifica que no importa si no lo es a la herramienta).

tieneLoNecesario(Integrante,Herramienta):-
    tiene(Integrante,Herramienta).

%3
esTarea(Tarea):-
    herramientasRequeridas(Tarea,_).

esPersona(Persona):-
    tiene(Persona,_).

puedeHacer(Persona,Tarea):-
    esTarea(Tarea),
    tiene(Persona,varitaDeNeutrones).

puedeHacer(Persona,Tarea):-
    esPersona(Persona),
    esTarea(Tarea),
    forall(herramientaDeTarea(Tarea,Herramienta),tieneLoNecesario(Persona,Herramienta)).

herramientaDeTarea(Tarea,Herramienta):-
    herramientasRequeridas(Tarea,Herramientas),
    member(Herramienta,Herramientas).

%4

%tareaPedida(tarea, cliente, metrosCuadrados).
tareaPedida(ordenarCuarto, dana, 20).
tareaPedida(cortarPasto, walter, 50).
tareaPedida(limpiarTecho, walter, 70).
tareaPedida(limpiarBanio, louis, 15).

%precio(tarea, precioPorMetroCuadrado).
precio(ordenarCuarto, 13).
precio(limpiarTecho, 20).
precio(limpiarBanio, 55).
precio(cortarPasto, 10).
precio(encerarPisos, 7).

cuantoCobrar(Cliente,CantidadACobrar):-
    tareaPedida(_,Cliente,_),
    findall(Precio,precioDeLaTarea(Cliente, _, Precio),Precios),
    sum_list(Precios,CantidadACobrar).

precioDeLaTarea(Cliente,Tarea,Precio):-
    tareaPedida(Cliente,Tarea,MetrosCuadrados),
    precio(Tarea,PrecioXMetroCuadrado),
    Precio is MetrosCuadrados * PrecioXMetroCuadrado.

%5
%pedido([Tarea]).

esTrabajador(Trabajador):-
    tiene(Trabajador,_).

esCliente(Cliente):-
    tareaPedida(Cliente,_,_).

estaDispuestoAAceptar(Trabajador,Cliente):-
    esTrabajador(Trabajador),
    esCliente(Cliente),
    puedeHacerPedido(Trabajador,Cliente),
    aceptaPedido(Cliente,Trabajador).

aceptaPedido(Cliente,ray):-
    not(tareaPedida(limpiarTecho,Cliente,_)).

aceptaPedido(Cliente,winston):-
    cuantoCobrar(Cliente,CantidadACobrar),
    CantidadACobrar >= 500.

aceptaPedido(Cliente,egon):-
    forall(tareaPedida(Tarea,Cliente,_),not(tareaCompleja(Tarea))).
    
aceptaPedido(_,peter).

puedeHacerPedido(Trabajador,Cliente):-
    forall(tareaPedida(Cliente,Tarea,_),puedeHacer(Trabajador,Tarea)).

tareaCompleja(Tarea):-
    herramientasRequeridas(Tarea,Herramientas),
    length(Herramientas,CantHerramientas),
    CantHerramientas > 2.

tareaCompleja(limpiarTecho).

%6
