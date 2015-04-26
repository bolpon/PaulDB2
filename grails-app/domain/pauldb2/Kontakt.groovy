/**
 * The Kontakt entity.
 *
 * @author
 *
 *
 */
package pauldb2

class Kontakt {
    static mapping = {
         cache true
         table 'kontakt'
         // version is set to false, because this isn't available by default for legacy databases
         version false
         id generator:'identity', column:'kontakt_id'
         akquiseaktion column:'akquiseaktion_id'
         kontaktzweck column:'kontaktZweck_id'
         kontaktart column:'kontaktArt_id'
         kontaktscoring column:"kontaktscoring_id"

         //die tabelle ist leer, wird in der db1 über mitarbeiter_kontakt->mitarbeiter->unternehmen abgefragt
         //unternehmen joinTable:[name:"kontakt_unternehmen", key:"kontakt_id", column:"unternehmen_id"]

		 
         personen joinTable:[name:"kontakt_person", key:"kontakt_id", column:"person_id"]
         mitarbeiter joinTable:[name:"mitarbeiter_kontakt", key:"kontakt_id", column:"mitarbeiter_id"]
    }

    //static hasMany = [unternehmen:Unternehmen, personen:Personen, mitarbeiter:Mitarbeiter]
    //static belongsTo = [Unternehmen,Personen,Mitarbeiter]


    //personen = paulis, mitarbeiter = unternehmen
    static hasMany = [personen:Personen, mitarbeiter:Mitarbeiter]
    static belongsTo = [Personen,Mitarbeiter]


    //Integer kontaktId
    String name
    String beschreibung
    Date datum
    Date naechsterkontakt
    // Relation
    Akquiseaktion akquiseaktion
    // Relation
    Kontaktzweck kontaktzweck
    // Relation
    Kontaktart kontaktart
	Kontaktscoring kontaktscoring 
	boolean geaendert

    static constraints = {
        //kontaktId(max: 2147483647)
        name(size: 0..100, nullable:true)
        naechsterkontakt(nullable: true) // , validator: { value, reference -> (value == null) || (value > reference.datum) })
        akquiseaktion(nullable:true)
		kontaktscoring(blank: false, nullable: true)
        personen(blank: false, nullable: false)
        mitarbeiter(blank: false, nullable: false)
    }
	
    String toString() {
        return "${name}"
    }

    public static List<Kontakt> getKontakteMitUnternehmen(Unternehmen unternehmen){
        List<Kontakt> kontaktlist = []
        def potAnfragen = KontaktMitarbeiter.findAllByMitarbeiterInList(unternehmen.mitarbeiter.toList())
        potAnfragen += KontaktUnternehmen.findAllByUnternehmen(unternehmen).toList()
        potAnfragen = potAnfragen.sort{x,y -> y.kontakt.datum<=>x.kontakt.datum}
        potAnfragen.each{
            if(!kontaktlist.contains(it.kontakt)) kontaktlist.add(it.kontakt)
        }
        return kontaktlist
    }
}
