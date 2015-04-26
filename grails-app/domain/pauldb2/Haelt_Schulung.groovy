package pauldb2

class Haelt_Schulung {

    static mapping = {
         table 'haelt_schulung'
         // version is set to false, because this isn't available by default for legacy databases
         version false
         id generator:'identity', column:'haeltSchulung_id'
    }

    static belongsTo = [Schulung, Personen]

    static constraints = {
      schulung(nullable:false)
      person(nullable:false)
    }

    Schulung schulung
    Personen person
}

