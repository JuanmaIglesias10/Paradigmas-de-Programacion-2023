import Text.Show.Functions ()

-- LINK TP: https://docs.google.com/document/d/1GMNli3FaVERM-OldRre467gT1LLhGXdXZoRoK7IvoKo/edit

data Jugador = UnJugador {
    nombre :: String,
    cantDinero :: Int,
    tactica :: String,
    propiedades :: [Propiedad],
    acciones :: [Accion]
}   deriving Show

type Propiedad = (Nombre,Precio)
type Nombre = String
type Precio = Int

---misAcciones :: Acciones
---misAcciones = [pasarPorElBanco, enojarse, gritar, subastar, cobrarAlquileres, pagarAAcionistas]

carolina :: Jugador
carolina = UnJugador { nombre = "Carolina", tactica = "Accionista", acciones = [pasarPorElBanco], cantDinero = 500, propiedades = [] }

manuel :: Jugador
manuel = UnJugador { nombre ="Manuel", tactica = "Oferente Singular", acciones = [pasarPorElBanco], cantDinero = 500, propiedades = [] }

type Accion = Jugador -> Jugador

pasarPorElBanco :: Accion 
pasarPorElBanco unJugador = (cambiarTacticaACompradorCompulsivo . agregarPlata 40) unJugador

agregarPlata :: Int -> Jugador -> Jugador
agregarPlata unaCantidad unJugador = unJugador {cantDinero = cantDinero unJugador + unaCantidad}

cambiarTacticaACompradorCompulsivo :: Jugador -> Jugador
cambiarTacticaACompradorCompulsivo unJugador = unJugador { tactica = "Comprador Compulsivo" }

enojarse :: Accion
enojarse unJugador =  (agregarAccion gritar . agregarPlata 50) unJugador

agregarAccion :: Accion -> Jugador -> Jugador
agregarAccion unaAccion unJugador = unJugador {acciones = unaAccion : acciones unJugador } 

gritar :: Accion
gritar unJugador = unJugador {nombre = "AHHHH" ++ nombre unJugador }

subastar :: Propiedad -> Accion
subastar unaPropiedad  unJugador = sumarPropiedad unaPropiedad . (restarPlata . precioPropiedad $ unaPropiedad)  $ unJugador

restarPlata :: Int -> Jugador -> Jugador
restarPlata unaCantidad unJugador = unJugador {cantDinero = cantDinero unJugador - unaCantidad}

sumarPropiedad :: Propiedad -> Jugador -> Jugador
sumarPropiedad unaPropiedad unJugador = unJugador {propiedades = propiedades unJugador ++ [unaPropiedad] }

precioPropiedad :: Propiedad -> Int
precioPropiedad (_ , precio) = precio

cobrarAlquileres :: Propiedad -> Accion
cobrarAlquileres unaPropiedad unJugador 
    | esPropiedadBarata unaPropiedad = unJugador {cantDinero = cantDinero unJugador + 10}
    | otherwise = unJugador {cantDinero = cantDinero unJugador + 20}
    
esPropiedadBarata :: Propiedad -> Bool
esPropiedadBarata unaPropiedad = precioPropiedad unaPropiedad < 150
 
pagarAAcionistas :: Accion 
pagarAAcionistas unJugador
    | esTacticaAccionista unJugador = unJugador {cantDinero = cantDinero unJugador + 200}
    | otherwise = unJugador {cantDinero = cantDinero unJugador - 100}

esTacticaAccionista :: Jugador -> Bool
esTacticaAccionista unJugador = (== "Accionista") . tactica $ unJugador 

