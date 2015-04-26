/**
 * The Projektphase entity.
 *
 * @author
 *
 *
 */
package pauldb2

class Projektphase {
    static mapping = {
         table 'projektphase'
         // version is set to false, because this isn't available by default for legacy databases
         version false
         id generator:'identity', column:'projektphase_id'
    }
    //Integer projektphaseId
    String bezeichnung
    String benoetigt
    Byte ordnung
    String projektwand

    static constraints = {
        //projektphaseId(max: 2147483647)
        bezeichnung(size: 1..30, blank: false)
        benoetigt()
        ordnung()
        projektwand()
    }
    String toString() {
        return "${bezeichnung}"
    }
}
