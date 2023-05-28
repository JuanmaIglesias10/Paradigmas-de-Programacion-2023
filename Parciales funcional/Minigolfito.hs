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


data Obstaculo = UnObstaculo {
  puedeSuperar :: Tiro -> Bool ,
  efectoLuegoDeSuperar :: Tiro -> Tiro
} 

intentarSuperarObstaculo :: Obstaculo -> Tiro -> Tiro
intentarSuperarObstaculo unObstaculo unTiro 
  | puedeSuperar unObstaculo unTiro = efectoLuegoDeSuperar unObstaculo unTiro
  | otherwise = tiroDetenido 

tunelConRampa :: Obstaculo 
tunelConRampa = UnObstaculo superaTunelConRampita efectoTunelConRampa 

superaTunelConRampita :: Tiro -> Bool
superaTunelConRampita unTiro = precision unTiro > 90 && alRasDelSuelo unTiro

alRasDelSuelo = (==0) . altura
 
efectoTunelConRampa :: Tiro -> Tiro
efectoTunelConRampa unTiro = unTiro {velocidad = velocidad unTiro *2 , precision = 100 , altura = 0}

tiroDetenido = UnTiro  0 0 0

laguna :: Int -> Obstaculo
laguna largoLaguna = UnObstaculo superaLaguna (efectoLaguna largoLaguna)

superaLaguna :: Tiro -> Bool
superaLaguna unTiro = velocidad unTiro > 80 && (between 1 5 . altura) unTiro 

between n m x = elem x [n .. m]

efectoLaguna :: Int -> Tiro -> Tiro
efectoLaguna largoLaguna unTiro = unTiro { altura = altura unTiro `div` largoLaguna }

hoyo :: Obstaculo
hoyo = UnObstaculo superaHoyo efectoHoyo

superaHoyo :: Tiro -> Bool
superaHoyo unTiro = (between 5 10 . velocidad) unTiro && alRasDelSuelo unTiro && precision unTiro > 95 

efectoHoyo :: Tiro -> Tiro
efectoHoyo unTiro = tiroDetenido 
