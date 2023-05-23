module Ejemplo where
import Text.Show.Functions ()
import GHC.IO (unsafeUnmask)

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

type Componente = (String,Int)


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
