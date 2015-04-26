/**
 * The Person entity.
 *
 * @author    
 *
 *
 */
package pauldb2

class Personen {
    static mapping = {
         cache true
         table 'person'
         // version is set to false, because this isn't available by default for legacy databases
         version false
         id generator:'identity', column:'person_id'
         adresse column:'adresse_id'
         mitarbeiter joinTable:[name:"mitarbeiter", key:"person_id"]
         betreuteUnternehmen joinTable:[name:"kundennachbetreuer", key:"person_id"]
         emails joinTable:[name:"email", key:"person_id", column:"email_id"]
         telefon joinTable:[name:"telefon", key:"person_id", column:"telefon_id"]
         studium joinTable:[name:"studium", key:"person_id", column:"studium_id"]
         tm joinTable:[name:"teammitglieder", key:"person_id"], cascade: 'all'
         schulungen joinTable:[name:"nimmtteilan_schulung", key:"person_id"]
         geleiteteSchulungen joinTable:[name:"haelt_schulung", key:"person_id"]
         aufgabenVerwalten joinTable:[name:"aufgabe_verwalter", key:"person_id", column:"aufgabe_id"]
         aufgabenBearbeiten joinTable:[name:"aufgabe_bearbeiter", key:"person_id", column:"aufgabe_id"]
         aufgabenZugriff joinTable:[name:"aufgabe_zugriff", key:"person_id", column:"aufgabe_id"]
         freieMitarbeiter joinTable:[name:"freieMitarbeiter", key:"person_id"]
         projektanfragen joinTable:[name:"projektanfrage_person", key:"person_id"]
         posten joinTable:[name:"person_postenRessorts", key:"person_id", column:"postenRessort_id"]
         entwicklung joinTable:[name:"personhistory", key:"person_id"]

      //personstatusIdPersonstatus column:'personStatus_id'
         //coachProjekte joinTable:[name:'projekt_coach', key:"person_id"]  //coach many-to-many beziehung


         //@todo ersetzen durch teammitglied.projekt
         //projekte joinTable:[name:'teammitglieder', key:"person_id", column:"projekt_id"]
         kontakt joinTable:[name:'kontakt_person', key:"person_id", column:"kontakt_id"]

    }
    //Integer personId

  /**
   * mitarbeiter:           Mitarbeiter in Unternehmen (externe Personen meistens)
   * beutreute Unternehmen: Unternehmen, die vom jeweiligen Pauli betreut werden
   * coachProjekte:         Projekte, in welchem der Pauli die Coachfunktion übernommen hat
   * tm:                    Teammitgliedschaft eines Paulis in seinen Projekten                     
   *
   *
   *
   */
    static hasMany = [aufgabenVerwalten:Aufgabe, aufgabenBearbeiten:Aufgabe, aufgabenZugriff:Aufgabe, mitarbeiter:Mitarbeiter, betreuteUnternehmen:Unternehmen, coachProjekte:Projekte, emails:Email, telefon:Telefon, studium:Studium, kontakt:Kontakt, tm:Teammitglied, schulungen:Schulung, geleiteteSchulungen:Schulung, freieMitarbeiter:FreieMitarbeiter, projektanfragen:Projektanfrage, posten:Posten, entwicklung:PersonHistory]
    static mappedBy = [coachProjekte: "coach", geleiteteSchulungen:"leiter"]
    
    static belongsTo = [Unternehmen, Schulung, Posten] //Betreuer, wenns das unternehmen nicht mehr gibt, kann die relation betreuer auch weg
    String vorname
    String nachname
    String anrede
    String titel
    String hobbys
    String ausbildung
    String visitenkarte
    String foto
    Date geburtsdatum
    Date letzteaktualisierung
    String bemerkung
    String zielestudium
    String zielepaul
    String kritikpaul
    String abschlussarbeit
    String abschlussbetreuer
    String berufslaufbahn

    // Relation
    Adresse adresse
    Personstatus personstatus

    // Relation
   // Personstatus personstatusIdPersonstatus

    static constraints = {
        //personId(max: 2147483647)
        vorname(size: 1..30, blank: false)
        nachname(size: 1..30, blank: false)
        anrede(inList:['Herr', 'Frau'])
        titel(nullable: true)
        hobbys(nullable: true)
        ausbildung(nullable: true)
        visitenkarte(nullable:true)
        foto(nullable: true)
        geburtsdatum(nullable: true)
        letzteaktualisierung(nullable: true)
        bemerkung(nullable: true)
        zielestudium(nullable: true)
        zielepaul(nullable:true)
        kritikpaul(nullable: true)
        abschlussarbeit(nullable: true)
        abschlussbetreuer(nullable: true)
        berufslaufbahn(nullable: true)
        adresse(nullable: true)
        personstatus()
    }
    String toString() {
        return vorname + ' '  + nachname
    }

    String findByID(){

    }

    def beforeUpdate(){

        letzteaktualisierung = new Date()
    }
}

