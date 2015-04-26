/**
 * The Projekt entity.
 *
 * @author
 *
 *
 */
package pauldb2

class Projekte {
    static mapping = {
         cache true
         table 'projekt'
         // version is set to false, because this isn't available by default for legacy databases
         version false
         id generator:'identity', column:'projekt_id'
         projektphase column:'projektphase_id'
         projektanfrage column:'projektanfrage_id'
         coach column: 'person_id'

         // die Bennenung 'person_id' ist doof, das doppelt sich und grails kommt damit nicht klar
         unternehmen joinTable:[name:"projekt_unternehmen", key:"projekt_id"]
         freieMitarbeiter joinTable:[name:"freieMitarbeiter", key:"projekt_id"], cascade: 'all'
         ansprechpartner joinTable:[name: "projekt_mitarbeiter", key:"projekt_id"], cascade: 'all'
         //coach joinTable: [name:"projekt_coach", key:"projekt_id"]   // für many-to-many coach beziehung
         //teammitglieder joinTable:[name:"teammitglieder", key:"projekt_id", column:"person_id"]
         tm joinTable:[name:"teammitglieder", key:"projekt_id"], cascade: 'all'
         taetigkeitsfeld joinTable:[name:"projekt_taetigkeitsfeld", key:"projekt_id"] 
    }
    //Integer projektId

    //static hasMany = [unternehmen:Unternehmen,teammitglieder:Personen]
    //static belongsTo = [Unternehmen,Personen]


    //static hasMany = [unternehmen:Unternehmen, coach:Personen, teammitglieder:Personen]  // many-to-many coachbeziehung 
    static hasMany = [unternehmen:Unternehmen, tm:Teammitglied, freieMitarbeiter:FreieMitarbeiter, ansprechpartner:Mitarbeiter, taetigkeitsfeld: Taetigkeitsfeld]
    static belongsTo = [Personen,Unternehmen]

    Date anfangsdatum
    Date enddatum
    Date enddatumvertrag
    Float btvertrag
    Float btreal
    Float tagessatz
    String beschreibung
    String internextern
    Date projektentstandenam
    String projektname
    String gbrname
    Date gbranfangsdatum
    Date gbrenddatum
    String referenzfreigabe
    String referenzbeschraenkung
    String referenztext
    // Relation
    Personen coach
    Projektphase projektphase
    // Relation
    Projektanfrage projektanfrage

    static constraints = {
        //projektId(max: 2147483647)
        anfangsdatum(nullable: true)
        enddatum(nullable: true)
        enddatumvertrag(nullable: true)
        btvertrag(nullable: true)
        btreal(nullable: true)
        tagessatz(nullable: true)
        beschreibung(blank: false)
        internextern(inList:['intern', 'extern'])
        projektentstandenam(nullable: true)
        projektname(size: 1..80, blank: false)
        gbrname(size: 0..80,nullable:true)
        gbranfangsdatum(nullable: true)
        gbrenddatum(nullable: true)
        referenzfreigabe(inList:['freigegeben', 'nicht freigegeben'])
        referenzbeschraenkung(nullable:true)
        referenztext(nullable:true)
        //projektLeiter(nullable: true, max: 2147483647)
        projektphase()
        projektanfrage(nullable: true)
        coach(nullable:true)
    }
    String toString() {
        return "${projektname}"
    }
}