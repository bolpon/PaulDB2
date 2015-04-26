package pauldb2

class KontaktzweckController {
        def beforeInterceptor = [action:this.&checkUser]

        def checkUser(){

        if(!session.user){
          flash.message = "Bitte melde dich an."
          flash.redirect = request.forwardURI - request.contextPath
          redirect(uri:"/");
          return false

        }
    }
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [kontaktzweckInstanceList: Kontaktzweck.list(params), kontaktzweckInstanceTotal: Kontaktzweck.count()]
    }

    def create = {
        def kontaktzweckInstance = new Kontaktzweck()
        kontaktzweckInstance.properties = params
        return [kontaktzweckInstance: kontaktzweckInstance]
    }

    def save = {
        def kontaktzweckInstance = new Kontaktzweck(params)
        if (kontaktzweckInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'kontaktzweck.label', default: 'Kontaktzweck'), kontaktzweckInstance.id])}"
            redirect(action: "show", id: kontaktzweckInstance.id)
        }
        else {
            render(view: "create", model: [kontaktzweckInstance: kontaktzweckInstance])
        }
    }

    def show = {
        def kontaktzweckInstance = Kontaktzweck.get(params.id)
        if (!kontaktzweckInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'kontaktzweck.label', default: 'Kontaktzweck'), params.id])}"
            redirect(action: "list")
        }
        else {
            [kontaktzweckInstance: kontaktzweckInstance]
        }
    }

    def edit = {
        def kontaktzweckInstance = Kontaktzweck.get(params.id)
        if (!kontaktzweckInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'kontaktzweck.label', default: 'Kontaktzweck'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [kontaktzweckInstance: kontaktzweckInstance]
        }
    }

    def update = {
        def kontaktzweckInstance = Kontaktzweck.get(params.id)
        if (kontaktzweckInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (kontaktzweckInstance.version > version) {
                    
                    kontaktzweckInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'kontaktzweck.label', default: 'Kontaktzweck')] as Object[], "Another user has updated this Kontaktzweck while you were editing")
                    render(view: "edit", model: [kontaktzweckInstance: kontaktzweckInstance])
                    return
                }
            }
            kontaktzweckInstance.properties = params
            if (!kontaktzweckInstance.hasErrors() && kontaktzweckInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'kontaktzweck.label', default: 'Kontaktzweck'), kontaktzweckInstance.id])}"
                redirect(action: "show", id: kontaktzweckInstance.id)
            }
            else {
                render(view: "edit", model: [kontaktzweckInstance: kontaktzweckInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'kontaktzweck.label', default: 'Kontaktzweck'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def kontaktzweckInstance = Kontaktzweck.get(params.id)
        if (kontaktzweckInstance) {
            try {
                kontaktzweckInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'kontaktzweck.label', default: 'Kontaktzweck'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'kontaktzweck.label', default: 'Kontaktzweck'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'kontaktzweck.label', default: 'Kontaktzweck'), params.id])}"
            redirect(action: "list")
        }
    }
}
