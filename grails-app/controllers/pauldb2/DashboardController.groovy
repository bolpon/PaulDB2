package pauldb2

import grails.converters.JSON
import org.codehaus.groovy.grails.commons.ConfigurationHolder
import org.apache.commons.logging.LogFactory
import grails.plugins.springsecurity.Secured
import grails.plugins.springsecurity.SpringSecurityService
import org.springframework.security.core.context.SecurityContextHolder
import ContextMapper.MyUserDetails

import ldap_manage.ldap_get_attr
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils

class DashboardController {

    def springSecurityService

    def beforeInterceptor = [action:this.&checkUser, except:['doLogin','preloadDB']]

    def checkUser(){

      if(!session.userperson){
        redirect (action: "doLogin")
        /*
        flash.message = "Bitte melde dich an."
        redirect(uri:"/");
        return false
        */
        return false
      }
    }



    def index = {

    }

    def preloadDB = {
        //Login.list()
        Unternehmen.list([max:30])
        Personen.list([max:30])
        return true
    }

    def doLogin = {
        def PersonID = ldap_get_attr.main(springSecurityService.principal.username)

        if(! PersonID){
            redirect(controller: 'logout')
        }
        session.userperson = getPersonInstance(PersonID)
        if(!session.userperson){
            redirect(controller: 'logout')
        }
        def now = System.currentTimeMillis()
        def name = session.userperson
        session.now = now
        session.role = "user"
        redirect(action:'index');
        return true
    }

    private getPersonInstance (db2ID) {
        return Personen.findById( db2ID )
    }

    //liefert Ergebnisse für die Quicksearch-Bar als JSON
    def ajaxQuickSearch = {

      // Personen

        List BezListe = params.term.split(" ");
        if (BezListe.size()>0) BezListe[BezListe.size()-1] = BezListe[BezListe.size()-1] + "%";
        while (BezListe.size()<2) BezListe.add("%");

        def personen
        if (BezListe.size()==2){
            personen = Personen.findAll("from Personen as p where p.vorname like (:Bez1) and p.nachname like (:Bez2)" +
                    "or p.vorname like (:Bez2) and p.nachname like (:Bez1)", [Bez1: BezListe[0], Bez2: BezListe[1]])
        } else personen = []


      def unternehmen = Unternehmen.findAllByNameLike("%"+params.term+"%")

            def projanfrage = []
        /* Anzeige wird für Quicksearch zu lang
        def projektUnternehmen = []
            unternehmen.each{
                projektUnternehmen = ProjektanfrageUnternehmen.findAllByUnternehmen(it)
                projektUnternehmen.each{
                    projanfrage.add(it.projektanfrage)
                }
            }
         */
      personen = personen.collect {
          [id:it.id, label:it.vorname + " " + it.nachname, value:it.vorname + " " + it.nachname, vorname:it.vorname, nachname:it.nachname, art:"personen", category:"Personen"]
        }

      unternehmen = unternehmen.collect {
        [id:it.id, label:it.name, value:it.name, name:it.name, art:"unternehmen", category:"Unternehmen"];
      }

      projanfrage = projanfrage.collect{
        [id:it.id, label:it.beschreibung, value:it.toString(), name:it.beschreibung, art:"projektanfrage", category:"Projektanfragen"]
      }

      def proj = Projekte.findAllByProjektnameOrBeschreibungLike("%"+params.term+"%","%"+params.term+"%")

      proj = proj.collect{
        [id:it.id, label:it.projektname, value:it.projektname, name:it.projektname, art:"projekt", category:"Projekte"]
      }



      def jsonResult =  personen + unternehmen + proj + projanfrage
      render jsonResult as JSON
                                    
    }


    def processQuickSearch = {

        if(params.art == "personen"){

          redirect(controller:"personen", action:"show", id:params.id)
          
        }
        else if (params.art =="unternehmen"){

          redirect(controller:"unternehmen", action:"show", id:params.id)
        }

        else if (params.art =="projekt"){

          redirect(controller:"projekte", action:"show", id:params.id)
        }

        else if (params.art =="projektanfrage"){
          redirect(controller:"projektanfrage", action:"show", id:params.id)
        }
        
    }

    def unternehmenWidget = {
        def person = Personen.get(session.userperson.id)
        def unternehmen = person.betreuteUnternehmen.sort{it.name}
        [unternehmen:unternehmen]
    }

    def aufgabenBearbeitenWidget = {
        def person = Personen.get(session.userperson.id)
        def aufgabenBearbeitenList = person.aufgabenBearbeiten.sort {it.end}
        [aufgabenBearbeitenList:aufgabenBearbeitenList,]
    }

    def aufgabenVerwaltenWidget = {
        def person = Personen.get(session.userperson.id)
        def aufgabenVerwaltenList = person.aufgabenVerwalten.sort{it.end}
        [aufgabenVerwaltenList:aufgabenVerwaltenList]
    }


}
