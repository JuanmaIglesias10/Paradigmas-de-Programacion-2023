import SalasDeEscape.*
import maestrias.*

class NoPuedesSubirDeNivel inherits Exception{}

class Escapista {
	var maestria
	const salasQueSalio = []
	var saldo
	
	method saldo() = saldo	
	method maestria() = maestria
	method salasQueSalio() = salasQueSalio
	
	method subirMaestria(unaMaestria){
		maestria = unaMaestria
	} 
	method cantidadDeSalasQueSalio() = salasQueSalio.size()
	method hizoMuchasSalas() = self.cantidadDeSalasQueSalio() >= 6
	method cumpleLasCondicionesParaSubir() = maestria.puedeSubirDeNivel() and self.hizoMuchasSalas()
	method agregarNuevaSala(unaSala) {
		salasQueSalio.add(unaSala)
	}
	method pagar(unaCantidad) {
		saldo -= unaCantidad
	}

	method puedeSalir(unEscapista,unaSala) = maestria.condicionParaQuePuedaSalir(unEscapista,unaSala)
	method subirNivelDeMaestria(){
		 if (self.cumpleLasCondicionesParaSubir()) {
		 	self.subirMaestria(profesional)
		 }
		 throw new NoPuedesSubirDeNivel(message = "Estas en el maximo nivel, o simplemente no hiciste muchas salas!")}
	method nombreDeLasSalasQueSalio() = salasQueSalio.map{sala => sala.nombre()}.asSet()
}

