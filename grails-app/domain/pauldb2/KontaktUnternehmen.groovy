package pauldb2

class KontaktUnternehmen {

    static mapping = {
         table 'kontakt_unternehmen'
         // version is set to false, because this isn't available by default for legacy databases
         version false
         id generator:'identity', column:'kontaktUnternehmen_id'
    }

    static belongsTo = [Kontakt, Unternehmen]

    static constraints = {
      kontakt(nullable:false)
      unternehmen(nullable:false)
    }

    Kontakt kontakt
    Unternehmen unternehmen
}