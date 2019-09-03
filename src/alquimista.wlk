object alquimista {
  var itemsDeCombate = []
  var itemsDeRecoleccion = []
  
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
  
		
}