%candidato
%Punto


candidato(frank, 50, rojo).
candidato(claire, 52, rojo).
candidato(catherine, 59, rojo).

candidato(garrett, 64, azul).
candidato(linda, 30, azul).
/*No contamos al candidato Peter, ya que desconocemos el partido al que pertenece, y por el principio de universo cerrado, 
asumimos como falso todo lo relacionado a el (no podemos asumir un partido). En conclusion, no lo agregamos a la base de conocimientos
*/

candidato(jackie, 38, amarillo).
candidato(heather, 54 , amarillo). % No sabemos en principio la edad de Heather pero si cuando nacio. Asumimos que su edad es 2023 - 1969 = 54 años


/*No contamos al candidato Seth, ya que desconocemos su edad, y por el principio de universo cerrado, 
asumimos como falso todo lo relacionado a el (no podemos asumir una edad). En conclusion, no lo agregamos a la base de conocimientos
*/

%partido

partidosPorProvincia(buenosAires, azul).
partidosPorProvincia(buenosAires, rojo).
partidosPorProvincia(buenosAires, amarillo).

partidosPorProvincia(chaco, azul).
partidosPorProvincia(chaco, amarillo).

partidosPorProvincia(tierraDelFuego, azul).
partidosPorProvincia(tierraDelFuego, rojo).

partidosPorProvincia(sanLuis, azul).
partidosPorProvincia(sanLuis, rojo).

partidosPorProvincia(neuquen, azul).

partidosPorProvincia(santaFe, rojo).

partidosPorProvincia(cordoba, rojo).

partidosPorProvincia(chubut, rojo).

partidosPorProvincia(formosa, amarillo).

/*No contamos a formosa en el partido rojo, ya que no se va a presentar en esa provincia.
Por el principio de universo cerrado, asumimos como falso todo lo relacionado a esta situacion, por ende no lo agregamos a la base de conocimientos*/

partidosPorProvincia(tucuman, amarillo).

partidosPorProvincia(salta, amarillo).

partidosPorProvincia(santaCruz, amarillo).

partidosPorProvincia(laPampa, amarillo).

partidosPorProvincia(corrientes, amarillo).

partidosPorProvincia(misiones, amarillo).

/*No contamos al partido violeta, ya que no tiene candidatos, y por el principio de universo cerrado, 
asumimos como falso todo lo relacionado a el (no podemos hacer consultas sin la informacion faltante). En conclusion, no lo agregamos a la base de conocimientos
*/

%provincia

provincia(buenosAires,15355000).
provincia(chaco,1143201).
provincia(tierraDelFuego,160720).
provincia(sanLuis,489255).
provincia(neuquen,637913).
provincia(santaFe,3397532).
provincia(cordoba,3567654).
provincia(chubut,577466).
provincia(formosa,527895).
provincia(tucuman,1687305).
provincia(salta,1333365).
provincia(santaCruz,273964).
provincia(laPampa,349299).
provincia(corrientes,992595).
provincia(misiones,1189446).

%PUNTO 2 

esPicante(Provincia):-
   provincia(Provincia, CantDeHabitantes),
   partidosPorProvincia(Provincia, UnPartido),
   partidosPorProvincia(Provincia, OtroPartido),
   CantDeHabitantes > 1000000,
   UnPartido \= OtroPartido.


%PUNTO3

intencionDeVotoEn(buenosAires, rojo, 40).
intencionDeVotoEn(buenosAires, azul, 30).
intencionDeVotoEn(buenosAires, amarillo, 30).
intencionDeVotoEn(chaco, rojo, 50).
intencionDeVotoEn(chaco, azul, 20).
intencionDeVotoEn(chaco, amarillo, 0).
intencionDeVotoEn(tierraDelFuego, rojo, 40).
intencionDeVotoEn(tierraDelFuego, azul, 20).
intencionDeVotoEn(tierraDelFuego, amarillo, 10).
intencionDeVotoEn(sanLuis, rojo, 50).
intencionDeVotoEn(sanLuis, azul, 20).
intencionDeVotoEn(sanLuis, amarillo, 0).
intencionDeVotoEn(neuquen, rojo, 80).
intencionDeVotoEn(neuquen, azul, 10).
intencionDeVotoEn(neuquen, amarillo, 0).
intencionDeVotoEn(santaFe, rojo, 20).
intencionDeVotoEn(santaFe, azul, 40).
intencionDeVotoEn(santaFe, amarillo, 40).
intencionDeVotoEn(cordoba, rojo, 10).
intencionDeVotoEn(cordoba, azul, 60).
intencionDeVotoEn(cordoba, amarillo, 20).
intencionDeVotoEn(chubut, rojo, 15).
intencionDeVotoEn(chubut, azul, 15).
intencionDeVotoEn(chubut, amarillo, 15).
intencionDeVotoEn(formosa, rojo, 0).
intencionDeVotoEn(formosa, azul, 0).
intencionDeVotoEn(formosa, amarillo, 0).
intencionDeVotoEn(tucuman, rojo, 40).
intencionDeVotoEn(tucuman, azul, 40).
intencionDeVotoEn(tucuman, amarillo, 20).
intencionDeVotoEn(salta, rojo, 30).
intencionDeVotoEn(salta, azul, 60).
intencionDeVotoEn(salta, amarillo, 10).
intencionDeVotoEn(santaCruz, rojo, 10).
intencionDeVotoEn(santaCruz, azul, 20).
intencionDeVotoEn(santaCruz, amarillo, 30).
intencionDeVotoEn(laPampa, rojo, 25).
intencionDeVotoEn(laPampa, azul, 25).
intencionDeVotoEn(laPampa, amarillo, 40).
intencionDeVotoEn(corrientes, rojo, 30).
intencionDeVotoEn(corrientes, azul, 30).
intencionDeVotoEn(corrientes, amarillo, 10).
intencionDeVotoEn(misiones, rojo, 90).
intencionDeVotoEn(misiones, azul, 0).
intencionDeVotoEn(misiones, amarillo, 0).

elCandidatoCompiteEnLaProvincia(UnCandidato, Provincia):-
   candidato(UnCandidato,_,PartidoDeUnCandidato),
   partidosPorProvincia(Provincia, PartidoDeUnCandidato).

ambosCandidatosEnLaProvincia(UnCandidato, OtroCandidato, Provincia):-
   elCandidatoCompiteEnLaProvincia(UnCandidato, Provincia),
   elCandidatoCompiteEnLaProvincia(OtroCandidato, Provincia).

pertenecenAlMismoPartido(UnCandidato, OtroCandidato):-
   candidato(UnCandidato,_,PartidoDeUnCandidato),
   candidato(OtroCandidato,_,PartidoDeOtroCandidato),
   PartidoDeOtroCandidato == PartidoDeUnCandidato.

estaSoloElPrimerCandidato(UnCandidato, OtroCandidato, Provincia):-
   elCandidatoCompiteEnLaProvincia(UnCandidato, Provincia),
   candidato(OtroCandidato,_,_),
   not(elCandidatoCompiteEnLaProvincia(OtroCandidato, Provincia)).

sacaMasVotosEn(Provincia, UnCandidato, OtroCandidato):-
   candidato(UnCandidato,_,PartidoDeUnCandidato),
   candidato(OtroCandidato,_,PartidoDeOtroCandidato),
   intencionDeVotoEn(Provincia, PartidoDeUnCandidato, PorcentajeGanador),
   intencionDeVotoEn(Provincia, PartidoDeOtroCandidato, PorcentajePerdedor),
   PorcentajeGanador > PorcentajePerdedor.


leGanaA(UnCandidato, OtroCandidato, Provincia):-%SiEstoSeCumpleSeRespondeTrueDeUna
   estaSoloElPrimerCandidato(UnCandidato, OtroCandidato, Provincia).

leGanaA(UnCandidato, OtroCandidato, Provincia):-
   ambosCandidatosEnLaProvincia(UnCandidato, OtroCandidato, Provincia),
   pertenecenAlMismoPartido(UnCandidato, OtroCandidato).%alPertenecerAlMismoPartidoGanaUnCandidato
   
leGanaA(UnCandidato, OtroCandidato, Provincia):-
   ambosCandidatosEnLaProvincia(UnCandidato, OtroCandidato, Provincia),
   sacaMasVotosEn(Provincia, UnCandidato, OtroCandidato).


%PUNTO4
 
%esMasJoven(UnCandidato,OtroCandidato):-
%   UnCandidato == OtroCandidato.

esMasJoven(UnCandidato,OtroCandidato):-
   candidato(UnCandidato,UnaEdad,_),
   candidato(OtroCandidato,OtraEdad,_),
   UnaEdad =< OtraEdad.

esElMasJovenDeSuPartido(UnCandidato):-
   candidato(UnCandidato,_,PartidoDeUnCandidato),
   forall(candidato(OtroCandidato,_,PartidoDeUnCandidato),esMasJoven(UnCandidato,OtroCandidato)).

ganaDondeSeaQueCompita(UnCandidato):-
   forall(ambosCandidatosEnLaProvincia(UnCandidato, OtroCandidato, Provincia),leGanaA(UnCandidato, OtroCandidato, Provincia)).

elGranCandidato(UnCandidato):-
   esElMasJovenDeSuPartido(UnCandidato),
   ganaDondeSeaQueCompita(UnCandidato).

%Punto5
porcentajeMayorA(Partido, _, _, OtroPartido):-
   Partido == OtroPartido.

porcentajeMayorA(Partido, Provincia, Porcentaje, _):-
   intencionDeVotoEn(Provincia, Partido, PorcentajeDelPartido),
   PorcentajeDelPartido > Porcentaje.

ganaEnProvincia(Provincia, Partido):-
   forall(intencionDeVotoEn(Provincia, OtroPartido, Porcentaje),porcentajeMayorA(Partido, Provincia, Porcentaje, OtroPartido)).

ajusteConsultora(Partido,Provincia,VerdaderoPorcentajeDeVotos):-
   ganaEnProvincia(Provincia, Partido),
   intencionDeVotoEn(Provincia, Partido, PorcentajeErroneo),
   VerdaderoPorcentajeDeVotos is PorcentajeErroneo - 20.

ajusteConsultora(Partido,Provincia,VerdaderoPorcentajeDeVotos):-
   not(ganaEnProvincia(Provincia, Partido)),
   intencionDeVotoEn(Provincia, Partido, PorcentajeErroneo),
   VerdaderoPorcentajeDeVotos is PorcentajeErroneo + 5.

/* En nuestro caso, nosotros desarrollamos otro predicado aprovechando que ya tenemos intencionDeVotoEn y ajusteConsultora.
No tuvimos que modificar ningun predicado ni tampoco realizar ningun cambio. El predicado que desarrollamos : */
intencionDeVotoReal(Provincia, Partido, PorcentajeEstimado , PorcentajeReal):-
   intencionDeVotoEn(Provincia,Partido,PorcentajeEstimado),
   ajusteConsultora(Partido,Provincia,PorcentajeReal).

% Punto 6
% inflacion(cotaInferior, cotaSuperior)
% construir(listaDeObras)
% nuevosPuestosDeTrabajo(cantidad)
% edilicio(EdilicioAConstruir, CantidadAConstruir)

% promete(Partido, Promesa)
promete(azul, construir(
   [edilicio(hospital, 1000),
   edilicio(jardin, 100),
   edilicio(escuela, 5)])).
promete(azul, inflacion(2, 4)).

promete(amarillo, construir(
   [edilicio(hospital, 100),
   edilicio(universidad, 1),
   edilicio(comisaria, 200)])).
promete(amarillo, nuevosPuestosDeTrabajo(10000)).
promete(amarillo, inflacion(1, 15)).

promete(rojo, nuevosPuestosDeTrabajo(800000)).
promete(rojo, inflacion(10, 30)).

% Punto 7
% influenciaDePromesas(Promesa, IntencionDeVotos)

influenciaDePromesas(Promesa, IntencionDeVotosTotales) :-
   votosSegun(Promesa, _),
   findall(IntencionDeVotos, votosSegun(Promesa, IntencionDeVotos), Intenciones),
   sum_list(Intenciones, IntencionDeVotosTotales).

votosSegun(inflacion(CotaInferior, CotaSuperior), IntencionDeVotos) :-
   IntencionDeVotos is - (CotaInferior + CotaSuperior) / 2.

votosSegun(nuevosPuestosDeTrabajo(Cantidad), 3) :-
   Cantidad > 50000.

votosSegun(construir(ListaDeObras), 2) :-
   member(edilicio(hospital, _), ListaDeObras).

votosSegun(construir(ListaDeObras), IntencionDeVotos) :-
   member(edilicio(jardin, Cantidad), ListaDeObras),
   IntencionDeVotos is 0.1 * Cantidad.

votosSegun(construir(ListaDeObras), IntencionDeVotos) :-
   member(edilicio(escuela, Cantidad), ListaDeObras),
   IntencionDeVotos is 0.1 * Cantidad.

votosSegun(construir(ListaDeObras), 2) :-
   member(edilicio(comisaria, 200), ListaDeObras).

votosSegun(construir(ListaDeObras), (-1)) :-
      not(member(edilicio(EdilicioAConstruir, _), ListaDeObras)),
      EdilicioAConstruir \= universidad.

% Punto 8
% promedioDeCrecimiento(Partido, Crecimiento)
promedioDeCrecimiento(Partido, CrecimientoTotal) :-
   promete(Partido, _),
   findall(VotosPorPartido, cantidadDeVotosSegun(Partido, VotosPorPartido), ListaDeVotosPorPartidoRepetidos),
   list_to_set(ListaDeVotosPorPartidoRepetidos, ListaDeVotosPorPartido),
   sum_list(ListaDeVotosPorPartido, CrecimientoTotal).

cantidadDeVotosSegun(Partido, IntencionDeVotos) :-
   promete(Partido, Promesa),
   influenciaDePromesas(Promesa, IntencionDeVotos).