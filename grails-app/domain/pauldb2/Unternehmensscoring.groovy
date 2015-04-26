package pauldb2

class Unternehmensscoring {
	static mapping = {
         cache true
         table 'unternehmensscoring'
		 // version is set to false, because this isn't available by default for legacy databases
         version false
         id generator:'identity', column:'unternehmensscoring_id'
    }
	
	String bezeichnung
	
	static constraints = {
		bezeichnung(maxSize: 1, blank: false)
	}
	
	String toString() {
		return "${bezeichnung}"
	}
}
