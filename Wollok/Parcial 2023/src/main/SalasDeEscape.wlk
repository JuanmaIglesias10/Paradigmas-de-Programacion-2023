import Escapista.*

class SalaDeEscape {
	const nombre
	const dificultad
	
	method nombre() = nombre
	method dificultad() = dificultad
	
	method precio() = 10000
	method esSalaDificil() = dificultad > 7
	
	/* method puedeSalir(unGrupo) = unGrupo.puedenSalirDe(self)
	A mi me parecio bueno agregar este metodo para chequear desde la sala de escape si un grupo puede salir de ella
	igualmente lo dejo comentado */
}

class SalaDeAnime inherits SalaDeEscape {
	
	override method precio() = super() + 7000
}

class SalaDeHistoria inherits SalaDeEscape {
	var basadaEnHechosReales 
	
	method basadaEnHechosReales(unValorBooleano){
	basadaEnHechosReales = unValorBooleano
}
	
	override method precio() = super() + dificultad * 0.314
	override method esSalaDificil() = super() and not self.basadaEnHechosReales(true) 
} 

class SalaDeTerror inherits SalaDeEscape {
	var cantidadDeSustos
	
	method cantidadDeSustos(unaCantidad) {
		cantidadDeSustos = unaCantidad
	}
	
	method haySuficientesSustos() = cantidadDeSustos > 5
	
	override method precio() {
		if (self.haySuficientesSustos()) {
			return super() + cantidadDeSustos * 0.2
		}
		    return super()}
	
	override method esSalaDificil() = super() or self.haySuficientesSustos()
}