package pauldb2

class Email {

    static mapping = {
         cache true
         table 'email'
         // version is set to false, because this isn't available by default for legacy databases
         version false
         id generator:'identity', column:'email_id'
         mailAdresse column: 'mailAdresse'

    }

    static constraints = {
    }
    static belongsTo = [Personen]


    String mailAdresse
    Personen person


    String toString(){

      return "${mailAdresse}"
    }
}
