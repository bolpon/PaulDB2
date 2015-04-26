package pauldb2

import pauldb2.Unternehmen

class Branche {

    static constraints = {
    }

    static mapping = {
      table 'branche'
      // version is set to false, because this isn't available by default for legacy databases
      version false
      id generator:'identity', column:'branche_id'
      unternehmen joinTable:[name:"branche_unternehmen", key:"branche_id"]
    }

    static hasMany = [unternehmen : Unternehmen]
    static belongsTo = [Unternehmen]

    String branche

    String toString(){
      return branche
    }
}
