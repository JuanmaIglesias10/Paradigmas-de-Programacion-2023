import Pirata.*
import BarcoPirata.*
import CiudadCostera.*

class Mision {
	
	method esUtil(unPirata)
	method puedeSerRealizadaPor(unBarco) = unBarco.tieneSuficienteTripulacion()

}

class BusquedaDelTesoro inherits Mision {
	
	method noTieneMasDe5Monedas(unPirata) = unPirata.numeroDeMonedas() <= 5
	method tieneElItemNecesario(unPirata) = unPirata.tiene("brujula") || unPirata.tiene("mapa") || unPirata.tiene("botella de grogXD") 
	
	override method esUtil(unPirata) = self.noTieneMasDe5Monedas(unPirata) and self.tieneElItemNecesario(unPirata)
	override method puedeSerRealizadaPor(unBarco) = super(unBarco) and  unBarco.hayUnaLlaveDeCofre()
}

class ConvertirseEnLeyenda inherits Mision {
	const itemObligatorio
	
	method tiene10items(unPirata) = unPirata.itemsDisponibles().size() >= 10
	method tieneElItemObligatorio(unPirata) = unPirata.tiene(itemObligatorio)
	
	override method esUtil(unPirata) = self.tiene10items(unPirata) and self.tieneElItemObligatorio(unPirata) 	
}

class Saqueo inherits Mision{
	var cantidadDeMonedas
	const objetivo 
	
	method cuentaConMenosDinero(unPirata) = unPirata.numeroDeMonedas() < cantidadDeMonedas
	
	override method esUtil(unPirata) = objetivo.puedeAnimarseASaquear(unPirata)
	override method puedeSerRealizadaPor(unBarco) = super(unBarco) and objetivo.esVulnerableA(unBarco) 
}