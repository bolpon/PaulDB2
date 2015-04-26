package pauldb2

import grails.converters.JSON
import java.text.SimpleDateFormat

class SchulungController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def beforeInterceptor = [action:this.&checkUser]

    def checkUser(){

        if(!session.userperson){
          flash.message = "Bitte melde dich an."
          flash.redirect = request.forwardURI - request.contextPath
          redirect(uri:"/");
          return false

        }
    }

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)

        if(!params.sort){
          params.sort='termin'
          params.order='desc'
        }

        [schulungInstanceList: Schulung.list(params), schulungInstanceTotal: Schulung.count(), role: session.role]
    }

    def create = {
        def schulungInstance = new Schulung()

        def posTeilnehmer = Personen.findAllByPersonstatus(Personstatus.get(3)) + Personen.findAllByPersonstatus(Personstatus.get(4))+ Personen.findAllByPersonstatus(Personstatus.get(2) )  +  Personen.findAllByPersonstatus(Personstatus.get(1) )

        posTeilnehmer.sort{
          it.nachname
        }

        schulungInstance.properties = params
        return [schulungInstance: schulungInstance, posTeilnehmer:posTeilnehmer]
    }

    def save = {
        if (!params.schulungbewertungstatus) params.schulungbewertungstatus = Schulungbewertungstatus.get(1) //Standard solange nicht gekl�rt
        def schulungInstance = new Schulung(params)
        SimpleDateFormat time = new SimpleDateFormat('dd.MM.yyyy HH:mm')
        schulungInstance.termin = time.parse(params.get('termin')+" "+params.get('uhrzeit'))

        if (schulungInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'schulung.label', default: 'Schulung'), schulungInstance.id])}"
            log.info(session.userperson.toString() +" hat Schulung "+ schulungInstance.toString() + " angelegt.")
            redirect(action: "show", id: schulungInstance.id)
        }
        else {
            render(view: "create", model: [schulungInstance: schulungInstance])
        }
    }

    def show = {
        def schulungInstance = Schulung.get(params.id)
        if (!schulungInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'schulung.label', default: 'Schulung'), params.id])}"
            redirect(action: "list")
        }
        else {
            log.info("Schulung: " + schulungInstance.toString() + " wird angezeigt ")
            [schulungInstance: schulungInstance, role: session.role]
        }
    }

    def edit = {
        def schulungInstance = Schulung.get(params.id)
        if (!schulungInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'schulung.label', default: 'Schulung'), params.id])}"
            redirect(action: "list")
        }
        else {

            def posTeilnehmer = Personen.findAllByPersonstatus(Personstatus.get(3)) + Personen.findAllByPersonstatus(Personstatus.get(4)) + Personen.findAllByPersonstatus(Personstatus.get(2))    +  Personen.findAllByPersonstatus(Personstatus.get(1) )
            return [schulungInstance: schulungInstance, posTeilnehmer:posTeilnehmer, role: session.role]
        }
    }

    def update = {
        //render params as JSON
        def schulungInstance = Schulung.get(params.id)
        if (!params.schulungbewertungstatus) params.schulungbewertungstatus = schulungInstance.schulungbewertungstatus
        //Teilnehmer updaten

        if(params['schulungTeilnehmer']?.class?.name?.equals("java.lang.String")){
            def person = Personen.get(params['schulungTeilnehmer'])

            //Aufgabe bei Personen entfernen, die nicht mehr dabei sind
            def personenList = schulungInstance.teilnehmer
            personenList.eachWithIndex{item,i ->
              if(item.id!=Integer.parseInt(params['schulungTeilnehmer'])){
                item.removeFromSchulungen(schulungInstance)
              }
            }

            //Pr�fen, ob die Person schon zur Aufgabe geh�rt, ansonsten zuweisen
            if(!person.schulungen.contains(schulungInstance)){
              person.addToSchulungen(schulungInstance)
            }
        }
        else{

            def teilnehmerAltList = schulungInstance.teilnehmer
            def teilnehmerNeuList = []

            params['schulungTeilnehmer'].eachWithIndex {item, i ->

              def person = Personen.get(item)
              teilnehmerNeuList.add(person)

              //Pr�fen ob Aufgabe und Person verkn�pft sind, wenn nicht -> verkn�pfen
              if(!person.schulungen.contains(schulungInstance)){
                person.addToSchulungen(schulungInstance)
              }

            }


            // Leute entfernen, die nicht mehr an der Aufgabe beteiligt sind
            def deleteList = []

              teilnehmerAltList.each{
                if(!teilnehmerNeuList.contains(it)){
                  deleteList.add(it)
                }
              }
              deleteList.each{
                it.removeFromSchulungen(schulungInstance)
              }


        }

        //Leiter updaten

        if(params['schulungLeiter']?.class?.name?.equals("java.lang.String")){
            def person = Personen.get(params['schulungLeiter'])

            //Aufgabe bei Personen entfernen, die nicht mehr dabei sind
            def personenList = schulungInstance.leiter
            personenList.eachWithIndex{item,i ->
              if(item.id!=Integer.parseInt(params['schulungLeiter'])){
                item.removeFromGeleiteteSchulungen(schulungInstance)
              }
            }

            //Pr�fen, ob die Person schon zur Aufgabe geh�rt, ansonsten zuweisen
            if(!person.geleiteteSchulungen.contains(schulungInstance)){
              person.addToGeleiteteSchulungen(schulungInstance)
            }
        }
        else{

            def leiterAltList = schulungInstance.leiter
            def leiterNeuList = []

            params['schulungLeiter'].eachWithIndex {item, i ->

              def person = Personen.get(item)
              leiterNeuList.add(person)

              //Pr�fen ob Aufgabe und Person verkn�pft sind, wenn nicht -> verkn�pfen
              if(!person.geleiteteSchulungen.contains(schulungInstance)){
                person.addToGeleiteteSchulungen(schulungInstance)
              }

            }


            // Leute entfernen, die nicht mehr an der Aufgabe beteiligt sind
            def deleteList = []

              leiterAltList.each{
                if(!leiterNeuList.contains(it)){
                  deleteList.add(it)
                }
              }
              deleteList.each{
                it.removeFromGeleiteteSchulungen(schulungInstance)
              }


        }

        if (schulungInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (schulungInstance.version > version) {

                    schulungInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'schulung.label', default: 'Schulung')] as Object[], "Another user has updated this Schulung while you were editing")
                    render(view: "edit", model: [schulungInstance: schulungInstance])
                    return
                }
            }
            // setzen des Datums
            schulungInstance.properties = params
            SimpleDateFormat time = new SimpleDateFormat('dd.MM.yyyy HH:mm')
            schulungInstance.termin = time.parse(params.get('termin')+" "+params.get('uhrzeit'))

            //schulungInstance.termin.
            if (!schulungInstance.hasErrors() && schulungInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'schulung.label', default: 'Schulung'), schulungInstance.id])}"
                log.info(session.userperson.toString() +" hat Schulung "+ schulungInstance.toString() + " geupdated.")
                redirect(action: "show", id: schulungInstance.id)
            }
            else {
                render(view: "edit", model: [schulungInstance: schulungInstance])
            }
        } else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'schulung.label', default: 'Schulung'), params.id])}"
            redirect(action: "list")
        }

    }

    def delete = {
        def schulungInstance = Schulung.get(params.id)
        if (schulungInstance) {

            def leiterAltList = schulungInstance.leiter
            def deleteList = []
            leiterAltList.each{
              deleteList.add(it)
            }

            deleteList.each{
              it.removeFromGeleiteteSchulungen(schulungInstance)
            }


            try {
                def name = schulungInstance.bezeichnung
                schulungInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'schulung.label', default: 'Schulung'), params.id])}"
                log.info(session.userperson.toString() +" hat Schulung "+ name + " gel�scht.")
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'schulung.label', default: 'Schulung'), params.id])}"
                log.info("Fehler beim L�schen der Schulung: " + schulungInstance.bezeichnung)
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'schulung.label', default: 'Schulung'), params.id])}"
            redirect(action: "list")
        }
    }

    def filter = {
        if (params?.status != 'intern' && params?.status != 'extern') {
            // Gebe Fehler aus
            render "error"
        }

        params.max = Math.min(params.max ? params.int('max') : 20, 100)

        params.offset = params?.offset?.toInteger() ?: 0

        if (params?.order_by == 'Name') {
            params.sort = params?.sort ?: "bezeichnung"
        } else {
            params.sort = params?.sort ?: "termin"
        }
        if (params?.order_by_order == 'aufsteigend') {
            params.order = params?.order ?: "asc"
        } else {
            params.order = params?.order ?: "desc"
        }

        def status = params?.status

        params.max = Math.min(params?.max?.toInteger() ?: 20, 100)

        // Suche alle Schulungen deren "Status" int_ext entspricht
        def list = Schulung.createCriteria().list(
            max: params.max,
            offset: params.offset,
            sort: params.sort,
            order: params.order)
            {
                like("status", status)
            }

        // Anzahl der Ergebnisse (ben�tigt f�r Darstellung)
        def total = Schulung.countByStatus(status)

        // Gebe alle n�tigen Daten an den View
        render(view: 'list', model:[schulungInstanceList: list, schulungInstanceTotal: total, status:status])

    }

    def suche = {
        params.max = Math.min(params?.max?.toInteger() ?: 20, 100)
        params.offset = params?.offset?.toInteger() ?: 0

        if (params?.order_by == 'Name') {
            params.sort = params?.sort ?: "bezeichnung"
        } else {
            params.sort = params?.sort ?: "termin"
        }

        if (params?.order_by_order == 'aufsteigend') {
            params.order = params?.order ?: "asc"
        } else {
            params.order = params?.order ?: "desc"
        }

        def searchFor = params.searchFor
        def name = params.searchInput1
        def nachname = params.searchInput2
        def listSchulung = []

        if (searchFor == 'Schulung') {
            // Suche nach Schulungsnamen

            listSchulung = Schulung.createCriteria().list(
                    max: params.max,
                    offset: params.offset,
                    sort: params.sort,
                    order: params.order)
                    {
                        like("bezeichnung", "%" + name + "%")
                    }
        } else {
            // Suche nach Teilnehmern

            def potPersonen = Personen.createCriteria().list(){
               like("vorname", name+"%")
               like("nachname", nachname+"%")
            }
            def IDListe = []

            def teilnehmer = NimmtTeil_AnSchulung.findAllByPersonInList(potPersonen)
            teilnehmer.each{IDListe.add(it.schulung.id)}
            def leiter = Haelt_Schulung.findAllByPersonInList(potPersonen)
            leiter.each{IDListe.add(it.schulung.id)}

            listSchulung = Schulung.createCriteria().list(
                    max: params.max,
                    offset: params.offset,
                    sort: params.sort,
                    order: params.order){
                        inList("id", IDListe)
            }
        }

        def total = listSchulung.size()

        render(view: 'list', model:[schulungInstanceList: listSchulung, schulungInstanceTotal: total, name:name, nachname:nachname])
    }
}