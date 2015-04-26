/**
 * The Schulung entity.
 *
 * @author
 *
 *
 */
package pauldb2

class Schulung {
    static mapping = {
         table 'schulung'
         // version is set to false, because this isn't available by default for legacy databases
         version false
         id generator:'identity', column:'schulung_id'
         schulungstyp column:'schulungsTyp_id'
         schulungbewertungstatus column:'schulungbewertungStatus_id'
         teilnehmer joinTable:[name:"nimmtteilan_schulung", key:"schulung_id"]
         leiter joinTable:[name:"haelt_schulung", key:"schulung_id"]   
        //schulungen jointable:[name:"nimmtTeilAnSchulung", key:"person_id"]

    }
    //Integer schulungId
    String bezeichnung
    Date termin
    String status
    String beschreibung
    // Relation
    Schulungstyp schulungstyp
    // Relation
    Schulungbewertungstatus schulungbewertungstatus



    static hasMany = [teilnehmer:Personen, leiter:Personen]


    static constraints = {
        //schulungId(max: 2147483647)
        bezeichnung(size: 1..255, blank: false)
        termin()
        status(inList:['intern', 'extern'])
        beschreibung(blank: true)
        schulungstyp(nullable:true)
        schulungbewertungstatus()
    }
    String toString() {
        return "${bezeichnung}"
    }
}
