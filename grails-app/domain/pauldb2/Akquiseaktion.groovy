/**
 * The Akquiseaktion entity.
 *
 * @author
 *
 *
 */
package pauldb2

class Akquiseaktion {
    static mapping = {
         table 'akquiseaktion'
         // version is set to false, because this isn't available by default for legacy databases
         version false
         id generator:'identity', column:'akquiseaktion_id'
    }
    //Integer akquiseaktionId
    String name
    String beschreibung
    Date start
    Date ende

    static constraints = {
        //akquiseaktionId(max: 2147483647)
        name(size: 1..100, blank: false)
        beschreibung(blank: false)
        start()
        ende(nullable: true, validator: { val, obj -> val >= obj.start })
    }
    String toString() {
        return "${name}"
    }
}
