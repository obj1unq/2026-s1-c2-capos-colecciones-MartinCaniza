object rolando {
    var capacidadMaxima = 2
    var ubicacion = castilloDePiedra
    var poderBase = 5

    const enemigos = #{}

    const artefactos = #{}

    const historial = []

    method poderBase(_poderBase){
        poderBase = _poderBase
    }

    method capacidadMaxima(_capacidadMaxima){
        capacidadMaxima = _capacidadMaxima
    }

    method artefactos(){
        return artefactos
    }

    method enemigos(){
        return enemigos
    }

    method agregarEnemigo(enemigo){
        enemigos.add(enemigo)
    }

    method poderBase(){
        return poderBase
    }

    method poderDePelea(){
        return poderBase + self.poderTotalDePelea()
    }

    method poderTotalDePelea(){
        return artefactos.sum({ artefacto => artefacto.poderQueAporta(self) })
    }

    method batallar(){
        poderBase = poderBase + 1
        artefactos.forEach({ artefacto => artefacto.usarArtefacto(self) })
    }

    method morada(){
        return ubicacion
    }

    method agregarArtefacto(artefacto){

        historial.add(artefacto)
        if (self.puedeLevantar()){
            artefactos.add(artefacto)
        }
    }

    method puedeLevantar(){
        return artefactos.size() < capacidadMaxima 
    } 

    method ubicacion(){
        return ubicacion
    }

    method llegarA(ubicacionNueva){
        
        ubicacionNueva.agregarArtefactos(artefactos)
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

    method enemigosPuedeVencer(){
        return enemigos.filter({ enemigo => enemigo.poderBase() < self.poderDePelea() }).asSet()

    }

    method moradasConquistables(){
        return self.enemigosPuedeVencer().map({ enemigo => enemigo.morada() }).asSet()
    }
  

   method esPoderoso(){
        return enemigos.all( {enemigo => enemigo.poderBase() < self.poderDePelea() } )
   }

   method contieneArtefactoFatal(enemigo){
        return artefactos.any({ artefacto => artefacto.poderQueAporta(self) > enemigo.poderBase() })
   }
}

object espadaDelDestino{
    var fueUsada = false

    method poderQueAporta(personaje) {
        return personaje.poderBase() / if (fueUsada) 2 else 1
    }

    method usarArtefacto(personaje){
        fueUsada = true
    }
}

object libroDeHechizos{

    const hechizos = []

    method hechizos(){
        return hechizos
    }

    method agregarHechizo(hechizo){
        hechizos.add(hechizo)
    }


    method poderQueAporta(personaje){

        return  if (self.hechizos().isEmpty() ) {0}
                 else {self.hechizos().head().poderQueAporta(personaje)}
            
        }


    method eliminarPrimerHechizo(){

        hechizos.remove( hechizos.head() )
    }

    method usarArtefacto(personaje){

        self.eliminarPrimerHechizo()
        
    }
}

object bendicion{
    const poder = 4

    method poderQueAporta(personaje){
        return poder
    }

}

object invisibilidad{

    method poderQueAporta(personaje){
        return personaje.poderBase()
    }

}

object invocacion{

    method poderQueAporta(personaje){

        return personaje.morada().artefactoMasPoderoso(personaje).poderQueAporta(personaje)
    }


}


object collarDivino {
    var puntos = 3 

    method poderQueAporta(personaje) {

        return if (personaje.poderBase() > 6) { puntos } else { 3 }
    }

    method usarArtefacto(personaje) {

        puntos = puntos + 1
    }
}


object armaduraDeAcero{
    const poder = 6

    method poderQueAporta(personaje){
        return poder
    }
    
    method usarArtefacto(personaje){
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

object caterina{
    const poderBase = 28
    const morada = fortalezaDeAcero

    method morada(){
        return morada
    }

    method poderBase(){
        return poderBase
    }
}

object archibaldo{
    const poderBase = 16
    const morada = palacioDeMarmol

    method morada(){
        return morada
    }

    method poderBase(){
        return poderBase
    }
}

object astra{
    const poderBase = 14
    const morada = torreDeMarfil

    method morada(){
        return morada
    }

    method poderBase(){
        return poderBase
    }
}

object fortalezaDeAcero{
    
}

object palacioDeMarmol{

}

object torreDeMarfil{

}