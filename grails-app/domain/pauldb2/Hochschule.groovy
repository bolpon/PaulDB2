package pauldb2

import pauldb2.Fakultaet

class Hochschule {
    static mapping = {
         table 'hochschule'
         version false
         id generator:'identity', column:'hochschule_id'
    }
		
	static hasMany = [fakultaeten: Fakultaet]
	
    static constraints = {
    }

    String name
	
    String toString(){
      return "${name}"
    }
}
