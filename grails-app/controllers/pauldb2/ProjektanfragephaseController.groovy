package pauldb2

class ProjektanfragephaseController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [projektanfragephaseInstanceList: Projektanfragephase.list(params), projektanfragephaseInstanceTotal: Projektanfragephase.count()]
    }

    def create = {
        def projektanfragephaseInstance = new Projektanfragephase()
        projektanfragephaseInstance.properties = params
        return [projektanfragephaseInstance: projektanfragephaseInstance]
    }

    def save = {
        def projektanfragephaseInstance = new Projektanfragephase(params)
        if (projektanfragephaseInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'projektanfragephase.label', default: 'Projektanfragephase'), projektanfragephaseInstance.id])}"
            redirect(action: "show", id: projektanfragephaseInstance.id)
        }
        else {
            render(view: "create", model: [projektanfragephaseInstance: projektanfragephaseInstance])
        }
    }

    def show = {
        def projektanfragephaseInstance = Projektanfragephase.get(params.id)
        if (!projektanfragephaseInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'projektanfragephase.label', default: 'Projektanfragephase'), params.id])}"
            redirect(action: "list")
        }
        else {
            [projektanfragephaseInstance: projektanfragephaseInstance]
        }
    }

    def edit = {
        def projektanfragephaseInstance = Projektanfragephase.get(params.id)
        if (!projektanfragephaseInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'projektanfragephase.label', default: 'Projektanfragephase'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [projektanfragephaseInstance: projektanfragephaseInstance]
        }
    }

    def update = {
        def projektanfragephaseInstance = Projektanfragephase.get(params.id)
        if (projektanfragephaseInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (projektanfragephaseInstance.version > version) {
                    
                    projektanfragephaseInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'projektanfragephase.label', default: 'Projektanfragephase')] as Object[], "Another user has updated this Projektanfragephase while you were editing")
                    render(view: "edit", model: [projektanfragephaseInstance: projektanfragephaseInstance])
                    return
                }
            }
            projektanfragephaseInstance.properties = params
            if (!projektanfragephaseInstance.hasErrors() && projektanfragephaseInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'projektanfragephase.label', default: 'Projektanfragephase'), projektanfragephaseInstance.id])}"
                redirect(action: "show", id: projektanfragephaseInstance.id)
            }
            else {
                render(view: "edit", model: [projektanfragephaseInstance: projektanfragephaseInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'projektanfragephase.label', default: 'Projektanfragephase'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def projektanfragephaseInstance = Projektanfragephase.get(params.id)
        if (projektanfragephaseInstance) {
            try {
                projektanfragephaseInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'projektanfragephase.label', default: 'Projektanfragephase'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'projektanfragephase.label', default: 'Projektanfragephase'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'projektanfragephase.label', default: 'Projektanfragephase'), params.id])}"
            redirect(action: "list")
        }
    }
}
