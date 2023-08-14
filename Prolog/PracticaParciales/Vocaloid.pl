%vocaloid(Nombre,Cancion).
%vocaloid(Nombre,cancion(Nombre,Duracion)).

vocaloid(megurineLuka,cancion(nightFever,4)).
vocaloid(megurineLuka,cancion(foreverYoung,5)).
vocaloid(hatsuneMiku,cancion(tellYourWorld,4)).
vocaloid(gumi,cancion(foreverYoung,4)).
vocaloid(gumi,cancion(tellYourWorld,5)).
vocaloid(seeU,cancion(novemberRain,6)).
vocaloid(seeU,cancion(nightFever,5)).


%1

esCantante(UnaPersona):-
    vocaloid(UnaPersona,_).

esNovedoso(Cantante):-
    esCantante(Cantante),
    sabeAlMenosDosCanciones(Cantante),
    cantaMenosDe(Cantante,15).

sabeAlMenosDosCanciones(Cantante):-
    vocaloid(Cantante,UnaCancion),
    vocaloid(Cantante,OtraCancion),
    UnaCancion \= OtraCancion.

cantaMenosDe(Cantante,Tiempo):-
    sumaDuracionDeCanciones(Cantante,DuracionTotal),
    DuracionTotal < Tiempo.

sumaDuracionDeCanciones(Cantante,DuracionTotal):-
    findall(Duracion,vocaloid(Cantante,cancion(_,Duracion)),Duraciones),
    sum_list(Duraciones, DuracionTotal).


%2

esAcelerado(Cantante):-
    esCantante(Cantante),
    not(algunaDeSusCancionesDuraMasDe(Cantante,4)).

algunaDeSusCancionesDuraMasDe(Cantante,TiempoADurar):-
    (vocaloid(Cantante,cancion(_,Tiempo)), Tiempo > TiempoADurar).


% ------------------------------------------------------------------------------------------

concierto(mikuExpo,eeuu,2000,gigante(2,6)).
concierto(magicalMirai,japon,3000,gigante(3,10)).
concierto(vocalektVisions,eeuu,1000,mediano(9)).
concierto(mikuFest,argentina,100,pequenio(4)).

puedeParticiparEn(Concierto,Cantante):-
    esCantante(Cantante),
    concierto(Concierto,_,_,TipoDeConcierto),
    cumpleLosRequisitos(Cantante,TipoDeConcierto).

esConcierto(Concierto):-
    concierto(Concierto,_,_,_). 

puedeParticiparEn(Concierto,hatsuneMiku):-
    esConcierto(Concierto).

cumpleLosRequisitos(Cantante,gigante(CantMinimaCanciones,CantidadDada)):-
    cantidadDeCanciones(Cantante,Cantidad),
    Cantidad >= CantMinimaCanciones,
    tiempoTotalDeCanciones(Cantante,TiempoTotal),
    TiempoTotal > CantidadDada.

cantidadDeCanciones(Cantante,Cantidad):-
    findall(Cancion,vocaloid(Cantante,Cancion),Canciones),
    length(Canciones,Cantidad).

tiempoTotalDeCanciones(Cantante,TiempoTotal):-
    sumaDuracionDeCanciones(Cantante,TiempoTotal).

cumpleLosRequisitos(Cantante,mediano(CantidadDada)):-
    tiempoTotalDeCanciones(Cantante,TiempoTotal),
    TiempoTotal < CantidadDada.

cumpleLosRequisitos(Cantante,pequenio(CantidadDada)):-
    algunaDeSusCancionesDuraMasDe(Cantante,CantidadDada).

% 3 -----------------------------------------------------------

esElMasFamoso(Cantante):-
    nivelDeFama(Cantante,NivelMasGrande),
    forall(nivelDeFama(_,Nivel), NivelMasGrande >= Nivel).
    
nivelDeFama(Cantante,Nivel):-
    esCantante(Cantante),
    findall(Fama,puedeParticiparEn(concierto(_,_,Famas,_),Cantante),Famas),
    sum_list(Famas,FamaTotal),
    cantidadDeCanciones(Cantante,Cantidad),
    Nivel is FamaTotal * Cantidad.

/*
famaConcierto(Cantante, Fama):-
    puedeParticiparEn(Concierto,Cantante),
    fama(Concierto, Fama).

fama(Concierto,Fama):- 
    concierto(Concierto,_,Fama,_).
        
 */

% 4 -------------------------

conoce(megurineLuka,hatsuneMiku).
conoce(megurineLuka,gumi).
conoce(gumi,seeU).
conoce(seeU,kaito).