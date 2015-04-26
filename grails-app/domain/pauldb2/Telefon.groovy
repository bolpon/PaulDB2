package pauldb2

class Telefon {

    static mapping = {
         cache true
         table 'telefon'
         // version is set to false, because this isn't available by default for legacy databases
         version false
         id generator:'identity', column:'telefon_id'


    }

    static constraints = {
    }

    static belongsTo = [Personen]

    String bemerkung
    String nummer
    Personen person
  
    String toString(){


      if(bemerkung.equals("")){
        return nummer
      }
      else{
        return "${nummer}" + "  --  " + "${bemerkung}" 
      }

    }
}
