import Text.Show.Functions ()

data Participante = UnParticipante {
    nombre :: Nombre,
    cantidadDinero :: Int,
    tactica :: String,
    propiedades :: [Propiedad],
    acciones :: [Accion]
} deriving Show

type Nombre = String
type Precio = Int
type Accion = Participante -> Participante
type Propiedad = (Nombre , Precio)

carolina :: Participante
carolina = UnParticipante "Carolina" 500 "Accionista" [("Casaquinta",1500)] [pasarPorElBanco , pagarAAccionistas]

manuel :: Participante
manuel = UnParticipante "Manuel" 500 "Oferente singular" [] [pasarPorElBanco , enojarse]

-- Funciones aux -- 
modificarDinero :: (Int -> Int) -> Participante -> Participante
modificarDinero unModificador unParticipante = unParticipante {cantidadDinero = unModificador.cantidadDinero $ unParticipante}

sumarDinero :: Int -> Participante -> Participante
sumarDinero unMonto = modificarDinero (+unMonto)

setTactica :: String -> Participante -> Participante
setTactica = modificarTactica . const

modificarTactica :: (String -> String) -> Participante -> Participante
modificarTactica unModificador unParticipante = unParticipante {tactica = unModificador.tactica $ unParticipante}

modificarAcciones :: ([Accion] -> [Accion]) -> Participante -> Participante
modificarAcciones unModificador unParticipante = unParticipante {acciones = unModificador.acciones $ unParticipante}

modificarNombre :: (Nombre -> Nombre) -> Participante -> Participante
modificarNombre unModificador unParticipante = unParticipante {nombre = unModificador.nombre $ unParticipante}

agregarAccion :: Accion -> Participante -> Participante
agregarAccion unaAccion unParticipante = unParticipante {acciones = (unaAccion :) . acciones $ unParticipante} 

agregarPropiedad :: Propiedad -> Participante -> Participante
agregarPropiedad unaPropiedad unParticipante = unParticipante {propiedades = (unaPropiedad :) . propiedades $ unParticipante}

quitarPropiedad :: Propiedad -> Participante -> Participante
quitarPropiedad unaPropiedad unaPersona = unaPersona { propiedades = filter ((/=) (nombrePropiedad unaPropiedad) . nombrePropiedad) . propiedades $ unaPersona}

-- Acciones --

pasarPorElBanco :: Accion
pasarPorElBanco unParticipante = setTactica "Comprador compulsivo" . sumarDinero 40 $ unParticipante 

enojarse :: Accion
enojarse unParticipante = sumarDinero 50 . agregarAccion gritar $ unParticipante

gritar :: Accion
gritar unParticipante = modificarNombre ("AHHHH" ++) unParticipante

subastar :: Propiedad -> Accion
subastar unaPropiedad unParticipante
    | tieneTactica "Oferente singular" unParticipante || tieneTactica "Accionista" unParticipante = ganarPropiedad unaPropiedad unParticipante 
    | otherwise                                                                                   = unParticipante

tieneTactica :: String -> Participante -> Bool
tieneTactica unaTactica unParticipante = tactica unParticipante == unaTactica

ganarPropiedad :: Propiedad -> Participante -> Participante
ganarPropiedad unaPropiedad unParticipante = 
    modificarDinero (subtract . precioPropiedad $ unaPropiedad) . agregarPropiedad unaPropiedad $ unParticipante

precioPropiedad :: Propiedad -> Int
precioPropiedad = snd

nombrePropiedad :: Propiedad -> String
nombrePropiedad = fst

esPropiedadBarata :: Propiedad -> Bool
esPropiedadBarata unaPropiedad = precioPropiedad unaPropiedad < 150

precioAlquiler:: Propiedad -> Int
precioAlquiler unaPropiedad
    | esPropiedadBarata unaPropiedad = 10
    | otherwise                      = 20

ingresosPorAlquileres :: Participante -> Int
ingresosPorAlquileres unParticipante = sum . map precioAlquiler . propiedades $ unParticipante

cobrarAlquileres :: Accion
cobrarAlquileres unParticipante = modificarDinero ((+).ingresosPorAlquileres $ unParticipante) unParticipante

pagarAAccionistas :: Accion
pagarAAccionistas unParticipante
    | tieneTactica "Accionista" unParticipante = modificarDinero (+200) unParticipante
    | otherwise                                = modificarDinero (subtract 100) unParticipante
