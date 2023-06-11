import Text.Show.Functions ()



---- Funciones AUX ----

modificarEpiteto :: (String -> String) -> Heroe -> Heroe
modificarEpiteto        unaFuncion unHeroe = unHeroe { epiteto        = unaFuncion . epiteto        $ unHeroe }
 
setEpiteto :: String -> Heroe -> Heroe
setEpiteto = modificarEpiteto . const

modificarArtefactos :: ([Artefacto] -> [Artefacto]) -> Heroe -> Heroe
modificarArtefactos     unaFuncion unHeroe = unHeroe { artefactos     = unaFuncion . artefactos     $ unHeroe }

agregarArtefacto :: Artefacto -> Heroe -> Heroe
agregarArtefacto = modificarArtefactos . (:)

modificarReconocimiento :: (Int -> Int) -> Heroe -> Heroe
modificarReconocimiento unaFuncion unHeroe = unHeroe { reconocimiento = unaFuncion . reconocimiento $ unHeroe }

ganarReconocimiento :: Int -> Heroe -> Heroe
ganarReconocimiento = modificarReconocimiento . (+)

---- PUNTO 1 ----

data Heroe = UnHeroe{
    nombre :: String, 
    epiteto :: String,
    reconocimiento :: Int,
    artefactos :: [Artefacto],
    tereas :: [Tarea]
} deriving (Show)

type Artefacto = Int
type Tarea = Heroe -> Heroe

---- PUNTO 2 ----

pasarALaHistoria :: Heroe -> Heroe
pasarALaHistoria unHeroe 
    | reconocimiento unHeroe > 1000 = setEpiteto "El mitico" unHeroe
    | reconocimiento unHeroe >= 500 = setEpiteto "El magnifico"  . agregarArtefacto lanzaDelOlimpo $ unHeroe
    | reconocimiento unHeroe > 100 && reconocimiento unHeroe < 500 = setEpiteto "Hoplita" . agregarArtefacto xiphos $ unHeroe
    | otherwise = unHeroe

lanzaDelOlimpo :: Artefacto
lanzaDelOlimpo = 100

xiphos :: Artefacto
xiphos = 50

relampagoDeZeus :: Artefacto
relampagoDeZeus = 500

encontrarUnArtefacto :: Artefacto -> Tarea
encontrarUnArtefacto unArtefacto = ganarReconocimiento unArtefacto . agregarArtefacto unArtefacto 

escalarElOlimpo :: Tarea
escalarElOlimpo  = ganarReconocimiento 500 . modificarArtefactos rarificar . agregarArtefacto relampagoDeZeus
    where rarificar = filter (>1000) . map (*3)



