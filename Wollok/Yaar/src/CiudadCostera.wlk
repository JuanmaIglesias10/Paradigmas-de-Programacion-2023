class CiudadCostera {
	var habitantes	
	
	method nosEstanPorInvadir(unBarco) = unBarco.cantidadDeTripulantes() >= habitantes * 0.4 
	
	method puedeAnimarseASaquear(unPirata) = unPirata.nivelDeEbriedad() >= 50 
	method sumarHabitante(){ 
		habitantes += 1}
	method esVulnerableA(unBarco) = self.nosEstanPorInvadir(unBarco) or unBarco.tripulacionPasadaDeGrogXD() 

}

