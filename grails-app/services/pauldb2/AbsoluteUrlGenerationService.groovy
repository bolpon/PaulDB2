package pauldb2

import grails.converters.JSON
import org.codehaus.groovy.grails.commons.ConfigurationHolder

class AbsoluteUrlGenerationService {
	def baseurl = 'https://intern.paul-consultants.de'
    static transactional = false
	
	def getAbsoluteUrl(relativeUrl) {
		return baseurl + relativeUrl
	}
}

