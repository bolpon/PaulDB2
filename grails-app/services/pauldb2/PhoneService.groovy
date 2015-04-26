package pauldb2

import grails.converters.JSON

class PhoneService {
	def pathToPhoneBookFile = '/var/phonecache/phoneAPI'
    static transactional = false
	def json
	
    def updatePhoneBook() {
		def idList = []
		def phoneList = []
		def mailList = []
		Personen.list().each {

			it.telefon.each {
				def adder = it.nummer.toString()
				def digits = adder.replaceAll("[^0-9.+]", "");
				phoneList.add(digits)
			}
			it.emails.each {
				def adder = it.mailAdresse
				mailList.add(adder)
			}
			
			idList.add(["id" : it.id, "name" : it.vorname + " " + it.nachname, "phone" : phoneList, "mail" : mailList])

			phoneList = []
			mailList = []
			
			
		}
		json = new JSON(idList);
		def jsonList = json.toString();
		def fileStore = new File(pathToPhoneBookFile).write(jsonList);
		
    }
	
	def getPhoneBookString() {
		try {
			def jsonString = new File(pathToPhoneBookFile).text;
			return jsonString
			
		} catch (Exception e) {
			def idList = []
			def phoneList = []
			def mailList = []
			Personen.list().each {
	
				it.telefon.each {
					def adder = it.nummer.toString()
					def digits = adder.replaceAll("[^0-9.+]", "");
					phoneList.add(digits)
				}
				it.emails.each {
					def adder = it.mailAdresse
					mailList.add(adder)
				}
				
				idList.add(["id" : it.id, "name" : it.vorname + " " + it.nachname, "phone" : phoneList, "mail" : mailList])
	
				phoneList = []
				mailList = []
			}
			json = new JSON(idList);
			def jsonList = json.toString();
			def fileStore = new File(pathToPhoneBookFile).write(jsonList);
			
			def jsonString = new File(pathToPhoneBookFile).text;
			return jsonString
		}
	}
}
