package pauldb2

class KontaktscoringController {
	def beforeInterceptor = [action:this.&checkUser]
	
			def checkUser(){
	
			if(!session.user){
			  flash.message = "Bitte melde dich an."
			  flash.redirect = request.forwardURI - request.contextPath
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
		[kontaktsscoringInstanceList: Kontaktsscoring.list(params), kontaktsscoringInstanceTotal: Kontaktsscoring.count()]
	}

	def create = {
		def kontaktsscoringInstance = new Kontaktsscoring()
		kontaktsscoringInstance.properties = params
		return [kontaktsscoringInstance: kontaktsscoringInstance]
	}

	def save = {
		def kontaktsscoringInstance = new Kontaktsscoring(params)
		if (kontaktsscoringInstance.save(flush: true)) {
			flash.message = "${message(code: 'default.created.message', args: [message(code: 'kontaktsscoring.label', default: 'Kontaktsscoring'), kontaktsscoringInstance.id])}"
			redirect(action: "show", id: kontaktsscoringInstance.id)
		}
		else {
			render(view: "create", model: [kontaktsscoringInstance: kontaktsscoringInstance])
		}
	}

	def show = {
		def kontaktsscoringInstance = Kontaktsscoring.get(params.id)
		if (!kontaktsscoringInstance) {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'kontaktsscoring.label', default: 'Kontaktsscoring'), params.id])}"
			redirect(action: "list")
		}
		else {
			[kontaktsscoringInstance: kontaktsscoringInstance]
		}
	}

	def edit = {
		def kontaktsscoringInstance = Kontaktsscoring.get(params.id)
		if (!kontaktsscoringInstance) {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'kontaktsscoring.label', default: 'Kontaktsscoring'), params.id])}"
			redirect(action: "list")
		}
		else {
			return [kontaktsscoringInstance: kontaktsscoringInstance]
		}
	}

	def update = {
		def kontaktsscoringInstance = Kontaktsscoring.get(params.id)
		if (kontaktsscoringInstance) {
			if (params.version) {
				def version = params.version.toLong()
				if (kontaktsscoringInstance.version > version) {
					
					kontaktsscoringInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'kontaktsscoring.label', default: 'Kontaktsscoring')] as Object[], "Another user has updated this Kontaktsscoring while you were editing")
					render(view: "edit", model: [kontaktsscoringInstance: kontaktsscoringInstance])
					return
				}
			}
			kontaktsscoringInstance.properties = params
			if (!kontaktsscoringInstance.hasErrors() && kontaktsscoringInstance.save(flush: true)) {
				flash.message = "${message(code: 'default.updated.message', args: [message(code: 'kontaktsscoring.label', default: 'Kontaktsscoring'), kontaktsscoringInstance.id])}"
				redirect(action: "show", id: kontaktsscoringInstance.id)
			}
			else {
				render(view: "edit", model: [kontaktsscoringInstance: kontaktsscoringInstance])
			}
		}
		else {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'kontaktsscoring.label', default: 'Kontaktsscoring'), params.id])}"
			redirect(action: "list")
		}
	}

	def delete = {
		def kontaktsscoringInstance = Kontaktsscoring.get(params.id)
		if (kontaktsscoringInstance) {
			try {
				kontaktsscoringInstance.delete(flush: true)
				flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'kontaktsscoring.label', default: 'Kontaktsscoring'), params.id])}"
				redirect(action: "list")
			}
			catch (org.springframework.dao.DataIntegrityViolationException e) {
				flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'kontaktsscoring.label', default: 'Kontaktsscoring'), params.id])}"
				redirect(action: "show", id: params.id)
			}
		}
		else {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'kontaktsscoring.label', default: 'Kontaktsscoring'), params.id])}"
			redirect(action: "list")
		}
	}
}
