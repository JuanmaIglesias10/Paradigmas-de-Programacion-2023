import Text.Show.Functions ()

data Chico = UnChico {
    nombreChico :: Nombre,
    edad :: Edad,
    habilidades :: [Habilidad],
    deseos :: [Deseo]
} deriving Show

type Nombre = String
type Edad = Int
type Habilidad = String
type Deseo = Chico -> Chico

timmy = UnChico "Timmy" 10 ["mirar television", "jugar en la pc"] [serMayor]

---- FUNCIONES AUXILIARES ----

modificarHabilidades :: ([Habilidad] -> [Habilidad]) -> Chico -> Chico
modificarHabilidades unaFuncion unChico = unChico{habilidades = unaFuncion.habilidades $ unChico}

agregarListaDeHabilidades :: [Habilidad] -> Chico -> Chico
agregarListaDeHabilidades unasHabilidades unChico = modificarHabilidades (++ unasHabilidades) unChico

modificarEdad :: (Int -> Int) -> Chico -> Chico
modificarEdad f unChico = unChico{edad= f.edad $ unChico}

setEdad :: Int -> Chico -> Chico
setEdad unaEdad = modificarEdad (const unaEdad)

--- PARTE A CONCEDIENDO DESEOS ---
    --- 1a ---

aprenderHabilidades :: [Habilidad] -> Deseo
aprenderHabilidades habilidades unChico = agregarListaDeHabilidades habilidades unChico

    --- 1b ---

serGrosoEnElNeedForSpeed :: Deseo
serGrosoEnElNeedForSpeed  = agregarListaDeHabilidades todosLosNeedForSpeed  

todosLosNeedForSpeed :: [Habilidad]
todosLosNeedForSpeed = map (("jugar need for speed " ++) . show) [1..]

    --- 1c ---

serMayor :: Deseo
serMayor = setEdad 18

    --- 2a ---

type Padrino = Chico -> Chico

wanda :: Padrino
wanda = madurar . cumplirPrimerDeseo

cumplirPrimerDeseo :: Chico -> Chico
cumplirPrimerDeseo unChico = (head . deseos $ unChico) unChico

madurar :: Chico -> Chico
madurar = modificarEdad (+1)

    --- 2b ---

cosmo :: Padrino
cosmo = desmadurar

desmadurar :: Chico -> Chico
desmadurar = modificarEdad (`div` 2)

    --- 2c ---

muffinMagico :: Padrino
muffinMagico unChico = foldr ($) unChico (deseos unChico)

--- PARTE B EN BUSQUEDA DE PAREJA ---

    --- 1a ---

tieneHabilidad :: Habilidad -> Chico -> Bool
tieneHabilidad unaHabilidad unChico = elem unaHabilidad (habilidades unChico)

    --- 1b ---

esSuperMaduro :: Chico -> Bool
esSuperMaduro unChico = ((>17) . edad) unChico && tieneHabilidad "manejar" unChico

    --- 2a ---

data Chica = UnaChica{
    nombreChica :: Nombre,
    condicion :: Condicion
} deriving Show

type Condicion = Chico -> Bool

{-
quienConquistaA :: Chica -> [Chico] -> Chico
quienConquistaA unaChica unosPretendientes 
    | 

cumpleLaCondicionDeLaChica :: Chica -> Chico -> Bool
cumpleLaCondicionDeLaChica unaChica unChico =   condicion unaChica

-} 

    --- 2b ---

-- UnaChica "Sofia" (tieneHabilidad "cocinar")

--- PARTE C Da Rules ---

--infractoresDeDaRules :: [Chico] -> [Nombre]
--infractoresDeDaRules unosChicos = 

infractoresDeDaRules :: [Chico] -> [String]
infractoresDeDaRules = map nombreChico . filter tieneDeseoProhibido

tieneDeseoProhibido :: Chico -> Bool
tieneDeseoProhibido unChico = any (esDeseoProhibidoPara unChico) . deseos $ unChico

esDeseoProhibidoPara :: Chico -> Deseo -> Bool
esDeseoProhibidoPara unChico unDeseo = tienenAlgunaHabilidadProhibida $ unDeseo unChico

tienenAlgunaHabilidadProhibida :: Chico -> Bool
tienenAlgunaHabilidadProhibida unChico = any esHabilidadProhibida . take 5 . habilidades $ unChico

esHabilidadProhibida :: Habilidad -> Bool
esHabilidadProhibida unaHabilidad = elem unaHabilidad habilidadesProhibidas

habilidadesProhibidas :: [Habilidad]
habilidadesProhibidas = ["enamorar","matar","Dominar el mundo"]