class Pirata {
 	var nivelDeEbriedad
    var numeroDeMonedas = 10
    const itemsDisponibles = []
    const invitadoPor 

	method nivelDeEbriedad() = nivelDeEbriedad
	method numeroDeMonedas() = numeroDeMonedas
	method itemsDisponibles()= itemsDisponibles
	method invitadoPor()     = invitadoPor

	method tiene(unItem) = itemsDisponibles.contains(unItem)
	method estaPasadoDeGrogXD() = nivelDeEbriedad >= 90
	method esUtilParaLaMisionDe(unBarco) = unBarco.mision().esUtil(self) 
	method aumentarNivelDeEbriedad(unaCantidad){
		nivelDeEbriedad += unaCantidad}
	method gastarMonedas(unaCantidad){
		numeroDeMonedas -= unaCantidad}
	method tomarUnTragoDeGrogXD() {
		self.aumentarNivelDeEbriedad(5)
		self.gastarMonedas(1)
	}
	method tieneUnaLlaveDeCofre() = itemsDisponibles.contains("Llave de cofre")
	method meInvito(unTripulante) = invitadoPor == unTripulante
	
	method seAnimaASaquear(unObjetivo) = unObjetivo.puedeAnimarseASaquear(self)
	method puedeFormarParteDeLaTripulacion(unBarco) = unBarco.tieneLugarDisponible() and self.esUtilParaLaMisionDe(unBarco) 
	
}

class EspiaDeLaCorona inherits Pirata{
	override method estaPasadoDeGrogXD() = false
	override method seAnimaASaquear(unObjetivo) = super(unObjetivo) and self.tiene("permiso de la corona")

}