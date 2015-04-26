/**
 * The Unternehmenstyp entity.
 *
 * @author
 *
 *
 */
package pauldb2

class Unternehmenstyp {

  static mapping = {
           table 'unternehmenstyp'
           // version is set to false, because this isn't available by default for legacy databases
           version false
           id generator:'identity', column:'unternehmenstyp_id'
      }

      String unternehmenstyp

      static constraints = {
          //personstatusId()
          unternehmenstyp()
      }

      String toString() {
          return "${unternehmenstyp}"
      }


}