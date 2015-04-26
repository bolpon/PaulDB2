package pauldb2

/**
 * Created by IntelliJ IDEA.
 * Date: 05.09.11
 */
class PersonHistory {

    static mapping = {
         table 'personhistory'
         // version is set to false, because this isn't available by default for legacy databases
         version false
         id generator:'identity', column:'personHistory_id'
    }

    static constraints = {
      von(nullable:true)
      bis(nullable:true)
    }
    //Datenbank sollte keine Daten vor 1970 enthalten (start der Zählung in JAVA); Nullpointer besser
    Date von
    Date bis

    Personen person
    Personstatus personstatus
    Posten postenressort

}
