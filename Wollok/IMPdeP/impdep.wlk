import Pelicula.*
import Artista.*


object impdep {
	
	method mejorSueldo(unosArtistas) {
		return unosArtistas.max{artista => artista.sueldo()}
	}
	
	method peliculasEconomicas(unasPeliculas) {
		return unasPeliculas.filter{unaPelicula => unaPelicula.presupuesto()< 500000}
	}
	
	method nombresDePeliculasEconomicas(unasPeliculas) {
		return self.peliculasEconomicas(unasPeliculas).map{unaPelicula => unaPelicula.nombre()}
	}
	
	method gananciasDePeliculasEconomicas(unasPeliculas){
		return self.peliculasEconomicas(unasPeliculas).sum{unaPelicula => unaPelicula.ganancia()}
	}
	
	method recategorizarArtistas(unosArtistas) {
		unosArtistas.forEach{artista => artista.recategorizar()}
	}
}


