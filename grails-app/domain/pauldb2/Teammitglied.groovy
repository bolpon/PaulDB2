package pauldb2

class Teammitglied {

    static mapping = {
         cache true
         table 'teammitglieder'
         // version is set to false, because this isn't available by default for legacy databases
         version false
         id generator:'identity', column:'teammitglieder_id'
         projektleiter: joinTable:[name:"projektleiter", key:"teammitglieder_id"]
    }

    static constraints = {

      //geleisteteMAT(nullable:true)
      von(nullable:true)
      bis(nullable:true)
    }
    static hasMany = [projektLeiter: Projektleiter]

    static belongsTo = [Projekte]

    Personen person
    Projekte projekt
    Date von
    Date bis

    //int geleisteteMAT
}
