/**
 * The Unternehmensstatus entity.
 *
 * @author
 *
 *
 */
package pauldb2

class Unternehmensstatus {

  static mapping = {
         table 'unternehmensstatus'
         // version is set to false, because this isn't available by default for legacy databases
         version false
         id generator:'identity', column:'unternehmensstatus_id'
    }

    String unternehmensstatus

    static constraints = {
        //personstatusId()
        unternehmensstatus()
    }

    String toString() {
        return "${unternehmensstatus}"
    }
}