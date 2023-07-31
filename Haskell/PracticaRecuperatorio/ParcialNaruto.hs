import Text.Show.Functions ()


data Ninja = Ninja {
    nombre :: Nombre,
    herramientas :: [Herramienta],
    jutsus :: [Jutsu],
    rango :: Int
} deriving Show

type Herramienta = (Nombre,Cantidad)
type Nombre = String
type Cantidad = Int

---- CASO DE PRUEBA ----

juancito :: Ninja
juancito = Ninja "Juancito" [("kunais",9),("shurikens",50)] [] 5

--- FUNCIONES AUX --- 

mapCantidad :: (Int -> Int) -> Herramienta -> Herramienta
mapCantidad unaFuncion (unNombre, unaCantidad) = (unNombre, unaFuncion unaCantidad)

modificarHerramientas :: ([Herramienta] -> [Herramienta]) -> Ninja -> Ninja
modificarHerramientas unModificador unNinja = unNinja {herramientas = unModificador.herramientas $ unNinja}

agregarHerramienta :: Herramienta -> Ninja -> Ninja
agregarHerramienta unaHerramienta = modificarHerramientas (unaHerramienta :) 

modificarRango :: (Int -> Int) -> Ninja -> Ninja
modificarRango unModificador unNinja = unNinja {rango = unModificador.rango $ unNinja}

disminuirRango :: Int -> Ninja -> Ninja
disminuirRango = modificarRango . (subtract)

-----------------------------------------------------------------------------------------------------------------

-- 1A

obtenerHerramienta :: Herramienta -> Ninja -> Ninja
obtenerHerramienta herramienta ninja 
    | (sumaDeTodasLasHerramientas ninja + cantidadDeUnaHerramienta herramienta) <= 100 = agregarHerramienta herramienta ninja
    | otherwise = agregarHerramienta (limitarCantidadA (cuantasHerramientasPuedeObtener ninja) herramienta) ninja

limitarCantidadA :: Int -> Herramienta -> Herramienta
limitarCantidadA unaCantidad = mapCantidad (min unaCantidad)

cuantasHerramientasPuedeObtener :: Ninja -> Int
cuantasHerramientasPuedeObtener = (100 -) . sumaDeTodasLasHerramientas

sumaDeTodasLasHerramientas :: Ninja -> Int
sumaDeTodasLasHerramientas unNinja = sum . map(cantidadDeUnaHerramienta) . herramientas $ unNinja

cantidadDeUnaHerramienta :: Herramienta -> Int
cantidadDeUnaHerramienta = snd

--- 1B

usarHerramienta :: Herramienta -> Ninja -> Ninja
usarHerramienta unaHerramienta unNinja = eliminarHerramienta unaHerramienta unNinja

eliminarHerramienta :: Herramienta -> Ninja -> Ninja
eliminarHerramienta unaHerramienta unNinja = modificarHerramientas (filter ((/=) (nombreHerramienta unaHerramienta) . nombreHerramienta)) unNinja 

nombreHerramienta :: Herramienta -> String
nombreHerramienta = fst

----- PARTE B

data Mision = Mision {
    cantidadDeNinjas  :: Int,
    rangoRecomendable :: Int,
    ninjasEnemigos    :: [Ninja],
    recompensa       :: Herramienta
} deriving Show

type Equipo = [Ninja]

--- B a

esDesafiante :: Equipo -> Mision -> Bool
esDesafiante unEquipo unaMision = tieneMenorRangoQueRecomendado unEquipo unaMision && derrotarAlMenos2 unaMision 

tieneMenorRangoQueRecomendado :: Equipo -> Mision -> Bool
tieneMenorRangoQueRecomendado unEquipo unaMision = any (rangoMenorQueRecomendado unaMision) unEquipo

rangoMenorQueRecomendado :: Mision -> Ninja -> Bool
rangoMenorQueRecomendado unaMision unNinja = rango unNinja < rangoRecomendable unaMision

derrotarAlMenos2 :: Mision -> Bool
derrotarAlMenos2 unaMision  = (>=2) . length . ninjasEnemigos $ unaMision

--- B b

esCopada :: Mision -> Bool
esCopada unaMision = esRecompensaCopada . recompensa $ unaMision

esRecompensaCopada :: Herramienta -> Bool
esRecompensaCopada unaHerramienta = elem unaHerramienta recompensasCopadas

recompensasCopadas :: [Herramienta]
recompensasCopadas = [("bombas de humo",3),("shurikens",5),("kunais",14)]

--- B c

esFactible :: Mision -> Equipo -> Bool
esFactible unaMision unEquipo = (not.esDesafiante unEquipo) unaMision && estaBienPreparado unaMision unEquipo 

estaBienPreparado :: Mision -> Equipo -> Bool
estaBienPreparado unaMision unEquipo = cantidadDeNinjasNecesaria unEquipo unaMision || herramientasSuficientes unEquipo

cantidadDeNinjasNecesaria :: Equipo -> Mision -> Bool
cantidadDeNinjasNecesaria unEquipo unaMision = length unEquipo >= cantidadDeNinjas unaMision

herramientasSuficientes :: Equipo -> Bool
herramientasSuficientes  = (>500) . sum . map (sumaDeTodasLasHerramientas)

--- B d

fallarMision :: Equipo -> Mision -> Equipo
fallarMision unEquipo unaMision = modificarRangoDelGrupo (subtract 2) . filter (rangoRecomendado unaMision) $ unEquipo

rangoRecomendado :: Mision -> Ninja -> Bool
rangoRecomendado unaMision unNinja = rango unNinja >= rangoRecomendable unaMision

modificarRangoDelGrupo :: (Int -> Int) -> [Ninja] -> [Ninja]
modificarRangoDelGrupo unModificador unosNinjas = map (modificarRango unModificador) unosNinjas

--- B e

cumplirMision :: Mision -> Equipo -> Equipo
cumplirMision unaMision = map (obtenerHerramienta (recompensa unaMision) . promoverRango)

promoverRango :: Ninja -> Ninja
promoverRango = modificarRango (+1)

type Jutsu = Mision -> Mision

--fuerzaDeUnCententar :: Jutsu 
--fuerzaDeUnCententar = 
