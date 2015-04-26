/**
 * The Kontaktzweck entity.
 *
 * @author
 *
 *
 */
package pauldb2

class Kontaktzweck {
    static mapping = {
         table 'kontaktzweck'
         // version is set to false, because this isn't available by default for legacy databases
         version false
         id generator:'identity', column:'kontaktZweck_id'
    }
    //Integer kontaktzweckId
    String bezeichnung

    static constraints = {
        //kontaktzweckId(max: 2147483647)
        bezeichnung(size: 1..50, blank: false)
    }
    String toString() {
        return "${bezeichnung}"
    }
}