package pauldb2

class UnternehmenstypController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [unternehmenstypInstanceList: Unternehmenstyp.list(params), unternehmenstypInstanceTotal: Unternehmenstyp.count()]
    }

    def create = {
        def unternehmenstypInstance = new Unternehmenstyp()
        unternehmenstypInstance.properties = params
        return [unternehmenstypInstance: unternehmenstypInstance]
    }

    def save = {
        def unternehmenstypInstance = new Unternehmenstyp(params)
        if (unternehmenstypInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'unternehmenstyp.label', default: 'Unternehmenstyp'), unternehmenstypInstance.id])}"
            redirect(action: "show", id: unternehmenstypInstance.id)
        }
        else {
            render(view: "create", model: [unternehmenstypInstance: unternehmenstypInstance])
        }
    }

    def show = {
        def unternehmenstypInstance = Unternehmenstyp.get(params.id)
        if (!unternehmenstypInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'unternehmenstyp.label', default: 'Unternehmenstyp'), params.id])}"
            redirect(action: "list")
        }
        else {
            [unternehmenstypInstance: unternehmenstypInstance]
        }
    }

    def edit = {
        def unternehmenstypInstance = Unternehmenstyp.get(params.id)
        if (!unternehmenstypInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'unternehmenstyp.label', default: 'Unternehmenstyp'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [unternehmenstypInstance: unternehmenstypInstance]
        }
    }

    def update = {
        def unternehmenstypInstance = Unternehmenstyp.get(params.id)
        if (unternehmenstypInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (unternehmenstypInstance.version > version) {
                    
                    unternehmenstypInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'unternehmenstyp.label', default: 'Unternehmenstyp')] as Object[], "Another user has updated this Unternehmenstyp while you were editing")
                    render(view: "edit", model: [unternehmenstypInstance: unternehmenstypInstance])
                    return
                }
            }
            unternehmenstypInstance.properties = params
            if (!unternehmenstypInstance.hasErrors() && unternehmenstypInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'unternehmenstyp.label', default: 'Unternehmenstyp'), unternehmenstypInstance.id])}"
                redirect(action: "show", id: unternehmenstypInstance.id)
            }
            else {
                render(view: "edit", model: [unternehmenstypInstance: unternehmenstypInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'unternehmenstyp.label', default: 'Unternehmenstyp'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def unternehmenstypInstance = Unternehmenstyp.get(params.id)
        if (unternehmenstypInstance) {
            try {
                unternehmenstypInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'unternehmenstyp.label', default: 'Unternehmenstyp'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'unternehmenstyp.label', default: 'Unternehmenstyp'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'unternehmenstyp.label', default: 'Unternehmenstyp'), params.id])}"
            redirect(action: "list")
        }
    }
}
