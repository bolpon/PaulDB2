Der Nachbetreuungstermin für das Unternehmen ${unternehmen} wurde bisher noch nicht wahrgenommen.

<g:if test="${!betreuer.isEmpty()}">
Die Betreuer des Unternehmens sind:
<g:each in="${betreuer}">
 - ${it}<g:if test="${!it.emails.isEmpty()}"> ${it.emails.toArray()[0]}</g:if>
</g:each>
</g:if>
<g:else>
Das Unternehmen hat keinen zugewiesenen Betreuer.
</g:else>