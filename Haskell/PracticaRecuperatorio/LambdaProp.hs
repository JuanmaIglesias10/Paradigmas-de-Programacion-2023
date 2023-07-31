import Text.Show.Functions ()

type Barrio = String
type Mail = String
type Requisito = Depto -> Bool
type Busqueda = [Requisito]

data Depto = Depto {
 ambientes :: Int,
 superficie :: Int,
 precio :: Int,
 barrio :: Barrio
} deriving (Show, Eq)

data Persona = Persona {
   mail :: Mail,
   busquedas :: [Busqueda]
}

ordenarSegun _ [] = []
ordenarSegun criterio (x:xs) =
 (ordenarSegun criterio . filter (not . criterio x)) xs ++
 [x] ++
 (ordenarSegun criterio . filter (criterio x)) xs

between :: Ord a => a -> a -> a -> Bool
between cotaInferior cotaSuperior valor =
 valor <= cotaSuperior && valor >= cotaInferior

deptosDeEjemplo :: [Depto]
deptosDeEjemplo = [
 Depto 3 80 7500 "Palermo",
 Depto 1 45 3500 "Villa Urquiza",
 Depto 2 50 5000 "Palermo",
 Depto 1 45 5500 "Recoleta"]

depto1 :: Depto
depto1 = Depto 3 80 7500 "Palermo"

ubicadoEn :: [Barrio] -> Requisito
ubicadoEn unosBarrios unDepto = elem (barrio unDepto) unosBarrios

cumpleRango :: Ord a => (Depto -> a) -> a -> a -> Requisito
cumpleRango unaFuncion cotaInferior cotaSuperior = between cotaInferior cotaSuperior . unaFuncion

cumpleBusqueda :: Busqueda -> Depto -> Bool
cumpleBusqueda unaBusqueda unDepto = all (\requisito -> requisito unDepto) unaBusqueda

buscar :: Busqueda -> (Depto -> Depto -> Bool) -> [Depto] -> [Depto]
buscar unaBusqueda criterio = ordenarSegun criterio . filter (cumpleBusqueda unaBusqueda)

mailsDePersonasInteresadas :: Depto -> [Persona] -> [Mail]
mailsDePersonasInteresadas unDepto = map mail . filter (any (`cumpleBusqueda` unDepto) . busquedas) 
