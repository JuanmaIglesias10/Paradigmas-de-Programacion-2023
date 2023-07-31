import Text.Show.Functions 


type Titulo = String
type Autor = String
type CantidadDePaginas = Int
type Libro = (Titulo, Autor, CantidadDePaginas)

elVisitante :: Libro
elVisitante = ("El Visitante", "Stephen King", 592)

shingekiNoKyojin1 :: Libro
shingekiNoKyojin1 = ("Shingeki no Kyojin 1", "Hajime Isayama", 40)

shingekiNoKyojin3 :: Libro
shingekiNoKyojin3 = ("Shingeki no Kyojin 3", "Hajime Isayama", 40)

shingekiNoKyojin27 :: Libro
shingekiNoKyojin27 = ("Shingeki no Kyojin 27", "Hajime Isayama", 40)

fundacion :: Libro
fundacion = ("Fundacion", "Isaac Asimov", 230)

sandman5 :: Libro
sandman5 = ("sandman5", "Neil Gaiman", 35)

sandman10 :: Libro
sandman10 = ("sandman10", "Neil Gaiman", 35)

sandman12 :: Libro
sandman12 = ("sandman12", "Neil Gaiman", 35)

eragon :: Libro
eragon = ("eragon", "Christopher Paolini", 544)

eldest :: Libro
eldest = ("eldest", "Christopher Paolini", 704)

brisignr :: Libro
brisignr = ("brisignr", "Christopher Paolini", 700)

legado :: Libro
legado = ("legado", "Christopher Paolini", 811)

type Biblioteca = [Libro]

miBiblioteca :: Biblioteca
miBiblioteca = [elVisitante, shingekiNoKyojin1, shingekiNoKyojin3, shingekiNoKyojin27, fundacion, sandman5, sandman10, sandman12, eragon, eldest, brisignr, legado]

promedioDePaginas :: Biblioteca -> Int
promedioDePaginas unaBiblioteca = (cantidadDePaginasTotales unaBiblioteca) `div` (cantidadDeLibros unaBiblioteca) 
 
cantidadDePaginasTotales :: Biblioteca -> Int
cantidadDePaginasTotales unaBiblioteca = sum . map paginasDeUnLibro $ unaBiblioteca

paginasDeUnLibro :: Libro -> Int
paginasDeUnLibro (_, _, paginas) = paginas

cantidadDeLibros :: Biblioteca -> Int
cantidadDeLibros unaBiblioteca = length unaBiblioteca

lecturaObligatoria :: Libro -> Bool
lecturaObligatoria unLibro = esDeStephenKing unLibro || esDeFundacion unLibro || esDeLaSagaDeEragon unLibro

esDeStephenKing :: Libro -> Bool
esDeStephenKing unLibro = (== "Stephen King") . autorDeUnLibro $ unLibro

autorDeUnLibro :: Libro -> String
autorDeUnLibro (_, autor, _) = autor

esDeFundacion :: Libro -> Bool
esDeFundacion unLibro = unLibro == fundacion

nombreDeUnLibro :: Libro -> String
nombreDeUnLibro (nombre, _, _) = nombre

esDeLaSagaDeEragon :: Libro -> Bool
esDeLaSagaDeEragon unLibro = (== "Christopher Paolini") . autorDeUnLibro $ unLibro

esFantasiosa :: Biblioteca -> Bool
esFantasiosa unaBiblioteca = any esLibroFantasioso unaBiblioteca

esLibroFantasioso :: Libro -> Bool
esLibroFantasioso unLibro = esDe "Christopher Paolini" unLibro || esDe "Neil Gaiman" unLibro 

esDe :: Autor -> Libro -> Bool
esDe unAutor unLibro = (== unAutor) . autorDeUnLibro $ unLibro

nombreDeLaBiblioteca :: Biblioteca -> String
nombreDeLaBiblioteca unaBiblioteca = eliminarVocales . concatenarLosTitulos $ unaBiblioteca

eliminarVocales :: String -> String
eliminarVocales unString = filter (not . esVocal) unString

esVocal :: Char -> Bool
esVocal unCaracter = elem unCaracter "aeiouAEIOUÁÉÍÓÚáéíóú" 

concatenarLosTitulos :: Biblioteca -> String
concatenarLosTitulos unaBiblioteca = concatMap nombreDeUnLibro unaBiblioteca

esBibliotecaLigera :: Biblioteca -> Bool
esBibliotecaLigera unaBiblioteca = all (tieneMenos40Paginas) unaBiblioteca

tieneMenos40Paginas :: Libro -> Bool
tieneMenos40Paginas unLibro = (< 40) . paginasDeUnLibro $ unLibro 