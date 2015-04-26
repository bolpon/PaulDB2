
<%@ page import="pauldb2.Kontakt" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="dashboard" />
        <g:javascript src="projekte.js" />
        <g:set var="entityName" value="${message(code: 'kontakt.label', default: 'Kontakt')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="body">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
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
                            <td valign="top" class="name"><g:message code="kontakt.datum.label" default="Datum" /></td>

                            <td valign="top" class="value"><g:formatDate format="dd.MM.yyyy" date="${kontaktInstance?.datum}" /></td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="kontakt.beteiligte.label" default="Beteiligte" /></td>

                            <td valign="top" class="value">

                              <table class="fixWidth">
                                <tr>
                                  <th>Paulis</th>
                                  <th>Unternehmer</th>
                                </tr>
                                <tr>
                                  <td>
                                    <ul class="noDeco">
                                      <g:each in="${kontaktInstance.personen}" var="p">
                                        <li>
                                          <g:link controller="personen" action="show" id="${p.id}">${p.toString()}</g:link>
                                        </li>
                                      </g:each>
                                    </ul>
                                  </td>
                                  <td>
                                    <ul class="noDeco">
                                      <g:each in="${kontaktInstance.mitarbeiter}" var="m">
                                        <li>
                                          <g:link controller="personen" action="show" id="${m.person.id}">${m.person.anrede + " " + m.toString()}</g:link> (<g:link class="nonBold" controller="unternehmen" action="show" id="${m.unternehmen.id}">${m.unternehmen.toString()}</g:link>)

                                        </li>
                                      </g:each>
                                    </ul>

                                  </td>
                                </tr>
                              </table>
                            </td>

                        </tr>


                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="kontakt.beschreibung.label" default="Beschreibung" /></td>                            
                            <td valign="top" class="value"><g:textArea readonly="readonly" name="beschreibung" value="${kontaktInstance?.beschreibung}"/></td>                            
                        </tr>

                        <%--<tr class="prop">
                            <td valign="top" class="name"><g:message code="kontakt.akquiseaktion.label" default="Akquiseaktion" /></td>                          
                            <td valign="top" class="value">${kontaktInstance?.akquiseaktion?.encodeAsHTML()}</td>                            
                        </tr>--%>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="kontakt.kontaktzweck.label" default="Kontaktzweck" /></td>                           
                            <td valign="top" class="value">${kontaktInstance?.kontaktzweck?.encodeAsHTML()}</td>                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="kontakt.kontaktart.label" default="Kontaktart" /></td>                            
                            <td valign="top" class="value">${kontaktInstance?.kontaktart?.encodeAsHTML()}</td>                            
                        </tr>
                        
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="kontakt.kontaktscoring.label" default="Bewertung" />&nbsp;&nbsp;&nbsp;(<a target="_blank" href="https://intern.paul-consultants.de/mediawiki/index.php/Kundenscoring#Kontaktbewertung" class="wikilink" title="Informationen zur Kontaktbewertung im Wiki"><span>Erklärung im Wiki</span></a>)</td>                            
                            <td valign="top" class="value">${kontaktInstance?.kontaktscoring?.encodeAsHTML()}</td>                            
                        </tr>         
                        
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="kontakt.naechsterkontakt.label" default="Nächster Kontakt" /></td>
                            <td valign="top" class="value${(kontaktInstance?.naechsterkontakt < new Date()) ? ' error' : ''}"><g:formatDate format="dd.MM.yyyy" date="${kontaktInstance?.naechsterkontakt}" /></td>
                        </tr>               
                  
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${kontaktInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <sec:ifAllGranted roles="ROLE_ADMIN"><span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span></sec:ifAllGranted>
                </g:form>
            </div>
        </div>
    </body>
</html>
