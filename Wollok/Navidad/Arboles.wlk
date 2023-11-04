import Adorno.*
import Regalo.*
import Tarjeta.* 

class NoHayMasCapacidad inherits Exception{}

class ArbolNavidenio {
	var regalos = #{}
	const tarjetas = #{}
	const adornos = #{}

	method capacidadParaContenerRegalos()
	method hayCapacidadParaAgregar(unRegalo) = regalos.size() < self.capacidadParaContenerRegalos()  
	method precioTotalRegalos() = regalos.sum{regalo => regalo.precio()}
	method teQuierenDemasiado() = regalos.filter{regalo => regalo.esTeQuierenMucho()}.size() > 5
	method tieneUnaTarjetaCara() = tarjetas.any{tarjeta => tarjeta.valorAdjunto() > 1000}
		
	method agregarUnRegalo(unRegalo) {
		if (self.hayCapacidadParaAgregar(unRegalo)){
			regalos.add(unRegalo)
		}
		throw new NoHayMasCapacidad(message = "No hay mas capacidad para contener regalos en el arbol!")
	}
	method beneficiarios() {
		const beneficiariosRegalos = regalos.map{regalo => regalo.destinatario()}
		const beneficiariosTarjetas = tarjetas.map{tarjeta => tarjeta.destinatario()}
		return beneficiariosRegalos + beneficiariosTarjetas
	}
	method costoTotalRegalos() = self.precioTotalRegalos()
	method importanciaAdornosDelArbol() = adornos.sum{adorno => adorno.importancia()}
	method esArbolPortentoso() = self.teQuierenDemasiado() or self.tieneUnaTarjetaCara()
	method adornoMasPesado() = adornos.max{adorno => adorno.peso()}  

} 
class ArbolNatural inherits ArbolNavidenio {
	var vejez
	var tamanioTronco
	
	override method capacidadParaContenerRegalos() = vejez * tamanioTronco
}

class ArbolArtificial inherits ArbolNavidenio {
	var cantidadDeVaras
	
	override method capacidadParaContenerRegalos() = cantidadDeVaras
}