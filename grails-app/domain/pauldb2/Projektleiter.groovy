package pauldb2

class Projektleiter {

    static mapping = {
         table 'projektleiter'
         // version is set to false, because this isn't available by default for legacy databases
         version false
         id generator:'identity', column:'projektleiter_id'
         teammitglied column:'teammitglieder_id'
    }

    static constraints = {
      von(nullable: true)
      bis(nullable: true)

    }
    static belongsTo = [Teammitglied]

    Teammitglied teammitglied
    Date von
    Date bis
}
