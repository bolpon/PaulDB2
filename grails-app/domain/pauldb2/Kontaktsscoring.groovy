/**
* The Kontaktsscoring entity.
*
* @author Walter Nuss
* 01.08.2012
*
*/
package pauldb2

class Kontaktsscoring {	
	static mapping = {
		table 'kontaktsscoring'
		// version is set to false, because this isn't available by default for legacy databases
		version false
		id generator:'identity', column:'kontaktsscoring_id'			
   }
	String bezeichnung
	
    static constraints = {
		bezeichnung(size: 1..50, blank: false)
    }
	
	String toString(){		
	  return "${bezeichnung}"
	}
}
