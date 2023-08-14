import Text.Show.Functions ()

data Carrera = UnaCarrera {
    nroDeVueltas :: Int,
    longitud :: Int,
    participantes :: [Auto],
    publico :: [Nombre]
} deriving Show

type Nombre = String
type Truco = Auto -> Auto

data Auto = UnAuto {
    nombre :: Nombre,
    nafta :: Int,
    velocidad :: Int,
    enamorado :: Nombre,
    truco :: Truco
} deriving Show

modificarNafta :: (Int -> Int) -> Auto -> Auto
modificarNafta unaFuncion unParticipante = unParticipante {nafta = unaFuncion.nafta $ unParticipante}

modificarVelocidad :: (Int -> Int) -> Auto -> Auto
modificarVelocidad unaFuncion unParticipante = unParticipante {velocidad = unaFuncion.velocidad $ unParticipante}

sumarNafta :: Int -> Auto -> Auto
sumarNafta unNumero = modificarNafta  (+ unNumero)

---- TRUCOS ---

deReversaRocha :: Carrera -> Truco 
deReversaRocha unaCarrera unParticipante = modificarNafta (  +5 * longitud unaCarrera ) unParticipante

-- Funcion para modificar cualquier campo ???

impresionar :: Carrera -> Truco
impresionar unaCarrera unParticipante 
    | estaElEnamorado unaCarrera unParticipante = modificarVelocidad (*2) unParticipante 
    | otherwise = unParticipante

estaElEnamorado :: Carrera -> Auto -> Bool
estaElEnamorado unaCarrera unParticipante = elem (enamorado unParticipante) $ publico unaCarrera

nitro :: Truco
nitro unParticipante = modificarVelocidad (+15) unParticipante

comboLoco :: Carrera -> Truco
comboLoco unaCarrera unParticipante = nitro . deReversaRocha unaCarrera $ unParticipante

--- PARTICIPANTES ---

galvez :: Carrera
galvez = UnaCarrera 20 15 [rochaMcQueen,biankerr,gushtav] []

rochaMcQueen :: Auto
rochaMcQueen = UnAuto "RochaMcQueen" 282 5 "Ronco" (deReversaRocha galvez)

biankerr :: Auto
biankerr = UnAuto "Biankerr" 378 10 "Tincho" (impresionar galvez)

gushtav :: Auto
gushtav = UnAuto "Gushtav" 230 50 "Peti" nitro 

rodra :: Auto
rodra = UnAuto "Rodra" 153 0 "Tais" (comboLoco galvez)

modificarParticipantes :: ([Auto] -> [Auto]) -> Carrera -> Carrera
modificarParticipantes unaFuncion unaCarrera = unaCarrera{participantes= unaFuncion.participantes $ unaCarrera}

--darVuelta :: Carrera -> Carrera 
--darVuelta unaCarrera = modificarParticipantes (remontada . incrementarVelocidad . restarNafta) unaCarrera

restarNafta :: Carrera -> Carrera
restarNafta unaCarrera = modificarParticipantes (map (sacarNafta unaCarrera)) unaCarrera

sacarNafta ::  Carrera -> Auto -> Auto
sacarNafta unaCarrera unAuto = modificarNafta (subtract (longitud unaCarrera * (length . nombre $ unAuto))) unAuto

elMasLentoDeTodos :: Carrera -> Auto
elMasLentoDeTodos unaCarrera = foldl1 autoMasLentoEntre2 (participantes unaCarrera)

autoMasLentoEntre2 :: Auto -> Auto -> Auto
autoMasLentoEntre2 unAuto otroAuto
    | velocidad unAuto > velocidad otroAuto = otroAuto
    | otherwise = unAuto

esElMasLento :: Carrera -> Auto -> Bool
esElMasLento unaCarrera = (==elMasLentoDeTodos unaCarrera) 

aplicarTruco :: Carrera -> Carrera
aplicarTruco unaCarrera = modificarParticipantes (map (truco . elMasLentoDeTodos $ unaCarrera)) unaCarrera

