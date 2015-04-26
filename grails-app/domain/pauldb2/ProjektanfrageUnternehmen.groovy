package pauldb2

class ProjektanfrageUnternehmen {

    static mapping = {
         table 'projektanfrage_unternehmen'
         // version is set to false, because this isn't available by default for legacy databases
         version false
         id generator:'identity', column:'projektanfrageUnternehmen_id'
    }

    static belongsTo = [Projektanfrage, Unternehmen]

    static constraints = {
      projektanfrage(nullable:false)
      unternehmen(nullable:false)
    }

    Projektanfrage projektanfrage
    Unternehmen unternehmen
}
