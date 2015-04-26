package pauldb2

class HomepageUnternehmen {

    static mapping = {
         table 'homepageunternehmen'
         // version is set to false, because this isn't available by default for legacy databases
         version false
         id generator:'identity', column:'homepageUnternehmen_id'
         unternehmen column:'unternehmen_id'
    }

    static constraints = {
       url(blank:false)
       bemerkung(nullable: true)
    }

   static belongsTo = [Unternehmen]

   Unternehmen unternehmen
   String url
   String bemerkung

   String toString(){

    if(bemerkung!="" && bemerkung != null)
        return url + " -- " + bemerkung
    else
        return url
   }

}
