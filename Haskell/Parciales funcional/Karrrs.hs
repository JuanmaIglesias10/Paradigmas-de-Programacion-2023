import Text.Show.Functions ()


data Auto = UnAuto{
    nombre :: String,
    nafta :: Int,
    velocidad :: Int,
    enamoradoDe :: String,
    truco :: Truco
} deriving (Show)

data Carrera = UnaCarrera{
    vueltas :: Int,
    longitudPista :: Int,
    participantes :: [Auto],
    publico :: [Publico]
} deriving (Show)

type Espectadores = String
type Truco = Carrera -> Auto -> Auto
type Publico = String

--------- FUNCIONES AUX ---------

modificarNafta :: (Int -> Int) -> Auto -> Auto
modificarNafta unModificador unAuto = unAuto {nafta = unModificador.nafta $ unAuto}

modificarVelocidad :: (Int -> Int) -> Auto -> Auto
modificarVelocidad unModificador unAuto = unAuto {velocidad = unModificador.velocidad $ unAuto}

modificarParticipantes :: ([Auto] -> [Auto]) -> Carrera -> Carrera
modificarParticipantes unModificador unaCarrera = unaCarrera {participantes = unModificador.participantes $ unaCarrera}
  
--------- Autos ---------

rochaMcQueen :: Auto
rochaMcQueen = UnAuto "Rocha Mc Queen" 282 0 "Ronco" deReversaRocha

biankerr :: Auto
biankerr = UnAuto "Biankerr" 378 0 "Tincho" impresionar

gushtav :: Auto
gushtav = UnAuto "Gushtav" 153 0 "Peti" nitro

rodra :: Auto
rodra = UnAuto "Rodra" 153 0 "Tais" comboLoco

--------- Trucos ---------

deReversaRocha :: Truco
deReversaRocha unaCarrera unAuto = modificarNafta  ((+) . (*5) . longitudPista $ unaCarrera) unAuto

impresionar :: Truco
impresionar unaCarrera unAuto 
    | enamoradoEnElPublico unaCarrera unAuto  = modificarVelocidad (*2) unAuto
    | otherwise = unAuto

enamoradoEnElPublico :: Carrera -> Auto -> Bool
enamoradoEnElPublico unaCarrera unAuto = elem  (enamoradoDe unAuto) . publico $ unaCarrera

nitro :: Truco
nitro _ = modificarVelocidad (+15)  

comboLoco :: Truco
comboLoco unaCarrera = nitro unaCarrera . deReversaRocha unaCarrera

--------- Vueltas ---------


restarCombustible :: Int -> Auto -> Auto
restarCombustible distancia unAuto = (modificarNafta . subtract . (* distancia) . longitudNombre) unAuto unAuto

restarCombustibleParticipantes :: Carrera -> Carrera
restarCombustibleParticipantes unaCarrera = (modificarParticipantes . map . restarCombustible . longitudPista $ unaCarrera) unaCarrera 

longitudNombre :: Auto -> Int
longitudNombre = length.nombre

nombreMasCortoQue :: Int -> Auto -> Bool
nombreMasCortoQue unLargo = (< unLargo) . longitudNombre

criterioDeAumento :: 