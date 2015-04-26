package pauldb2

class AkquiseaktionController {
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
        [akquiseaktionInstanceList: Akquiseaktion.list(params), akquiseaktionInstanceTotal: Akquiseaktion.count()]
    }

    def create = {
        def akquiseaktionInstance = new Akquiseaktion()
        akquiseaktionInstance.properties = params
        return [akquiseaktionInstance: akquiseaktionInstance]
    }

    def save = {
        def akquiseaktionInstance = new Akquiseaktion(params)
        if (akquiseaktionInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'akquiseaktion.label', default: 'Akquiseaktion'), akquiseaktionInstance.id])}"
            redirect(action: "show", id: akquiseaktionInstance.id)
        }
        else {
            render(view: "create", model: [akquiseaktionInstance: akquiseaktionInstance])
        }
    }

    def show = {
        def akquiseaktionInstance = Akquiseaktion.get(params.id)
        if (!akquiseaktionInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'akquiseaktion.label', default: 'Akquiseaktion'), params.id])}"
            redirect(action: "list")
        }
        else {
            [akquiseaktionInstance: akquiseaktionInstance]
        }
    }

    def edit = {
        def akquiseaktionInstance = Akquiseaktion.get(params.id)
        if (!akquiseaktionInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'akquiseaktion.label', default: 'Akquiseaktion'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [akquiseaktionInstance: akquiseaktionInstance]
        }
    }

    def update = {
        def akquiseaktionInstance = Akquiseaktion.get(params.id)
        if (akquiseaktionInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (akquiseaktionInstance.version > version) {
                    
                    akquiseaktionInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'akquiseaktion.label', default: 'Akquiseaktion')] as Object[], "Another user has updated this Akquiseaktion while you were editing")
                    render(view: "edit", model: [akquiseaktionInstance: akquiseaktionInstance])
                    return
                }
            }
            akquiseaktionInstance.properties = params
            if (!akquiseaktionInstance.hasErrors() && akquiseaktionInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'akquiseaktion.label', default: 'Akquiseaktion'), akquiseaktionInstance.id])}"
                redirect(action: "show", id: akquiseaktionInstance.id)
            }
            else {
                render(view: "edit", model: [akquiseaktionInstance: akquiseaktionInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'akquiseaktion.label', default: 'Akquiseaktion'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def akquiseaktionInstance = Akquiseaktion.get(params.id)
        if (akquiseaktionInstance) {
            try {
                akquiseaktionInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'akquiseaktion.label', default: 'Akquiseaktion'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'akquiseaktion.label', default: 'Akquiseaktion'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'akquiseaktion.label', default: 'Akquiseaktion'), params.id])}"
            redirect(action: "list")
        }
    }
}
