package pauldb2

class Taetigkeitscluster {

    static mapping = {
         table 'taetigkeitscluster'
         // version is set to false, because this isn't available by default for legacy databases
         version false
         id generator:'identity', column:'taetigkeitscluster_id'
    }

    static constraints = {
    }

    String bezeichnung

  
    String toString() {
        return "${bezeichnung}"
    }
}


