package pauldb2

class FreieMitarbeiter {

    static mapping = {
         table 'freiemitarbeiter'
         // version is set to false, because this isn't available by default for legacy databases
         version false
         id generator:'identity', column:'freieMitarbeiter_id'
         person column:'person_id'
         projekt column:'projekt_id'


    }

    static belongsTo = [Projekte]

    static constraints = {
      von(nullable:true)
      bis(nullable:true)
    }



    Personen person
    Projekte projekt
    Date von
    Date bis
    String bemerkung

}
