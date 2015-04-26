/**
 * The Projektanfrage entity.
 *
 * @author
 *
 *
 */
package pauldb2

class Projektanfrage {
    static mapping = {
         cache true
         table 'projektanfrage'
         // version is set to false, because this isn't available by default for legacy databases
         version false
         id generator:'identity', column:'projektanfrage_id'
         kontakt column:'kontakt_id'
         projektanfragephase column:'projektanfragePhase_id'
         unternehmen joinTable:[name:"projektanfrage_unternehmen", key:"projektanfrage_id"]
         personen joinTable:[name:"projektanfrage_person", key:"projektanfrage_id"]
         taetigkeitsfeld joinTable:[name:"projektanfrage_taetigkeitsfeld", key:"projektanfrage_id"]
    }

    static hasMany = [personen:Personen, unternehmen:Unternehmen, taetigkeitsfeld: Taetigkeitsfeld, kontakt: Kontakt]
    static belongsTo = [Personen, Unternehmen]
    //Integer projektanfrageId
    String beschreibung
    String ablehnungsgrund
    // Relation
    Kontakt kontakt
    // Relation
    Projektanfragephase projektanfragephase

    static constraints = {
        //projektanfrageId(max: 2147483647)
        beschreibung(blank: false)
        ablehnungsgrund(blank: true)
        kontakt(nullable: false)
        projektanfragephase(nullable:false)
        personen(nullable: false)
        unternehmen(nullable: false)
    }
    String toString() {
        def ausgabe = beschreibung;
        if(ausgabe.length() > 70){
          ausgabe = ausgabe.substring(0,70)
        }
        return getBezeichner() + ausgabe
    }

    private String getBezeichner(){
        def ausgabe2 = ""
        //nur die maximal ersten 3 ausgeben
        def grenze = java.lang.Math.min(unternehmen.size()-1,2)
        if (grenze>-1) unternehmen.toList()[0..grenze].each{
            ausgabe2 += it.toString() + ', '
        }
        if(ausgabe2.length() > 50){
                ausgabe2 = ausgabe2.substring(0,50) +'.. '
        }
        return ausgabe2
    }
}
