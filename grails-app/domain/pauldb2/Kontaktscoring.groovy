package pauldb2

class Kontaktscoring {	
	static mapping = {
		table 'kontaktscoring'
		// version is set to false, because this isn't available by default for legacy databases
		version false
		id generator:'identity', column:'kontaktscoring_id'			
   }
	String bezeichnung
	
    static constraints = {
		bezeichnung(maxsize: 1, blank: false)
    }
	
	String toString(){		
	  return "${bezeichnung}"
	}
}
