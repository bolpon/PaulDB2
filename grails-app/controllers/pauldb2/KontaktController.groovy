package pauldb2

import grails.converters.JSON
import org.springframework.security.ldap.userdetails.Person

class KontaktController {

    def beforeInterceptor = [action:this.&checkUser]

    def checkUser(){

        if(!session.userperson){
          redirect(uri:"/");
          return false

        }
    }

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }


    def unternehmenList = {
      def unternehmen = Unternehmen.createCriteria().list(){

            or {
                like("name","%"+params.term+"%")
                like("kurzname","%"+params.term+"%")
              }
      }


      unternehmen = unternehmen.collect{
        [id:it.id, label:it.name, value:it.name]
      }

      render unternehmen as JSON
    }


    def list = {
        params.sort = params?.sort ?: "datum"
        params.order = params?.order ?: "desc"
        params.max = Math.min(params.max ? params.int('max') : 10, 100)

      [kontaktInstanceList: Kontakt.list(params), kontaktInstanceTotal: Kontakt.count(), role: session.role]
    }

    def create = {
        def kontaktInstance = params.kontaktInstance ?: new Kontakt()

        def posPaulis = Personen.findAllByPersonstatus(Personstatus.get(3)) + Personen.findAllByPersonstatus(Personstatus.get(4)) + Personen.findAllByPersonstatus(Personstatus.get(2))

        posPaulis.sort{
          it.nachname
        }

        kontaktInstance.datum = kontaktInstance.datum ?: new Date()
        kontaktInstance.properties = params
        return [kontaktInstance: kontaktInstance, posPaulis:posPaulis]
    }

    def save = {
        if (!params.personen || !params.mitarbeiter) {
            flash.message = "${message(code: 'default.not.created.message', args: [message(code: 'projektanfrage.label', default: 'Projektanfrage'), params.id])}"
            redirect(action: "create")
        } else {
        def kontaktInstance = new Kontakt(params)

        kontaktInstance.name = bezeichnerErstellen(kontaktInstance)
		kontaktInstance.geaendert = true

            if (kontaktInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.created.message', args: [message(code: 'kontakt.label', default: 'Kontakt'), kontaktInstance.id])}"
                    redirect(action: "show", id: kontaktInstance.id)
            } else {
                render(view: "create", model: [kontaktInstance: kontaktInstance])
            }
        }
        
    }

    def show = {
        def kontaktInstance = Kontakt.get(params.id)

        if (!kontaktInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'kontakt.label', default: 'Kontakt'), params.id])}"
            redirect(action: "list")
        }
        else {
            [kontaktInstance: kontaktInstance, role: session.role]
        }
    }

    def edit = {
        def kontaktInstance = Kontakt.get(params.id)

        List posMitarbeiter = []

        kontaktInstance.mitarbeiter.each{
             posMitarbeiter += it.unternehmen.mitarbeiter
        }

        posMitarbeiter = posMitarbeiter.unique()

        def posPaulis = Personen.findAllByPersonstatus(Personstatus.get(3)) + Personen.findAllByPersonstatus(Personstatus.get(4)) + Personen.findAllByPersonstatus(Personstatus.get(2))

        posPaulis.sort{
          it.nachname
        }


        if (!kontaktInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'kontakt.label', default: 'Kontakt'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [kontaktInstance: kontaktInstance, posPaulis:posPaulis, posMitarbeiter:posMitarbeiter, role: session.role]
        }
    }

    def update = {
      def kontaktInstance = Kontakt.get(params.id)
        if (!params.personen || !params.mitarbeiter) {
            flash.message = "${message(code: 'default.not.updated.message', args: [message(code: 'projektanfrage.label', default: 'Projektanfrage'), params.id])}"
            redirect(action: "edit", id: params.id)
        } else {
      if (kontaktInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (kontaktInstance.version > version) {

                    kontaktInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'kontakt.label', default: 'Kontakt')] as Object[], "Another user has updated this Kontakt while you were editing")
                    render(view: "edit", model: [kontaktInstance: kontaktInstance])
                    return
                }
            }

          //Löschen der alten Inhalte
          def alteLeute = kontaktInstance.personen - params.personen
            alteLeute.each {
              kontaktInstance.removeFromPersonen(it)
            }

          alteLeute = kontaktInstance.mitarbeiter - params.mitarbeiter
            alteLeute.each {
              kontaktInstance.removeFromMitarbeiter(it)
            }

            kontaktInstance.properties = params
            kontaktInstance.name = bezeichnerErstellen(kontaktInstance)
			kontaktInstance.geaendert = true

            if (!kontaktInstance.hasErrors() && kontaktInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'kontakt.label', default: 'Kontakt'), kontaktInstance.id])}"
                redirect(action: "show", id: kontaktInstance.id)
            }
            else {
                render(view: "edit", model: [kontaktInstance: kontaktInstance])
            }
        }

      else {
        flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'kontakt.label', default: 'Kontakt'), params.id])}"
            redirect(action: "list")
        }
        }
    }

    def delete = {
        def kontaktInstance = Kontakt.get(params.id)
        if (kontaktInstance) {

            kontaktInstance.personen.each {

              kontaktInstance.removeFromPersonen(Personen.get(it.id))
            }

            kontaktInstance.mitarbeiter.each {

              kontaktInstance.removeFromMitarbeiter(Mitarbeiter.get(it.id))
            }

            try {
                kontaktInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'kontakt.label', default: 'Kontakt'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'kontakt.label', default: 'Kontakt'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'kontakt.label', default: 'Kontakt'), params.id])}"
            redirect(action: "list")
        }
    }

    private String bezeichnerErstellen(Kontakt kontakt){
        def ausgabe=""
        def unter = []
        kontakt.mitarbeiter.each{
            ausgabe = it.unternehmen.kurzname
            if (!(ausgabe)) ausgabe = it.unternehmen.name
            if (!(unter.contains(ausgabe))) unter.add(ausgabe)
        }
        ausgabe = ""
        unter.each{
            ausgabe += it
        }
        if(ausgabe.length() > 80){
          ausgabe = ausgabe.substring(0,80) +'..'
        }

        return   kontakt.datum.dateString + '_' +  ausgabe
    }

    def nameUpdate = {
        def liste = Kontakt.list()
        liste.each{
            it.name = bezeichnerErstellen(it)
            it.save(flush: true)
        }
        redirect(dashboard:index)
    }

    def getKontakteByUnternehmen = {
       def potAnfragen = Kontakt.getKontakteMitUnternehmen(Unternehmen.get(params.id))
       potAnfragen = potAnfragen.collect {
           [id:it.id, bezeichnung: it.toString()]
       }
       render potAnfragen as JSON
   }

   def abgeben={
    def p = Personen.findById(params.pid)
    def u = Unternehmen.findById(params.uid)
    if( (!p) | (!u) ){
        redirect(controller:"dashboard", action:"index")
    }
    p.removeFromBetreuteUnternehmen(u)
    redirect(controller:"dashboard", action:"index")
   }

}
