/**
 * The Projektanfragephase entity.
 *
 * @author
 *
 *
 */
package pauldb2

class Projektanfragephase {
    static mapping = {
         table 'projektanfragephase'
         // version is set to false, because this isn't available by default for legacy databases
         version false
         id generator:'identity', column:'projektanfragePhase_id'
    }
    //Integer projektanfragephaseId
    String bezeichnung
    Byte ordnung
    String projektwand

    static constraints = {
        //projektanfragephaseId(max: 2147483647)
        bezeichnung(size: 1..50, blank: false)
        ordnung()
        projektwand()
    }
    String toString() {
        return "${bezeichnung}"
    }
}