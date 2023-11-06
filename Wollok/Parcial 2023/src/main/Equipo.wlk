import SalasDeEscape.*
import Escapista.*

class NoPudieronPagar inherits Exception{}

class Equipo {
	const integrantes = #{}
	
	method puedenSalirDe(unaSala) = integrantes.any{unEscapista => unEscapista.puedeSalir(unEscapista,unaSala)}
	method quienesPuedenPagar(unaSala) = integrantes.filter{escapista => escapista.saldo() >= unaSala.precio()}
	method todosPuedenPagar(unaSala) = integrantes.all{escapista => escapista.saldo() >= unaSala.precio() }
	method sonSolidarios(unaSala) = self.quienesPuedenPagar(unaSala).sum{escapista => escapista.saldo()} >= unaSala.precio()
	method condicionesDePago(unaSala) = self.todosPuedenPagar(unaSala) or self.sonSolidarios(unaSala)
	method lograronEscapar(unaSala) {
		integrantes.forEach{escapista => escapista.agregarNuevaSala(unaSala)}
	}
	method cantidadAPagarCadaUno(unaSala) = unaSala.precio() / integrantes.size()
	method pagar(unaSala) {
		integrantes.forEach{escapista => escapista.pagar(self.cantidadAPagarCadaUno(unaSala))}
	} /// El error decidi ponerlo en el metodo escapar, me parecia mejor
	
	method puedenPagar(unaSala) = self.condicionesDePago(unaSala)
	method escapar(unaSala) {
		if (self.puedenPagar(unaSala)){
			self.pagar(unaSala)
			self.lograronEscapar(unaSala)
		}
		throw new NoPudieronPagar(message = "Lamentablemente esta sala es muy cara")
	}
}
