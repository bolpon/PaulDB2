package pauldb2

class Aufgabenstatus {

    static mapping = {
         table 'aufgabe_status'
         // version is set to false, because this isn't available by default for legacy databases
         version false
         id generator:'identity', column:'id'
    }


    static constraints = {
    }

    String beschreibung

    String toString(){

      return beschreibung
    }
}
