package pauldb2
import grails.plugins.springsecurity.Secured
import groovy.sql.Sql
import grails.converters.JSON
import java.text.SimpleDateFormat
import org.apache.commons.logging.LogFactory

class UnternehmenController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def sessionFactory
    def beforeInterceptor = [action:this.&checkUser]

    //private static final log = LogFactory.getLog("pauldb2")


    def checkUser(){

        if(!session.userperson){
          flash.message = "Bitte melde dich an."
          println(request.forwardURI - request.contextPath)
          flash.redirect = request.forwardURI - request.contextPath
          redirect(uri:"/");
          return false

        }
    }


    def dataSource;

    def index = {
        redirect(action: "list", params: params)
    }

    def getMitarbeiterPositionen = {

      def m = MitarbeiterPosition.list()

      m.sort{
        it.position
      }

      m = m.collect {

        [position: it.position, id: it.id]
      }

      render m as JSON
    }

    def getMitarbeiterByUnternehmenId = {


      def unternehmen = Unternehmen.get(params.uId)
      if(unternehmen){
        def m = unternehmen.mitarbeiter

       m = m.collect {

          [id: it.id, vorname: it.person.vorname, nachname: it.person.nachname]
        }
        

        render m as JSON
      }
      else{
          return false
        //render [] as JSON
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

    def mitarbeiterAutoComplete = {

      //def mitarbeiter = Personen.findAllByPersonstatus(Personstatus.get(1));

       def mitarbeiter = Personen.createCriteria().list(){

            and{
              eq("personstatus",Personstatus.get(1))
              or {

                like("vorname",params.term+"%")
                like("nachname",params.term+"%")
  
              }
            }
       }


        mitarbeiter = mitarbeiter.collect {
          [id:it.id, label:it.vorname + " " +it.nachname, value:it.vorname + " " +it.nachname]
        }

        render mitarbeiter as JSON
    }




    def list = {
        // Maximale Listenlänge festlegen
        params.max = Math.min(params?.max?.toInteger() ?: 20, 100)
        
        // Unternehmen ermitteln und Unternehmen ohne gesetzten Kontakt filtern, wenn nach diesem sortiert wird
        def unternehmen = Unternehmen.createCriteria().list(params) {
            if (params.sort == 'naechsterkontakt') isNotNull('naechsterkontakt')
        }
        
        // Debugausgabe tätigen und Werte weitergeben
        [unternehmenInstanceList: unternehmen, unternehmenInstanceTotal: Unternehmen.count(), role: session.role]
    }

    @Secured(["hasRole('ROLE_WRITEACCESS')"])
    def create = {
        def unternehmenInstance = new Unternehmen()

        def posBetreuer = Personen.findAllByPersonstatus(Personstatus.get(3)) + Personen.findAllByPersonstatus(Personstatus.get(4)) + Personen.findAllByPersonstatus(Personstatus.get(2))
        def posBranche = Branche.list().sort{
          it.branche
        }

        posBetreuer = posBetreuer.sort{
          it.nachname
        }

        unternehmenInstance.properties = params

        //anlegenden User automatisch zu Betreuern hinzufügen
        if(!unternehmenInstance.betreuer){

            
            Set mySet = []
            mySet.add(session.userperson)
            unternehmenInstance.betreuer = Personen.findAllById(session.userperson.id)
            
        } 
        else if(!unternehmenInstance.betreuer.contains(session.userperson)){

            unternehmenInstance.betreuer += Personen.findAllById(session.userperson.id)
        }
        print unternehmenInstance.betreuer


        return [unternehmenInstance: unternehmenInstance, posBetreuer: posBetreuer, posBranche:posBranche]
    }

    def save = {

        //render params as JSON

        def adresseInstance = new Adresse(params['adresse'])
        def unternehmenInstance = new Unternehmen(params)
		if (!unternehmenInstance.unternehmensscoring)
			unternehmenInstance.unternehmensscoring = Unternehmensscoring.findByBezeichnung('C')

        if(adresseInstance.save(flush: true)){

          unternehmenInstance.adresse = adresseInstance
          unternehmenInstance.setVeroeffentlichung("nein")
          if(params['oberunternehmen.id']){
            unternehmenInstance.setOberunternehmen(Unternehmen.get(params['oberunternehmen.id']))
          }else{
            unternehmenInstance.oberunternehmen = unternehmenInstance
          }



          //Email(s)

          if(params['email.adresse']?.class?.name?.equals("java.lang.String")){

               def e = new EmailUnternehmen()
               e.setMailAdresse (params['email.adresse'])

               if(params['email.bemerkung'] && !params['email.bemerkung'].equals("Bemerkung")){
                  e.setBemerkung(params['email.bemerkung'])
               } else{
                  e.setBemerkung("")
               }

               unternehmenInstance.addToEmails(e)
          }
          else {

              params['email.adresse'].eachWithIndex{item ,i ->

                def e = new EmailUnternehmen()
                e.setMailAdresse(item)

                if((params['email.bemerkung'][i]) && !params['email.bemerkung'][i].equals("Bemerkung")){
                  e.setBemerkung(params['email.bemerkung'][i])
                } else{
                  e.setBemerkung("")
                }



                unternehmenInstance.addToEmails(e)
              }
          }

          // Telefonnummer(n)

          if(params['telefon.nummer']?.class?.name?.equals("java.lang.String")){

               def t = new TelefonUnternehmen()
               t.nummer= params['telefon.nummer']
               if(params['telefon.bemerkung'] && !params['telefon.bemerkung'].equals('Bemerkung')){
                t.bemerkung = params['telefon.bemerkung']
               } else{
                t.bemerkung= ""
               }
               unternehmenInstance.addToTelefon(t)
          }
          else {

              params['telefon.nummer'].eachWithIndex{item,i ->

                def t = new TelefonUnternehmen()
                t.nummer= item
                if(params['telefon.bemerkung'][i] && !params['telefon.bemerkung'][i].equals('Bemerkung')){
                  t.bemerkung = params['telefon.bemerkung'][i]
                } else{
                  t.bemerkung= ""
                }
                unternehmenInstance.addToTelefon(t)
              }
          }


          // Homepage(s)

          if(params['homepage.url']?.class?.name?.equals("java.lang.String")){
               println("Eine Homepage..")
               def h = new HomepageUnternehmen()
               h.url= params['homepage.url']
               if(params['homepage.bemerkung'] && !params['homepage.bemerkung'].equals("Bemerkung") ){
                  h.bemerkung = params['homepage.bemerkung']
               }else{
                  h.bemerkung = ""
               }

                unternehmenInstance.addToHomepages(h)
          }
          else {
               println("Mehrere homepages..")
              params['homepage.url'].eachWithIndex{item,i ->
                println("speichere Homepage " + item)
                def h = new HomepageUnternehmen()
                h.url= item
                if(params['homepage.bemerkung'][i] && !params['homepage.bemerkung'][i].equals("Bemerkung") ){
                  h.bemerkung = params['homepage.bemerkung'][i]
                }else{
                  h.bemerkung = ""
                }

                unternehmenInstance.addToHomepages(h)
              }
          }

          //render params as JSON

          // mitarbeiter

          if(params['p.id']?.class?.name?.equals("java.lang.String")){
            def person = Personen.get(params['p.id'])
            def m = new Mitarbeiter()
            m.setPerson(person)
            m.setPosition(MitarbeiterPosition.get(params['m.position']))
            unternehmenInstance.addToMitarbeiter(m)

          }
          else{

            params['p.id'].eachWithIndex {item, i ->

              def person = Personen.get(item)
              def m = new Mitarbeiter()
              m.setPerson(person)

              m.setPosition(MitarbeiterPosition.get(params['m.position'][i]))

              //m.setAnfang(mVon[i])
              //m.setEnde(mBis[i])

              unternehmenInstance.addToMitarbeiter(m)

            }

          }

          unternehmenInstance.bewertung = BewertungUnternehmen.get(params['unternehmensbewertung.id'])

          if (unternehmenInstance.save(flush: true)) {
            log.info(session.userperson.toString() +" hat Unternehmen "+ unternehmenInstance.name + " angelegt.")
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'unternehmen.label', default: 'Unternehmen'), unternehmenInstance.id])}"
            redirect(action: "show", id: unternehmenInstance.id)

          }
          else {
              //rollback adresse
              adresseInstance.delete(flush: true)
              render(view: "create", model: [unternehmenInstance: unternehmenInstance, adresseInstance:adresseInstance])
          }

        }
        else{
           flash.message = "${message(code: 'default.not.created.message', args: [message(code: 'unternehmen.label', default: 'Unternehmen'), unternehmenInstance.id])}"
           render(view: "create", model: [unternehmenInstance: unternehmenInstance, adresseInstance:adresseInstance])
        }




    }


    def show = {
        def unternehmenInstance = Unternehmen.get(params.id)
        def mitarbeiter = unternehmenInstance.mitarbeiter
        def projekteList = unternehmenInstance.projekte.sort{it.projektname}
        def subunternehmenList = Unternehmen.findAllByOberunternehmen(unternehmenInstance).sort{it.name}

        mitarbeiter = mitarbeiter.sort{

            it.person.nachname
        }

        List kontakteIDList = [];

        mitarbeiter.each{
            //nur neue Kontakte einfügen
          it.kontakt.toList().each{
              if(kontakteIDList.indexOf(it.id)==-1){
                  kontakteIDList +=it.id
              }
          }
        }

        List kontakteList = [];
        kontakteIDList.each{
            kontakteList += Kontakt.get(it)
        }

        kontakteList=kontakteList.sort{
          it.datum

        }
        kontakteList = kontakteList.reverse()


        if (!unternehmenInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'unternehmen.label', default: 'Unternehmen'), params.id])}"
            redirect(action: "list")
        }
        else {
            log.info("Unternehmen: " + unternehmenInstance.toString() + " wird angezeigt ")
            [unternehmenInstance: unternehmenInstance, mitarbeiter: mitarbeiter, kontakteList:kontakteList, subunternehmenList:subunternehmenList,projekteList:projekteList, role: session.role]
        }
    }

    @Secured(["hasRole('ROLE_WRITEACCESS')"])
    def edit = {

        // mögliche Betreuer
        def posBetreuer = Personen.findAllByPersonstatus(Personstatus.get(3)) + Personen.findAllByPersonstatus(Personstatus.get(4)) + Personen.findAllByPersonstatus(Personstatus.get(2))
        posBetreuer = posBetreuer.sort{it.nachname}
        def unternehmenInstance = Unternehmen.get(params.id)
        def mitarbeiter = unternehmenInstance.mitarbeiter.sort{it.person.nachname}
        def oberunternehmen =  unternehmenInstance.oberunternehmen
        def posList = MitarbeiterPosition.list().sort{it.position}
        if (!unternehmenInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'unternehmen.label', default: 'Unternehmen'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [unternehmenInstance: unternehmenInstance, posBetreuer:posBetreuer, oberunternehmen:oberunternehmen, mitarbeiter:mitarbeiter, posList:posList, role: session.role]
        }
    }

    def update = {

        //render params as JSON

        def unternehmenInstance = Unternehmen.get(params.id)

        // relationen auflösen

        if(params.unternehmenstyp){
          params.unternehmenstyp = Unternehmenstyp.get(params.unternehmenstyp)
        }

        if(params.unternehmensstatus){
          params.unternehmensstatus = Unternehmensstatus.get(params.unternehmensstatus)
        }

        if(params.bewertung){
          params.bewertung = BewertungUnternehmen.get(params.bewertung)

        }

        if(params.oberunternehmenHidden){
          params.oberunternehmen = Unternehmen.get(params.oberunternehmenHidden)

        }

        //--------------mitarbeiter ---------------------------

            //prüfen, ob mitarbeiter gelöscht wurden:
            //alle Mitarbeiter des Unternehmens laden und mit den neuen aus params abgleichen
            //die zu löschenden in einer Liste festhalten und anschließend aus dem Unternehmen löschen
            def listToDelete = []
            unternehmenInstance.mitarbeiter.toList().eachWithIndex {item, i ->
               if(!params['m.id'].any{item.id}) listToDelete.add(item)
            }
            //Verbindung kappen und anschließend löschen
            listToDelete.each{
               unternehmenInstance.removeFromMitarbeiter(it);
               it.delete(flush:true) //Mitarbeiter wird gelöscht / nicht Person
            }


         SimpleDateFormat target = new SimpleDateFormat("dd.MM.yyyy");

         if(params['m.id']?.class?.name?.equals("java.lang.String")){
             def mit;
             if(Integer.parseInt(params['m.id'])!=-1){
                 //alter Mitarbeiter
                 mit = Mitarbeiter.get(params['m.id'])
             } else {
                 mit = new Mitarbeiter()
                 def person = Personen.get(params['p.id'])
                 mit.setPerson(person)
             }
             mit.setPosition(MitarbeiterPosition.get(params['m.position']));

              if(params['m.anfang']!=""){
                mit.setAnfang(target.parse(params['m.anfang']))
              }else{
                mit.setAnfang(null)
              }

              if(params['m.ende']!=""){
                mit.setEnde(target.parse(params['m.anfang']))
              }else{
                mit.setEnde(null)
              }

              mit.save(flush: true)
              if(Integer.parseInt(params['m.id'])==-1) unternehmenInstance.addToMitarbeiter(mit)

         } else {
            //neue Mitarbeiter finden, anlegen und speichern

             params['m.id'].eachWithIndex{item,i ->

               def mit;
               if(Integer.parseInt(item)!=-1){
                 //Mitarbeiter bereits vorhanden, also nur updaten
                  mit = Mitarbeiter.get(item)
               } else {
                   mit = new Mitarbeiter()
                   mit.setPerson(Personen.get(params['p.id'][i]))
               }
                  mit.setPosition(MitarbeiterPosition.get(params['m.position'][i]));

                  if(params['m.anfang'][i]!=""){
                    mit.setAnfang(target.parse(params['m.anfang'][i]))
                  }else{
                    mit.setAnfang(null)
                  }

                  if(params['m.ende'][i]!=""){
                    mit.setEnde(target.parse(params['m.ende'][i]))
                  }else{
                    mit.setEnde(null)
                  }

                mit.save(flush: true)
                if(Integer.parseInt(item)==-1) unternehmenInstance.addToMitarbeiter(mit)

             }
        }


        //--------------emails----------------------------------------



        if(params['email.id']?.class?.name?.equals("java.lang.String")){

          def emailsAlt = unternehmenInstance.emails
          def deleteList = []
          //Alte EMail(s) mit neuer Vergleichen
          //wenn id ungleich -> nicht mehr vorhanden in Liste also zum Löschen vormerken
          //wenn id gleich -> adresse updaten

          emailsAlt.each{
            if(it.id != Integer.parseInt(params['email.id'])){
              deleteList.add(it)
            }
            else{
              it.mailAdresse = params['email.nummer']
              it.bemerkung = params['email.bemerkung']
              it.save(flush:true)
            }
          }
          //Email ist neu
          if(Integer.parseInt(params['email.id'])==-1){
            println('speichere neue mail')
            def e = new EmailUnternehmen()
            e.mailAdresse = params['email.nummer']
            e.bemerkung = params['email.bemerkung']
            e.unternehmen = unternehmenInstance
            unternehmenInstance.addToEmails(e)
            e.save(flush:true)
          }
          //gelöschte Emails löschen
          deleteList.each {
            println('lösche mail')

            unternehmenInstance.removeFromEmails(it)
            it.delete(flush:true)
          }


        }
        else{
        //Es sind mehrere Emails angegeben
        //ansonsten das gleiche wie oben
          def bestehendeEmails = []
          def neueEmails = []

          //Emails in neue und alte aufgliedern
          params['email.id'].eachWithIndex{item, i ->

            if(Integer.parseInt(item)!=-1){
              //zur Sicherheit mailadresse updaten, falls diese geändert worden ist
              EmailUnternehmen.get(item).mailAdresse=params['email.nummer'][i]
              EmailUnternehmen.get(item).bemerkung=params['email.bemerkung'][i]
              EmailUnternehmen.get(item).save(flush:true)
              bestehendeEmails.add(EmailUnternehmen.get(item))
            }
            else{
              def e = new EmailUnternehmen()
              e.mailAdresse=params['email.nummer'][i]
              e.bemerkung=params['email.bemerkung'][i]
              e.unternehmen=unternehmenInstance
              neueEmails.add(e)


            }

          }

          //bestehende von gepspeicherten abziehen .. alles was übrig bleibt, wurde vom User gelöscht
          def deleteList = unternehmenInstance.emails - bestehendeEmails

          deleteList.each{
            unternehmenInstance.removeFromEmails(it)
            it.delete(flush:true)

          }
          //Neue Emails hinzufügen
          neueEmails.each{
            unternehmenInstance.addToEmails(it)
            it.save(flush:true)
          }

        }

        //--------------telefonnummern----------------------------------------

        if(params['telefon.id']?.class?.name?.equals("java.lang.String")){

          def telefonAlt = unternehmenInstance.telefon
          def deleteList = []

          telefonAlt.each{
            if(it.id != Integer.parseInt(params['telefon.id'])){
              deleteList.add(it)
            }
            else{
              it.nummer = params['telefon.nummer']
              it.bemerkung = params['telefon.bemerkung']
              it.save(flush:true)
            }
          }
          //Telefon ist neu
          if(Integer.parseInt(params['telefon.id'])==-1){
            println('speichere neue telefonnummer')
            def t = new TelefonUnternehmen()
            t.nummer = params['telefon.nummer']
            t.bemerkung = params['telefon.bemerkung']
            t.unternehmen = unternehmenInstance
            unternehmenInstance.addToTelefon(t)
            t.save(flush:true)
          }
          //gelöschte Telefone löschen
          deleteList.each {
            println('lösche Telefon')

            unternehmenInstance.removeFromTelefon(it)
            it.delete(flush:true)
          }




        }
        else{
        //Es sind mehrere Telefone angegeben
        //ansonsten das gleiche wie oben

          def bestehendeTelefon = []
          def neueTelefon = []

          //Emails in neue und alte aufgliedern
          params['telefon.id'].eachWithIndex{item, i ->

            if(Integer.parseInt(item)!=-1){
              //zur Sicherheit mailadresse updaten, falls diese geändert worden ist
              TelefonUnternehmen.get(item).nummer = params['telefon.nummer'][i]
              TelefonUnternehmen.get(item).bemerkung = params['telefon.bemerkung'][i]
              TelefonUnternehmen.get(item).save(flush:true)
              bestehendeTelefon.add(TelefonUnternehmen.get(item))
            }
            else{
              println("neues telefon..")
              def t = new TelefonUnternehmen()
              t.nummer=params['telefon.nummer'][i]
              t.bemerkung=params['telefon.bemerkung'][i]
              t.unternehmen=unternehmenInstance
              neueTelefon.add(t)


            }

          }

          //bestehende von gepspeicherten abziehen .. alles was übrig bleibt, wurde vom User gelöscht
          def deleteList = unternehmenInstance.telefon - bestehendeTelefon

          deleteList.each{
            unternehmenInstance.removeFromTelefon(it)
            it.delete(flush:true)

          }
          //Neue Emails hinzufügen
          neueTelefon.each{
            unternehmenInstance.addToTelefon(it)
            it.save(flush:true)
          }
        }




     //--------------homepage----------------------------------------

        if(params['homepage.id']?.class?.name?.equals("java.lang.String")){

          def homepageAlt = unternehmenInstance.homepages
          def deleteList = []
          //Alte EMail(s) mit neuer Vergleichen
          //wenn id ungleich -> nicht mehr vorhanden in Liste also zum Löschen vormerken
          //wenn id gleich -> adresse updaten
          homepageAlt.each{
            if(it.id != Integer.parseInt(params['homepage.id'])){
              deleteList.add(it)
            }
            else{
              it.url = params['homepage.nummer']
              it.bemerkung = params['homepage.bemerkung']
              it.save(flush:true)
            }
          }
          //Email ist neu
          if(Integer.parseInt(params['homepage.id'])==-1){
            println('speichere neue homepage')
            def h = new HomepageUnternehmen()
            h.url = params['homepage.nummer']
            h.bemerkung = params['homepage.bemerkung']
            h.unternehmen = unternehmenInstance
            unternehmenInstance.addToHomepages(h)
            h.save(flush:true)
          }
          //gelöschte Emails löschen
          deleteList.each {
            println('lösche homepage')

            unternehmenInstance.removeFromHomepages(it)
            it.delete(flush:true)
          }


        }
        else{
          //Es sind mehrere Homepages angegeben
          //ansonsten das gleiche wie oben
          def bestehendeHomepage= []
          def neueHomepage = []

          //homepages in neue und alte aufgliedern
          params['homepage.id'].eachWithIndex{item, i ->

            if(Integer.parseInt(item)!=-1){
              //zur Sicherheit mailadresse updaten, falls diese geändert worden ist
              HomepageUnternehmen.get(item).url=params['homepage.nummer'][i]
              HomepageUnternehmen.get(item).bemerkung=params['homepage.bemerkung'][i]
              bestehendeHomepage.add(HomepageUnternehmen.get(item))
            }
            else{
              def h = new HomepageUnternehmen()
              h.url=params['homepage.nummer'][i]
              h.bemerkung=params['homepage.bemerkung'][i]
              h.unternehmen=unternehmenInstance
              neueHomepage.add(h)


            }

          }

          //bestehende von gepspeicherten abziehen .. alles was übrig bleibt, wurde vom User gelöscht
          def deleteList = unternehmenInstance.homepages - bestehendeHomepage

          deleteList.each{
            unternehmenInstance.removeFromHomepages(it)
            it.delete(flush:true)

          }
          //Neue Emails hinzufügen
          neueHomepage.each{
            unternehmenInstance.addToHomepages(it)
            it.save(flush:true)
          }

        }




        if (unternehmenInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (unternehmenInstance.version > version) {
                    
                    unternehmenInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'unternehmen.label', default: 'Unternehmen')] as Object[], "Another user has updated this Unternehmen while you were editing")
                    render(view: "edit", model: [unternehmenInstance: unternehmenInstance])
                    return
                }
            }
            unternehmenInstance.properties = params
            if (!unternehmenInstance.hasErrors() && unternehmenInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'unternehmen.label', default: 'Unternehmen'), unternehmenInstance.id])}"
                redirect(action: "show", id: unternehmenInstance.id)
            }
            else {
                render(view: "edit", model: [unternehmenInstance: unternehmenInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'unternehmen.label', default: 'Unternehmen'), params.id])}"
            redirect(action: "list")
        }

        

    }

    def delete = {
        def unternehmenInstance = Unternehmen.get(params.id)
        if (unternehmenInstance) {
            try {
                def Loesche = unternehmenInstance.mitarbeiter.toList()
                Loesche.each{
                   unternehmenInstance.removeFromMitarbeiter(it)
                }
                Loesche = unternehmenInstance.betreuer.toList()
                Loesche.each{
                   unternehmenInstance.removeFromBetreuer(it)
                }
                Loesche = unternehmenInstance.telefon.toList()
                Loesche.each{
                    unternehmenInstance.removeFromTelefon(it)
                    it.delete()
                }
                def a = unternehmenInstance.name
                unternehmenInstance.delete(flush: true)
                log.info(session.userperson.toString() +" hat Unternehmen "+ a + " gelöscht.")
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'unternehmen.label', default: 'Unternehmen'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                log.error("Fehler beim löschen von Unternehmen "+ unternehmenInstance.name)
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'unternehmen.label', default: 'Unternehmen'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'unternehmen.label', default: 'Unternehmen'), params.id])}"
            redirect(action: "list")
        }
    }

    def newBranche = new Branche()

    def getBetreuer = {



      def betreuer = Unternehmen.get(params.id)
      render betreuer.betreuer

    }



    def inaktiveBetreuer = {


        def aktive = [Personstatus.get(2), Personstatus.get(3)] //Paulaber & Anwärter


        def inaktiveUnternehmenList = []

        params.sort = params?.sort ?: "name"
        params.order = params?.order ?: "asc"
        def u2 = Unternehmen.createCriteria().list(
                 sort: params.sort,
                 order: params.order) {
               sizeGt("betreuer", 0)
        }


        u2.eachWithIndex{unternehmen, i ->

            def aktiv = false
            unternehmen.betreuer.each{
                if(aktive.contains(it.personstatus)){
                    aktiv = true
                }
            }
            if(!aktiv){
                inaktiveUnternehmenList.add(unternehmen)

            }
        }


        render(view:'inaktiveBetreuer', model:[unternehmenList:inaktiveUnternehmenList, anzahl: inaktiveUnternehmenList.size()])
    }



    def ohneBetreuer = {


        //sql variante
        //SELECT * FROM `unternehmen` WHERE `unternehmen_id` not in (SELECT `unternehmen_id` FROM `kundennachbetreuer`)

        /*
        def sql = new Sql(dataSource);

           String query = "SELECT * FROM `unternehmen` WHERE `unternehmen_id` not in (SELECT `unternehmen_id` FROM `kundennachbetreuer`)"


        def u2 = sql.rows(query)
        */


        // gut schnell, genau eine datenbankabfrage

        if(!params['sort']){
            params['sort']='name'
        }
        if(!params['order']){
            params['order']='asc'
        }

        def u2 = Unternehmen.createCriteria().list(){
                 sizeEq("betreuer", 0)
                 order(params['sort'], params['order'])
        }



        // elendig langsam da anzahl(unternehmen)+1 db-anfragen

        /*
        def u1 = Unternehmen.list()
        def u2 = []
        u1.each{

          if(it.betreuer.size() ==0){

              u2.push(it)
          }
        }

        */


        return [unternehmenList:u2, anzahl: u2.size()]
    }

    def betreuerZuweisen = {

        def unternehmen = Unternehmen.get(params['id'])
        def person = Personen.get(session.userperson.id)


        if(unternehmen && person){
            person.addToBetreuteUnternehmen(unternehmen)
            if(person.save(flush:true)){
                sessionFactory.queryCache.clear()

                flash.message= "Du wurdest dem Unternehmen " + unternehmen.name + " als Betreuer zugeordnet."
                redirect(action: "ohneBetreuer", params: params)

            }
            else{
                flash.message= "Beim Speichern des Unternehmens ist ein Fehler aufgetreten."
                redirect(action: "ohneBetreuer", params: params)
            }

        }
        else{
            flash.message = "Unternehmen nicht gefunden."
            redirect(action: "ohneBetreuer", params: params)
        }
    }

    def unternehmenSearch2 = {

      def name = params.unternehmenName

      params.max = Math.min(params?.max?.toInteger() ?: 20, 100)
      params.offset = params?.offset?.toInteger() ?: 0
      params.sort = params?.sort ?: "name"
      params.order = params?.order ?: "asc"

      def unternehmen = Unternehmen.createCriteria().list(
                max: params.max,
                offset: params.offset,
                sort: params.sort,
                order: params.order) {
            like("name", "%"+name+"%")

        }
      def total = unternehmen.totalCount

      //render params
      render(view: 'list', model:[unternehmenInstanceList: unternehmen, unternehmenInstanceTotal: total, params:params])

    }
	
	def filter = {
		// Maximale Listenlänge festlegen
		params.max = Math.min(params?.max?.toInteger() ?: 20, 100)

        // Filter anwenden
        if (params.kontaktscoring) render('"' + params.kontaktscoring + '"')
        
        def unternehmen = Unternehmen.createCriteria().list(params) {
            if (params.unternehmensscoring) eq('unternehmensscoring', Unternehmensscoring.findByBezeichnung(params.unternehmensscoring))
            if (params.kontaktscoring) letzterkontakt { eq('kontaktscoring', Kontaktscoring.findByBezeichnung(params.kontaktscoring)) }
        }
           
		// Alle nötigen Daten an den List-View geben
		render(view: 'list', model: [unternehmenInstanceList: unternehmen, unternehmenInstanceTotal: unternehmen.totalCount, params:params])
    }
    
    def updateScoring = {
        // Cronjob manuell triggern
        UnternehmensscoringJob.triggerNow()
        render('Done!')
    }
}
