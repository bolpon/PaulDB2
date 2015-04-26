package pauldb2

import pauldb2.Fakultaet

class Studium {
    static mapping = {
         table 'studium'
         // version is set to false, because this isn't available by default for legacy databases
         version false
         id generator:'identity', column:'studium_id'
         status column:'studiumstatus_id'
         nebenfach joinTable:[name:'nebenfach_studium', key:'studium_id', column:'nebenfachStudium_id']
		 fakultaet column:'fakultaet_id'
    }

    static constraints = {
      anfang()
      schwerpunkt(nullable:true)
      status()
      nebenfach()
    }

    //static belongsTo = [Personen]
    static hasMany = [nebenfach:Nebenfach]

    Date anfang
    String schwerpunkt
    Studienfach studienfach
	Fakultaet fakultaet
    Studiumstatus status

    String toString(){
      return "huhu" // wtf?!
    }
}
