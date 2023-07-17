% BASE DE CONOCIMIENTOS

%escribio(AutorOAutora, Obra) -> hecho (hay 24 claúsulas)
escribio(elsaBornemann, socorro).
escribio(neilGaiman, sandman).
escribio(alanMoore, watchmen).
escribio(brianAzarello, cienBalas).
escribio(warrenEllis, planetary).
escribio(frankMiller, elCaballeroOscuroRegresa).
escribio(frankMiller, batmanAnioUno).
escribio(neilGaiman, americanGods).
escribio(neilGaiman, buenosPresagios).
escribio(terryPratchett, buenosPresagios).
escribio(isaacAsimov, fundacion).
escribio(isaacAsimov, yoRobot).
escribio(isaacAsimov, elFinDeLaEternidad).
escribio(isaacAsimov, laBusquedaDeLosElementos).
escribio(joseHernandez, martinFierro).
escribio(stephenKing, it).
escribio(stephenKing, misery).
escribio(stephenKing, carrie).
escribio(stephenKing, elJuegoDeGerald).
escribio(julioCortazar, rayuela).
escribio(jorgeLuisBorges, ficciones).
escribio(jorgeLuisBorges, elAleph).
escribio(horacioQuiroga, cuentosDeLaSelva).
escribio(horacioQuiroga, cuentosDeLocuraAmorYMuerte).

% Agregamos qué obras son cómics.

esComic(sandman).
esComic(cienBalas).
esComic(watchmen).
esComic(planetary).
esComic(elCaballeroOscuroRegresa).
esComic(batmanAnioUno).

% Queremos saber si alguien es artista del noveno arte (comics).
% Lo resolvemos por comprensión.
% esArtistaDelNovenoArte/1 predicado con dos claúsulas (una regla y un hecho).

% p ^ q => r -> en discreta
% r <= p ^ q -> en lógico

esArtistaDelNovenoArte(Artista) :- % regla
    escribio(Artista, Obra),
    esComic(Obra).

% En lógico no asignamos. Sí ligamos o unificamos, por eso no hace falta decir que la "Obra" es la misma.

% Y si también queremos aclarar que Art Spiegelman es un artista del noveno arte, hacemos:

esArtistaDelNovenoArte(artSpiegelman). % hecho

% Un artista es reincidente si escribió al menos 2 obras.

esReincidente(Artista) :-
    escribio(Artista, UnaObra),
    escribio(Artista, OtraObra),
    UnaObra \=  OtraObra.

% Una obra es un libro cuando NO es un comic.
% not no es inversible!! No puede ligar las variables dentro de su predicado.
% Si a esLibro no le agregamos el generador, no sería un predicado inversible porque el not no es inversible.
% El generador nos "achica" el universo de opciones.

esLibro(Obra) :-
    esObra(Obra), % generador para que esLibro sea inversible
    not(esComic(Obra)).

esObra(Obra) :-
    escribio(_, Obra).

%copiasVendidas(Obra,Cantidad)

copiasVendidas(socorro, 10000).
copiasVendidas(sandman, 20000).
copiasVendidas(watchmen, 30000).
copiasVendidas(cienBalas, 40000).
copiasVendidas(planetary, 50000).
copiasVendidas(elCaballeroOscuroRegresa, 60000).
copiasVendidas(batmanAnioUno, 70000).
copiasVendidas(americanGods, 80000).
copiasVendidas(buenosPresagios, 90000).
copiasVendidas(buenosPresagios, 10000).
copiasVendidas(fundacion, 20000).

bestSeller(Obra):-
    copiasVendidas(Obra,Cantidad),
    Cantidad > 50000.

% Conviene contratar un artista si escribió un bestseller o es reincidente. Tiene que ser inversible.

%Queremos saber si una obra es rioplatense, que es cuando la nacionalidad de su artista es platense (Uruguay o Argentina). ¡Ojo con repetir lógica! 

nacionalidad(elsaBornemann, argentina).
nacionalidad(joseHernandez, argentina).
nacionalidad(julioCortazar, argentina).
nacionalidad(jorgeLuisBorges, argentina).
nacionalidad(horacioQuiroga, uruguaya).
nacionalidad(neilGaiman, britanica).
nacionalidad(alanMoore, britanica).
nacionalidad(warrenEllis, britanica).
nacionalidad(terryPratchett, britanica).
nacionalidad(brianAzarello, estadounidense).
nacionalidad(frankMiller, estadounidense).
nacionalidad(stephenKing, estadounidense).
nacionalidad(isaacAsimov, rusa).

esObraRioPlatense(Obra):-
    escribio(Obra,Autor),
    nacionalidad(Autor,Nacionalidad),
    platense(Nacionalidad).

platense(argentina).
platense(uruguaya).

% novela(Genero, CantidadDeCapitulos)
% libroDeCuentos(CantidadDeCuentos)
% libroCientifico(Disciplina)
% bestSeller(Precio, CantidadDePaginas)

esDeTipo(it, novela(terror, 11)).
esDeTipo(cuentosDeLaSelva, libroDeCuentos(10)).
esDeTipo(elUniversoEnUnaTabla, cientifico(quimica)).
esDeTipo(elUltimoTeoremaDeFermat, cientifico(matematica)).
esDeTipo(yoRobot, bestSeller(700, 253)).

/*
estaBuena/1 nos dice cuando una obra está buena. Esto sucede cuando:
- Es una novela policial y tiene menos de 12 capítulos.
- Es una novela de terror.
- Los libros con más de 10 cuentos siempre son buenos.
- Es una obra científica de fisicaCuantica.
- Es un best seller y el precio por página es menor a $50.
*/

estaBuena(Obra):-
    esDeTipo(Obra, novela(policial,Capitulos)),
    Capitulos < 12.

estaBuena(Obra):-
    esDeTipo(Obra, novela(terror,_)).

estaBuena(Obra):-
    esDeTipo(Obra, libroDeCuentos(CantidadDeCuentos)),
    CantidadDeCuentos > 10.

estaBuena(Obra):-
    esDeTipo(Obra, cientifico(fisicaCuantica)).

estaBuena(Obra):-
    esDeTipo(Obra, bestSeller(Precio,Paginas)),
    (Precio / Paginas) < 50.

/* Pero usando polimorfismo nos quedaria*/

estaBuena(Obra):-
    esDeGenero(Obra, Tipo),
    esBuenGenero(Tipo).

esBuenGenero(novela(policial, Capitulos)):-
    Capitulos < 12.
esBuenGenero(novela(terror, _)).
esBuenGenero(libroDeCuentos(CantidadDeCuentos)):-
    CantidadDeCuentos > 10.
esBuenGenero(cientifico(fisicaCuantica)).
esBuenGenero(bestSeller(Precio, Paginas)):-
    Precio / Paginas < 50.

ventasDeUnaObraDeUnAutor(Autor,Cantidad):-
    escribio(Autor,Obra),
    copiasVendidas(Obra,Cantidad).

promedioCopiasVendidas(Autor, Promedio):-
    escribio(Autor, _),
    findall(Copias, ventasDeUnaObraDeUnAutor(Autor,Copias), ListaDeCopias),
    length(ListaDeCopias, Cantidad),
    sum_list(ListaDeCopias , TotalDeCopiasVendidas),
    Promedio is TotalDeCopiasVendidas / Cantidad.
    
    
    



       

 