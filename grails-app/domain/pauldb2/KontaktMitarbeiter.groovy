package pauldb2

class KontaktMitarbeiter {

    static mapping = {
         table 'mitarbeiter_kontakt'
         // version is set to false, because this isn't available by default for legacy databases
         version false
         id generator:'identity', column:'mitarbeiterKontakt_id'
    }

    static belongsTo = [Kontakt, Mitarbeiter]

    static constraints = {
      kontakt(nullable:false)
      mitarbeiter(nullable:false)
    }

    Kontakt kontakt
    Mitarbeiter mitarbeiter
}
