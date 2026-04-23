object rolando {
    var capacidadMaxima = 2
    var ubicacion = castilloDePiedra
    var poderBase = 0
    const morada = castilloDePiedra

    const artefactos = #{}

    const historial = []

    method poderBase(){
        return poderBase
    }

    method morada(){
        return morada
    }

    method agregarArtefacto(artefacto){

        historial.add(artefacto)
        if (self.puedeLevantar()){
            artefactos.add(artefacto)
        }else{
            self.error("La mochila está llena.")
        }
    }

    method puedeLevantar(){
        return artefactos.size() < capacidadMaxima 
    } 

    method ubicacion(){
        return ubicacion
    }

    method ubicacion(_ubicacion){

        ubicacion = _ubicacion        
    
    }

    method dejarArtefactos(){
        
        ubicacion.agregarArtefactos(artefactos)
        artefactos.clear()

    }

    method todosLosArtefactos(){

        return artefactos.union(ubicacion.artefactos())
    }

    method tieneArtefacto(artefacto){
        return self.todosLosArtefactos().contains(artefacto)
    }

    method historial(){
        return historial
    }
}

object espadaDelDestino{
    var fueUsada = false

    method poderQueAporta(pj){
        if ( fueUsada ){
            return pj.poder() / 2
             
        } else{
            return pj.poder(

            )
        }
    }

    method usarArtefacto(pj){
        if ( fueUsada ){
            return pj.poder() / 2
             
        } else{
            fueUsada = true
            return pj.poder()
        }
    }
}

object libroDeHechicos{

    const hechizos = []

    method hechizos(){
        return hechizos
    }

    method agregarHechizo(hechizo){
        hechizos.add(hechizo)
    }

    method poderQueAporta(personaje){

        if ( self.hechizos().isEmpty() ){
             return 0
        } else {



           return self.hechizos().head().poderQueAporta(personaje)

            
        }
    }

    method eliminarPrimerHechizo(){

        hechizos.remove( hechizos.head() )
    }

    method usarHechizo(personaje){

        if (hechizos.isEmpty() ){
            self.error("No hay hechizos disponibles.")
        }else{
        self.poderQueAporta(personaje) // ???? solo retorna un numero.
        self.eliminarPrimerHechizo()
        }
    }
}

object bendicion{
    const poder = 4

    method poderQueAporta(){
        return poder
    }

}

object invisibilidad{

    method poderQueAporta(pj){
        return pj.poderBase()
    }

}

object invocacion{

    method poderQueAporta(personaje){

        return personaje.morada().artefactoMasPoderoso(personaje).poderQueAporta()
    }


}

object collarDivino{
    var cantidadBatallas = 0
    const puntos = 3

    method poderQueAporta(pj){

        if ( pj.poder() > 6 ){
            return puntos + cantidadBatallas
        } else{
            return puntos
        }
    }

    method usarArtefacto(pj){

        if ( pj.poder() > 6 ){
            return puntos + cantidadBatallas
        } else{
            return puntos
        }
    
        cantidadBatallas = cantidadBatallas + 1
    }
}

object armaduraDeAcero{
    const poder = 6

    method poderQueAporta(){
        return poder
    }
    
    method usarArtefacto(){
        return poder
    }
}

object castilloDePiedra{

    const artefactos = #{}

    method artefactos(){
        return artefactos
    }

    method agregarArtefactos(artefactosNuevos){
        artefactos.addAll(artefactosNuevos)
    }

    method agregarArtefacto(artefacto){
        artefactos.add(artefacto)
    }

    method artefactoMasPoderoso(personaje){

        return artefactos.max({ artefacto => artefacto.poderQueAporta(personaje) })
    }

}

