package pauldb2

class Login {

    static mapping = {
         table 'login'
         // version is set to false, because this isn't available by default for legacy databases
         version false
         id generator:'identity', column:'login_id'
         person column:'person_id'
         
    }

    static constraints = {
      role(inList:['user', 'admin'])

    }

    
    Personen person
    String loginname
    String password
    String role

    String toString(){

      return "Login: " + loginname + " Role: " + role;
    }
}
