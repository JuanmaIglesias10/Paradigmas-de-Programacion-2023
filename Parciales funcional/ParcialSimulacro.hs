module Ejemplo where
import Text.Show.Functions ()

data Participante = UnParticipante {
    nombre       :: String,
    trucos       :: [Truco],
    especialidad :: Plato
} deriving (Show)

type Truco = Plato -> Plato 

data Plato = UnPlato {
    dificultad  :: Int,
    componentes :: [Componente]
}deriving (Show,Eq)

type Componente = (Ingrediente,Int)
type Ingrediente = String


endulzar :: Int -> Truco
endulzar unosGramos unPlato = agregarComponente "Azucar" unosGramos unPlato

salar :: Int -> Truco
salar unosGramos unPlato = agregarComponente "Sal" unosGramos unPlato

agregarComponente :: String -> Int -> Plato -> Plato
agregarComponente unNombre unosGramos unPlato = mapComponentes ((unNombre,unosGramos) :) unPlato 

mapComponentes :: ([Componente] -> [Componente]) -> Plato -> Plato
mapComponentes unaFuncion unPlato = unPlato {componentes = unaFuncion . componentes $ unPlato}

darSabor :: Int -> Int -> Truco
darSabor gramosSal gramosAzucar unPlato = endulzar gramosAzucar . salar gramosSal $ unPlato 

duplicarPorcion :: Truco
duplicarPorcion unPlato = unPlato {componentes = map duplicarCantidad . componentes $ unPlato}

duplicarCantidad :: Componente -> Componente
duplicarCantidad (string , int) = (string , int * 2)

simplificar :: Truco
simplificar unPlato 
    | esUnBardo unPlato = mapComponentes (filter hayMucho) $ unPlato {dificultad = 5}
    | otherwise         = unPlato

hayMucho :: Componente -> Bool
hayMucho unComponente = snd unComponente >= 10 

esUnBardo :: Plato -> Bool
esUnBardo unPlato = dificultad unPlato > 7 && cantidadDeComponentes unPlato > 5

cantidadDeComponentes :: Plato -> Int
cantidadDeComponentes unPlato = length . componentes $ unPlato

esVegano :: Plato -> Bool
esVegano unPlato = not . any esProductoAnimal . componentes $ unPlato

esProductoAnimal :: Componente -> Bool
esProductoAnimal (ingrediente , _) = elem ingrediente productosAnimales

productosAnimales :: [Ingrediente]
productosAnimales = ["Leche", "Carne", "Huevo", "Manteca"]

esSinTacc :: Plato -> Bool
esSinTacc unPlato = not . any esProductoConHarina . componentes $ unPlato

esProductoConHarina :: Componente -> Bool
esProductoConHarina (ingrediente , _) = elem ingrediente productosConHarina

productosConHarina :: [Ingrediente]
productosConHarina = ["Pastas","Pizza","Pan"]

esComplejo :: Plato -> Bool
esComplejo unPlato = esUnBardo unPlato

noAptoHipertension :: Plato -> Bool
noAptoHipertension unPlato = any tieneMuchaSal (componentes  unPlato)

tieneMuchaSal :: Componente -> Bool
tieneMuchaSal unComponente = fst unComponente == "Sal" && snd unComponente > 2

--PARTE B

pepeRonccino :: Participante
pepeRonccino = UnParticipante "Pepe Ronccino" [darSabor 2 5 , simplificar , duplicarPorcion] unPlatoComplejo

unPlatoComplejo :: Plato
unPlatoComplejo = UnPlato 10 [("Sal",5),("azucar",1),("champinion",4),("carne",2),("huevo",2),("lechuga",6)]

--PARTE C 

cocinar :: Participante -> Plato
cocinar unParticipante = foldl aplicarTrucos (especialidad unParticipante) (trucos unParticipante) 

aplicarTrucos :: Plato -> Truco -> Plato
aplicarTrucos unPlato unTruco = unTruco unPlato

esMejorQue :: Plato -> Plato -> Bool
esMejorQue unPlato otroPlato = dificultad unPlato > dificultad otroPlato && pesoDelPlato unPlato < pesoDelPlato otroPlato

pesoDelPlato :: Plato -> Int
pesoDelPlato unPlato = sum . map (snd) . componentes $ unPlato

participanteEstrella :: [Participante] -> Participante
participanteEstrella unaListaDeParticipantes = foldl1 tieneElMejorPlato unaListaDeParticipantes

tieneElMejorPlato :: Participante -> Participante -> Participante
tieneElMejorPlato unParticipante otroParticipante
    | esMejorQue (cocinar unParticipante) (cocinar otroParticipante) = unParticipante
    | otherwise = otroParticipante

-- Parte D

platinum :: Plato
platinum = UnPlato 10 (repeat ("carne",100))

