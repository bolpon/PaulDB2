package pauldb2

class BewertungUnternehmen {

    static mapping = {
         table 'bewertung'
         // version is set to false, because this isn't available by default for legacy databases
         version false
         id generator:'identity', column:'bewertung_id'

    }
    static constraints = {

    }


    String bewertung

    String toString() {
        return bewertung
    }
}
