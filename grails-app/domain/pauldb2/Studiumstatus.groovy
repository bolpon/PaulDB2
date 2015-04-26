package pauldb2

class Studiumstatus {

    static mapping = {
         table 'studiumstatus'
         // version is set to false, because this isn't available by default for legacy databases
         version false
         id generator:'identity', column:'studiumstatus_id'


    }

    static constraints = {
    }

    String bezeichnung

    String toString(){

      return "${bezeichnung}"
    }
}
