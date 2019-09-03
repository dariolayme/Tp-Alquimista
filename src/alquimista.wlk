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
  	return self.calidadPromedioDeTodosLosItems() > 50 && self.bienEquipado() && self.esBuenExplorador()
  }
  
  method calidadPromedioDeTodosLosItems() {
  	
  	return self.calidadTotalDeSusItems() / (itemsDeCombate.size() + itemsDeRecoleccion.size())
  }
  
  method calidadTotalDeSusItems() {
  	return self.calidadTotalDeItems(itemsDeCombate) + self.calidadTotalDeItems(itemsDeRecoleccion)
  }
  
  method calidadTotalDeItems(items) {
  	return items.sum({
  		item => item.calidad()
  	})  	
  }
  
  method bienEquipado() {
  	return itemsDeCombate.all({
  		item => item.esEfectico()
  	})
  }
  
		
} //%%%%% Fin alquimista %%%%%%


object bomba {
  var danio = 150
  
  method esEfectivo() {
    return danio > 100
  }
  
  method capacidad() {
  	return danio/2
  } 
} //%%%%% Fin bomba %%%%%%


object pocion {
  var materiales = []
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
  
} //%%%%% Fin pocion %%%%%%


object debilitador {
  var materiales = []
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

}//%%%%% Fin Debilitador %%%%%% 


object florRoja {
	var mistico = false
	
	method esMistico() {
		return mistico
	}
}

object uni {
	var mistico = true
	
	method esMistico() {
		return mistico
	}
}

object polvora {
	var mistico = false
	
	method esMistico() {
		return mistico
	}
}

