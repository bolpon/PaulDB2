package pauldb2

class EmailUnternehmen {

    static mapping = {
         cache true
         table 'emailunternehmen'
         // version is set to false, because this isn't available by default for legacy databases
         version false
         id generator:'identity', column:'eMailUnternehmen_id'
         mailAdresse column: 'mailAdresse'
         unternehmen column: 'unternehmen_id'
    }

    static constraints = {
      bemerkung(nullable:true)
    }
    static belongsTo = [Unternehmen]


    String mailAdresse
    String bemerkung
    Unternehmen unternehmen

    String toString(){

      if(bemerkung!="" && bemerkung != null)
        return mailAdresse + " -- " + bemerkung
      else
        return mailAdresse
    }
}
