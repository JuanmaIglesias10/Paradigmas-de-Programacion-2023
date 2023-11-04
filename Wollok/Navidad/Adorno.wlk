class Adorno {
	const pesoBase
	const coeficienteDeSuperioridad
		
	method importancia() = coeficienteDeSuperioridad * pesoBase
	method peso() = pesoBase
}

class Luz inherits Adorno {
	const cantidadDeLamparitas
	
	method luminosidad() = cantidadDeLamparitas
	override method importancia() = super() * self.luminosidad()
}

class FiguraElaborada inherits Adorno {
	const volumen
	
	override method importancia() = super() * volumen
}

class Guirnalda inherits Adorno {
	const anioDeCompra
	
	method aniosEnUso() = 2023 - anioDeCompra
	method pelosPerdidos() = 100 * self.aniosEnUso()
	override method peso()= pesoBase -  self.pelosPerdidos()
}