package pauldb2

import grails.converters.JSON
import org.codehaus.groovy.grails.commons.ConfigurationHolder

class PictureUrlGenerationService {
	
	def relativeUrlBaseToPictures = '/pauldbbilder/'
	def filesystemPathBaseToPictures = '/var/www' + relativeUrlBaseToPictures
	def relativeUrlToDefaultPicture = '/pauldb2/personImages/foto_default.jpg'
    static transactional = false
	

	
	
	def getFilesystemPathToPictureOfPerson(id) {
		return filesystemPathBaseToPictures + "/personImages_" + id + ".jpg"
	}
	
	def pictureExists(id) {
		if (new File( filesystemPathBaseToPictures + "personImages_" + id + ".jpg" ).exists()){
			return true
		} else {
			return false
		}
	}
	def getRelativeUrlToPictureOfPerson(id) {
		if (new File( filesystemPathBaseToPictures + "personImages_" + id + ".jpg" ).exists()){
			return (relativeUrlBaseToPictures + "personImages_" + id + ".jpg")
		} else {
			return relativeUrlToDefaultPicture
		}
	}
}

