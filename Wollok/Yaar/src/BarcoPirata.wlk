class ElPirataNoPuedeIncorporarse inherits Exception{}

class BarcoPirata {
	var mision
    var tripulantes = #{}
    const capacidad
	
	method cantidadDeTripulantes() = tripulantes.size()
	method mision() = mision
	method reemplazarMision(unaNuevaMision) {
		mision = unaNuevaMision
	}
	method tieneLugarDisponible() = self.cantidadDeTripulantes() < capacidad
	method nuevosTripulantes(unosTripulantes){
		tripulantes = unosTripulantes
	}
	method echarALosTripulantesQueNoSirven(unaNuevaMision) {
		self.nuevosTripulantes(tripulantes.filter{pirata => unaNuevaMision.esUtil(pirata)})}
	method todosTomanUnTragoDeGrogXD() {
		tripulantes.forEach{pirata => pirata.tomarUnTragoDeGrogXD()}
	}
	method sePierdeElMasEbrio(){
		tripulantes.remove(self.pirataMasEbrio())
	}
	method tieneSuficienteTripulacion() = self.cantidadDeTripulantes() * 0.9 > capacidad
	method hayUnaLlaveDeCofre() = tripulantes.any{pirata => pirata.tieneUnaLlaveDeCofre()}
	method esVulnerableA(unBarco) = self.cantidadDeTripulantes() <= unBarco.cantidadDeTripulantes() / 2
	method tripulacionPasadaDeGrogXD() = tripulantes.all{pirata => pirata.estaPasadoDeGrogXD()}
	method pasadosDeGrogXD() = tripulantes.filter{pirata => pirata.estaPasadoDeGrogXD()}
	method itemsPasadosDeGrogXDDistintos()= self.pasadosDeGrogXD().map{pirata => pirata.itemsDisponibles()}.asSet()
	method tripulanteMasRico(unosTripulantes) = unosTripulantes.max{pirata => pirata.numeroDeMonedas()}
	method cantidadDeTripulantesQueInvito(unTripulante) = tripulantes.count{pirata => pirata.meInvito(unTripulante)}
	
	method puedeAnimarseASaquear(unPirata) = unPirata.estaPasadoDeGrogXD()
	method incorporarALaTripulacion(unPirata){
		if (unPirata.puedeFormarParteDeLaTripulacion(self)){
			tripulantes.add(unPirata)}
		throw new ElPirataNoPuedeIncorporarse(message = "El pirata no cumple con las condiciones de ser incorporado")
	}
	method cambiarDeMision(unaNuevaMision) {
		self.reemplazarMision(unaNuevaMision)
		self.echarALosTripulantesQueNoSirven(unaNuevaMision)
	}	
	method pirataMasEbrio() = tripulantes.max{pirata => pirata.nivelDeEbriedad()}
	method anclarEnCiudadCostera(unaCiudad) {
		self.todosTomanUnTragoDeGrogXD()
		self.sePierdeElMasEbrio()
		unaCiudad.sumarHabitante()
	}
	method esTemible() = mision.puedeSerRealizadaPor(self)
	method cantidadDePasadosDeGrogXD() = self.pasadosDeGrogXD().size()
	method cantidadItemsPasadosDeGrogXDDistintos() = self.itemsPasadosDeGrogXDDistintos().size()
	method tripulantePasadoDeGrogXDMasRico() = self.tripulanteMasRico(self.pasadosDeGrogXD())
	method tripulanteQueMasInvito() = tripulantes.max{tripulante => self.cantidadDeTripulantesQueInvito(tripulante)}
}


