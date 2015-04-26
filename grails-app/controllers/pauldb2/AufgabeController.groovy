package pauldb2

import grails.converters.JSON




class AufgabeController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]


    def beforeInterceptor = [action:this.&checkUser]

    def checkUser(){

        if(!session.userperson){
          redirect(uri:"/");
          return false

        }

        //geht um spezielle Aufgabe -> prüfen ob Zugriff erlaubt
        if(params['id']){
          def aufgabe = Aufgabe.get(params['id'])
          if(aufgabe){
            //Aufgabe ist vorhanden
            if(aufgabe.geschuetzt){
              //Aufgabe ist geschützt, prüfen ob Zugriff gestattet ist
              def person = Personen.get(session.userperson.id)
              if(!(aufgabe.bearbeiter.contains(person) || aufgabe.verwalter.contains(person) || aufgabe.personenMitZugriff.contains(person))){
                flash.message = "Du hast keinen Zugriff auf diese Aufgabe."
                redirect(uri:"/aufgabe/list");
                return false
              }
            }
          }else{
            //Keine Aufgabe zur Id gefunden, umleiten zur Listenansicht
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'aufgabe.label', default: 'Aufgabe'), params.id])}"
            redirect(action: "list")
            return false

          }


        }
    }


    def index = {
        redirect(action: "list", params: params)
    }

    def list = {


        params.max = Math.min(params.max ? params.int('max') : 30, 100)

        def aufgaben = Aufgabe.list(params)

        def person = Personen.get(session.userperson.id)

        def AufgabenOhneZugriff = []

        aufgaben.eachWithIndex {item, i ->
          if(item.geschuetzt){
            if(!(item.bearbeiter.contains(person) || item.verwalter.contains(person) || item.personenMitZugriff.contains(person))){
              AufgabenOhneZugriff.add(item)
              println('ohne zugriff: ' + item)
            }
          }

        }

        def aufgabeInstanceList = Aufgabe.list(params)
        aufgabeInstanceList.removeAll(AufgabenOhneZugriff)


        [aufgabeInstanceList: aufgabeInstanceList, aufgabeInstanceTotal: (Aufgabe.count()-AufgabenOhneZugriff.size()), role: session.role]
    }

    def create = {
        def aufgabeInstance = new Aufgabe()

        //Sich selbst zu den Verwaltern hinzufügen
        aufgabeInstance.verwalter = Personen.findAllById(session.userperson.id)


        def posPaulis = Personen.findAllByPersonstatus(Personstatus.get(3)) + Personen.findAllByPersonstatus(Personstatus.get(4)) + Personen.findAllByPersonstatus(Personstatus.get(2))

        posPaulis.sort{
          it.nachname
        }

        aufgabeInstance.properties = params
        return [aufgabeInstance: aufgabeInstance, posPaulis:posPaulis]
    }

    def save = {

        //render params as JSON

        def aufgabeInstance = new Aufgabe(params)
        //aufgabeInstance.oberaufgabe = aufgabeInstance
        aufgabeInstance.status = Aufgabenstatus.get(1)

        //Verwalter
        if(params['verwalter.id']?.class?.name?.equals("java.lang.String")){
            def person = Personen.get(params['verwalter.id'])
            person.addToAufgabenVerwalten(aufgabeInstance)
            //aufgabeInstance.addToVerwalter(person)
            log.debug("Adding to Verwalter: " + person)
        }
        else{

            params['verwalter.id'].eachWithIndex {item, i ->

              def person = Personen.get(item)
              //aufgabeInstance.addToVerwalter(person)
              person.addToAufgabenVerwalten(aufgabeInstance)
              log.debug("Adding to Verwalter: " + person)
            }

        }
        //Bearbeiter
        if(params['bearbeiter.id']?.class?.name?.equals("java.lang.String")){
            def person = Personen.get(params['bearbeiter.id'])
            //aufgabeInstance.addToBearbeiter(person)
            person.addToAufgabenBearbeiten(aufgabeInstance)
            log.debug("Adding to Bearbeiter: " + person)
        }
        else{

            params['bearbeiter.id'].eachWithIndex {item, i ->

              def person = Personen.get(item)
              //aufgabeInstance.addToBearbeiter(person)
              person.addToAufgabenBearbeiten(aufgabeInstance)
              log.debug("Adding to Bearbeiter: " + person)
            }

        }
        //Zugriff, nur, wenn checkbox auch ausgewählt ist
        if(params['geschuetzt']?.equals('on')){
          if(params['personenMitZugriff.id']?.class?.name?.equals("java.lang.String")){
            def person = Personen.get(params['personenMitZugriff.id'])
            //aufgabeInstance.addToBearbeiter(person)
            person.addToAufgabenZugriff(aufgabeInstance)
            log.debug("Adding to Bearbeiter: " + person)
            }
            else{

                params['personenMitZugriff.id'].eachWithIndex {item, i ->

                  def person = Personen.get(item)
                  //aufgabeInstance.addToBearbeiter(person)
                  person.addToAufgabenZugriff(aufgabeInstance)
                  log.debug("Adding to Bearbeiter: " + person)
                }

            }
        }




        if (aufgabeInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'aufgabe.label', default: 'Aufgabe'), aufgabeInstance.id])}"
            log.info(session.userperson.toString() + "hat Aufgabe " + aufgabeInstance.name+ " angelegt")
            redirect(action: "show", id: aufgabeInstance.id)

        }
        else {
            render(view: "create", model: [aufgabeInstance: aufgabeInstance])
        }
    }

    def show = {
        def aufgabeInstance = Aufgabe.get(params.id)




        if (!aufgabeInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'aufgabe.label', default: 'Aufgabe'), params.id])}"
            redirect(action: "list")
        }
        else {
            log.info("Aufgabe " + aufgabeInstance.name+ " wurde angezeigt")
            [aufgabeInstance: aufgabeInstance, role: session.role]
        }
    }

    def edit = {
        def aufgabeInstance = Aufgabe.get(params.id)

        def posPaulis = Personen.findAllByPersonstatus(Personstatus.get(3)) + Personen.findAllByPersonstatus(Personstatus.get(4)) + Personen.findAllByPersonstatus(Personstatus.get(2))

        posPaulis.sort{
          it.nachname
        }


        if (!aufgabeInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'aufgabe.label', default: 'Aufgabe'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [aufgabeInstance: aufgabeInstance,posPaulis:posPaulis, role: session.role]
        }
    }

    def update = {
        def aufgabeInstance = Aufgabe.get(params.id)
        if(params['status']){
          params['status'] = Aufgabenstatus.get(params['status'])
        }

        //Verwalter updaten

        if(params['verwalter.id']?.class?.name?.equals("java.lang.String")){
            def person = Personen.get(params['verwalter.id'])

            //Aufgabe bei Personen entfernen, die nicht mehr dabei sind
            def personenList = aufgabeInstance.verwalter
            personenList.eachWithIndex{item,i ->
              if(item.id!=Integer.parseInt(params['verwalter.id'])){
                item.removeFromAufgabenVerwalten(aufgabeInstance)
              }
            }

            //Prüfen, ob die Person schon zur Aufgabe gehört, ansonsten zuweisen
            if(!person.aufgabenVerwalten.contains(aufgabeInstance)){
              person.addToAufgabenVerwalten(aufgabeInstance)
            }

        }
        else{

            def verwalterAltList = aufgabeInstance.verwalter
            def verwalterNeuList = []

            params['verwalter.id'].eachWithIndex {item, i ->

              def person = Personen.get(item)
              verwalterNeuList.add(person)

              //Prüfen ob Aufgabe und Person verknüpft sind, wenn nicht -> verknüpfen
              if(!person.aufgabenVerwalten.contains(aufgabeInstance)){
                person.addToAufgabenVerwalten(aufgabeInstance)
              }

            }


            // Leute entfernen, die nicht mehr an der Aufgabe beteiligt sind
            def deleteList = []

              verwalterAltList.each{
                if(!verwalterNeuList.contains(it)){
                  deleteList.add(it)
                }
              }
              deleteList.each{
                it.removeFromAufgabenVerwalten(aufgabeInstance)
              }

        }

        //Bearbeiter updaten

        if(params['bearbeiter.id']?.class?.name?.equals("java.lang.String")){
            def person = Personen.get(params['bearbeiter.id'])

            //Aufgabe bei Personen entfernen, die nicht mehr dabei sind
            def personenList = aufgabeInstance.bearbeiter
            personenList.eachWithIndex{item,i ->
              if(item.id!=Integer.parseInt(params['bearbeiter.id'])){
                item.removeFromAufgabenBearbeiten(aufgabeInstance)
              }
            }

            //Prüfen, ob die Person schon zur Aufgabe gehört, ansonsten zuweisen
            if(!person.aufgabenBearbeiten.contains(aufgabeInstance)){
              person.addToAufgabenBearbeiten(aufgabeInstance)
            }
        }
        else{

            def bearbeiterAltList = aufgabeInstance.bearbeiter
            def bearbeiterNeuList = []

            params['bearbeiter.id'].eachWithIndex {item, i ->

              def person = Personen.get(item)
              bearbeiterNeuList.add(person)

              //Prüfen ob Aufgabe und Person verknüpft sind, wenn nicht -> verknüpfen
              if(!person.aufgabenBearbeiten.contains(aufgabeInstance)){
                person.addToAufgabenBearbeiten(aufgabeInstance)
              }

            }


            // Leute entfernen, die nicht mehr an der Aufgabe beteiligt sind
            def deleteList = []

              bearbeiterAltList.each{
                if(!bearbeiterNeuList.contains(it)){
                  deleteList.add(it)
                }
              }
              deleteList.each{
                it.removeFromAufgabenBearbeiten(aufgabeInstance)
              }


        }

        //Leute mit Zugriffserlaubnis updaten updaten
        if(params['geschuetzt']?.equals('on')){
          if(params['personenMitZugriff.id']?.class?.name?.equals("java.lang.String")){
              def person = Personen.get(params['personenMitZugriff.id'])

              //Aufgabe bei Personen entfernen, die nicht mehr dabei sind
              def personenList = aufgabeInstance.personenMitZugriff
              personenList.eachWithIndex{item,i ->
                if(item.id!=Integer.parseInt(params['personenMitZugriff.id'])){
                  item.removeFromAufgabenZugriff(aufgabeInstance)
                }
              }

              //Prüfen, ob die Person schon zur Aufgabe gehört, ansonsten zuweisen
              if(!person.aufgabenZugriff.contains(aufgabeInstance)){
                person.addToAufgabenZugriff(aufgabeInstance)
              }
          }
          else{

              def zugriffAltList = aufgabeInstance.personenMitZugriff
              def zugriffNeuList = []

              params['personenMitZugriff.id'].eachWithIndex {item, i ->

                def person = Personen.get(item)
                zugriffNeuList.add(person)

                //Prüfen ob Aufgabe und Person verknüpft sind, wenn nicht -> verknüpfen
                if(!person.aufgabenZugriff.contains(aufgabeInstance)){
                  person.addToAufgabenZugriff(aufgabeInstance)
                }

              }


              // Leute entfernen, die nicht mehr an der Aufgabe beteiligt sind
              def deleteList = []

                zugriffAltList.each{
                  if(!zugriffNeuList.contains(it)){
                    deleteList.add(it)
                  }
                }
                deleteList.each{
                  it.removeFromAufgabenZugriff(aufgabeInstance)
                }


          }
        }

        if (aufgabeInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (aufgabeInstance.version > version) {
                    
                    aufgabeInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'aufgabe.label', default: 'Aufgabe')] as Object[], "Another user has updated this Aufgabe while you were editing")
                    render(view: "edit", model: [aufgabeInstance: aufgabeInstance])
                    return
                }
            }
            aufgabeInstance.properties = params
            if (!aufgabeInstance.hasErrors() && aufgabeInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'aufgabe.label', default: 'Aufgabe'), aufgabeInstance.id])}"
                log.info(session.userperson.toString() + "hat Aufgabe " + aufgabeInstance.name + " geupdated")
                redirect(action: "show", id: aufgabeInstance.id)
            }
            else {
                render(view: "edit", model: [aufgabeInstance: aufgabeInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'aufgabe.label', default: 'Aufgabe'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def aufgabeInstance = Aufgabe.get(params.id)
        if (aufgabeInstance) {
            try {

                def verwalterList = aufgabeInstance.verwalter.toList()
                verwalterList.each{
                    it.removeFromAufgabenVerwalten(aufgabeInstance)
                }

                def bearbeiterList = aufgabeInstance.bearbeiter.toList()
                bearbeiterList.each{
                    aufgabeInstance.removeFromBearbeiter(it)
                }

                def zugriffList = aufgabeInstance.personenMitZugriff.toList()
                zugriffList.each{
                    aufgabeInstance.removeFromPersonenMitZugriff(it)
                }

                aufgabeInstance.delete(flush: true)
                def name = aufgabeInstance.name
                log.info(session.userperson.toString() + "hat Aufgabe " + name+ " gelöscht")
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'aufgabe.label', default: 'Aufgabe'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'aufgabe.label', default: 'Aufgabe'), params.id])}"
                log.error("Fehler beim Löschen der Aufgabe: " + aufgabeInstance.name)
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'aufgabe.label', default: 'Aufgabe'), params.id])}"
            redirect(action: "list")
        }
    }
}
