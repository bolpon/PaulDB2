package pauldb2

class ProjektphaseController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [projektphaseInstanceList: Projektphase.list(params), projektphaseInstanceTotal: Projektphase.count()]
    }

    def create = {
        def projektphaseInstance = new Projektphase()
        projektphaseInstance.properties = params
        return [projektphaseInstance: projektphaseInstance]
    }

    def save = {
        def projektphaseInstance = new Projektphase(params)
        if (projektphaseInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'projektphase.label', default: 'Projektphase'), projektphaseInstance.id])}"
            redirect(action: "show", id: projektphaseInstance.id)
        }
        else {
            render(view: "create", model: [projektphaseInstance: projektphaseInstance])
        }
    }

    def show = {
        def projektphaseInstance = Projektphase.get(params.id)
        if (!projektphaseInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'projektphase.label', default: 'Projektphase'), params.id])}"
            redirect(action: "list")
        }
        else {
            [projektphaseInstance: projektphaseInstance]
        }
    }

    def edit = {
        def projektphaseInstance = Projektphase.get(params.id)
        if (!projektphaseInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'projektphase.label', default: 'Projektphase'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [projektphaseInstance: projektphaseInstance]
        }
    }

    def update = {
        def projektphaseInstance = Projektphase.get(params.id)
        if (projektphaseInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (projektphaseInstance.version > version) {
                    
                    projektphaseInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'projektphase.label', default: 'Projektphase')] as Object[], "Another user has updated this Projektphase while you were editing")
                    render(view: "edit", model: [projektphaseInstance: projektphaseInstance])
                    return
                }
            }
            projektphaseInstance.properties = params
            if (!projektphaseInstance.hasErrors() && projektphaseInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'projektphase.label', default: 'Projektphase'), projektphaseInstance.id])}"
                redirect(action: "show", id: projektphaseInstance.id)
            }
            else {
                render(view: "edit", model: [projektphaseInstance: projektphaseInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'projektphase.label', default: 'Projektphase'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def projektphaseInstance = Projektphase.get(params.id)
        if (projektphaseInstance) {
            try {
                projektphaseInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'projektphase.label', default: 'Projektphase'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'projektphase.label', default: 'Projektphase'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'projektphase.label', default: 'Projektphase'), params.id])}"
            redirect(action: "list")
        }
    }
}
