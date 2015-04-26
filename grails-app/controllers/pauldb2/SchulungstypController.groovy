package pauldb2

class SchulungstypController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [schulungstypInstanceList: Schulungstyp.list(params), schulungstypInstanceTotal: Schulungstyp.count()]
    }

    def create = {
        def schulungstypInstance = new Schulungstyp()
        schulungstypInstance.properties = params
        return [schulungstypInstance: schulungstypInstance]
    }

    def save = {
        def schulungstypInstance = new Schulungstyp(params)
        if (schulungstypInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'schulungstyp.label', default: 'Schulungstyp'), schulungstypInstance.id])}"
            redirect(action: "show", id: schulungstypInstance.id)
        }
        else {
            render(view: "create", model: [schulungstypInstance: schulungstypInstance])
        }
    }

    def show = {
        def schulungstypInstance = Schulungstyp.get(params.id)
        if (!schulungstypInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'schulungstyp.label', default: 'Schulungstyp'), params.id])}"
            redirect(action: "list")
        }
        else {
            [schulungstypInstance: schulungstypInstance]
        }
    }

    def edit = {
        def schulungstypInstance = Schulungstyp.get(params.id)
        if (!schulungstypInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'schulungstyp.label', default: 'Schulungstyp'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [schulungstypInstance: schulungstypInstance]
        }
    }

    def update = {
        def schulungstypInstance = Schulungstyp.get(params.id)
        if (schulungstypInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (schulungstypInstance.version > version) {
                    
                    schulungstypInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'schulungstyp.label', default: 'Schulungstyp')] as Object[], "Another user has updated this Schulungstyp while you were editing")
                    render(view: "edit", model: [schulungstypInstance: schulungstypInstance])
                    return
                }
            }
            schulungstypInstance.properties = params
            if (!schulungstypInstance.hasErrors() && schulungstypInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'schulungstyp.label', default: 'Schulungstyp'), schulungstypInstance.id])}"
                redirect(action: "show", id: schulungstypInstance.id)
            }
            else {
                render(view: "edit", model: [schulungstypInstance: schulungstypInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'schulungstyp.label', default: 'Schulungstyp'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def schulungstypInstance = Schulungstyp.get(params.id)
        if (schulungstypInstance) {
            try {
                schulungstypInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'schulungstyp.label', default: 'Schulungstyp'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'schulungstyp.label', default: 'Schulungstyp'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'schulungstyp.label', default: 'Schulungstyp'), params.id])}"
            redirect(action: "list")
        }
    }
}
