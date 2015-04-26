Unternehmen,Projekt,Abschluss,BT,Beschreibung

<g:each in="${projekte}" var="var">"${var.unternehmenname}","${var.projektname}","${var.enddatum?.format('dd.MM.yyyy')}","${var.btvertrag}","${var.beschreibung}"
</g:each>
