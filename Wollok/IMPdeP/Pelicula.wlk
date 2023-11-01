import Artista.*

class Pelicula {
	const nombre
	const elenco = []

	method elenco() = elenco
	method nombre() = nombre

	method sueldoTotalDelElenco() {
		return elenco.sum{artista => artista.sueldo(artista)}
	}
	
	method presupuesto() {
		return self.sueldoTotalDelElenco() * 1.7 
	}

	method ganancia() {
		return self.recaudacion() - self.presupuesto()
	}
	
	method recaudacion() = 1000000
	
	method rodar() {
		elenco.forEach{artista => artista.actuar()}
	}
}

class Drama inherits Pelicula {
	
	method recaudacionAdicional() {
		return nombre.size() * 1000000
	}
	
	override method recaudacion() {
		return super() + self.recaudacionAdicional()
	}
}

class Accion inherits Pelicula {
	const vidriosRotos
	
	method recaudacionAdicional() {
		return 50000 * elenco.size()
	}
	
	override method presupuesto(){
		return super() + 100000 * vidriosRotos
	}
	
	override method recaudacion() {
		return super() + self.recaudacionAdicional()
	}
}

class Terror inherits Pelicula {
	const cantidadDeCuchos
	
	method recaudacionAdicional() {
		return cantidadDeCuchos * 20000
	}
	
	override method recaudacion() {
		return super() + self.recaudacionAdicional()
	}
}