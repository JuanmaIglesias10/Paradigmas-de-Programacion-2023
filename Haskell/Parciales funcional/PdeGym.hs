import Text.Show.Functions ()

data Persona = UnaPersona {
    nombre :: String,
    calorias :: Int,
    hidratacion :: Int,
    tiempoDisponible :: Int,
    equipamientos :: [Equipamiento]
} deriving (Show)

type Equipamiento = String

------ Personas para probar las funciones -------

juancito :: Persona
juancito = UnaPersona "Juancito" 2000 50 60 []

----------- Funciones Modificar ----------- 

modificarCalorias :: (Int -> Int) -> Persona -> Persona
modificarCalorias unModificador unaPersona = unaPersona {calorias = unModificador.calorias $ unaPersona}

perderCalorias :: Int -> Persona -> Persona
perderCalorias unaCantidad = modificarCalorias (subtract unaCantidad) 

modificarHidratacion :: (Int -> Int) -> Persona -> Persona
modificarHidratacion unModificador unaPersona = unaPersona {hidratacion = unModificador.hidratacion $ unaPersona}

perderHidratacion :: Int -> Persona -> Persona
perderHidratacion  unaCantidad = modificarHidratacion (subtract unaCantidad)

coeficienteHidratacion :: Int -> Int
coeficienteHidratacion repeticiones = repeticiones `div` 10

modificarEquipamientos :: ([Equipamiento] -> [Equipamiento]) -> Persona -> Persona
modificarEquipamientos unModificador unaPersona = unaPersona {equipamientos = unModificador.equipamientos $ unaPersona}

setEquipamientos :: [Equipamiento] -> Persona -> Persona
setEquipamientos unosEquipamientos = modificarEquipamientos (const unosEquipamientos)

modificarNombre :: (String -> String) -> Persona -> Persona
modificarNombre unModificador unaPersona = unaPersona {nombre = unModificador.nombre $ unaPersona} 

----------- PARTE A ----------- 

type Ejercicio = Persona -> Persona

--A1

abdominales :: Int -> Ejercicio
abdominales repeticiones unaPersona = perderCalorias (8 * repeticiones)  unaPersona

--A2

flexiones :: Int -> Ejercicio
flexiones repeticiones unaPersona = perderCalorias (16 * repeticiones) . perderHidratacion ((*2) . coeficienteHidratacion $ repeticiones) $ unaPersona 

--A3 

levantarPesas :: Int -> Int -> Ejercicio
levantarPesas unPeso unasRepeticiones unaPersona 
    | tiene "pesa" unaPersona = perderCalorias (32 * unasRepeticiones)  . perderHidratacion ((*unPeso) . coeficienteHidratacion $ unasRepeticiones) $ unaPersona
    | otherwise = unaPersona

tiene :: Equipamiento -> Persona -> Bool
tiene unEquipamiento =  elem unEquipamiento . equipamientos 

--A4

laGranHomeroSimpson :: Ejercicio
laGranHomeroSimpson = id 

----------- OTRAS ACCIONES -----------

type Accion = Persona -> Persona

--Punto 1

renovarEquipo :: Accion
renovarEquipo unaPersona = modificarEquipamientos (map ("Nuevo " ++)) unaPersona

--Punto 2

volverseYoguista :: Accion
volverseYoguista = modificarCalorias (`div` 2) . modificarHidratacion (* 2) . setEquipamientos ["Colchoneta"]

--Punto 3

volverseBodyBuilder :: Accion
volverseBodyBuilder unaPersona
    | tieneSoloPesas unaPersona = modificarNombre (++ "BB") . modificarCalorias (*3) $ unaPersona  
    | otherwise = unaPersona

tieneSoloPesas :: Persona -> Bool
tieneSoloPesas = all esPesa . equipamientos

esPesa :: Equipamiento -> Bool
esPesa = (== "pesa")

--Punto 4

comerUnSandwich :: Accion
comerUnSandwich = modificarCalorias (+500) . modificarHidratacion (+100)

----------- PARTE B ----------- 

data Rutina = UnaRutina {
    tiempoDeDuracion :: Int,
    ejercicios :: [Ejercicio]
} deriving (Show)

hacerRutina :: Rutina -> Persona -> Persona
hacerRutina unaRutina unaPersona
    | tieneTiempoPara unaRutina unaPersona = foldr ($) unaPersona (ejercicios unaRutina)
    | otherwise = unaPersona    

tieneTiempoPara :: Rutina -> Persona -> Bool
tieneTiempoPara unaRutina unaPersona = tiempoDisponible unaPersona >= tiempoDeDuracion unaRutina

--B1

esPeligrosa :: Rutina -> Persona -> Bool
esPeligrosa unaRutina unaPersona = personaAgotada . hacerRutina unaRutina $ unaPersona

personaAgotada :: Persona -> Bool
personaAgotada unaPersona = calorias unaPersona < 50 && hidratacion unaPersona < 10

--B2

esBalanceada :: Rutina -> Persona -> Bool
esBalanceada unaRutina unaPersona = quedaBien . hacerRutina unaRutina $ unaPersona
    where quedaBien personaPostRutina = hidratacion personaPostRutina > 80 && calorias personaPostRutina < calorias unaPersona `div` 2

elAbominableAbdominal :: Rutina
elAbominableAbdominal = UnaRutina 60 (map abdominales [1..])

----------- PARTE C -----------

--C1 
seleccionarGrupoDeEjercicio :: Persona -> [Persona] -> [Persona]
seleccionarGrupoDeEjercicio unaPersona unasPersonas = filter (tienenElMismoTiempoDisponible unaPersona) $ unasPersonas

tienenElMismoTiempoDisponible :: Persona -> Persona -> Bool
tienenElMismoTiempoDisponible unaPersona otraPersona = tiempoDisponible unaPersona == tiempoDisponible otraPersona

--C2

promedioDeRutina :: Rutina -> [Persona] -> (Int, Int)
promedioDeRutina unaRutina unasPersonas = estadisticasGrupales . map (hacerRutina unaRutina) $ unasPersonas

estadisticasGrupales :: [Persona] -> (Int, Int)
estadisticasGrupales unasPersonas = (promedioDe calorias unasPersonas, promedioDe hidratacion unasPersonas)

promedioDe :: (b -> Int) -> [b] -> Int
promedioDe funcionPonderadora = promedio . map funcionPonderadora

promedio :: [Int] -> Int
promedio unosValores = sum unosValores `div` length unosValores
