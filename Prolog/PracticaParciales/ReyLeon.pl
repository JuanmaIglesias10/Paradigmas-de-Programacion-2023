%comio(Personaje, Bicho)
comio(pumba, vaquitaSanAntonio(gervasia,3)).
comio(pumba, hormiga(federica)).
comio(pumba, hormiga(tuNoEresLaReina)).
comio(pumba, cucaracha(ginger,15,6)).
comio(pumba, cucaracha(er,ikElRojo25,70)).
comio(timon, vaquitaSanAntonio(romualda,4)).
comio(timon, cucaracha(gimeno,12,8)).
comio(timon, cucaracha(cucurucha,12,5)).
comio(simba, vaquitaSanAntonio(remeditos,4)).
comio(simba, hormiga(schwartzenegger)).
comio(simba, hormiga(niato)).
comio(simba, hormiga(lula)).

pesoHormiga(2).

%peso(Personaje, Peso)
peso(pumba, 100).
peso(timon, 50).
peso(simba, 200).

% 1------------------------------------------------------------------------------------------------------------

%a

jugosita(Cucaracha):-
    comio(_,cucaracha(Cucaracha,Tamanio,Peso)),
    comio(_,cucaracha(OtraCucaracha,Tamanio,OtroPeso)),
    Cucaracha \= OtraCucaracha,
    Peso >= OtroPeso.

%b

hormigofilico(Personaje):-
    comio(Personaje,hormiga(Hormiga)),    
    comio(Personaje,hormiga(OtraHormiga)),
    Hormiga \= OtraHormiga.

%c

cucarachafobico(Personaje):-
    comio(Personaje,_),
    not(comio(Personaje,cucaracha(_,_,_))).

%d

picarones(Personajes):-
    findall(Personaje,esPicaron(Personaje),Personajes).

esPicaron(Personaje):-
    comio(Personaje,cucaracha(Cucaracha,_,_)),
    jugosita(Cucaracha).

esPicaron(Personaje):-
    comio(Personaje,vaquitaSanAntonio(remeditos,4)).

esPicaron(pumba).

% 2------------------------------------------------------------------------------------------------------------

persigue(scar, timon).
persigue(scar, pumba).
persigue(shenzi, simba).
persigue(shenzi, scar).
persigue(banzai, timon).

comio(shenzi,hormiga(conCaraDeSimba)).

peso(scar, 300).
peso(shenzi, 400).
peso(banzai, 500).

%a

cuantoEngorda(Personaje,Cantidad):-
    comio(Personaje,_),
    findall(Peso,pesoBichoComido(Personaje,_,Peso),PesosComidos),
    sum_list(PesosComidos,Cantidad).

pesoBichoComido(Personaje,Bicho,Peso):-
    comio(Personaje,Bicho),
    pesoDeBicho(Bicho,Peso).

pesoDeBicho(vaquitaSanAntonio(_,Peso),Peso).

pesoDeBicho(hormiga(_),Peso):-
    pesoHormiga(Peso).

pesoDeBicho(cucaracha(_,_,Peso),Peso).

%b

cuantoEngorda(Personaje,Cantidad):-
    persigue(Personaje,_),
    findall(Peso, pesoPerseguido(Personaje,_,Peso),ListaDePesosPerseguidos),
    findall(Peso, pesoBichoComido(Personaje,_,Peso),ListaDePesoscomidos),
    append(ListaDePesoscomidos,ListaDePesosPerseguidos,ListaDePesosTotales),
    sum_list(ListaDePesosTotales,Cantidad).

pesoPerseguido(Personaje,Animal,Peso):-
    persigue(Personaje,Animal),
    peso(Animal,Peso).

persigueYComio(Personaje):-
    comio(Personaje,_),
    persigue(Personaje,_).

%3

persigue(scar,mufasa).

rey(Personaje):-
    persigue(scar,Personaje),
    not(persigue(Personaje,_)),
    not(comio(Personaje,_)).