package pauldb2

class UnternehmensscoringJob {
    // Mailservice und Templaterendering "injizieren"
    def mailService, grailsTemplateEngineService
    
    // Triggerdefinitionen
    static triggers = {
      simple name: 'startTrigger', startDelay: 5000, repeatCount: 0 // Kurz nach Serverstart
      cron name: 'hourlyTrigger', cronExpression: '0 0 6 * * ?' // Jeden morgen um 6
    }
    
    
    // "Konfiguration" des Scoringsystems (Zeitangaben basieren auf einem 30-Tage-Monat und 360-Tage-Jahr)
    final static projektAlterBKunde = 720 // legt fest, ab welchem Projektalter ein Unternehmen als B-Kunde zählz (in Tagen)
    final static naechsterKontaktMatrix = [ // Matrix, in der die Zeiträume für die nächste Kontaktaufnahme gespeichert werden (in Tagen)
        'A': [
            '1': 3,
            '2': 14,
            '3': 120,
            '4': 360,
			'0': null
        ],
        
        'B': [
            '1': 3,
            '2': 14,
            '3': 240,
            '4': 720,
			'0': null
        ],
        
        'C': [
            '1': 3,
            '2': 14,
            '3': 360,
            '4': null,
			'0': null
        ]
    ]
    final static warnung = 3 // Zeit, bis eine Warnung an den Warnungsempfänger geschickt wird
    final static empfaengerWarnung = 'kmu@paul-consultants.de' // Mailadresse des Warnungsempfängers
	final static adminMail = 'grails@paul-consultants.de'
    final static mailAdresse = 'PAUL DB2 <pauldb2@paul-consultants.de>' // Mailadresse des Absenders
    final static neuOderLoeschen = 30 // legt fest, ab wann ein überfälliger Nachbetreuungstermin entweder automatisch neu gesetzt oder gelöscht wird

    def execute(context) {
		
		mailService.sendMail {
			to adminMail
			from mailAdresse
			subject 'DB2-Scoring startet'
			body 'Scoring startet'
		}

        
        // Debug-Timer starten und Hinweis ausgeben
        long timer = System.currentTimeMillis();
        log.info('Update des Unternehmensscorings gestartet.')
        
        // Unternehmensscorings zwischenspeichern
        def unternehmensscoringA = Unternehmensscoring.findByBezeichnung('A'),
            unternehmensscoringB = Unternehmensscoring.findByBezeichnung('B'),
            unternehmensscoringC = Unternehmensscoring.findByBezeichnung('C')

        // Unternehmen holen
        Date datumHeute = new Date(), datumKundeIstB = datumHeute - projektAlterBKunde, datumWarnung = datumHeute - warnung, datumNeuOderLoeschen = datumHeute - neuOderLoeschen
        Unternehmen.list().each { unternehmen ->
            // Unternehmensscoring festlegen
            Unternehmensscoring altesScoring = unternehmen.unternehmensscoring
            unternehmen.unternehmensscoring = unternehmen.projekte.findAll { it.anfangsdatum != null }.isEmpty() ? unternehmensscoringC : (
                (unternehmen.projekte.find { it.enddatum > datumKundeIstB } == null) ? unternehmensscoringB : unternehmensscoringA
            )
            boolean speichern = unternehmen.unternehmensscoring != altesScoring
            
            // Letzten Kontakt ermitteln und schreiben
            def alterLetzterKontakt = unternehmen.letzterkontakt
            unternehmen.letzterkontakt = Kontakt.getKontakteMitUnternehmen(unternehmen).max{ it.datum }
            boolean letzterKontaktGeaendert = unternehmen.letzterkontakt != alterLetzterKontakt
			if (unternehmen.letzterkontakt?.geaendert) {
				letzterKontaktGeaendert = true
				unternehmen.letzterkontakt.geaendert = false
				if (!unternehmen.letzterkontakt.save(flush: true)) {
					log.error('Fehler für Kontakt ' + unternehmen.letzterkontakt.id)
	                unternehmen.letzterkontakt.errors.each{ error ->
	                    log.error(error)
	                }
				}
			}
			speichern |= letzterKontaktGeaendert
            
            // Letzten Kontakt überprüfen
            def alterNaechsterKontakt = unternehmen.naechsterkontakt, altesKontaktLevel = unternehmen.naechsterkontaktlevel
            if (letzterKontaktGeaendert) {
                if (unternehmen.letzterkontakt?.naechsterkontakt == null) {
                    // Nächsten Kontakt anhand des Scorings errechnen
                    def naechsterKontakt = naechsterKontaktMatrix[unternehmen.unternehmensscoring.bezeichnung][unternehmen.letzterkontakt.kontaktscoring?.bezeichnung ?: '4']
                    unternehmen.naechsterkontakt = naechsterKontakt ? unternehmen.letzterkontakt.datum + naechsterKontakt : null
                } else {
                    // Nächsten Kontakt des letzten Kontaktes eintragen
                    unternehmen.naechsterkontakt = unternehmen.letzterkontakt.naechsterkontakt
                }
                
                // Warnlevel zurücksetzen
                unternehmen.naechsterkontaktlevel = null
            }
            if ((unternehmen.naechsterkontakt != null) && (unternehmen.letzterkontakt != null)) {
                // Zeiträume testen
                if (unternehmen.naechsterkontakt < datumNeuOderLoeschen) {            
                    // Nächsten Kontakt anhand des Scorings errechnen und Datum prüfen
                    def naechsterKontakt = naechsterKontaktMatrix[unternehmen.unternehmensscoring.bezeichnung][unternehmen.letzterkontakt.kontaktscoring?.bezeichnung ?: '4']
                    if ((naechsterKontakt != null) && (unternehmen.letzterkontakt.datum + naechsterKontakt > datumHeute)) {
                        // Termin setzen
                        unternehmen.naechsterkontakt = unternehmen.letzterkontakt.datum + naechsterKontakt
                    } else {
                        // Termin zurücksetzen
                        unternehmen.naechsterkontakt = null
                    }
                    
                    // Level zurücksetzen
                    unternehmen.naechsterkontaktlevel = null
                } else if ((unternehmen.naechsterkontakt < datumHeute) && (unternehmen.naechsterkontaktlevel != 'warnung')) {
                    // Auf Warnmail prüfen und Level setzen
                    boolean betreuerMails = false
                    if (unternehmen.naechsterkontakt < datumWarnung) {
                        // Level hochsetzen und Betreuermails fordern
                        unternehmen.naechsterkontaktlevel = 'warnung'
                        betreuerMails = true
                        
                        // Warnmail an den festgelegten Empfänger schicken
                        mailService.sendMail {
                            to empfaengerWarnung
                            from mailAdresse
                            subject '[PAUL] Kontakterinnerung - ' + unternehmen.toString()
                            body grailsTemplateEngineService.renderView('kontakterinnerungWarnung', [
                                betreuer: unternehmen.betreuer, unternehmen: unternehmen
                            ])
                        }
						mailService.sendMail {
							to adminMail
							from mailAdresse
							subject 'Mail versendet'
							body 'Empf�ngerwarnung an KMU gesendet'
						}
                        log.info('Erinnerungsmail für ' + unternehmen.toString() + ' an ' + empfaengerWarnung + ' geschickt.')
                        
                    } else if (unternehmen.naechsterkontaktlevel == null) {
                        // Level hochsetzen und Betreuermails fordern
                        unternehmen.naechsterkontaktlevel = 'ermahnung'
                        betreuerMails = true
                    }
                    
                    if (betreuerMails) {
                        // Betreuer ermitteln...
                        unternehmen.betreuer.each { betreuer ->
                            // ... und Warn-/Mahnmails schicken
                            if (!betreuer.emails.isEmpty()) {
                                def mailAdresse = betreuer.emails.toArray()[0].toString()
                                mailService.sendMail {
                                    to mailAdresse
                                    from mailAdresse
                                    subject '[PAUL] Kontakterinnerung - ' + unternehmen.toString()
                                    body grailsTemplateEngineService.renderView('kontakterinnerungBetreuer', [
                                        betreuer: betreuer, unternehmen: unternehmen
                                    ])
                                }
								mailService.sendMail {
									to adminMail
									from mailAdresse
									subject 'Mail versendet'
									body 'Erinnerung an Pauli gesendet'
								}
                                log.info((unternehmen.naechsterkontaktlevel == 'ermahnung' ? '1' : '2') + '. Erinnerungsmail für '
                                    + unternehmen.toString() + ' an ' + betreuer.toString() + ' (' + mailAdresse + ') geschickt.')
                            }
                        }
                    }
                }
            }
            speichern |= (unternehmen.naechsterkontakt != alterNaechsterKontakt) | (unternehmen.naechsterkontaktlevel != altesKontaktLevel)
            
            // Unternehmen speichern
            if (speichern && !unternehmen.save(flush: true)) {
				log.error('Fehler für Unternehmen ' + unternehmen.id)
                unternehmen.errors.each{ error ->
                    log.error(error)
                }
            }
        }
		new PhoneBookService().updatePhoneBook()
        // Timer ausgeben und Job entsperren
        log.info('Unternehmensscoring in ' + (System.currentTimeMillis() - timer) + 'ms upgedatet.');
		mailService.sendMail {
			to adminMail
			from mailAdresse
			subject 'Scoring ende'
			body 'Scoring Ende nach ' + (System.currentTimeMillis() - timer) + 'ms'
		}
    }
}