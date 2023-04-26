import Text.Show.Functions ()

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
