package pauldb2

import grails.converters.JSON

class PhoneBookService {
	def pathToPhoneBookFile = '/var/phonecache/phoneAPI'
    static transactional = false
	def json
	def personList = []
	
	
	def updatePhoneBook() {
		
		personList = Personen.list().collect(transformPersonIntoDesiredFormat)
		json = new JSON(personList);
		def jsonList = json.toString();
		def fileStore = new File(pathToPhoneBookFile).write(jsonList);
		
	}
	
	def transformPersonIntoDesiredFormat = { person ->
		def pictureUrlGenerator = new PictureUrlGenerationService()
		def absoluteUrlGenerator = new AbsoluteUrlGenerationService()
		return (
		[	"id" : person.id, 
			"name" : person.vorname + " " + person.nachname,
			"phone" : person.telefon.collect(getPhoneNumberFromTelefon), 
			"mail" : person.emails.collect(getMailAdresseFromEmails),
			"imageUrl" : absoluteUrlGenerator.getAbsoluteUrl(pictureUrlGenerator.getRelativeUrlToPictureOfPerson(person.id))
		])
	}
	
	def getPhoneNumberFromTelefon = { telefon ->
		return telefon.nummer.toString().replaceAll("[^0-9.+]", "")
	}
	def getMailAdresseFromEmails = {email ->
		return email.mailAdresse
	}
	
	def getPhoneBookString() {
		try {
			def jsonString = new File(pathToPhoneBookFile).text;
			return jsonString
			
		} catch (Exception e) {
			this.updatePhoneBook()
			
			def jsonString = new File(pathToPhoneBookFile).text;
			return jsonString
		}
	}
}
