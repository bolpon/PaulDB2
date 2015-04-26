package pauldb2

import grails.converters.*



class ApiController {
	
    def index = {
		
	}
	
	def phone = {
		
		if (params.key == 'XXXX') {			
			
			def json = new JSON()
			
			def jsonString = new PhoneBookService().getPhoneBookString()
			render  json.parse(jsonString) as JSON;
			
			
			
		} else {
			render('Wrong Key');
		}
		
		
	}
	def dev = {
		
		if (params.key == 'dev') {
			
			def json = new JSON()

			
			def clos = { unternehmen ->
				return (
					[	"name" : unternehmen.name, 
						"scoring" : unternehmen.unternehmensscoring,
						"kontakt" : unternehmen.letzterkontakt,
						"Projektenddatum" : unternehmen.projekte.enddatum.collect({it?.getTime()}).max(),
						"Tage seit Projektende" : 1
						
					])
			}
			
			render (Unternehmen.list().collect(clos))

			
			
		} else {
			render('Wrong Key');
		}
		
		
	}
}
