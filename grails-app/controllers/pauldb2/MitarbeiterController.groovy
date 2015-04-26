package pauldb2

class MitarbeiterController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {



        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [mitarbeiterInstanceList: Mitarbeiter.list(params), mitarbeiterInstanceTotal: Mitarbeiter.count()]
    }

    def create = {
        def mitarbeiterInstance = new Mitarbeiter()
        mitarbeiterInstance.properties = params
        return [mitarbeiterInstance: mitarbeiterInstance]
    }

    def save = {
        def mitarbeiterInstance = new Mitarbeiter(params)
        if (mitarbeiterInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'mitarbeiter.label', default: 'Mitarbeiter'), mitarbeiterInstance.id])}"
            redirect(action: "show", id: mitarbeiterInstance.id)
        }
        else {
            render(view: "create", model: [mitarbeiterInstance: mitarbeiterInstance])
        }
    }

    def show = {
        def mitarbeiterInstance = Mitarbeiter.get(params.id)
        if (!mitarbeiterInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'mitarbeiter.label', default: 'Mitarbeiter'), params.id])}"
            redirect(action: "list")
        }
        else {
            [mitarbeiterInstance: mitarbeiterInstance]
        }
    }

    def edit = {
        def mitarbeiterInstance = Mitarbeiter.get(params.id)
        if (!mitarbeiterInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'mitarbeiter.label', default: 'Mitarbeiter'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [mitarbeiterInstance: mitarbeiterInstance]
        }
    }

    def update = {
        def mitarbeiterInstance = Mitarbeiter.get(params.id)
        if (mitarbeiterInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (mitarbeiterInstance.version > version) {
                    
                    mitarbeiterInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'mitarbeiter.label', default: 'Mitarbeiter')] as Object[], "Another user has updated this Mitarbeiter while you were editing")
                    render(view: "edit", model: [mitarbeiterInstance: mitarbeiterInstance])
                    return
                }
            }
            mitarbeiterInstance.properties = params
            if (!mitarbeiterInstance.hasErrors() && mitarbeiterInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'mitarbeiter.label', default: 'Mitarbeiter'), mitarbeiterInstance.id])}"
                redirect(action: "show", id: mitarbeiterInstance.id)
            }
            else {
                render(view: "edit", model: [mitarbeiterInstance: mitarbeiterInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'mitarbeiter.label', default: 'Mitarbeiter'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def mitarbeiterInstance = Mitarbeiter.get(params.id)
        if (mitarbeiterInstance) {
            try {
                mitarbeiterInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'mitarbeiter.label', default: 'Mitarbeiter'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'mitarbeiter.label', default: 'Mitarbeiter'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'mitarbeiter.label', default: 'Mitarbeiter'), params.id])}"
            redirect(action: "list")
        }
    }
}
