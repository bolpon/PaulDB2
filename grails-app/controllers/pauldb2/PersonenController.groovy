package pauldb2
import groovy.sql.Sql
import grails.converters.*
import org.codehaus.groovy.grails.commons.GrailsApplication
import grails.util.GrailsUtil
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils

class PersonenController {
  def springSecurityService

  def beforeInterceptor = [action:this.&checkUser]

  /**
   * Prüft, ob der Nutzer angemeldet ist (d.h. eine Session besteht) ist,
   * wenn nicht wird er zur Anmeldeseite umgeleitet
   * @return
   */

  def checkUser(){

      if(!session.userperson){
        redirect(uri:"/");
        return false

      }
  }


  static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def dataSource;

    def index = {
        redirect(action: "list", params: params)
    }

  /**
   * Listet Personen anhand der Parameter auf
   * @return  personenInstanceList: Liste mit Personen
   * @return  personenInstanceTotal: Anzahl an Personen gesamt
   * @return role: Nutzerrolle (ob Admin oder normaler User)
   *
   */

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 20, 100)
        [personenInstanceList: Personen.list(params), personenInstanceTotal: Personen.count(), role: session.role]

    }

  /**
   *  Ähnlich wie list, nur dass es ausschließlich Mitglieder auflistet, heißt Personen mit Personstatus = 2
   */


    def listMemberOnly = {

         params.max = Math.min(params.max ? params.int('max') : 20, 100)

         def p2 = Personstatus.get(2) // Paulaner
         def member= Personen.findAllByPersonstatus(p2,params)

         

        //[personenInstanceList: Personen.list(params), personenInstanceTotal: Personen.count()]

        render(view:'list', model:[personenInstanceList: member, personenInstanceTotal: member.count()])

    }

    // funzt bis auf pagination
    def ajaxList = {

        params.max = Math.min(params.max ? params.int('max') : 20, 100)

        Personstatus ps = Personstatus.get(params.wahl)

        if(ps){

            
            def list = Personen.findAllByPersonstatus(ps,params)
            def total = Personen.countByPersonstatus(ps)
            [personenInstanceList: list, personenInstanceTotal: total, opt:params.wahl]
        }
        else{
            render "error"
        }
    }

    def create = {
        def personenInstance = new Personen()
        personenInstance.properties = params
        return [personenInstance: personenInstance]
    }

    def save = {


        def personenInstance = new Personen(params)
        
//        render personenInstance

        
        def adresseInstance = new Adresse(params)

//        render adresseInstance


        

        if (adresseInstance.save(flush:true)){

//            render " success adress <br />"
            
            personenInstance.setAdresse(adresseInstance)

            if(params['email.adresse'].class.name.equals("java.lang.String")){

               def e = new Email()
               e.setMailAdresse (params['email.adresse'])
               personenInstance.addToEmails(e) 
            }
            else {

              params['email.adresse'].each{

                def e = new Email()
                e.setMailAdresse(it)
                personenInstance.addToEmails(e)
              }
            }


            if(params['telefon.nummer'].class.name.equals("java.lang.String")){

               def t = new Telefon()
               t.nummer= params['telefon.nummer']
               t.bemerkung = params['telefon.bemerkung']
               personenInstance.addToTelefon(t)
			  
            }
            else {

              params['telefon.nummer'].eachWithIndex{item,i ->

               def t = new Telefon()
               t.nummer= item
               t.bemerkung = params['telefon.bemerkung'][i]
               personenInstance.addToTelefon(t)

              }
            }
			


            if(personenInstance.save(flush:true, validation:false)){
                HistoryStart(personenInstance, Posten.get(23), personenInstance.personstatus)
                    log.info(session.userperson.toString() +" hat Person "+ personenInstance.toString() + " angelegt.")
                    flash.message = "${message(code: 'default.created.message', args: [message(code: 'personen.label', default: 'Person'), personenInstance.id], default:"Person erfolgreich angelegt")}"
                    redirect(action: "show", id: personenInstance.id)
            }
            else{
                // Fehler beim Anlegen der Person (unvollständige / falsche Eingage
                // Rollback: Löschen der bereits gespeicherten Adresse
                adresseInstance.delete(flush: true)
                render(view: "create", model: [personenInstance: personenInstance, adresseInstance:adresseInstance])
            }
        }

        else {

            //fehler beim Adresse einfügen
            render(view: "create", model: [personenInstance: personenInstance, adresseInstance:adresseInstance])
            
        }
    }

  /**
   * Sammelt Details zu einer bestimmten Person und zeigt diese an
   */

    def show = {
        def personenInstance = Personen.get(params.id)

        //Keine Person zur ID gefunden, umleiten auf List-Seite
        if (!personenInstance) {
            flash.message = "Person mit ID " + params.id + " wurde nicht in der Datenbank gefunden."
            redirect(action: "list")
        }
        //Person gefunden, Details sammeln
        else {

            def beutreuteUnternehmenList = personenInstance.betreuteUnternehmen

            def fremd = personenInstance.personstatus.bezeichnung.equals("fremd")

            beutreuteUnternehmenList.sort{
              it.name
            }

            def posten = personenInstance.posten


            // Prüfen ob Foto zur Person existiert, wenn nicht, Standard-Foto verwenden

            def linkfoto
			def folder = new File( "/var/www/pauldbbilder/personImages_"+params.id+".jpg" )
            if(folder.exists()){
              linkfoto = "/pauldbbilder/personImages_"+params.id+".jpg"
            }else{
              linkfoto = "/pauldb2/personImages/foto_default.jpg"
            }


            def freieMitarbeiterList = personenInstance.freieMitarbeiter.sort{it.projekt.projektname}

            def teammitgliedList = personenInstance.tm.sort{it.id}

            def historyList = personenInstance.entwicklung.sort{it.von}

            // leere Map fuer Projektleiter anlegen
            def plMap = [:]

            teammitgliedList.each{

              def pl = Projektleiter.findByTeammitglied(it)
              if(pl){
                plMap[it.id] = pl
              }

            }

            def idZul = Bearbeitbar(personenInstance)

            //debug
            //render personenInstance as JSON
            log.info("Person: " + personenInstance.toString() + " wird angezeigt ")
            [personenInstance: personenInstance, teammitgliedList:teammitgliedList, plMap:plMap,
                    beutreuteUnternehmenList:beutreuteUnternehmenList, fremd:fremd,freieMitarbeiterList:freieMitarbeiterList,

                    linkfoto:linkfoto, role: session.role, historyList:historyList, idZul: idZul]

        }
    }

    def edit = {


        def personenInstance = Personen.get(params.id)

        if (!Bearbeitbar(personenInstance)){
            redirect(action: "show", id: personenInstance.id)
            return
        }

        def ressortIDs = [9L,10L,11L,12L,13L]
        def ressortList = Posten.findAllByIdInList(ressortIDs)

        def ressortMitglied = []

        //ressorts durchgehen und prüfen, ob person mitglied ist

        ressortList.each {
          if(personenInstance.posten.contains(it)){
            ressortMitglied.add(true)
          }
          else{
            ressortMitglied.add(false)
          }

        }

        if(!personenInstance){
            flash.message = "Person mit ID " + params.id + " wurde nicht in der Datenbank gefunden."
            redirect(action: "list")
        }else{
            def studium = personenInstance.studium

            def studienfachList = Studienfach.list(sort:'bezeichnung', order:'asc')
            def studiumstatusList = Studiumstatus.list(sort:'bezeichnung', order:'asc')

            return [ressortList:ressortList, ressortMitglied:ressortMitglied, personenInstance: personenInstance, studium:studium, studienfachList:studienfachList, studiumstatusList:studiumstatusList, role: session.role]
        }


    }

    def update = {
		
        def personenInstance = Personen.get(params.id)

        // ressortzuordnung

        //9-13 sind die Ids der ressorts in der tabelle postenRessort
        def ressortIds = [9,10,11,12,13]
        def ausgewaehlteRessorts = []
        def ressorts = []
        def statusNeu = Personstatus.get(params.personstatus.id)

        // alle Ressorts aus Tabelle holen
        ressortIds.each{
          ressorts.add(Posten.get(it))
        }

        //Prüfen, welche Ressorts ausgewählt wurden und zur Liste ausgewaehlteRessorts hinzufügen
        ressortIds.each{

          def att = "ressortMitglied_"+it
          if(params[att]=="on"){
            ausgewaehlteRessorts.add(Posten.get(it))
          }
        }

        //Aktuelle Ressortzugehörigkeit der Person bestimmen als Schnittmenge aller Ressorts und der postenRessorts der Person
        def aktuelleResssorts = ressorts.intersect(personenInstance.posten)

        //zu löschende Ressortszugehörigkeiten bestimmen
        def deleteRessorts = aktuelleResssorts - ausgewaehlteRessorts

        //neue Ressorts bestimmen
        def neueRessorts = ausgewaehlteRessorts - aktuelleResssorts

        //Löschen und hinzufügen der Ressorts
        deleteRessorts.each{
          personenInstance.removeFromPosten(it)
          HistoryEnde(personenInstance, it, null)
        }

        neueRessorts.each{
          personenInstance.addToPosten(it)
          HistoryStart(personenInstance, it, statusNeu)
          //Personenhistory updaten
        }

        //Update Status
        if (!(personenInstance.personstatus.equals(statusNeu))){
            HistoryEnde(personenInstance, null, personenInstance.personstatus)
            if (personenInstance.posten)
              personenInstance.posten.each{
              HistoryStart(personenInstance, it, statusNeu)
           } // 23 - kein Ressort zugewiesen
            else HistoryStart(personenInstance, Posten.get(23), statusNeu)
        }

        //Update EMails-------------------------

        if(params['email.id']?.class?.name?.equals("java.lang.String")){

          def emailsAlt = personenInstance.emails
          def deleteList = []
          //Alte EMail(s) mit neuer Vergleichen
          //wenn id ungleich -> nicht mehr vorhanden in Liste also zum Löschen vormerken
          //wenn id gleich -> adresse updaten
          emailsAlt.each{
            if(it.id != Integer.parseInt(params['email.id'])){
              deleteList.add(it)
            }
            else{
              it.mailAdresse = params['email.adresse']
            }
          }
          //Email ist neu
          if(Integer.parseInt(params['email.id'])==-1){
            //Prüfen, ob Feld leer ist
            if(params['email.adresse']){
                println('speichere neue mail')
                def e = new Email()
                e.mailAdresse = params['email.adresse']
                e.person = personenInstance
                personenInstance.addToEmails(e)
                e.save(flush:true)
            }

          }
          //gelöschte Emails löschen
          deleteList.each {
            println('lösche mail')

            personenInstance.removeFromEmails(it)
            it.delete()
          }

        }

        else{

          def bestehendeEmails = []
          def neueEmails = []

          //Emails in neue und alte aufgliedern
          params['email.id'].eachWithIndex{item, i ->

            if(Integer.parseInt(item)!=-1){
              //zur Sicherheit mailadresse updaten, falls diese geändert worden ist
              Email.get(item).mailAdresse=params['email.adresse'][i]
              bestehendeEmails.add(Email.get(item))
            }
            else{
              if(params['email.adresse'][i]!=null && params['email.adresse'][i] !=""){
                def e = new Email()
                e.mailAdresse=params['email.adresse'][i]
                e.person=personenInstance
                neueEmails.add(e)
              }
            }

          }

          //bestehende von gepspeicherten abziehen .. alles was übrig bleibt, wurde vom User gelöscht
          def deleteList = personenInstance.emails - bestehendeEmails

          deleteList.each{
            personenInstance.removeFromEmails(it)
            it.delete(flush:true)

          }
          //Neue Emails hinzufügen
          neueEmails.each{
            println('speichere ' + it)
            personenInstance.addToEmails(it)
          }
        }

        //Update Telefon-------------------------

        if(params['telefon.id']?.class?.name?.equals("java.lang.String")){

          def telefonAlt = personenInstance.telefon
          def deleteList = []
          //Alte telefone mit neuer Vergleichen
          //wenn id ungleich -> nicht mehr vorhanden in Liste also zum Löschen vormerken
          //wenn id gleich -> adresse updaten
          telefonAlt.each{
            if(it.id != Integer.parseInt(params['telefon.id'])){
              deleteList.add(it)
            }
            else{
              it.nummer = params['telefon.nummer']
              it.bemerkung = params['telefon.bemerkung']
			 
            }
          }
          //Telefon ist neu
          if(Integer.parseInt(params['telefon.id'])==-1){
            println('speichere neue telefon..')
            def t = new Telefon()
            t.nummer = params['telefon.nummer']
            t.bemerkung = params['telefon.bemerkung']
            t.person = personenInstance
            personenInstance.addToTelefon(t)
            t.save(flush:true)

          }
          //gelöschte Telefone löschen
          deleteList.each {
            println('lösche Telefon')

            personenInstance.removeFromTelefon(it)
            it.delete()
          }

        }

        else{

          def bestehendeTelefon = []
          def neueTelefon = []

          //Emails in neue und alte aufgliedern
          params['telefon.id'].eachWithIndex{item, i ->

            if(Integer.parseInt(item)!=-1){
              //zur Sicherheit mailadresse updaten, falls diese geändert worden ist
              Telefon.get(item).nummer=params['telefon.nummer'][i]
              Telefon.get(item).bemerkung=params['telefon.bemerkung'][i]
              bestehendeTelefon.add(Telefon.get(item))
            }
            else{
              def t = new Telefon()
              t.nummer=params['telefon.nummer'][i]
              t.bemerkung=params['telefon.bemerkung'][i]
              t.person=personenInstance
              neueTelefon.add(t)


            }

          }

          //bestehende von gepspeicherten abziehen .. alles was übrig bleibt, wurde vom User gelöscht
          def deleteList = personenInstance.telefon - bestehendeTelefon

          deleteList.each{
            personenInstance.removeFromTelefon(it)
            it.delete(flush:true)

          }
          //Neue Telefone hinzufügen
          neueTelefon.each{
            personenInstance.addToTelefon(it)
            it.save(flush:true)
          }
		  

        }
        //--------End Email und Telefon Update


        if (personenInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (personenInstance.version > version) {
                    
                    personenInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'personen.label', default: 'Personen')] as Object[], "Another user has updated this Personen while you were editing")
                    render(view: "edit", model: [personenInstance: personenInstance])
                    return
                }
            }
            personenInstance.properties = params

            if (!personenInstance.hasErrors() && personenInstance.save(flush: true)) {
                log.info(session.userperson.toString() +" hat Person "+ personenInstance.toString() + " geupdatet.")
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'personen.label', default: 'Personen'), personenInstance.id])}"
                redirect(action: "show", id: personenInstance.id)
            }
            else {
                render(view: "edit", model: [personenInstance: personenInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'personen.label', default: 'Personen'), params.id])}"
            redirect(action: "list")
        }

        
		
    }

    def delete = {
        def personenInstance = Personen.get(params.id)
        //def adresse = personenInstance.adresse

        if (personenInstance) {

            def pa = personenInstance.projektanfragen


            pa.each{

              it.removeFromPersonen(personenInstance)
            }


            try {
                def name = personenInstance.vorname +" "+ personenInstance.nachname
                personenInstance.delete(flush:true)
                log.info(session.userperson.toString() +" hat Person "+ name + " gelöscht.")
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'personen.label', default: 'Personen'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'personen.label', default: 'Personen'), params.id])}"
                log.error("Fehler beim löschen von Person: " + personenInstance.toString() + " " + e.message)
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'personen.label', default: 'Personen'), params.id])}"
            redirect(action: "list")
        }
    }

    /**
     * Gibt eine Fotowand der Personen aus mit dem jeweiligen Personenstatus
     * View: postenliste
     * Menu: Personen->Bilderwand
     */
    def bilderwand = {
        //Welche Personen angezeigt werden: Anwärter, Paulaner, AO
        def member= Personen.findAllByPersonstatusInList([Personstatus.get(2), Personstatus.get(3), Personstatus.get(4)])

        def fotolist = [:]

        member.each{
					 def folder = new File( "/var/www/pauldbbilder/personImages_"+it.id+".jpg" )

                     if(folder.exists()){
                   //     println("füge hinzu " + p + " : " + "/pauldb2/personImages/foto_"+p.id+".jpg -- für posten: " + item.postenName)
                        fotolist.put(it.id.toString(),'/pauldbbilder/personImages_'+it.id+'.jpg')
                     }else{
                     //    println("füge hinzu " + p + " : " + "/pauldb2/personImages/foto_default.jpg -- für posten: " + item.postenName)
                         fotolist.put(it.id.toString(),"/pauldb2/personImages/foto_default.jpg")

                     }
        }
        member.sort{
            it.vorname
        }
        [member:member, fotolist:fotolist]
    }

    /**
     * Gibt eine Fotowand der Personen aus die einen Posten besitzen
     * View: postenliste
     * Menu: Personen->Postenliste
     */
    def postenliste = {
        def posten = [1L,2L,3L,4L,5L,6L,7L,8L,14L,15L,16L,17L,18L, 24L]  // L bedeutet Long
        def ressorts = [9L,10L,11L,12L,13L]
        def postenlist = Posten.findAllByIdInList(posten)

        //Fotos zu den Personen raussuchen, falls es keine Foto gibt, default-Foto nehmen
        def fotolist = [:]


        postenlist.eachWithIndex{item, i ->
               item.person.eachWithIndex {p,j ->
				     def folder = new File( "/var/www/pauldbbilder/personImages_"+p.id+".jpg" )
                     if(folder.exists()){
                   //     println("füge hinzu " + p + " : " + "/pauldb2/personImages/foto_"+p.id+".jpg -- für posten: " + item.postenName)
                        fotolist.put(p.id.toString(),"/pauldbbilder/personImages_"+p.id+".jpg")
                     }else{
                     //    println("füge hinzu " + p + " : " + "/pauldb2/personImages/foto_default.jpg -- für posten: " + item.postenName)
                         fotolist.put(p.id.toString(),"/pauldb2/personImages/foto_default.jpg")

                     }
               }

        }

        [postenlist:postenlist, fotolist:fotolist]

    }

    /**
     * Realisiert die Zuordnung von Personen zu posten
     */
    def postenzuordnung = {
        def posten = [1L,2L,3L,4L,5L,6L,7L,8L,14L,15L,16L,17L,18L, 24L]
        def postenList = Posten.findAllByIdInList(posten)
        println(postenList.size())
        [postenList:postenList ]
    }

    def postenzuordnungSave = {

        //render params as JSON

        params['posten.id'].eachWithIndex{item, i ->
            def posten = Posten.get(item)
            def person = Personen.get(params['person.id'][i])

            if(!person){
            //posten wurde keine Person zugeordnet -> noch mit ihm verbundene Personen löschen
                def deleteList = posten.person

                deleteList.each {
                    HistoryEnde(it, posten, null)
                    posten.removeFromPerson(it)
                }
            } else {
            // Posten wurde eine Person zugeordnet
            // Alte personen von Posten löschen und neue Hinzufügen
            // Etwas verquer, da im Schema ein Posten mehrere Personen haben kann, es aber in Realität keinen Sinn macht
            // und deshalb pro Posten nur eine Person gespeichert wird
                def personenAlt = posten.person
                def deleteList = []
                def bleibeList = []
                personenAlt.each{
                    if(!it.equals(person)){
                        deleteList.add(it)
                    }
                    else{
                        bleibeList.add{it}
                    }
                }
                deleteList.each{
                    HistoryEnde(it, posten, null)
                    posten.removeFromPerson(it)
                }
                if(!bleibeList.contains(person)){
                    posten.addToPerson(person)
                    HistoryStart(person, posten, null)
                }


            }

            if (!posten.hasErrors() && posten.save(flush: true)) {
                log.info(session.userperson.toString() +" hat Posten "+ posten.toString() + " geupdatet.")
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'personen.label', default: 'Personen'), posten.id])}"
            }
            else {
                render(view: "postenzuordnung", model: [posten: posten])
            }
        }

        redirect(action: "postenliste")



    }


    def telefonverzeichnis = {


        def personenList = Personen.createCriteria().list(){
                 sizeGt("telefon", 0)

        }
        //def mitglieder = Personen.findAllByPersonstatus(Personstatus.get(2))

        //personenList = personenList.intersect(mitglieder)
        personenList.sort{it.nachname}


        [personenList:personenList]
    }

    def addAddress = {

        render(view: "addAddress")

    }

  /**
   * AJAX-Funktionalität für die Suche nach Nachnamen
   * @param params.term Der von Javascript übermittelte Teil des Nachnamens, nach dem gesucht werden soll
   * @return erg: Liste mit passenden Einträgen
   */

    def nachnameAutoComplete = {

        def personen = Personen.findAllByNachnameLike(params.term+"%");

        def nameList = []
        def erg = []

        //Namen filtern, so dass nicht 300 mal "Schmidt" im autocomplete auftauchen
        //Bei einem Klick auf Suchen werden dann alle Schmidts als Ergebnis der Suche dargestellt
        personen.each{
            if(!nameList.contains(it.nachname)){
                nameList.add(it.nachname)
                erg.add(it)
            }
        }


        erg = erg.collect {
          [id:it.id, label:it.nachname, value:it.nachname]
        }

        render erg as JSON
    }

    /**
   * AJAX-Funktionalität für die Suche nach Vornamen
   * @param params.term Der von Javascript übermittelte Teil des Vornamens, nach dem gesucht werden soll
   * @return erg: Liste mit passenden Einträgen
   */

    def vornameAutoComplete = {

        def personen = Personen.findAllByVornameLike(params.term+"%");

        def nameList = []
        def erg = []

        //Namen filtern, so dass nicht 300 Michaels im autocomplete auftauchen
        personen.each{
            if(!nameList.contains(it.vorname)){
                nameList.add(it.vorname)
                erg.add(it)
            }
        }

        erg = erg.collect {
          [id:it.id, label:it.vorname, value:it.vorname]
        }

        render erg as JSON
    }

  /**
   * Filter der Personen-Liste nach Personenstatus
   */

    def personSearch = {



        params.max = Math.min(params.max ? params.int('max') : 20, 100)

        Personstatus ps = Personstatus.get(params.personstatus)

        if(ps){
            def list = Personen.findAllByPersonstatus(ps,params)
            def total = Personen.countByPersonstatus(ps)
            render(view: 'list', model:[personenInstanceList: list, personenInstanceTotal: total, opt:params.personstatus])
        }
        else{
            render "error"
        }

    }

  /**
   * Funktions, welche die Eingaben der Suchfunktion entgegen nimmt, passende Personen anhand des eingegeben Vor- und Nachnamens aus
   * der Datenbank lädt und diese an den List-View weiterleitet
   * @param params.searchVorname In der Suche eingebener Vorname
   * @param params.searchNachname In der Suche eingebener Nachname
   */


    def personSearch2 = {

      

      def vorname = params.searchVorname;
      def nachname = params.searchNachname

      params.max = Math.min(params?.max?.toInteger() ?: 20, 100)
      params.offset = params?.offset?.toInteger() ?: 0
      params.sort = params?.sort ?: "vorname"
      params.order = params?.order ?: "asc"
      
      def personen = Personen.createCriteria().list(
                max: params.max,
                offset: params.offset,
                sort: params.sort,
                order: params.order) {
            like("nachname", nachname+"%")
            like("vorname", vorname+"%")
        }
      def total = personen.totalCount

      //render params
      render(view: 'list', model:[personenInstanceList: personen, personenInstanceTotal: total, params:params])
      
    }

  /**
   * Lädt Personen, die in den nächsten 7 Tagen (monatsende-übergreifend) Geburtstag haben aus der Datenbank
   */
    def birthdayTest = {


        def sql = new Sql(dataSource);

    		String query = "select person_id, vorname, nachname, concat(date_format(geburtsdatum, '%d'),'.', date_format(geburtsdatum, '%m'),'.', date_format(geburtsdatum, '%y')) as bday from person where ((date_format(geburtsdatum, '%m%d') between date_format(curdate(), '%m%d') and if((month(curdate()) = 12 and day(curdate()) > 24), date_format(str_to_date('12312008', '%m%d%y'), '%m%d'), date_format(adddate(curdate(), interval 7 day), '%m%d'))) or (date_format(geburtsdatum, '%m%d') between if((month(curdate()) = 12 and day(curdate()) > 24), date_format(str_to_date('01012008', '%m%d%y'), '%m%d'), date_format(curdate(), '%m%d')) and if((month(curdate()) = 12 and day(curdate()) > 24), date_format(adddate(str_to_date('01012008', '%m%d%y'), interval (6-(31-day(curdate()))) day), '%m%d'), date_format(adddate(curdate(), interval 7 day), '%m%d')))) order by bday"

    		// You get results as List of Object[]
    		
        def personen = sql.rows(query)

        /*def personen = Personen.findAllBygeburtsdatumIsNotNull(order:'asc')
        foreach
        */
        return [personen:personen.sort{it.bday}]
    }


    def getPossibleBetreuer = {

      def betreuer = Personen.findAllByPersonstatusInList([Personstatus.get(3), Personstatus.get(4), Personstatus.get(2)])
      
      return [betreuerList: betreuer]

    }

  /**
   * AJAX-Funktionalität, Listet alle Mitglieder, Anwärter und AOler auf
   * z.B. für die Auswahl des Coaches bei einem Projekt gebraucht
   */

    def getAktivePaulisByNameAsJSON = {

      def search = params['term'].toString().toLowerCase()

      def aktivePaulis = Personen.findAllByPersonstatusInList([Personstatus.get(3), Personstatus.get(4), Personstatus.get(2)])
      println(aktivePaulis.size())
      def res = []
      aktivePaulis.each{
        if(it.vorname.toLowerCase().contains(search) || it.nachname.toLowerCase().contains(search)){
          res.add(it)
        }
      }

      res = res.collect {
        [id: it.id, label:it.vorname + " " + it.nachname, value:it.vorname + " " + it.nachname]
      }
      render res as JSON
    }

  /**
   * AJAX-Funktionalität
   * Listet alle Paulis auf (keine Externen Personen) die auf den Namen passen
   */


    def getPaulisByNameAsJSON = {

      def search = params['term'].toString().toLowerCase()
      def aktivePaulis = Personen.findAllByPersonstatusInList([Personstatus.get(3), Personstatus.get(4), Personstatus.get(2), Personstatus.get(7), Personstatus.get(8)])
      def res = []

      //Nach Namen filtern
      aktivePaulis.each{
        if(it.vorname.toLowerCase().contains(search) || it.nachname.toLowerCase().contains(search)){
          res.add(it)
        }
      }

      res = res.collect {
        [id: it.id, label:it.vorname + " " + it.nachname, value:it.vorname + " " + it.nachname]
      }
      render res as JSON
    }




    /**
     * Methode zum Upload von fotos bei Personen->show
     * Imagemagick muss dazu auf dem System installiert sein.
    */

    def fotoUpload = {

      def f = request.getFile('myFile')

      if(!f.empty) {

        def imageMagick
        def tmpFileLocation
        def convertFileLocation

        if ( GrailsUtil.getEnvironment().equals(GrailsApplication.ENV_DEVELOPMENT)){
            imageMagick = '/opt/local/bin/convert'
            tmpFileLocation = '/usr/local/db2fotos/tmp/personImages_' + params['fotoId'] + '_tmp.jpg'
            convertFileLocation = '/var/lib/tomcat7/webapps/db2bilder/personImages_' + params['fotoId'] + '.jpg'
        }

        else{
            imageMagick = '/opt/local/bin/convert'
            tmpFileLocation = '/usr/local/db2fotos/tmp/personImages_' + params['fotoId'] + '_tmp.jpg'
            convertFileLocation = '/var/www/pauldbbilder/personImages_' + params['fotoId'] + '.jpg'
        }

        //Prüfen, ob imageMagick gefunden wurde, wenn nicht, abbrechen

        def iFile = grailsApplication.parentContext.getResource(imageMagick)

          if(iFile.exists()){
            flash.message="ImageMagick konnte auf dem System nicht gefunden werden."
            redirect(action: "show", id: params['fotoId'])
            return false

        }else{
          f.transferTo( new File(tmpFileLocation) )

          //imagemagick von commandline aufrufen
          Process proc
        
		  def command = imageMagick + " " + tmpFileLocation + ' -resize 300x300 ' + convertFileLocation
          println command
          try {
          //System.out.println("Trying to execute command " + Arrays.asList(command));

            proc = Runtime.getRuntime().exec(command);
          } catch (IOException e) {
              flash.message="IOException while trying to execute " + command;
              redirect(action: "show", id: params['fotoId'])
              return false;
          }

          //Abwarten, was mit Prozess passiert (nach http://www.darcynorman.net/2005/03/15/jai-vs-imagemagick-image-resizing/ )
          int exitStatus;

          while (true) {
              try {
                  exitStatus = proc.waitFor();
                  break;
              } catch (java.lang.InterruptedException e) {
                  System.out.println("Interrupted: Ignoring and waiting");
              }
          }
          if (exitStatus != 0) {

              //flash.message="Error executing command: " + exitStatus;
              redirect(action: "show", id: params['fotoId'])
              return false
          }
          redirect(action: "show", id: params['fotoId'])
          return (exitStatus == 0);

        }

      }
      else {
         flash.message = 'file cannot be empty'
         redirect(view:'show', id:params['fotoId'])
      }
    }



    def get = {

        def person = Personen.findById(params.id)

        render person as JSON

    }

    private HistoryEnde(Personen person, Posten posten, Personstatus status){
           //Personenhistory updaten
        def ph
          if (posten!=null) ph = PersonHistory.findAllByPersonAndPostenressort(person, posten)
            else ph = PersonHistory.findAllByPersonAndPersonstatus(person, status)
          if(ph){
              ph.each{
                if (!it.bis) it.bis = new Date();  //nur wenn leer
              }
          }
    }

    private HistoryStart(Personen person, Posten posten, Personstatus status){
           //Personenhistory updaten
              def ph2 = new PersonHistory()
              ph2.person = person
              ph2.personstatus = status
              ph2.postenressort = posten
              ph2.von = new Date()
              ph2.save(flush:true)
    }


    private Boolean Bearbeitbar(Personen person){

        def gesperrterStatus = [Personstatus.get(2), Personstatus.get(3), Personstatus.get(4)]

        //es werden nur AO, Anwärter und Paulumni nicht zur vollen Bearbeitung für jeden frei gegeben
        if(gesperrterStatus.toArray().count(person.personstatus) == 0){return true}

        //admin hat immer Zugriff
        if(springSecurityService.authentication.authorities.toArray().find{it == "ROLE_ADMIN"} ){return true}

        //jeder darf auf seine eigene Person zugreifen
        if(session.userperson.id == person.id){return true}

        log.info(session.userperson.toString() +" illegaler Zugriff auf "+ person.toString())

        return false
    }

}
