package pauldb2

class KontaktartController {
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

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [kontaktartInstanceList: Kontaktart.list(params), kontaktartInstanceTotal: Kontaktart.count()]
    }

    def create = {
        def kontaktartInstance = new Kontaktart()
        kontaktartInstance.properties = params
        return [kontaktartInstance: kontaktartInstance]
    }

    def save = {
        def kontaktartInstance = new Kontaktart(params)
        if (kontaktartInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'kontaktart.label', default: 'Kontaktart'), kontaktartInstance.id])}"
            redirect(action: "show", id: kontaktartInstance.id)
        }
        else {
            render(view: "create", model: [kontaktartInstance: kontaktartInstance])
        }
    }

    def show = {
        def kontaktartInstance = Kontaktart.get(params.id)
        if (!kontaktartInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'kontaktart.label', default: 'Kontaktart'), params.id])}"
            redirect(action: "list")
        }
        else {
            [kontaktartInstance: kontaktartInstance]
        }
    }

    def edit = {
        def kontaktartInstance = Kontaktart.get(params.id)
        if (!kontaktartInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'kontaktart.label', default: 'Kontaktart'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [kontaktartInstance: kontaktartInstance]
        }
    }

    def update = {
        def kontaktartInstance = Kontaktart.get(params.id)
        if (kontaktartInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (kontaktartInstance.version > version) {
                    
                    kontaktartInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'kontaktart.label', default: 'Kontaktart')] as Object[], "Another user has updated this Kontaktart while you were editing")
                    render(view: "edit", model: [kontaktartInstance: kontaktartInstance])
                    return
                }
            }
            kontaktartInstance.properties = params
            if (!kontaktartInstance.hasErrors() && kontaktartInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'kontaktart.label', default: 'Kontaktart'), kontaktartInstance.id])}"
                redirect(action: "show", id: kontaktartInstance.id)
            }
            else {
                render(view: "edit", model: [kontaktartInstance: kontaktartInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'kontaktart.label', default: 'Kontaktart'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def kontaktartInstance = Kontaktart.get(params.id)
        if (kontaktartInstance) {
            try {
                kontaktartInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'kontaktart.label', default: 'Kontaktart'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'kontaktart.label', default: 'Kontaktart'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'kontaktart.label', default: 'Kontaktart'), params.id])}"
            redirect(action: "list")
        }
    }
}
