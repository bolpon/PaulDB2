package pauldb2

class Unternehmen {
    static mapping = {
         cache true
         table 'unternehmen'
         // version is set to false, because this isn't available by default for legacy databases
         version false
         id generator:'identity', column:'unternehmen_id'
         adresse column:'adresse_id'
         unternehmenstyp column: 'unternehmenstyp_id'
         unternehmensstatus column: 'unternehmensstatus_id'
         oberunternehmen column: 'oberunternehmen_id'
		 unternehmensscoring column: 'unternehmensscoring_id'
		 letzterkontakt column: 'letzterkontakt_id'
         betreuer joinTable:[name:"kundennachbetreuer", key:"unternehmen_id"]
         projekte joinTable:[name:"projekt_unternehmen", key:"unternehmen_id"]
         telefon joinTable:[name:"telefonunternehmen", key:"unternehmen_id", column:"telefonUnternehmen_id"]
         emails joinTable:[name:"emailunternehmen", key:"unternehmen_id", column:"eMailUnternehmen_id"]
         //kontakte joinTable:[name:"kontakt_unternehmen", key:"unternehmen_id", column:"kontakt_id"]
         mitarbeiter joinTable:[name:"mitarbeiter", key:"unternehmen_id"]
         branche joinTable:[name:"branche_unternehmen", key:"unternehmen_id"]
         homepages joinTable:[name:"homepageunternehmen", key:"unternehmen_id"]
         projektanfragen joinTable:[name:"projektanfrage_unternehmen", key:"unternehmen_id"]
    }

    //static hasMany = [betreuer:Personen,projekte:Projekte, telefon:TelefonUnternehmen, emails: EmailUnternehmen, kontakt: Kontakt, mitarbeiter:Mitarbeiter]
    static hasMany = [betreuer:Personen,projekte:Projekte, telefon:TelefonUnternehmen, emails: EmailUnternehmen, mitarbeiter:Mitarbeiter, branche:Branche, homepages:HomepageUnternehmen,projektanfragen:Projektanfrage]

    //static belongsTo = [pauldb2.Branche]
    String name
    String kurzname
    //Integer adresseId
    Date letzteaktualisierung
    //Integer unternehmenstypId
    //Integer unternehmensstatusId
    //Integer bewertungId
    String bemerkung
    String logo
    String veroeffentlichung
    Date naechsterkontakt
    String naechsterkontaktlevel
    //Integer oberunternehmenId
    Unternehmen oberunternehmen
    String kontaktnoetig
    Adresse adresse
    Unternehmensstatus unternehmensstatus
    Unternehmenstyp unternehmenstyp
    BewertungUnternehmen bewertung
	Unternehmensscoring unternehmensscoring
	Kontakt letzterkontakt
	
    static constraints = {
        name(size: 1..100, blank: false)
        kurzname(size: 1..30, blank: true)
        //adresseId(max: 2147483647)
        letzteaktualisierung()
        unternehmenstyp(max: 2147483647)
        unternehmensstatus(max: 2147483647)
		unternehmensscoring(max: 2147483647)
		letzterkontakt(nullable: true)
        //bewertungId(max: 2147483647)
        bemerkung()
        logo(nullable: true)
        adresse(nullable: true)
        bewertung(nullable: true)
        veroeffentlichung(nullable: true)
        naechsterkontakt(nullable: true)
        naechsterkontaktlevel(inList: ['ermahnung', 'warnung'], nullable: true)
        //oberunternehmenId(nullable: true, max: 2147483647)
        kontaktnoetig(inList: ['ja', 'nein'])
        letzteaktualisierung(nullable: true)
    }
	
    String toString() {
        return "${name}"
    }

    def beforeUpdate(){
        letzteaktualisierung = new Date()
    }
}
