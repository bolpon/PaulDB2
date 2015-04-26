package pauldb2

class StatistikController {
	// Ein paar global festzulegende Parameter
	static sonstigeZusammenfassen = 7, // Grenze für Sonstige in Studiengangsstatistik
	       nachkommastellen = 2        // Anzahl anzuzeigender Nachkommastellen
	
	// Interne Rundungsmethode
	private static Object round (Object obj) {
		return obj ? obj.floatValue().round(nachkommastellen) : 0.0
	}
		   
	// Statische Methode, welche bestimmte (String-)Eigenschaften eines Objektes in ein CSV-kompatibles Format konvertiert
	private static void csvify (Object object, ArrayList<String> properties) {
		for (String property in properties) {
			if (object.hasProperty(property)) {
				// Wert ermitteln und bearbeiten
				def value = object."${property}".toString()
				value = value.replaceAll('"', '""') // quotation marks müssen verdoppelt werden (" --> "")
				
				// Wert speichern (muss in der MetaClass passieren, sonst werden die Werte im Model übeschrieben)
				object.metaClass."${property}" = value
			}
		}
	}
	
	// Dependency Injection für Session und Templates
	def sessionFactory, grailsTemplateEngineService
	
	// Login-Status überprüfen
	def beforeInterceptor = [action:this.&checkUser]
	def checkUser() {
		if(!session.userperson){
		  flash.message = "Bitte melde dich an."
		  println(request.forwardURI - request.contextPath)
		  flash.redirect = request.forwardURI - request.contextPath
		  redirect(uri:"/");
		  return false
		}
	}

	def index = {
		[role: session.role]
	}
		
	def studiengaenge = {		
		// Personenparameter festlegen, falls diese nicht übermittelt wurden
		if (!params.any { key, value -> key == 'personen' })
			params.personen = params.angepasst ? [] : ['mitglieder', 'aoler', 'anwaerter']
		else if (params.personen instanceof String)
			params.personen = [params.personen]
		if (!params.any { key, value -> key == 'zusammenfassen' })
			params.zusammenfassen = !params.angepasst
		
		// Wenn keine Personengruppen ausgewählt sind, dann abbrechen
		if (params.personen.size() == 0)
			return [studienfachStatistik: [], gesamt: 0, params: params, role: session.role]
			
		// Relevante Status finden
		def status = []
		params.personen.each { option ->
			switch (option) {
				case 'mitglieder':
					status.add('Paulaner')
					break
					
				case 'aoler':
					status.add('AO')
					break
					
				case 'anwaerter':
					status.add('Anwärter')
					break
					
				case 'ehrenmitglieder':
					status.add('Ehrenmitglied')
					status.add('DB2-Gott (und Ehrenmitglied)')
					break
					
				case 'paulumni':
					status.add('Paulumni')
					status.add('Ehemalige')
					break
			}
		}
		status = status.collect { Personstatus.findByBezeichnung(it) }
		
		// Relevante Personen suchen
		def personen = Personen.createCriteria().list() {
			inList('personstatus', status)
			sizeGt('studium', 0)
		}
		
		// Studiengänge clustern
		def studienfaecher = personen.collect { it.studium.toList().sort { it.anfang }[-1].studienfach },
			statistik = [], gesamt = studienfaecher.size()
		studienfaecher.collect { it }.unique().each { studienfach ->
			def anzahl = Collections.frequency(studienfaecher, studienfach)
			statistik.add([studienfach: studienfach.bezeichnung, anzahl: anzahl, anteil: StatistikController.round(anzahl * 100.0 / gesamt)])
		}
		statistik.sort { -it.anzahl }
		
		// Zusammenfassen, wenn nötig
		if (params.zusammenfassen && statistik.size() > sonstigeZusammenfassen) {
			statistik = statistik[0..(sonstigeZusammenfassen - 2)]
			def anzahl = gesamt - statistik.sum { it.anzahl }	
			statistik.add([studienfach: 'Sonstige', anzahl: anzahl, anteil: StatistikController.round(anzahl * 100.0 / gesamt)])
		}
		
		// Auf Export überprüfen
		if (params.export) {
			// Ausgabe
			response.setHeader('Content-disposition', 'attachment; filename=referenz.csv')
			response.contentType = 'text/csv'
			response.outputStream << grailsTemplateEngineService.renderView('studiengaengeExport', [statistik: statistik])
			response.outputStream.flush()
		}
				
		// An den View übergeben
		[statistik: statistik, gesamt: gesamt, params: params, role: session.role]
	}
	
	def mitglieder = {
		// Mitgliederstatistik ermitteln
		def statusFremd = Personstatus.findByBezeichnung('fremd')
		def personen = Personen.createCriteria().list() {
			ne('personstatus', statusFremd)
			projections {
				groupProperty('personstatus')
				rowCount()
			}
		}
		def statistik = personen.collect { [status: it[0], anzahl: it[1]] }
		
		// Auf Export überprüfen
		if (params.export) {				
			// Ausgabe
			response.setHeader('Content-disposition', 'attachment; filename=referenz.csv')
			response.contentType = 'text/csv'
			response.outputStream << grailsTemplateEngineService.renderView('mitgliederExport', [statistik: statistik])
			response.outputStream.flush()
		}
		
		// An den View übergeben
		[statistik: statistik, gesamt: statistik.size(), role: session.role]
	}
	
	def referenz = {
		// Datum ermitteln
		def datum
		if (params.einschraenken && params.datum)
			datum = Date.parse('dd.MM.yyyy', params.datum)

		// Projekte finden, Unternehmen zuordnen und sortieren
		def projekte = Projekte.createCriteria().list() {
			eq('referenzfreigabe', 'freigegeben')
			eq('internextern', 'extern')
			sizeGt('unternehmen', 0)
			if (datum) gt('enddatum', datum)
		}
		projekte.each {
			def unternehmen = it.unternehmen.toArray().getAt(0)
			it.metaClass.unternehmenname = unternehmen.name
			it.metaClass.unternehmenid = unternehmen.id
		}
		projekte.sort { it.unternehmenname }
		
		// Auf Export überprüfen
		if (params.export) {
			// CSV-ify auf alle relevanten Eigenschaften durchführen durchführen
			projekte.each { StatistikController.csvify(it, ["unternehmenname", "projektname", "beschreibung"]) }
				
			// Ausgabe
			response.setHeader('Content-disposition', 'attachment; filename=referenz.csv')
			response.contentType = 'text/csv'
			response.outputStream << grailsTemplateEngineService.renderView('referenzExport', [projekte: projekte])
			response.outputStream.flush()
		}
		
		// An den View übergeben
		[projekte: projekte, params: params, role: session.role]
	}
	
	def projekte = {
		// Daten auslesen
		def datumAnfang, datumEnde, datum = params.status == 'angefangen' ? 'anfangsdatum' : 'enddatum'
		if (params.datumAnfang && params.datumEnde) {
			datumAnfang = Date.parse('dd.MM.yyyy', params.datumAnfang)
			datumEnde = Date.parse('dd.MM.yyyy', params.datumEnde)
			
			// Daten prüfen und gegebenenfalls tauschen
			if (datumAnfang > datumEnde) {
				(datumAnfang, datumEnde) = [datumEnde, datumAnfang]
				def tmp = params.datumAnfang; params.datumAnfang = params.datumEnde; params.datumEnde = tmp
			}
		}
		
		// Externe Projekte finden und Unternehmen zuordnen
		def projekteExtern = Projekte.createCriteria().list() {
			eq('internextern', 'extern')
			sizeGt('unternehmen', 0)
			order('enddatum', 'desc')
			if (datumAnfang) ge(datum, datumAnfang)
			if (datumEnde) lt(datum, datumEnde)
		}
		projekteExtern.each {
			def unternehmen = it.unternehmen.toArray().getAt(0)
			it.metaClass.unternehmenname = unternehmen.name
			it.metaClass.unternehmenid = unternehmen.id
		}
		
		// Interne Projekte finden
		def projekteIntern = Projekte.createCriteria().list() {
			eq('internextern', 'intern')
			order('enddatum', 'desc')
			if (datumAnfang) ge(datum, datumAnfang)
			if (datumEnde) lt(datum, datumEnde)
		}
		
		// Projektstatistik ermitteln
		def statistik
		if (projekteExtern.size() + projekteIntern.size()) {
			statistik = [
				extern: projekteExtern.size() ?: 0,
				intern: projekteIntern.size() ?: 0,
				gesamt: null,
				
				btExtern: StatistikController.round(projekteExtern.sum { it.btvertrag ?: 0 }),
				btIntern: StatistikController.round(projekteIntern.sum { it.btvertrag ?: 0 }),
				btGesamt: null,
				
				btRealExtern: StatistikController.round(projekteExtern.sum { it.btreal ?: 0 }),
				btRealIntern: StatistikController.round(projekteIntern.sum { it.btreal ?: 0 }),
				btRealGesamt: null
			]
			statistik.gesamt = statistik.extern + statistik.intern
			statistik.btGesamt = StatistikController.round(statistik.btExtern + statistik.btIntern)
			statistik.btRealGesamt = StatistikController.round(statistik.btRealExtern + statistik.btRealIntern)
		}
		
		// An den View übergeben
		[statistik: statistik, projekteExtern: projekteExtern, projekteIntern: projekteIntern, params: params, role: session.role]
	}
}
