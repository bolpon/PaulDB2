package pauldb2

class Studienfach {

    static mapping = {
         table 'studienfach'
         // version is set to false, because this isn't available by default for legacy databases
         version false
         id generator:'identity', column:'studienfach_id'
    }

	static hasMany = [fakultaeten: Fakultaet]
	static belongsTo = pauldb2.Fakultaet
	
    static constraints = {
    }

    String bezeichnung
    int regelstudienzeit

    String toString(){

      return "${bezeichnung}"
    }
}
