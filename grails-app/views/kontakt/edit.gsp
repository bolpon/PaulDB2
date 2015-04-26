
<%@ page import="java.text.SimpleDateFormat; pauldb2.Kontakt" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="dashboard" />
        <g:javascript src="kontakte.js" />
        <g:javascript src="hilfeTexte.js" />
        <g:set var="entityName" value="${message(code: 'kontakt.label', default: 'Kontakt')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${kontaktInstance}">
            <div class="errors">
                <g:renderErrors bean="${kontaktInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${kontaktInstance?.id}" />
                <g:hiddenField name="version" value="${kontaktInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                            <g:if test="${role.equals('admin')}">
                                <tr class="prop">
                                    <td valign="top" class="name"><g:message code="kontakt.id.label" default="Id" /></td>

                                    <td valign="top" class="value">${fieldValue(bean: kontaktInstance, field: "id")}</td>

                                </tr>
                            </g:if>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="datum"><g:message code="kontakt.datum.label" default="Datum" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: kontaktInstance, field: 'datum', 'errors')}">
                                    <input name="datum" id="datum" class="jqDatepicker" type="text" value="<%
                                     SimpleDateFormat d = new SimpleDateFormat("dd.MM.yyyy");
                                     if (kontaktInstance?.datum != null)
                                      println(d.format(kontaktInstance?.datum));
                                  %>" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="personen"><g:message code="kontakt.paulis.label" default="Paulis" /></label>
                                </td>

                                  <td valign="top" class="value ${hasErrors(bean: kontaktInstance, field: 'personen', 'errors')}">

                                    <div id="ubw">
                                        <g:select id="paulis" class="multiselect" name="personen" from="${posPaulis}" optionKey="id" multiple="yes" size="5" value="${kontaktInstance?.personen}" />
                                    </div>

                                  </td>

                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="unternehmen"><g:message code="kontakt.unternehmen.label" default="Unternehmen" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: kontaktInstance, field: 'beschreibung', 'errors')}">
                                   <form id="mitarbeiterInput">
                                      <input type="text" name="unternehmen" id="kontaktCreateUnternehmen" />
                                      <input type="hidden" id="mitarbeiterInputHidden" value=""/>
                                      <button id="unternehmenCreateMHilfe">Hilfe</button>
                                    </form>
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="mitarbeiter"><g:message code="kontakt.mitarbeiter.label" default="Mitarbeiter" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: kontaktInstance, field: 'mitarbeiter', 'errors')}">
                                    <g:select id="mitarbeiter" class="multiselect" name="mitarbeiter" from="${posMitarbeiter}" optionKey="id" multiple="yes" size="5" value="${kontaktInstance?.mitarbeiter}" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="beschreibung"><g:message code="kontakt.beschreibung.label" default="Beschreibung" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: kontaktInstance, field: 'beschreibung', 'errors')}">
                                    <g:textArea name="beschreibung" value="${kontaktInstance?.beschreibung}" />
                                </td>
                            </tr>
                        
                            <%--<tr class="prop">
                                <td valign="top" class="name">
                                  <label for="akquiseaktion.id"><g:message code="kontakt.akquiseaktion.label" default="Akquiseaktion" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: kontaktInstance, field: 'akquiseaktion', 'errors')}">
                                    <g:select name="akquiseaktion.id" from="${pauldb2.Akquiseaktion.list()}" optionKey="id" value="${kontaktInstance?.akquiseaktion?.id}"  />
                                </td>
                            </tr>--%>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="kontaktzweck.id"><g:message code="kontakt.kontaktzweck.label" default="Kontaktzweck" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: kontaktInstance, field: 'kontaktzweckIdKontaktzweck', 'errors')}">
                                    <g:select name="kontaktzweck.id" from="${pauldb2.Kontaktzweck.list()}" optionKey="id" value="${kontaktInstance?.kontaktzweck?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="kontaktart.id"><g:message code="kontakt.kontaktart.label" default="Kontaktart" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: kontaktInstance, field: 'kontaktart', 'errors')}">
                                    <g:select name="kontaktart.id" from="${pauldb2.Kontaktart.list()}" optionKey="id" value="${kontaktInstance?.kontaktart?.id}"  />
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="kontaktscoring.id"><g:message code="kontakt.kontaktscoring.label" default="Bewertung" />&nbsp;&nbsp;&nbsp;(<a target="_blank" href="https://intern.paul-consultants.de/mediawiki/index.php/Kundenscoring#Kontaktbewertung" class="wikilink" title="Informationen zur Kontaktbewertung im Wiki"><span>Erklärung im Wiki</span></a>)</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: kontaktInstance, field: 'kontaktscoring', 'errors')}">
                                    <g:select name="kontaktscoring.id" from="${pauldb2.Kontaktscoring.list()}" optionKey="id" value="${kontaktInstance?.kontaktscoring?.id}"  />
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="naechsterkontakt"><g:message code="kontakt.naechsterkontakt.label" default="Nächster Kontakt" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: kontaktInstance, field: 'naechsterkontakt', 'errors')}">
                                    <input name="naechsterkontakt" id="naechsterkontakt" class="jqDatepicker" type="text" value="<%
                                        if (kontaktInstance?.naechsterkontakt != null)
                                            println(d.format(kontaktInstance.naechsterkontakt));
                                    %>" />
                                </td>
                            </tr>
                                              
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <g:if test="${role.equals('admin')}"><span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span></g:if>
                </div>
            </g:form>
        </div>
    </body>
</html>
