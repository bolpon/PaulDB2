/**
 * The Schulungstyp entity.
 *
 * @author
 *
 *
 */
package pauldb2

class Schulungstyp {
    static mapping = {
         table 'schulungsTyp'
         // version is set to false, because this isn't available by default for legacy databases
         version false
         id generator:'identity', column:'schulungsTyp_id'
    }
    //Integer schulungstypId
    String name
    String beschreibung

    static constraints = {
        //schulungstypId(max: 2147483647)
        name(size: 1..100, blank: false)
        beschreibung(blank: false)
    }
    String toString() {
        return "${name}"
    }
}
