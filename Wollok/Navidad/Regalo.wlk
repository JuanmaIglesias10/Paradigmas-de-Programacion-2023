import Arboles.*

class Regalo {
	var precio
	const destinatario
	const precioPromedio
	
	method destinatario() = destinatario
	method precio() = precio
	
	method esTeQuierenMucho() = precio > precioPromedio 
}
