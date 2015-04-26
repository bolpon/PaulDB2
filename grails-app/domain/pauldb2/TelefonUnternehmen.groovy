package pauldb2

class TelefonUnternehmen {

    static mapping = {
         table 'telefonunternehmen'
         // version is set to false, because this isn't available by default for legacy databases
         version false
         id generator:'identity', column:'telefonUnternehmen_id'
         unternehmen column: 'unternehmen_id'

    }

    static constraints = {
      bemerkung(nullable:true)
    }

    static belongsTo = [Unternehmen]

    String bemerkung
    String nummer
    Unternehmen unternehmen

    String toString(){

      if(bemerkung!=null && bemerkung != "")
        return nummer + "  --  " + bemerkung
      else
        return nummer
    }
}
