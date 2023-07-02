
import Text.Show.Functions ()
import Data.Char (toUpper)


data Barbaro = UnBarbaro {
    nombre :: String,
    fuerza :: Int,
    habilidades :: [Habilidad],
    objetos :: [Objeto]
}   deriving (Show)

type Habilidad = String

--------- FUNCIONES AUX ---------

modificarFuerza :: (Int -> Int) -> Barbaro -> Barbaro
modificarFuerza unModificador unBarbaro = unBarbaro {fuerza = unModificador.fuerza $ unBarbaro}

modificarHabilidad :: ([Habilidad] -> [Habilidad]) -> Barbaro -> Barbaro
modificarHabilidad unModificador unBarbaro = unBarbaro {habilidades = unModificador.habilidades $ unBarbaro}

modificarObjeto :: ([Objeto] -> [Objeto]) -> Barbaro -> Barbaro
modificarObjeto unModificador unBarbaro = unBarbaro {objetos = unModificador.objetos $ unBarbaro}

setObjetos :: [Objeto] -> Barbaro -> Barbaro
setObjetos unosObjetos unBarbaro = modificarObjeto (const unosObjetos) unBarbaro


--------- PUNTO 1 ---------
type Objeto = Barbaro -> Barbaro

dave :: Barbaro
dave = UnBarbaro "Dave" 100 ["tejer","escribirPoesia"] [ardilla, varitasDefectuosas]

espadas :: Int -> Objeto
espadas unPeso unBarbaro = modificarFuerza (+ unPeso * 2) $ unBarbaro

amuletosMisticos :: String -> Objeto
amuletosMisticos unaHabilidad  = aprenderHabilidad unaHabilidad 

aprenderHabilidad :: String -> Barbaro -> Barbaro
aprenderHabilidad unaHabilidad  = modificarHabilidad (unaHabilidad :) 

varitasDefectuosas :: Objeto
varitasDefectuosas = aprenderHabilidad "Hacer Magia" . setObjetos [varitasDefectuosas]

ardilla :: Objeto
ardilla unBarbaro = unBarbaro

cuerda :: Objeto -> Objeto -> Objeto
cuerda unObjeto otroObjeto = unObjeto . otroObjeto 

--------- PUNTO 2 ---------

megafono :: Objeto
megafono unBarbaro = modificarHabilidad  concatenarYMayus unBarbaro

concatenarYMayus :: [Habilidad] -> [Habilidad]
concatenarYMayus unasHabilidades = [map toUpper . concat $ unasHabilidades]

megafonoBarbarico :: Objeto
megafonoBarbarico = cuerda ardilla megafono

--------- PUNTO 3 ---------

type Aventura = [Evento]
type Evento = Barbaro -> Bool

invasionDeSuciosDuendes :: Evento
invasionDeSuciosDuendes  unBarbaro = sabe "Escribir Poesia Atroz" unBarbaro

sabe :: String -> Barbaro -> Bool
sabe unaHabilidad unBarbaro = elem unaHabilidad . habilidades $ unBarbaro

cremalleraDelTiempo :: Evento
cremalleraDelTiempo unBarbaro = not . tienePulgares . nombre $ unBarbaro

tienePulgares :: String -> Bool
tienePulgares "Faffy" = False
tienePulgares "Astro" = False
tienePulgares   _     = True 

type Prueba = Barbaro -> Bool

--ritualDeFechorias :: [Prueba] -> Evento
--ritualDeFechorias pruebas unBarbaro = 

saqueo :: Prueba
saqueo unBarbaro = sabe "Robar" unBarbaro && ((>80) . fuerza) unBarbaro

gritoDeGuerra :: Prueba
gritoDeGuerra unBarbaro = largoDeHabilidades unBarbaro > poderNecesario unBarbaro

largoDeHabilidades :: Barbaro -> Int
largoDeHabilidades unBarbaro =  length . concat . habilidades $ unBarbaro

poderNecesario :: Barbaro -> Int
poderNecesario unBarbaro = (*4) . length . objetos $ unBarbaro

caligrafia :: Prueba
caligrafia unBarbaro = tieneTresVocales . comienzanConMayus $ unBarbaro

comienzanConMayus :: String -> Bool
comienzanConMayus unaHabilidad = isUpper . head $ unaHabilidad

tieneTresVocales :: String -> Bool
tieneTresVocales unaHabilidad = 
