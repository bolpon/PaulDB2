package pauldb2

import grails.converters.JSON
import java.text.SimpleDateFormat

class ProjekteController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    //nur befugter Zugriff fuer angemeldete Leute ansonsten Umleitung auf Loginseite
    def beforeInterceptor = [action:this.&checkUser]

    def checkUser(){
        if(!session.userperson){
          redirect(uri:"/");
          return false
        }
    }

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)

      //Für Suche nach Projektteammitgliedern
      def paulis = (Personen.createCriteria().list() { ne("personstatus", pauldb2.Personstatus.findByBezeichnung("fremd")); order("id","desc"); })
      paulis.sort{

        it.vorname
      }

      params.intern = true;
      params.extern = true;
      params.sort = params?.sort ?: "anfangsdatum"
      params.order = params?.order ?: "desc"

      [projekteInstanceList: Projekte.list(params), projekteInstanceTotal: Projekte.count(), projekteInstancePaulis: paulis, role: session.role]
    }

    def create = {
        def projekteInstance = new Projekte()

        def posTeammitglieder = Personen.findAllByPersonstatusInList([Personstatus.get(3), Personstatus.get(4), Personstatus.get(2)])

        posTeammitglieder.sort{
          it.nachname
        }

        projekteInstance.properties = params
        return [projekteInstance: projekteInstance, posTeammitglieder: posTeammitglieder ]
    }

    def save = {

        /*render params as JSON
        return false*/

        def projekteInstance = new Projekte(params)

        // neue Unternehmen
        def unternehmen_neu = params.get('uID')

        if (params['uID']?.class?.name?.equals('java.lang.String')) {
            // übergebene Parameter sind String

            // Füge Unternehmen hinzu
            def u = Unternehmen.get(params['uID'])
            projekteInstance.addToUnternehmen(u)

        } else {
            // übergebene Unternehmen sind eine Liste

            // Füge alle neuen Unternehmen hinzu
            unternehmen_neu.eachWithIndex{ item, i ->
                def u = pauldb2.Unternehmen.get(item)
                projekteInstance.addToUnternehmen(u)
            }
        }

         /**
         * Kontaktperson zum Projekt
         *
         * ! Ansprechpartner = Mitarbeiter;  nicht Person !
         */

        // definiere Zwischenspeicher für alte AP, neue AP sowie zu löschende AP

        // Teste übergebenen Parameter auf String oder Liste
        if (params.get('ansprechpartner')?.class?.name?.equals('java.lang.String')) {
            // Parameter ist String (einzelner AP)

            projekteInstance.addToAnsprechpartner(Mitarbeiter.get(params['ansprechpartner']))
        } else {
            // Parameter ist eine Liste (mehrere AP)
            params['ansprechpartner'].eachWithIndex {item, i ->

                def ap = Mitarbeiter.get(item)
                // in Projekte.Ansprechpartner einfügen
                projekteInstance.addToAnsprechpartner(ap)
            }
        }


      /**
       * Tätigkeitsfelder-Daten Updaten
       */

        def tf = params.get('taetigkeitsFelder')

        // Rückgabewert ist einzeln ein String, bei mehreren ein Array
        if (params['taetigkeitsFelder']?.class?.name?.equals('java.lang.String')) {

            // Erzeuge ein neues Tätigkeitsfeld-Element
            def tf_new = pauldb2.Taetigkeitsfeld.findById(tf)
            // Füge es zum Projekt hinzu
            projekteInstance.addToTaetigkeitsfeld(tf_new)

        } else {

            // das Gleiche wie oben, nur der übergebene Parameter ist eine Liste und muss durchiteriert werden
            tf.eachWithIndex{ item, i ->

                def tf_new = pauldb2.Taetigkeitsfeld.findById(item)
                projekteInstance.addToTaetigkeitsfeld(tf_new)

            }
        }

        def coach = Personen.get(params.coach?.id)

        if(coach){
          projekteInstance.coach = coach
        }

        /*

        def projektphase = Projektphase.get(params.projektphase.id)
        def projektanfrage = Projektanfrage.get(params.projektanfrage.id)


        projekteInstance.projektphase = projektphase
        projekteInstance.projektanfrage = projektanfrage

        */

        if(params.teammitglieder){

          if(params.teammitglieder.class.name.equals("java.lang.String")){
              def person = Personen.get(params.teammitglieder)
              def tm = new Teammitglied()
              tm.person = person
              tm.projekt= projekteInstance
              projekteInstance.addToTm(tm)

            }
            else{

              params.teammitglieder.eachWithIndex {item, i ->

                def person = Personen.get(item)
                def tm = new Teammitglied()
                tm.person = person
                tm.projekt = projekteInstance
                projekteInstance.addToTm(tm)

              }

            }
        }

        if(params['projektleiter']){

              def person = Personen.get(params.projektleiter)
              def tm = new Teammitglied()
              tm.person = person
              tm.projekt= projekteInstance
              projekteInstance.addToTm(tm)

              def pl = new Projektleiter()
              pl.teammitglied = tm;
              tm.addToProjektLeiter(pl)

        }

        /*
            Freie Mitarbeiter
         */

        def fmaPersonID = params['fmaPersonId']
        def fmaBemerkung = params['fmaBemerkung']
        SimpleDateFormat germanDate = new SimpleDateFormat("dd.MM.yyyy");

        if (params['fmaPersonId']?.class?.name?.equals('java.lang.String')) {

            // nur ein FMA zu speichern (String)
            // Speichere in freiemitarbeiter person_id projekt_id, von [YYYY-MM-DD], bis [YYYY-MM-DD]
            def fma_single = new FreieMitarbeiter()
            fma_single.person = Personen.get(fmaPersonID)
            fma_single.projekt = projekteInstance
            fma_single.bemerkung = fmaBemerkung

            if(params['fmaVon']!=null && params['fmaVon']!=""){
              fma_single.von = germanDate.parse(params['fmaVon'])
            }
            if(params['fmaBis']!=null && params['fmaBis']!=""){
              fma_single.bis = germanDate.parse(params['fmaBis'])
            }


            //println("ahfisdpofasdgfagaderfgwre")
            //println ("S: Füge Freien Mitarbeiter hinzu: "+fma_single.person.vorname+" "+fma_single.person.nachname+", Projekt: "+fma_single.projekt.projektname+", von-bis: "+germanDate.format(fma_single.von)+" - "+germanDate.format(fma_single.bis)+", Bemerkung: "+fma_single.bemerkung)

            projekteInstance.addToFreieMitarbeiter(fma_single)
            fma_single.save(flush:true)

        } else {
            // Liste -> mehrere Mitarbeiter

            fmaPersonID.eachWithIndex{ item, i ->
                def fma_list = new FreieMitarbeiter()
                fma_list.person = Personen.get(fmaPersonID[i])
                fma_list.projekt = projekteInstance
                fma_list.bemerkung = fmaBemerkung[i]

                if(params['fmaVon'][i]!=null && params['fmaVon'][i]!=""){
                  fma_list.von = germanDate.parse(params['fmaVon'][i])
                }
                if(params['fmaBis'][i]!=null && params['fmaBis'][i]!=""){
                  fma_list.bis = germanDate.parse(params['fmaBis'][i])
                }

                projekteInstance.addToFreieMitarbeiter(fma_list)

            }
        }

        if (projekteInstance.save(flush: true)) {
            log.info(session.userperson.toString() +" hat Projekt "+ projekteInstance.toString() + " angelegt.")
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'projekte.label', default: 'Projekte'), projekteInstance.id])}"
            redirect(action: "show", id: projekteInstance.id)
        }
        else {
            def fma = projekteInstance.freieMitarbeiter
            def deleteList = []
            fma.each {deleteList.add(it)}
            deleteList.each{
              projekteInstance.removeFromFreieMitarbeiter(it)
              it.delete(flush:true)
            }
            render(view: "create", model: [projekteInstance: projekteInstance])
        }


    }

    def show = {

        def projekteInstance = Projekte.get(params.id)

        if (!projekteInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'projekte.label', default: 'Projekte'), params.id])}"
            redirect(action: "list")
        }
        else {

            def freieMitarbeiterList = projekteInstance.freieMitarbeiter.sort{it.person.nachname}
            def unternehmenList = projekteInstance.unternehmen

            def ansprechpartnerList = projekteInstance.ansprechpartner
            def taetigkeitsfelderList = projekteInstance.taetigkeitsfeld.sort{it.bezeichnung}
            def teammitgliedList = projekteInstance.tm.sort{it.id}
            def projektleiterList = []   //enthält die IDs der Teammitglieder, die PL sind

            teammitgliedList.each{

              if(Projektleiter.findByTeammitglied(it)){

                  def pl = Projektleiter.findByTeammitglied(it)
                  if(pl){projektleiterList.add(pl.teammitglied.id)}
              }
            }
            log.info("Projekt: " + projekteInstance.toString() + " wird angezeigt ")
            [projekteInstance: projekteInstance, teammitgliedList:teammitgliedList, freieMitarbeiterList:freieMitarbeiterList, unternehmenList:unternehmenList, ansprechpartnerList:ansprechpartnerList, projektleiterList:projektleiterList, taetigkeitsfelderList:taetigkeitsfelderList, role: session.role]
        }
    }

    def edit = {

        def projekteInstance = Projekte.get(params.id)

        def taetigkeitsFelder = projekteInstance.taetigkeitsfeld

        def taetigkeitsCluster = projekteInstance.taetigkeitsfeld.cluster
        def taetigkeitsFelderSelectList = [:]

        taetigkeitsCluster.eachWithIndex{item, i ->
              def felder = Taetigkeitsfeld.findAllByCluster(item)
              taetigkeitsFelderSelectList.put(i,felder)

        }

        if (!projekteInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'projekte.label', default: 'Projekte'), params.id])}"
            redirect(action: "list")
        }
        else {
            def posTeammitglieder = Personen.findAllByPersonstatus(Personstatus.get(3)) + Personen.findAllByPersonstatus(Personstatus.get(4)) + Personen.findAllByPersonstatus(Personstatus.get(2))
            posTeammitglieder.sort{
              it.nachname
            }

            def freieMitarbeiterList = projekteInstance.freieMitarbeiter.sort{it.person.nachname}


          /**
           * da posTeammitglieder nur aktuelle Anwärter, Paulis und AOler enthält
           * kann es vor allem bei älteren Projekten vorkommen, dass die Projektteammitglieder bzw der Coach nicht darunter sind
           * in diesem Fall werden sie zur der Liste hinzugefügt, damit sie in der Auswahlansicht als selektiert mit auftauchen
           *
           */


            def teammitglieder = projekteInstance.tm.sort{it.person.nachname}
            def coach = projekteInstance.coach

            //teammitglieder hinzufügen wenn nicht vorhanden
            projekteInstance.tm.each{

              if(!posTeammitglieder.contains(it.person)){

                posTeammitglieder.add(it.person)
              }
            }

            //wenn projekt coach hat und dieser nicht in posTeammitglieder ist -> hinzu
            if (projekteInstance.coach && !posTeammitglieder.contains(projekteInstance.coach)){
              posTeammitglieder.add(projekteInstance.coach)
            }

            def projektleiter

            teammitglieder.each{

              if(Projektleiter.findByTeammitglied(it)){

                  projektleiter = Projektleiter.findByTeammitglied(it)
              }
            }

            // Mitarbeiterliste für die Auswahl der Ansprechpartner eines Projektes
            def mitarbeiter = []

            projekteInstance.unternehmen.mitarbeiter.each{
                it.each{item ->
                    mitarbeiter.add(item)
                }
            }


            def projektanfragen = []
            def projektUnternehmen = ProjektanfrageUnternehmen.findAllByUnternehmenInList(projekteInstance.unternehmen)
                projektUnternehmen.each{
                    projektanfragen.add(it.projektanfrage)
                }

            return [projekteInstance: projekteInstance, posTeammitglieder:posTeammitglieder, teammitglieder:teammitglieder,
                    coach:coach,freieMitarbeiterList:freieMitarbeiterList, projektleiter:projektleiter, taetigkeitsCluster:taetigkeitsCluster,
                    taetigkeitsFelder:taetigkeitsFelder, taetigkeitsFelderSelectList:taetigkeitsFelderSelectList,
                    mitarbeiter:mitarbeiter, role: session.role, anfrageListe: projektanfragen]
        }
    }


    def editTeammitglieder = {

      def projekt = Projekte.get(params.projektId);
      def now = new Date()
      // neue Teammitglieder finden und anlegen

      def tmList = []
      SimpleDateFormat germanDate = new SimpleDateFormat("dd.MM.yyyy");
      params['teammitglieder[]'].each{
      //IDs von Personen, nicht von tm

        def person = Personen.get(it)
        def tm = Teammitglied.findByProjektAndPerson(projekt,person)

        if(!tm){

          def tmnew = new Teammitglied()
          tmnew.person = person
          tmnew.projekt = projekt
          tmnew.von = null
          tmnew.bis = null
          projekt.addToTm(tmnew)

          def msg = now.toString() + " " + tmnew.person.toString() + " wurde von "+ session.userperson.toString() + " zum Projekt " + projekt.toString() + " hinzugefügt"
          println(msg)

          tmList.add(tmnew)
          tmnew.save(flush:true)
          /*if(!tmnew.save(flush:true)){

            flash.message ="Fehler beim Speichern des Teammitgliedes"
          }*/
        }else{
          tmList.add(tm)
        }
      }


      // teammitglieder löschen

      def tms = Teammitglied.findAllByProjekt(projekt)
      def deleteList = tms - tmList
      println('old: ' + tms)
      println('new: ' + tmList)
      deleteList.each{
        println('lösche aus projekt: '+ it)
        projekt.removeFromTm(it)
        it.delete(flush:true)
      }

      //def erg = Teammitglied.findAllByProjekt(projekt).sort{ it.person }

      // emtpy map
      def erg2 = []

      tmList.each{

        println("adding..")
        def res = [:]
        res.put("tmId", it.id)

        res.put("vorname", it.person.vorname)
        res.put("nachname", it.person.nachname)

        if(it.von!=null){
          res.put("von", germanDate.format(it.von))
        } else {
          res.put("von", "")
        }

        if(it.bis!=null){
          res.put("bis", germanDate.format(it.bis))
        } else {
          res.put("bis", "")
        }

        def projektleiter = Projektleiter.findByTeammitglied(it)
        if(projektleiter){
          res.put("pl",true)
          res.put("plVon",germanDate.format(projektleiter.von))
          res.put("plBis",germanDate.format(projektleiter.bis))
        }
        else{
          res.put("pl",false)
        }

        erg2.add(res)
      }

       render erg2 as JSON
    }


    def editFMA = {


      def projekt = Projekte.get(params.projektId);
      def now = new Date()
      // neue Teammitglieder finden und anlegen

      def fmaList = []
      SimpleDateFormat germanDate = new SimpleDateFormat("dd.MM.yyyy");



      // nur ein FMA in Liste
      if(params['fma[]'].class.name.equals("java.lang.String")){
          fmaList.add(params['fma[]'])
          def person = Personen.get(params['fma[]'])
          def fma = FreieMitarbeiter.findByProjektAndPerson(projekt,person)

          if(!fma){

            def fmanew = new FreieMitarbeiter()
            fmanew.person = person
            fmanew.projekt = projekt
            fmanew.von = null
            fmanew.bis = null
            fmanew.bemerkung = ""

            def msg = now.toString() + " " + fmanew.person.toString() + " wurde von "+ session.userperson.toString() + " zum Projekt " + projekt.toString() + " hinzugefügt"
            println(msg)
            if(!fmanew.save(flush:true)){

              flash.message ="Fehler beim Speichern des Teammitgliedes"
            }
          }

      }
      else{

        params['fma[]'].each{

          fmaList.add(it)
          def person = Personen.get(it)
          def fma = FreieMitarbeiter.findByProjektAndPerson(projekt,person)

          if(!fma){

            def fmanew = new FreieMitarbeiter()
            fmanew.person = person
            fmanew.projekt = projekt
            fmanew.von = null
            fmanew.bis = null
            fmanew.bemerkung = ""

            def msg = now.toString() + " " + fmanew.person.toString() + " wurde von "+ session.userperson.person.toString() + " zum Projekt " + projekt.toString() + " hinzugefügt"
            println(msg)
            if(!fmanew.save(flush:true)){

              flash.message ="Fehler beim Speichern des Teammitgliedes"
            }
          }
        }

      }




      // teammitglieder löschen

      def fmas = FreieMitarbeiter.findAllByProjekt(projekt)

      fmas.each{

        if(!fmaList.contains ( it.person.id.toString() )){

          def msg = now.toString() + " " + it.person.toString() + " wurde von "+ session.userperson.person.toString() + " aus dem Projekt " + projekt.toString() + " gelöscht"
          println(msg)

          it.delete(flush:true)
        }
      }

      def erg = FreieMitarbeiter.findAllByProjekt(projekt).sort{ it.person.nachname }.reverse()

      // emtpy map
      def erg2 = []

      erg.each{

        println("adding " + it.person.vorname + " " + it.person.nachname + " to FMA, bemerkung=" + it.bemerkung)
        def res = [:]
        res.put("fmaId", it.id)
        res.put("vorname", it.person.vorname)
        res.put("nachname", it.person.nachname)
        if(it.von!=null){
          res.put("von", germanDate.format(it.von))
        } else {
          res.put("von", "")
        }
        if(it.bis!=null){
          res.put("bis", germanDate.format(it.bis))
        } else {
          res.put("bis", "")
        }
        if(it.bemerkung!=""){
          res.put("bemerkung", it.bemerkung)
        } else {
          res.put("bemerkung", "")
        }
        erg2.add(res)
      }



        render erg2 as JSON

    }

    def update = {
       // Projektinstanz zuweisen

      /*render params as JSON
      return false*/

      def projekteInstance = Projekte.get(params.id)

       // zum Ausgeben der übergebenen Daten als JSON-Datei Kommentar unten entfernen
       // render params as JSON

       /**
        * Unternehmen Updaten
        */

       // neue Unternehmen
       def unternehmen_neu = params.get('uName')
       // alte Unternehmen
       def unternehmen_alt = projekteInstance.unternehmen
       def unternehmen_delete = []

       if (params['uName']?.class?.name?.equals('java.lang.String')) {
          // Lösche altes Item
          // Suche für jedes alte Unternehmen ob es >dem< neuen entspricht. Wenn nein -> löschen
          unternehmen_alt.eachWithIndex {item, i ->
               if (!(item.name.equals(unternehmen_neu))) {
                   unternehmen_delete.add(item)
               }
           }

           // Suche neues Unternehmen in den alten, wird es nicht gefunden -> hinzufügen
           if (!(unternehmen_alt.find{it.name.equals(unternehmen_neu)})) {
               // Füge Unternehmen hinzu
               def u = pauldb2.Unternehmen.findByName(unternehmen_neu)
               projekteInstance.addToUnternehmen(u)
           }

       } else {
           // übergebene Unternehmen sind eine Liste

           // überprüfe für alle alten Unternehmen...
           unternehmen_alt.eachWithIndex{ item, i ->
               // Ist es in der Liste der neuen Unternehmen?
               if (!(unternehmen_neu.find{it.equals(item.name)})) {
                   // Nein: Lösche altes Unternehmen
                   def u = projekteInstance.unternehmen.find{it.name.equals(item.name)}
                   unternehmen_delete.add(u)
               }
           }
           // überprüfe für alle neuen Unternehmen...
           unternehmen_neu.eachWithIndex{ item, i ->
               // Ist es in den alten Unternehmen zu finden?
               if (!(unternehmen_alt.find{it.name.equals(item)})) {
                   // Nein: Füge neues Unternehmen hinzu
                   def u = pauldb2.Unternehmen.findByName(item)
                   projekteInstance.addToUnternehmen(u)
               }
           }
       }

       // Zum löschen vorgemerkte Unternehmen löschen
       unternehmen_delete.each{
           projekteInstance.removeFromUnternehmen(it)
       }

        /**
         * Kontaktperson zum Projekt
         *
         * ! Ansprechpartner = Mitarbeiter;  nicht Person !
         */

        // definiere Zwischenspeicher für alte AP, neue AP sowie zu löschende AP
        def ap_neu = params.get('projektAnsprechpartner')
        def ap_alt = projekteInstance?.ansprechpartner
        def ap_delete = []


        // Teste übergebenen Parameter auf String oder Liste
        if (params.get('projektAnsprechpartner')?.class?.name?.equals('java.lang.String')) {
            // Parameter ist String (einzelner AP)
            // Test ob alte AP gelöscht werden müssen

            // Überprüfe für alle alten AP...
            ap_alt?.eachWithIndex {item, i ->
                // ...ist AP der, der übergeben wurde?
                if (!(item.id == Integer.parseInt(ap_neu))) {
                    // Wenn nicht -> merke diesen AP zum Löschen vor
                    ap_delete?.add(item)
                }
            }
            // Suche den neuen AP in den alten...
            if (!(ap_alt?.find{it.id == Integer.parseInt(ap_neu)})) {
                // ...ist er nicht enthalten, füge ihn hinzu

                // Neues APobjekt aus der APtabelle holen
                def ap = pauldb2?.Mitarbeiter?.findById(ap_neu)
                // in Projekte.Ansprechpartner einfügen
                projekteInstance?.addToAnsprechpartner(ap)
            }
        } else {
            // Parameter ist eine Liste (mehrere AP)
            // Test ob alte AP gelöscht werden müssen

            // Überprüfe für alle alten AP...
            ap_alt?.eachWithIndex {item, i ->
                // ...ist AP der, der übergeben wurde?
                if (!(ap_neu?.find{Integer.parseInt(it) == item.id})) {
                    // Wenn nein, merke AP zum Löschen vor
                    ap_delete?.add(item)
                }
            }
            // Überprüfe für alle neuen AP...
            ap_neu?.eachWithIndex {item, i ->
                // Ist er in den alten enthalten?
                if (!(ap_alt?.find{it.id == Integer.parseInt(item)})) {
                    // Wenn nein, fürge ihn hinzu

                    // Neues APobjekt aus der APtabelle holen
                    def ap = pauldb2?.Mitarbeiter?.findById(item)
                    // in Projekte.Ansprechpartner einfügen
                    projekteInstance?.ansprechpartner.add(ap)
                }
            }
        }

        // Zum löschen vorgemerkte AP löschen
        ap_delete.each{
            projekteInstance?.removeFromAnsprechpartner(it)
        }

     /**
      * Tätigkeitsfelder-Daten Updaten
      */

       // neue Tätigkeitsfelder
       def tf_new = params.get('taetigkeitsFelder')
       // alte Tätigkeitsfelder
       def tf_old = projekteInstance.taetigkeitsfeld

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
               projekteInstance.addToTaetigkeitsfeld(tf)
           }
       } else {
           // Ist neues TF in alten zu finden?
           if (tf_old != null) {
               tf_old.eachWithIndex{ item, i ->
                   // Wenn nein:
                   if (!(tf_new.find{Integer.parseInt(it) == item.id})) {
                       // Lösche altes Item
                       def tf = projekteInstance.taetigkeitsfeld.find{it.id == item.id}
                       taetigkeitsFelder_delete.add(tf)
                   }
               }
           }
           tf_new.eachWithIndex{ item, i ->
               //Falls Tätigkeitsfeld noch nicht vorhanden ist
               if (!(tf_old.find{it.id == Integer.parseInt(item)})) {
                   // Füge Tätigkeitsfeld hinzu
                   def tf = pauldb2.Taetigkeitsfeld.findById(item)
                   projekteInstance.addToTaetigkeitsfeld(tf)
               }
           }
       }

       // Zum löschen vorgemerkte TF löschen
       taetigkeitsFelder_delete.each{
           projekteInstance.removeFromTaetigkeitsfeld(it)
       }


     /**
      * Teammitglieder-Daten updaten
      */

       params.tmId.eachWithIndex{item, i ->

         def tm = Teammitglied.get(item)
         SimpleDateFormat target = new SimpleDateFormat("dd.MM.yyyy");

         if(params.tmVon[i].equals("")){
           tm.von = null
         }
         else{
           tm.von = target.parse(params.tmVon[i])
         }

         if(params.tmBis[i].equals("")){
           tm.bis = null
         }
         else{
           tm.bis = target.parse(params.tmBis[i])
         }


         if(!tm.save(flush:true)){
            flash.message = "Something went wrong by saving teammembers..."
            render(view: "edit", model: [projekteInstance: projekteInstance])
            return false
         }

       }

     /**
     *
      * FMA updaten
      */


         SimpleDateFormat target = new SimpleDateFormat("dd.MM.yyyy");
         if(params.fmaId){
            if(params.fmaId?.class.name.equals("java.lang.String")){
              //kommentar1
              def fma = FreieMitarbeiter.get(params.fmaId)
              //kommentar 2
              if(params.fma.Von.equals("")){
                fma.von = null
              }
              else{
                fma.von = target.parse(params.fmaVon)
              }

              if(params.fmaBis.equals("")){
                fma.bis = null
              }
              else{
                fma.bis = target.parse(params.fmaBis)
              }

              fma.bemerkung = params.fmaBemerkung

              if(!fma.save(flush:true)){
                flash.message = "Something went wrong by saving fma..."
                render(view: "edit", model: [projekteInstance: projekteInstance])
                return false
              }

            }

            else{
              // mehrere FMA

              params.fmaId.eachWithIndex{item, i ->

                def fma = FreieMitarbeiter.get(item)


                if(params.fmaVon[i].equals("")){
                  fma.von = null
                }
                else{
                  fma.von = target.parse(params.fmaVon[i])
                }

                if(params.fmaBis[i].equals("")){
                  fma.bis = null
                }
                else{
                  fma.bis = target.parse(params.fmaBis[i])
                }

                fma.bemerkung = params.fmaBemerkung[i]

                if(!fma.save(flush:true)){
                  flash.message = "Something went wrong by saving fma..."
                  render(view: "edit", model: [projekteInstance: projekteInstance])
                  return false
                }

               }
            }


         }



      /**
       * Projektleiter prüfen
       *
       */

       def pl = Projektleiter.get(params.plId)
       if(pl){
            //pl existiert
            if(params.plGroup!=params.plTmId){
                //aber wurde neu gesetzt
                pl.teammitglied = Teammitglied.get(params.plGroup)
            }
       }else{
            if(params.plGroup){
                //pl exisistiert noch nicht
                def plNew = new Projektleiter();
                plNew.teammitglied = Teammitglied.get(params.plGroup)
                Teammitglied.get(params.plGroup).addToProjektLeiter(plNew)
            }

       }









     /**
       * restliches Projekt updaten
      */



       //def projekteInstance = Projekte.get(params.id)
       if (projekteInstance) {
           if (params.version) {
               def version = params.version.toLong()
               if (projekteInstance.version > version) {

                   projekteInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'projekte.label', default: 'Projekte')] as Object[], "Another user has updated this Projekte while you were editing")
                   render(view: "edit", model: [projekteInstance: projekteInstance])
                   return
               }
           }
           projekteInstance.properties = params
           if (!projekteInstance.hasErrors() && projekteInstance.save(flush: true)) {
               flash.message = "${message(code: 'default.updated.message', args: [message(code: 'projekte.label', default: 'Projekte'), projekteInstance.id])}"
               log.info(session.userperson.toString() +" hat Projekt "+ projekteInstance.toString() + " upgedated.")
               redirect(action: "show", id: projekteInstance.id)
           }
           else {
               render(view: "edit", model: [projekteInstance: projekteInstance])
           }
       }
       else {
           flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'projekte.label', default: 'Projekte'), params.id])}"
           redirect(action: "list")
       }


   }

    def delete = {


        def projekteInstance = Projekte.get(params.id)
        if (projekteInstance) {

            def unternehmen = projekteInstance.unternehmen
            unternehmen.each{
              it.removeFromProjekte(projekteInstance)
            }



            try {
                def name = projekteInstance.projektname
                projekteInstance.delete(flush: true)
                log.info(session.userperson.toString() +" hat Projekt "+ name + " gelöscht.")
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'projekte.label', default: 'Projekte'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'projekte.label', default: 'Projekte'), params.id], default:'Projekt konnte nicht gelöscht werden.')}"
                log.error("Fehler beim Löschen von Projekt: "+ projekteInstance.projektname)
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'projekte.label', default: 'Projekte'), params.id])}"
            redirect(action: "list")
        }

    }


  def filter = {

    params.max = Math.min(params.max ? params.int('max') : 20, 100)


    def paulis = (Personen.createCriteria().list() { ne("personstatus", pauldb2.Personstatus.findByBezeichnung("fremd")); order("id","desc"); })
    paulis.sort{

      it.nachname
    }

    def flist = []
    def total = 0;

    // Falls Person angegeben: Person aus DB laden und verknüpfte Projekte nach Status ordnen
    if(params.tmfilter){
        def person = Personen.get(params.teammitglied)
        person.tm.each{

          switch(it.projekt.internextern){
            case "intern":
              if(params.intern){
                flist.add(it.projekt)
              }
              break;
            case "extern":
              if(params.extern){
                flist.add(it.projekt)
              }
              break

          }

        }
      total = flist.count();

    }

    // Keine Person angegeben -> alle Projekte die ausgewähltem Status entsprechen laden
    else{

      flist = Projekte.createCriteria().list(params) {
        if(params.intern && !params.extern){
          eq("internextern","intern")
          total = Projekte.countByInternextern("intern")
        }
        else if (params.extern && !params.intern){
          eq("internextern","extern")
          total = Projekte.countByInternextern("extern")
        }
        else {
          or{
             eq("internextern","extern")
             eq("internextern","intern")
             total = Projekte.countByInternextern("intern") +  Projekte.countByInternextern("extern")
          }

        }
      }
    }


    println(total);
    render(view: 'list', model:[projekteInstanceList: flist, projekteInstanceTotal: total, params:params, projekteInstancePaulis: paulis])
  }

   def getTaetigkeitsfeldByCluster = {


        def cluster = Taetigkeitscluster.get(params.id)
        def taetigkeitsfeld = Taetigkeitsfeld.findAllByCluster(cluster)

        render taetigkeitsfeld as JSON

   }

   def getTaetigkeitscluster = {
       def cluster = Taetigkeitscluster.list()

       render cluster as JSON
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

   def getMitarbeiter = {
       def projekteInstance = Projekte.get(params.id)
       def mitarbeiter = projekteInstance.unternehmen.mitarbeiter

       render mitarbeiter as JSON
   }

   def listtest = {

     //def list = Taetigkeitsfeld.list().collect {it.id}
     //println(list)

     def list = [5.0,4.0,1.0]
     def list2 = [1,2,5,200]
     def tf = Taetigkeitsfeld.get(5)
     tf.removeFromProjekte
     list2.eachWithIndex{item, i ->

          if(list.find{it==item}){
              println(item + " was found in list")
          }
          else {

              println(item + " was not found")
          }
     }


   }

   def getMitarbeiterByUnternehmen = {
       def potAnsprechpartner =  Mitarbeiter.findAllByUnternehmen(Unternehmen.get(params.id))
       potAnsprechpartner = potAnsprechpartner.collect {
           [mid:it.id, pid: it.person.id, vorname: it.person.vorname, nachname: it.person.nachname, uid: it.unternehmen.id, unternehmen: it.unternehmen.name]
       }
       render potAnsprechpartner as JSON
   }

}
