import SalasDeEscape.*
import Escapista.*

object amateur {
		
	method condicionParaQuePuedaSalir(unEscapista,unaSala) = not unaSala.esSalaDificil() and unEscapista.hizoMuchasSalas()
	method puedeSubirDeNivel() = true
}

object profesional {
	method condicionParaQuePuedaSalir(unEscapista,unaSala) = true
	method puedeSubirDeNivel() = false
}