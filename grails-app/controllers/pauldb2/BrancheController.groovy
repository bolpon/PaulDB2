package pauldb2

class BrancheController {

  def beforeInterceptor = [action:this.&checkUser]

  def checkUser(){

      if(!session.userperson ){
        redirect(uri:"/");
        return false
      }
  }

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 20, 100)
        params.sort = params?.sort ?: "branche"
        params.order = params?.order ?: "asc"
        [brancheInstanceList: Branche.list(params), brancheInstanceTotal: Branche.count()]
    }

    def create = {
        def brancheInstance = new Branche()
        brancheInstance.properties = params
        return [brancheInstance: brancheInstance]
    }

    def save = {
        def brancheInstance = new Branche(params)
        if (brancheInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'branche.label', default: 'pauldb2.Branche'), brancheInstance.id])}"
            redirect(controller:"unternehmen", action: "create")
        }
        else {
            render(view: "create", model: [brancheInstance: brancheInstance])
        }
    }

    def show = {
        def brancheInstance = Branche.get(params.id)
        if (!brancheInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'branche.label', default: 'pauldb2.Branche'), params.id])}"
            redirect(action: "list")
        }
        else {
            [brancheInstance: brancheInstance]
        }
    }

    def edit = {
        def brancheInstance = Branche.get(params.id)
        if (!brancheInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'branche.label', default: 'pauldb2.Branche'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [brancheInstance: brancheInstance]
        }
    }

    def update = {
        def brancheInstance = Branche.get(params.id)
        if (brancheInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (brancheInstance.version > version) {
                    
                    brancheInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'branche.label', default: 'pauldb2.Branche')] as Object[], "Another user has updated this pauldb2.Branche while you were editing")
                    render(view: "edit", model: [brancheInstance: brancheInstance])
                    return
                }
            }
            brancheInstance.properties = params
            if (!brancheInstance.hasErrors() && brancheInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'branche.label', default: 'pauldb2.Branche'), brancheInstance.id])}"
                redirect(action: "show", id: brancheInstance.id)
            }
            else {
                render(view: "edit", model: [brancheInstance: brancheInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'branche.label', default: 'pauldb2.Branche'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def brancheInstance = Branche.get(params.id)
        if (brancheInstance) {
            try {
                brancheInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'branche.label', default: 'pauldb2.Branche'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'branche.label', default: 'pauldb2.Branche'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'branche.label', default: 'pauldb2.Branche'), params.id])}"
            redirect(action: "list")
        }
    }
}
