package pauldb2

import groovy.sql.Sql

class StudiumController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def dataSource

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [studiumInstanceList: Studium.list(params), studiumInstanceTotal: Studium.count()]
    }

    def create = {

        def studiumInstance = new Studium()
        if(params.pid){
          session.pid=params.pid
        }


        studiumInstance.properties = params
        return [studiumInstance: studiumInstance]
    }

    def save = {



        def studiumInstance = new Studium(params)


          if (studiumInstance.save(flush: true)) {

              if(session.pid){

                def sql = new Sql(dataSource);
                String query = "update studium set person_id = " + session.pid + " where studium_id = " + studiumInstance.id
                sql.executeUpdate(query)
                def p = session.pid
                session.pid = null

                flash.message = "${message(code: 'default.created.message', args: [message(code: 'studium.label', default: 'Studium'), studiumInstance.id])}"
                redirect(controller:"personen", action: "show", id: p)

              }else{

                 flash.message = "${message(code: 'default.created.message', args: [message(code: 'studium.label', default: 'Studium'), studiumInstance.id])}"
                 redirect(action: "show", id: studiumInstance.id)
              }


          }
          else {
              render(view: "create", model: [studiumInstance: studiumInstance])
          }


    }


        


    def show = {
        def studiumInstance = Studium.get(params.id)
        if (!studiumInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'studium.label', default: 'Studium'), params.id])}"
            redirect(action: "list")
        }
        else {
            [studiumInstance: studiumInstance]
        }
    }

    def edit = {




        def studiumInstance = Studium.get(params.id)
        if (!studiumInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'studium.label', default: 'Studium'), params.id])}"
            redirect(action: "list")
        }
        else {
            session.pid = params.pid
            return [studiumInstance: studiumInstance]
        }


    }

    def update = {

        def studiumInstance = Studium.get(params.id)

        if (studiumInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (studiumInstance.version > version) {
                    
                    studiumInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'studium.label', default: 'Studium')] as Object[], "Another user has updated this Studium while you were editing")
                    render(view: "edit", model: [studiumInstance: studiumInstance])
                    return
                }
            }
            studiumInstance.properties = params
            if (!studiumInstance.hasErrors() && studiumInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'studium.label', default: 'Studium'), studiumInstance.id],  default:'Studium erfolgreich geupdated')}"
                if(session.pid){
                  redirect(controller: "personen", action: "show", id: session.pid)
                  session.pid = null
                }
                else{
                  redirect(action : "show", id: studiumInstance.id)
                }

            }
            else {
                render(view: "edit", model: [studiumInstance: studiumInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'studium.label', default: 'Studium'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def studiumInstance = Studium.get(params.id)
        if (studiumInstance) {
            try {
                studiumInstance.delete(flush: true)
                if(session.pid){

                  flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'studium.label', default: 'Studium'), params.id])}"
                  redirect(controller: "personen", action: "show", id:session.pid)
                  session.pid = null

                } else{

                   flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'studium.label', default: 'Studium'), params.id])}"
                   redirect(action: "list")
                }


            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'studium.label', default: 'Studium'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'studium.label', default: 'Studium'), params.id])}"
            redirect(action: "list")
        }
    }
}
