package pauldb2

//git test mit branches und so

class AdresseController {

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
        [adresseInstanceList: Adresse.list(params), adresseInstanceTotal: Adresse.count()]
    }

    def create = {
        def adresseInstance = new Adresse()
        adresseInstance.properties = params
        return [adresseInstance: adresseInstance]
    }

    def save = {
        def adresseInstance = new Adresse(params)

        if (adresseInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'adresse.label', default: 'Adresse'), adresseInstance.id])}"
            redirect(action: "show", id: adresseInstance.id)
        }
        else {
            render(view: "create", model: [adresseInstance: adresseInstance])
        }
    }

    def show = {
        def adresseInstance = Adresse.get(params.id)
        if (!adresseInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'adresse.label', default: 'Adresse'), params.id])}"
            redirect(action: "list")
        }
        else {
            [adresseInstance: adresseInstance]
        }
    }

    def edit = {
        def adresseInstance = Adresse.get(params.id)
        if (!adresseInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'adresse.label', default: 'Adresse'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [adresseInstance: adresseInstance]
        }
    }

    def update = {
        def adresseInstance = Adresse.get(params.id)
        if (adresseInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (adresseInstance.version > version) {
                    
                    adresseInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'adresse.label', default: 'Adresse')] as Object[], "Another user has updated this Adresse while you were editing")
                    render(view: "edit", model: [adresseInstance: adresseInstance])
                    return
                }
            }
            adresseInstance.properties = params
            if (!adresseInstance.hasErrors() && adresseInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'adresse.label', default: 'Adresse'), adresseInstance.id])}"
                redirect(action: "show", id: adresseInstance.id)
            }
            else {
                render(view: "edit", model: [adresseInstance: adresseInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'adresse.label', default: 'Adresse'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def adresseInstance = Adresse.get(params.id)
        if (adresseInstance) {
            try {
                adresseInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'adresse.label', default: 'Adresse'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'adresse.label', default: 'Adresse'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'adresse.label', default: 'Adresse'), params.id])}"
            redirect(action: "list")
        }
    }
}
