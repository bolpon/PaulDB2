package pauldb2

class MitarbeiterPosition {

    static mapping = {
         table 'position'
         // version is set to false, because this isn't available by default for legacy databases
         version false
         id generator:'identity', column:'position_id'
    }

    static constraints = {
    }

    String position

    String toString(){
      return position
    }
}
