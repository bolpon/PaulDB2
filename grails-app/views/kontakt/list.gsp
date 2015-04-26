
<%@ page import="pauldb2.Kontakt" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="dashboard" />
        <g:javascript src="projekte.js" />
        <g:set var="entityName" value="${message(code: 'kontakt.label', default: 'Kontakt')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                            <g:if test="${role.equals('admin')}">
                                <g:sortableColumn property="id" title="${message(code: 'kontakt.id.label', default: 'Id')}" />
                            </g:if>
                            <g:else>
                                <g:sortableColumn property="id" title="${message(code: 'kontakt.anzeigen.label', default: ' ')}" />
                            </g:else>

                            <th><g:message code="kontakt.personen.label" default="Beteiligte Paulis" /></th>

                            <th><g:message code="kontakt.mitarbeiter.label" default="Beteiligte MA" /></th>

                            <%--<g:sortableColumn property="name" title="${message(code: 'kontakt.name.label', default: 'Kontakt vom')}" />--%>
                          
                            <g:sortableColumn property="kontaktscoring" params="['kontaktName':params.kontaktName]" title="${message(code: 'kontakt.kontaktscoring.label', default: 'Bewertung')}" />
                                                    
                            <g:sortableColumn property="datum" defaultOrder="desc" title="${message(code: 'kontakt.datum.label', default: 'Datum')}" />

                            <g:sortableColumn property="naechsterkontakt" defaultOrder="desc" title="${message(code: 'kontakt.nacehsterkontakt.label', default: 'Naechster Kontakt')}" />
                        	                        	
                            <%--<th><g:message code="kontakt.akquiseaktion.label" default="Akquiseaktion" /></th>
                   	    
                            <th><g:message code="kontakt.kontaktzweck.label" default="Kontaktzweck" /></th>--%>
                   	        
                   	        <th><g:message code="kontakt.beschreibung.label" default="Beschreibung" /></th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${kontaktInstanceList}" status="i" var="kontaktInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td>
                                <g:if test="${role.equals('admin')}">
                                    <g:link action="show" id="${kontaktInstance.id}">${kontaktInstance.id}</g:link>
                                </g:if><g:else>
                                    <g:link action="show" id="${kontaktInstance.id}">anzeigen</g:link>
                                </g:else>
                            </td>

                            <td>

                              <ul class="noDeco">
                                <g:each in="${kontaktInstance.personen}" var="p">
                                    <li><g:link controller="personen" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></li>
                                </g:each>
                              </ul>

                            </td>

                            <td>

                              <ul class="noDeco">
                                <g:each in="${kontaktInstance.mitarbeiter}" var="m">
                                    <li><g:link controller="personen" action="show" id="${m.person.id}">${m?.encodeAsHTML()}</g:link> </li>
                                    <li>(<g:link class="nonBold" controller="unternehmen" action="show" id="${m.unternehmen.id}">${m?.unternehmen.encodeAsHTML()}</g:link>) </li>
                                </g:each>
                              </ul>

                            </td>

                            <td><g:link action="show" id="${kontaktInstance.id}">${kontaktInstance.kontaktscoring}</g:link></td>

                            <%--<td><g:link action="show" id="${kontaktInstance.id}">${kontaktInstance.name}</g:link></td>--%>
                                                    
                            <td><g:formatDate format="dd.MM.yyyy" date="${kontaktInstance.datum}" /></td>
                            
                            <td${(kontaktInstance?.naechsterkontakt < new Date()) ? ' class="error"' : ''}><g:formatDate format="dd.MM.yyyy" date="${kontaktInstance?.naechsterkontakt}" /></td>
                                                        
                            <%--<td>${fieldValue(bean: kontaktInstance, field: "akquiseaktion")}</td>
                        
                            <td>${fieldValue(bean: kontaktInstance, field: "kontaktzweck")}</td>--%>
                            
                            <td><g:textArea readonly="readonly" name="beschreibung" cols="5" value="${kontaktInstance.beschreibung}" /></td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${kontaktInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
