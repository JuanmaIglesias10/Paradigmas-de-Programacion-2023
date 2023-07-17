% Punto 1

%candidato(nombre,edad,partido).

candidato(frank, 50, partidoRojo).
candidato(claire, 52, partidoRojo).
candidato(catherine, 59, partidoRojo).

candidato(garrett, 64, partidoAzul).
candidato(linda, 30, partidoAzul).
candidato(peter, 26 , partidoAzul). %Supongo que peter es del azul, porque es el unico partido que me queda con dos candidatos.

candidato(jackie, 38, partidoAmarillo).
candidato(seth, _ , partidoAmarillo).
candidato(heather, 54 , partidoAmarillo).

%partido...(provincia donde se presenta).

partidoAzul(buenosAires).
partidoAzul(chaco).
partidoAzul(tierraDelFuego).
partidoAzul(sanLuis).
partidoAzul(neuquen).

partidoRojo(buenosAires).
partidoRojo(santaFe).
partidoRojo(cordoba).
partidoRojo(chubut).
partidoRojo(tierraDelFuego).
partidoRojo(sanLuis).

partidoAmarillo(chaco).
partidoAmarillo(formosa).
partidoAmarillo(tucuman).
partidoAmarillo(salta).
partidoAmarillo(santaCruz).
partidoAmarillo(laPampa).
partidoAmarillo(corrientes).
partidoAmarillo(misiones).
partidoAmarillo(buenosAires).

%provincia(Nombre,Habitantes).

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

alMenosDosPartidos(Provincia):-
    partidoAmarillo(Provincia),
    partidoAzul(Provincia).

alMenosDosPartidos(Provincia):-
    partidoRojo(Provincia),             %Esto asi me hace ruido, pero funciona 
    partidoAzul(Provincia).

alMenosDosPartidos(Provincia):-
    partidoAmarillo(Provincia),
    partidoRojo(Provincia).

esPicante(Provincia):-
    provincia(Provincia,Habitantes),
    Habitantes > 1000000,
    alMenosDosPartidos(Provincia).

%PUNTO 3
