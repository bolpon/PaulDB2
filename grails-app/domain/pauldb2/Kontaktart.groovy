/**
 * The Kontaktart entity.
 *
 * @author
 *
 *
 */
package pauldb2

class Kontaktart {
    static mapping = {
         table 'kontaktart'
         // version is set to false, because this isn't available by default for legacy databases
         version false
         id generator:'identity', column:'kontaktArt_id'
    }
    //Integer kontaktartId
    String bezeichnung

    static constraints = {
        //kontaktartId(max: 2147483647)
        bezeichnung(size: 1..50, blank: false)
    }
    String toString() {
        return "${bezeichnung}"
    }
}