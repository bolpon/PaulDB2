/**
 * The Personstatus entity.
 *
 * @author
 *
 *
 */
package pauldb2

class Personstatus {

    static mapping = {
         table 'personstatus'
         // version is set to false, because this isn't available by default for legacy databases
         version false
         id generator:'identity', column:'personStatus_id'
    }
    
    String bezeichnung

    static constraints = {
        //personstatusId()
      
        bezeichnung(size: 1..20, blank: false)
    }

    String toString() {
        return "${bezeichnung}"
    }
}