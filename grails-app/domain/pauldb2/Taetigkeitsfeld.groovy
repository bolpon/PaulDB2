package pauldb2

class Taetigkeitsfeld {

    static mapping = {
         table 'taetigkeitsfeld'
         // version is set to false, because this isn't available by default for legacy databases
         version false
         id generator:'identity', column:'taetigkeitsfeld_id'
         cluster column: "taetigkeitscluster_id"
         projekte joinTable:[name:"projekt_taetigkeitsfeld", key:"taetigkeitsfeld_id"]
         projektanfragen joinTable:[name:"projektanfrage_taetigkeitsfeld", key:"taetigkeitsfeld_id"]
    }



    static hasMany = [projekte:Projekte, projektanfragen: Projektanfrage]
    static belongsTo = [Projekte, Projektanfrage]

    static constraints = {
    }


    String bezeichnung
    Taetigkeitscluster cluster

   String toString() {
        return "${bezeichnung}"
   }
}
