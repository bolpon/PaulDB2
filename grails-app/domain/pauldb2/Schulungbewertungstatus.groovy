/**
 * The Schulungbewertungstatus entity.
 *
 * @author
 *
 *
 */
package pauldb2

class Schulungbewertungstatus {
    static mapping = {
         table 'schulungbewertungstatus'
         // version is set to false, because this isn't available by default for legacy databases
         version false
         id generator:'identity', column:'Schulungbewertungstatus_id'
    }
    //Byte schulungbewertungstatusId
    String bezeichnung

    static constraints = {
        //schulungbewertungstatusId()
        bezeichnung(size: 0..20)
    }
    String toString() {
        return "${bezeichnung}"
    }
}
