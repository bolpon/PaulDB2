package pauldb2


//Mitarbeiter in Unternehmen
class Mitarbeiter {

    static mapping = {
         table 'mitarbeiter'
         // version is set to false, because this isn't available by default for legacy databases
         version false
         id generator:'identity', column:'mitarbeiter_id'
         person column:'person_id'
         unternehmen column:'unternehmen_id'

         kontakt joinTable:[name:"mitarbeiter_kontakt", key:"mitarbeiter_id", column:"kontakt_id"]
    }

    static constraints = {

      anfang(nullable:true)
      ende(nullable:true)

    }
    static hasMany = [kontakt:Kontakt]
    static belongsTo = [Personen,Unternehmen]

    Date    anfang
    Date    ende
    Personen person
    Unternehmen unternehmen
    MitarbeiterPosition position


    String toString(){
      person
    }
}