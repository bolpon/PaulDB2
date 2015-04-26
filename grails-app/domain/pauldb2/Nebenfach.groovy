package pauldb2

class Nebenfach {

    static mapping = {
         table 'nebenfach_studium'
         // version is set to false, because this isn't available by default for legacy databases
         version false
         id generator:'identity', column:'nebenfachStudium_id'


    }

    
    static constraints = {
    }
    //Studium studium
    Studienfach studienfach

    String toString(){

      return studienfach
    }
}
