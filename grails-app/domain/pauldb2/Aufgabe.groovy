package pauldb2

class Aufgabe {

    static mapping = {
         table 'aufgabe'
         // version is set to false, because this isn't available by default for legacy databases
         version false
         id generator:'identity', column:'aufgabe_id'
         status column: 'status'
         oberaufgabe column: 'oberaufgabe_id', cascade: 'all'

         verwalter joinTable:[name:"aufgabe_verwalter", key:"aufgabe_id", column:"person_id"]
         bearbeiter joinTable:[name:"aufgabe_bearbeiter", key:"aufgabe_id", column:"person_id"]
         personenMitZugriff joinTable:[name:"aufgabe_zugriff", key:"aufgabe_id", column:"person_id"]
    }

    static constraints = {
      oberaufgabe(nullable:true)
      beschreibung(blank: false)
      name(blank:false)
      bearbeiter(blank:false)
      verwalter(blank:false)
    }

    //static hasMany = [bearbeiter:Personen, verwalter:Personen, personenMitZugriff:Personen]
    static hasMany = [bearbeiter:Personen, verwalter:Personen, personenMitZugriff:Personen]

    static belongsTo = [Personen]

    String beschreibung
    Aufgabe oberaufgabe
    String name
    Date start
    Date end
    boolean geschuetzt
    Aufgabenstatus status
}