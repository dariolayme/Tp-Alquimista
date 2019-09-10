object alquimista {
  var itemsDeCombate = []
  var itemsDeRecoleccion = []
  
  method itemsDeCombate(lista) {
  	itemsDeCombate = lista
  }
  
  method itemsDeRecoleccion(lista) {
  	itemsDeRecoleccion = lista
  }
  
  /*%%%%% PUNTO 1 %%%%%*/
  method tieneCriterio() {
    return self.cantidadDeItemsDeCombateEfectivos() >= self.cantidadDeItemsDeCombate() / 2
  }
  
  method cantidadDeItemsDeCombate() {
    return itemsDeCombate.size()
  }
  
  method cantidadDeItemsDeCombateEfectivos() {
    return itemsDeCombate.count({ itemDeCombate =>
      itemDeCombate.esEfectivo()
    })
  }
  
  
  /*%%%%% PUNTO 2 %%%%%*/
  method esBuenExplorador () {
  	return self.cantidadSinRepetir(itemsDeRecoleccion) >=3
  }
		
  method cantidadSinRepetir(lista) {
	return lista.asSet().size()
  }
  
  
  /*%%%%% PUNTO 3 %%%%%*/		
  method capacidadOfensiva() {
  	return itemsDeCombate.sum({
   		itemDeCombate => itemDeCombate.capacidad()
  	})
  }	
  
  
  
  
  /*%%%%% PUNTO 4 %%%%%*/
  method esProfesional() {
  	return self.calidadPromedioDeTodosLosItems() > 50 && self.bienEquipado()/* */ && self.esBuenExplorador()
  }
  
  //bienEquipado() = Que todo sus items de Combate sean Efectivos //
  
  method calidadPromedioDeTodosLosItems() {
  	
  	return self.calidadTotalDeSusItems() / (itemsDeCombate.size() + itemsDeRecoleccion.size())
  }
  
  method calidadTotalDeSusItems() {
  	return self.calidadTotalDe(itemsDeCombate) + self.calidadTotalDe(itemsDeRecoleccion)
  }
  
  method calidadTotalDe(items) {
  	return items.sum({
  		item => item.calidad()
  	})  	
  }
  
  method bienEquipado() {
  	return itemsDeCombate.all({
  		item => item.esEfectivo()
  	})
  }
  
		
} //%%%%% Fin alquimista %%%%%%


object bomba {
  var danio = 150
  var materiales = [florRoja, uni, polvora]
  
  method esEfectivo() {
    return (danio > 100)
  }
  
  method capacidad() {
  	return danio/2
  } 
  
  method calidad() {
  	return materiales.min({
  		material => material.calidad()
  	})
  }
} //%%%%% Fin bomba %%%%%%


object pocion {
  var materiales = [uni, florRoja]
  var poderCurativo = 20
  
  method esEfectivo() {
    return poderCurativo > 50 and self.fueCreadaConAlgunMaterialMistico()
  }
  
  method fueCreadaConAlgunMaterialMistico() {
    return materiales.any({ material =>
      material.esMistico()
    })
  }
  method capacidad() {
  	return poderCurativo + 10* self.cantidadDeMaterialesMisticosQueContiene()
  }
  
  method cantidadDeMaterialesMisticosQueContiene() {
  	return materiales.count({
  		material => material.esMistico()
  	})
  	
  }
  
  method calidad() {
  	if ( self.fueCreadaConAlgunMaterialMistico() ){
  		
  		return materiales.find({
  			material => material.esMistico()
  		}).calidad()
  	}
  	else{
  		return materiales.head().calidad()
  	}
  }
  
} //%%%%% Fin pocion %%%%%%


object debilitador {
  var materiales = [florRoja,florRoja]
  var potencia = 0
  
  method esEfectivo() {
    return potencia > 0 and self.fueCreadoPorAlgunMaterialMistico().negate()
  }
  
  method fueCreadoPorAlgunMaterialMistico() {
    return materiales.any({ material =>
      material.esMistico()
    })
  }
  
  method cantidadDeMaterialesMisticosQueContiene() {
  	
  	return materiales.count({
  		material => material.esMistico()
  	})
  	
  }
  
  method capacidad() {
  	if (self.fueCreadoPorAlgunMaterialMistico()){
  		return self.cantidadDeMaterialesMisticosQueContiene()*12
  	}
  	else {
  		return 5
  	}

  }
  
  method calidad() {
  	var calidadesDeMaterial = materiales.sortedBy({
  		material1, material2 => material1.calidad() < material2.calidad()
  	}).map({
  		material => material.calidad()
  	})
  	
  	return calidadesDeMaterial.take(2).sum() / 2 
  }

}//%%%%% Fin Debilitador %%%%%% 



//%%%%% Materiales %%%%%%

object florRoja {
	var calidad = 2
	var mistico = false
	
	method esMistico() {
		return mistico
	}
	method calidad() {
		return calidad
	}
}

object uni {
	var calidad = 12
	var mistico = true
	
	method calidad() {
		return calidad
	}
	
	method esMistico() {
		return mistico
	}
}

object polvora {
	var calidad = 22
	var mistico = false
	
	method esMistico() {
		return mistico
	}
	method calidad() {
		return calidad
	}
}


//%%%%% Items de Recoleccion %%%%%%

object caniaDePescar {
	
} 

object bolsaDeVientoMagica {
	
}
object redParaInsectos {
	
}

