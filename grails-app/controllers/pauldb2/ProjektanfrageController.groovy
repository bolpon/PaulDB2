package pauldb2

import grails.converters.JSON

class ProjektanfrageController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 20, 100)
        params.sort = params?.sort ?: "id"
        params.order = params?.order ?: "desc"
        [projektanfrageInstanceList: Projektanfrage.list(params), projektanfrageInstanceTotal: Projektanfrage.count(), phase:'']
    }

    def create = {
        def projektanfrageInstance = new Projektanfrage()

        def posTeammitglieder = Personen.findAllByPersonstatusInList([Personstatus.get(3), Personstatus.get(4), Personstatus.get(2)])
        def unternehmenlist = Unternehmen.list().sort{it.name}
        def kontaktlist = []

        posTeammitglieder.sort{
          it.nachname
        }

        projektanfrageInstance.properties = params
        return [projektanfrageInstance: projektanfrageInstance, posTeammitglieder: posTeammitglieder,
            unternehmenlist:unternehmenlist, kontaktlist:kontaktlist]
    }

    def save = {

         /*render params as JSON
         return false*/

        if(!params.personen || !params.unternehmen || !params.beschreibung || !params.kontakt) {
            flash.message = "${message(code: 'default.not.created.message', args: [message(code: 'projektanfrage.label', default: 'Projektanfrage'), params.id])}"
            redirect(action: "create")
        } else {

        def projektanfrageInstance = new Projektanfrage(params)

       /**
        * Tätigkeitsfelder-Daten Updaten
        */

         def tf = params.get('taetigkeitsFelder')

         // Rückgabewert ist einzeln ein String, bei mehreren ein Array
         if (params['taetigkeitsFelder']?.class?.name?.equals('java.lang.String')) {

             // Erzeuge ein neues Tätigkeitsfeld-Element
             def tf_new = pauldb2.Taetigkeitsfeld.findById(tf)
             // Füge es zum Projekt hinzu
             projektanfrageInstance.addToTaetigkeitsfeld(tf_new)

         } else {

             // das Gleiche wie oben, nur der übergebene Parameter ist eine Liste und muss durchiteriert werden
             tf.eachWithIndex{ item, i ->

                 def tf_new = pauldb2.Taetigkeitsfeld.findById(item)
                 projektanfrageInstance.addToTaetigkeitsfeld(tf_new)

             }
         }

         if (projektanfrageInstance.save(flush: true)) {
             log.info(session.userperson.toString() +" hat Projektanfrage "+ projektanfrageInstance.toString() + " angelegt.")
             flash.message = "${message(code: 'default.created.message', args: [message(code: 'projektanfrage.label', default: 'Projektanfrage'), projektanfrageInstance.id])}"
             redirect(action: "show", id: projektanfrageInstance.id)
         }
         else {
             render(view: "create", model:[projektanfrageInstance: projektanfrageInstance])
         }

        }
     }

    def show = {
        def projektanfrageInstance = Projektanfrage.get(params.id)
        if (!projektanfrageInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'projektanfrage.label', default: 'Projektanfrage'), params.id])}"
            redirect(action: "list")
        }
        else {
            [projektanfrageInstance: projektanfrageInstance]
        }
    }

    def edit = {


        def projektanfrageInstance = Projektanfrage.get(params.id)

        def taetigkeitsFelder = projektanfrageInstance.taetigkeitsfeld

        def taetigkeitsCluster = projektanfrageInstance.taetigkeitsfeld.cluster
        def taetigkeitsFelderSelectList = [:]

        taetigkeitsCluster.eachWithIndex{item, i ->
              def felder = Taetigkeitsfeld.findAllByCluster(item)
              taetigkeitsFelderSelectList.put(i,felder)

        }

        if (!projektanfrageInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'projektanfrage.label', default: 'Projektanfrage'), params.id])}"
            redirect(action: "list")
        }
        else {
            def posTeammitglieder = Personen.findAllByPersonstatus(Personstatus.get(3)) + Personen.findAllByPersonstatus(Personstatus.get(4)) + Personen.findAllByPersonstatus(Personstatus.get(2))
            posTeammitglieder.sort{
              it.nachname
            }

          /**
           * da posTeammitglieder nur aktuelle Anwärter, Paulis und AOler enthält
           * kann es vor allem bei älteren Projekten vorkommen, dass die Projektteammitglieder bzw der Coach nicht darunter sind
           * in diesem Fall werden sie zur der Liste hinzugefügt, damit sie in der Auswahlansicht als selektiert mit auftauchen
           *
           */


            def teammitglieder = projektanfrageInstance.personen.sort{it.nachname}

            //teammitglieder hinzufügen wenn nicht vorhanden
            teammitglieder.each{
              if(!posTeammitglieder.contains(it)){

                posTeammitglieder.add(it)
              }
            }

        def unternehmenlist = Unternehmen.list().sort{it.name}
        def kontaktlist = []
        unternehmenlist.each{
            kontaktlist += Kontakt.getKontakteMitUnternehmen(it)
        }

            return [projektanfrageInstance: projektanfrageInstance, posTeammitglieder:posTeammitglieder, teammitglieder:teammitglieder,
                    taetigkeitsCluster:taetigkeitsCluster, taetigkeitsFelder:taetigkeitsFelder,
                    taetigkeitsFelderSelectList:taetigkeitsFelderSelectList, role: session.role,
                    unternehmenlist: unternehmenlist, kontaktlist:kontaktlist]
        }
    }

    def update = {
        if(!params.personen || !params.unternehmen || !params.beschreibung || !params.kontakt) {
            flash.message = "${message(code: 'default.not.updated.message', args: [message(code: 'projektanfrage.label', default: 'Projektanfrage'), params.id])}"
            redirect(action: "edit", id: params.id)
        } else {

        def projektanfrageInstance = Projektanfrage.get(params.id)

       // zum Ausgeben der übergebenen Daten als JSON-Datei Kommentar unten entfernen
       // render params as JSON

          //Löschen der alten Inhalte
          def alteLeute = projektanfrageInstance.personen - params.personen
            alteLeute.each {
              projektanfrageInstance.removeFromPersonen(it)
            }

          alteLeute = projektanfrageInstance.unternehmen - params.unternehmen
            alteLeute.each {
              projektanfrageInstance.removeFromUnternehmen(it)
            }

     /**
      * Tätigkeitsfelder-Daten Updaten
      */

       // neue Tätigkeitsfelder
       def tf_new = params.get('taetigkeitsFelder')
       // alte Tätigkeitsfelder
       def tf_old = projektanfrageInstance.taetigkeitsfeld

       // Liste zum Vormerken der löschenden Items
       def taetigkeitsFelder_delete = []

       if (params['taetigkeitsFelder']?.class?.name?.equals('java.lang.String')) {
          // Lösche altes Item
          tf_old.eachWithIndex {item, i ->
               if (!(item.id == Integer.parseInt(tf_new))) {
                   taetigkeitsFelder_delete.add(item)
               }
           }

           if (!(tf_old.find{it.id == Integer.parseInt(tf_new)})) {
               // Füge Tätigkeitsfeld hinzu
               def tf = pauldb2.Taetigkeitsfeld.findById(tf_new)
               projektanfrageInstance.addToTaetigkeitsfeld(tf)
           }
       } else {
           // Ist neues TF in alten zu finden?
           if (tf_old != null) {
               tf_old.eachWithIndex{ item, i ->
                   // Wenn nein:
                   if (!(tf_new.find{Integer.parseInt(it) == item.id})) {
                       // Lösche altes Item
                       def tf = projektanfrageInstance.taetigkeitsfeld.find{it.id == item.id}
                       taetigkeitsFelder_delete.add(tf)
                   }
               }
           }
           tf_new.eachWithIndex{ item, i ->
               //Falls Tätigkeitsfeld noch nicht vorhanden ist
               if (!(tf_old.find{it.id == Integer.parseInt(item)})) {
                   // Füge Tätigkeitsfeld hinzu
                   def tf = pauldb2.Taetigkeitsfeld.findById(item)
                   projektanfrageInstance.addToTaetigkeitsfeld(tf)
               }
           }
       }

       // Zum löschen vorgemerkte TF löschen
       taetigkeitsFelder_delete.each{
           projektanfrageInstance.removeFromTaetigkeitsfeld(it)
       }

     /**
       * restliches Projekt updaten
      */

       //def projekteInstance = Projekte.get(params.id)
       if (projektanfrageInstance) {
           if (params.version) {
               def version = params.version.toLong()
               if (projektanfrageInstance.version > version) {

                   projektanfrageInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'projektanfrage.label', default: 'Projektanfrage')] as Object[], "Another user has updated this Projekte while you were editing")
                   render(view: "edit", model: [projektanfrageInstance: projektanfrageInstance])
                   return
               }
           }
           projektanfrageInstance.properties = params
           if (!projektanfrageInstance.hasErrors() && projektanfrageInstance.save(flush: true)) {
               flash.message = "${message(code: 'default.updated.message', args: [message(code: 'projektanfrage.label', default: 'Projektanfrage'), projektanfrageInstance.id])}"
               log.info(session.userperson.toString() +" hat Projektanfrage "+ projektanfrageInstance.toString() + " upgedated.")
               redirect(action: "show", id: projektanfrageInstance.id)
           }
           else {
               render(view: "edit", model: [projektanfrageInstance: projektanfrageInstance])
           }
       }
       else {
           flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'projektanfrage.label', default: 'Projektanfrage'), params.id])}"
           redirect(action: "list")
       }

     }
   }

    def delete = {
      def projektanfrageInstance = Projektanfrage.get(params.id)
        if (projektanfrageInstance) {
            def unternehmen = projektanfrageInstance.unternehmen.toList()
            unternehmen.each{
              it.removeFromProjektanfragen(projektanfrageInstance)
            }

            def personen = projektanfrageInstance.personen.toList()
            personen.each{
                it.removeFromProjektanfragen(projektanfrageInstance)
            }

            def taetigkeit = projektanfrageInstance.taetigkeitsfeld.toList()
            taetigkeit.each{
                it.removeFromProjektanfragen(projektanfrageInstance)
            }

            try {
                def name = projektanfrageInstance.toString()
                projektanfrageInstance.delete(flush: true)
                log.info(session.userperson.toString() +" hat Projektanfrage "+ name + " gelöscht.")
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'projektanfrage.label', default: 'Projektanfrage'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'projektanfrage.label', default: 'Projektanfrage'), params.id], default:'Projektanfrage konnte nicht gelöscht werden.')}"
                log.error("Fehler beim Löschen von Projektanfrage: "+ projektanfrageInstance.toString())
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'projektanfrage.label', default: 'Projektanfrage'), params.id])}"
            redirect(action: "list")
        }

    }

    def unternehmenAutoComplete = {

       def u = Unternehmen.createCriteria().list(){
          like("name","%"+params.term+"%")

       }

       u.sort{it.name}
       def unternehmen = u.collect {
          [id:it.id, label:it.name, value:it.name]
        }

       render unternehmen as JSON
    }

    def getProjektanfragenByUnternehmen = {
       def potAnfragen = ProjektanfrageUnternehmen.findAllByUnternehmen(Unternehmen.get(params.id))
       potAnfragen = potAnfragen.collect {
           [id:it.projektanfrage.id, kid: it.projektanfrage.kontakt.id, bezeichnung: it.projektanfrage.toString()]
       }
       render potAnfragen as JSON
   }


    def anfrageStatusSearch = {
        params.max = Math.min(params.max ? params.int('max') : 20, 100)
        params.sort = params?.sort ?: "id"
        params.order = params?.order ?: "desc"
        Projektanfragephase pap = Projektanfragephase.get(params.anfragephaseProjekt)

        if(pap){
            def list = Projektanfrage.findAllByProjektanfragephase(pap,params)
            def total = Projektanfrage.countByProjektanfragephase(pap)
            render(view: 'list', model:[projektanfrageInstanceList: list, projektanfrageInstanceTotal: total, phase: params.anfragephaseProjekt])
        }
        else{
            render "error"
        }

    }
}
