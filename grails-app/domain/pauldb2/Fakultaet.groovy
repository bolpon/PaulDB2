package pauldb2

import pauldb2.Hochschule
import pauldb2.Studienfach

class Fakultaet {
    static mapping = {
         table 'fakultaet'
         version false
         id generator:'identity', column:'fakultaet_id'
		 
		 studienfaecher joinTable: [name: 'fakultaet_studienfach', key: 'fakultaet_id'], cascade: 'all'
    }

	static hasMany = [studienfaecher: Studienfach]
	static belongsTo = [hochschule: Hochschule]
	static mappedBy = [hochschule: 'hochschule_id']
	
    static constraints = {
    }

    String bezeichnung
	Hochschule hochschule
	
    String toString(){
      return "${bezeichnung}"
    }
}
