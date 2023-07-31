import Text.Show.Functions ()

data Persona = Persona {
  nombrePersona :: String,
  suerte :: Int,
  inteligencia :: Int,
  fuerza :: Int
} deriving (Show, Eq)

data Pocion = Pocion {
  nombrePocion :: String,
  ingredientes :: [Ingrediente]
}

type Efecto = Persona -> Persona

data Ingrediente = Ingrediente {
  nombreIngrediente :: String,
  efectos :: [Efecto]
}

nombresDeIngredientesProhibidos :: [String]
nombresDeIngredientesProhibidos = [
 "sangre de unicornio",
 "veneno de basilisco",
 "patas de cabra",
 "efedrina"]


--- 1a ---

niveles :: Persona -> [Int]
niveles persona = [fuerza persona, suerte persona, inteligencia persona]

sumaDeNiveles :: Persona -> Int
sumaDeNiveles = sum . niveles  

--- 1b ---

diferenciaDeNiveles :: Persona -> Int
diferenciaDeNiveles persona = maximoNivel persona `subtract` minimoNivel persona 

maximoNivel :: Persona -> Int
maximoNivel = maximum . niveles

minimoNivel :: Persona -> Int
minimoNivel = minimum . niveles

--- 1c ---

nivelesMayoresA :: Int -> Persona -> Int
nivelesMayoresA unN = length . filter (> unN) . niveles

--- 2 ---

efectosDePocion :: Pocion -> [Efecto]
efectosDePocion  = concat . map efectos  . ingredientes

--- 3a ---

pocionesHardcore :: [Pocion] -> [String]
pocionesHardcore  = map nombrePocion . filter ((>=4) . length . efectosDePocion)

--- 3b ---

cantidadDePocionesProhibidas :: [Pocion] -> Int
cantidadDePocionesProhibidas = length . filter esProhibida

esProhibida :: Pocion -> Bool
esProhibida = any ( flip elem nombresDeIngredientesProhibidos . nombreIngrediente) . ingredientes

--- 3c ---

sonTodasDulces :: [Pocion] -> Bool
sonTodasDulces = all esDulce

esDulce :: Pocion -> Bool
esDulce = any ((=="azucar") . nombreIngrediente) . ingredientes

--- 4 ---

tomarPocion :: Pocion -> Persona -> Persona
tomarPocion unaPocion unaPersona = foldr ($) unaPersona (efectosDePocion unaPocion)

--- 5 ---

esAntidotoDe :: Pocion -> Pocion -> Persona -> Bool
esAntidotoDe primeraPocion segundaPocion unaPersona = (== unaPersona) . tomarPocion segundaPocion . tomarPocion primeraPocion $ unaPersona

--- 6 ---

personaMasAfectada :: Pocion -> (Persona -> Int) -> [Persona] -> Persona
personaMasAfectada unaPocion criterio  = maximoSegun (criterio . tomarPocion unaPocion) 

maximoSegun :: Ord b => (a -> b) -> [a] -> a
maximoSegun _ [ x ] = x
maximoSegun  f ( x : y : xs)
  | f x > f y = maximoSegun f (x:xs)
  | otherwise = maximoSegun f (y:xs)