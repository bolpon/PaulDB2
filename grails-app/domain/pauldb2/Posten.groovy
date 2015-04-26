package pauldb2

class Posten {


    static mapping = {
         table 'postenRessorts'
         // version is set to false, because this isn't available by default for legacy databases
         version false
         id generator:'identity', column:'postenRessort_id'
         postenKurz column: 'postenKurz'
         postenName column: 'postenName'
         aktiv column: 'aktiv'
         person joinTable: [name:"person_postenRessorts", key:"postenRessort_id", column:"person_id"]
    }

    static hasMany = [person:Personen]


    static constraints = {
    }


    String postenName
    String postenKurz
    boolean aktiv

    String toString(){
        return postenName
    }
}
