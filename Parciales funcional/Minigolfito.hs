module Ejemplo where
import Text.Show.Functions ()

data Jugador = UnJugador {
  nombre :: String,
  padre :: String,
  habilidad :: Habilidad
} deriving (Eq, Show)

data Habilidad = Habilidad {
  fuerzaJugador :: Int,
  precisionJugador :: Int
} deriving (Eq, Show)

bart :: Jugador
bart = UnJugador "Bart" "Homero" (Habilidad 25 60)
todd :: Jugador
todd = UnJugador "Todd" "Ned" (Habilidad 15 80)
rafa :: Jugador
rafa = UnJugador "Rafa" "Gorgory" (Habilidad 10 1)

data Tiro = UnTiro {
  velocidad :: Int,
  precision :: Int,
  altura :: Int
} deriving (Eq, Show)

type Puntos = Int


--PUNTO 1 

--A

type Palo = Habilidad -> Tiro 
type Precision = Int

putter :: Palo
putter unaHabilidad = UnTiro {velocidad = 10 , precision = precisionJugador unaHabilidad * 2  , altura = 0}  

madera :: Palo
madera unaHabilidad = UnTiro {velocidad = 100 , precision = div (precisionJugador unaHabilidad) 2 , altura = 5}

hierro :: Int -> Palo
hierro unN unaHabilidad = UnTiro {velocidad =  fuerzaJugador unaHabilidad * unN , precision = precisionJugador unaHabilidad `div` unN , altura =  (unN - 3) `max` 0 } 

--B

palos :: [Palo]
palos = [putter , madera] ++ map hierro [1..10]

--PUNTO 2

golpe :: Jugador -> Palo -> Tiro
golpe unJugador unPalo = unPalo . habilidad $ unJugador

--PUNTO 3

