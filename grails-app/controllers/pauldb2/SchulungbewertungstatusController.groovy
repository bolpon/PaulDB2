package pauldb2

class SchulungbewertungstatusController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [schulungbewertungstatusInstanceList: Schulungbewertungstatus.list(params), schulungbewertungstatusInstanceTotal: Schulungbewertungstatus.count()]
    }

    def create = {
        def schulungbewertungstatusInstance = new Schulungbewertungstatus()
        schulungbewertungstatusInstance.properties = params
        return [schulungbewertungstatusInstance: schulungbewertungstatusInstance]
    }

    def save = {
        def schulungbewertungstatusInstance = new Schulungbewertungstatus(params)
        if (schulungbewertungstatusInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'schulungbewertungstatus.label', default: 'Schulungbewertungstatus'), schulungbewertungstatusInstance.id])}"
            redirect(action: "show", id: schulungbewertungstatusInstance.id)
        }
        else {
            render(view: "create", model: [schulungbewertungstatusInstance: schulungbewertungstatusInstance])
        }
    }

    def show = {
        def schulungbewertungstatusInstance = Schulungbewertungstatus.get(params.id)
        if (!schulungbewertungstatusInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'schulungbewertungstatus.label', default: 'Schulungbewertungstatus'), params.id])}"
            redirect(action: "list")
        }
        else {
            [schulungbewertungstatusInstance: schulungbewertungstatusInstance]
        }
    }

    def edit = {
        def schulungbewertungstatusInstance = Schulungbewertungstatus.get(params.id)
        if (!schulungbewertungstatusInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'schulungbewertungstatus.label', default: 'Schulungbewertungstatus'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [schulungbewertungstatusInstance: schulungbewertungstatusInstance]
        }
    }

    def update = {
        def schulungbewertungstatusInstance = Schulungbewertungstatus.get(params.id)
        if (schulungbewertungstatusInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (schulungbewertungstatusInstance.version > version) {
                    
                    schulungbewertungstatusInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'schulungbewertungstatus.label', default: 'Schulungbewertungstatus')] as Object[], "Another user has updated this Schulungbewertungstatus while you were editing")
                    render(view: "edit", model: [schulungbewertungstatusInstance: schulungbewertungstatusInstance])
                    return
                }
            }
            schulungbewertungstatusInstance.properties = params
            if (!schulungbewertungstatusInstance.hasErrors() && schulungbewertungstatusInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'schulungbewertungstatus.label', default: 'Schulungbewertungstatus'), schulungbewertungstatusInstance.id])}"
                redirect(action: "show", id: schulungbewertungstatusInstance.id)
            }
            else {
                render(view: "edit", model: [schulungbewertungstatusInstance: schulungbewertungstatusInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'schulungbewertungstatus.label', default: 'Schulungbewertungstatus'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def schulungbewertungstatusInstance = Schulungbewertungstatus.get(params.id)
        if (schulungbewertungstatusInstance) {
            try {
                schulungbewertungstatusInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'schulungbewertungstatus.label', default: 'Schulungbewertungstatus'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'schulungbewertungstatus.label', default: 'Schulungbewertungstatus'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'schulungbewertungstatus.label', default: 'Schulungbewertungstatus'), params.id])}"
            redirect(action: "list")
        }
    }
}
