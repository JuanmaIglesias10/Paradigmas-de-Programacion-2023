% festival(NombreDelFestival, Bandas, Lugar).
% Relaciona el nombre de un festival con la lista de los nombres de bandas que tocan en él y el lugar dónde se realiza.
festival(lollapalooza, [gunsAndRoses, theStrokes, littoNebbia], hipodromoSanIsidro).
festival(lalalal, [callejeros], lujan).

% lugar(nombre, capacidad, precioBase).
% Relaciona un lugar con su capacidad y el precio base que se cobran las entradas ahí.
lugar(hipodromoSanIsidro, 85000, 3000).

% banda(nombre, nacionalidad, popularidad).
% Relaciona una banda con su nacionalidad y su popularidad.
banda(gunsAndRoses, eeuu, 69420).
banda(callejeros,argentina,50000).

% entradaVendida(NombreDelFestival, TipoDeEntrada).
% Indica la venta de una entrada de cierto tipo para el festival 
% indicado.
% Los tipos de entrada pueden ser alguno de los siguientes: 
%     - campo
%     - plateaNumerada(Fila)
%     - plateaGeneral(Zona).
entradaVendida(lollapalooza, campo).
entradaVendida(lollapalooza, plateaNumerada(1)).
entradaVendida(lollapalooza, plateaGeneral(zona2)).

entradaVendida(lalalal,campo).

% plusZona(Lugar, Zona, Recargo)
% Relacion una zona de un lugar con el recargo que le aplica al precio de las plateas generales.
plusZona(hipodromoSanIsidro, zona1, 1500).

%1 Se cumple para los festivales que ocurren en más de un lugar, pero con el mismo nombre y las mismas bandas en el mismo orden.

itinerante(Festival):-
    festival(Festival,Bandas,UnLugar),
    festival(Festival,Bandas,OtroLugar),
    UnLugar \= OtroLugar.

% careta/1: Decimos que un festival es careta si no tiene campo o si es el personalFest.

careta(personalFest).
    
careta(Festival):-
    festival(Festival,_,_),
    not(entradaVendida(Festival,campo)).

% nacAndPop/1: Un festival es nac&pop si no es careta y 
% todas las bandas que tocan en él son de nacionalidad argentina y tienen popularidad mayor a 1000.

nacAndPop(Festival):-
    festival(Festival,Bandas,_),
    forall(member(Banda,Bandas),(banda(Banda,argentina,Popularidad),Popularidad > 1000)),
    not(careta(Festival)).

%sobrevendido/1: Se cumple para los festivales que vendieron más entradas que la capacidad del lugar donde se realizan.

sobrevendido(Festival):-
    festival(Festival,_,Lugar),
    lugar(Lugar,Capacidad,_),
    findall(Entrada,entradaVendida(Festival,Entrada),Entradas),
    length(Entradas,EntradasVendidasTotales),
    EntradasVendidasTotales > Capacidad.


