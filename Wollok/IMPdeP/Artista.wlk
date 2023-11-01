class NoEsPosibleRecategorizarse inherits Exception{}
class YaSosUnaEstrella inherits Exception{}

class Artista {
	var experiencia
	var cantidadDePeliculasQueActuo
	var ahorros
	
	method cantidadDePeliculasQueActuo() = cantidadDePeliculasQueActuo
	method experiencia() = experiencia
	method incrementarAhorros(unaCantidad){
		ahorros += unaCantidad
	}
	method actualizarCantidadDePeliculas(unaCantidad){
		cantidadDePeliculasQueActuo += unaCantidad
	}
   	
	method sueldo(unArtista){
		return experiencia.sueldo(unArtista)
	}
	
	method recategorizar() {
		experiencia = experiencia.experienciaRecategorizable(self)
	}
	
	method actuar() {
		self.actualizarCantidadDePeliculas(1) 
		self.incrementarAhorros(self.sueldo(self)) 
	}
	
}	

object amateur {
	
	method sueldo(unArtista) {
		return 10000
	}
	
	method experienciaRecategorizable(unArtista) {
		if (unArtista.cantidadDePeliculasQueActuo() > 10){
			return establecido
		}
		else {
			throw new NoEsPosibleRecategorizarse(message = "No cumples con la cantidad adecuada de peliculas para establecerte") 
		}
	}
}

object establecido {
	
	method nivelDeFama(unArtista){
		return unArtista.cantidadDePeliculasQueActuo()/ 2
	}
	
	method nivelDeFamaSuficiente(unArtista, famaMinima) {
    	return unArtista.nivelDeFama() >= famaMinima
}
	
	method sueldo(unArtista) {
		if(self.nivelDeFamaSuficiente(unArtista,15)){
			return 5000 * self.nivelDeFama(unArtista)
		}
		else {
			return 15000
		}
	}
	
	method experienciaRecategorizable(unArtista) {
		if(self.nivelDeFamaSuficiente(unArtista,10)) {
			return estrella
		}
		else {
			throw new NoEsPosibleRecategorizarse(message = "No cumples con el nivel de fama necesario para ser estrella")
		}
	}	
}

object estrella {
	method sueldo(unArtista) {
		return 30000 * unArtista.cantidadDePeliculasQueActuo()
	}
	
	method experienciaRecategorizable(unArtista) {
			throw new YaSosUnaEstrella(message = "Llegaste al nivel maximo de experiencia, felicidades :D!")
		}
}
