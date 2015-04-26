package pauldb2

/**
 * The Adresse entity.
 *
 * @author
 *
 *
 */
class Adresse {
    static mapping = {
         cache true
         table 'adresse'
         // version is set to false, because this isn't available by default for legacy databases
         version false
         id generator:'identity', column:'adresse_id'
    }
    //Integer adresseId
    String strasse
    String nummer
    String plz
    String stadt
    String land
    String postfach

     // Adresse wird automatisch gel�scht, wenn die dazugeh�rige Person/Unternehmen gel�scht wird
     // wird auch ohne belongsTo kaskadiert gelöscht, mit belongsTo gibts Error weil er zweimal löschen will Oo
    // static belongsTo = [Personen,Unternehmen]


    static belongsTo = [Unternehmen,Personen]
    static constraints = {
        //adresseId(max: 2147483647)
        strasse(size: 0..50, nullable:true)
        nummer(size: 0..20, nullable:true)
        plz(size: 0..5, nullable:true)
        stadt(size: 1..100, blank: true)
        land(size: 0..25, nullable: true)
        postfach(size: 0..8, nullable:true)

    }
    String toString() {
		return strasse + ' ' + nummer + System.getProperty("line.separator") + plz + ' ' + stadt;
    }
}

