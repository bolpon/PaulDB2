<%--
  Created by IntelliJ IDEA.
  User: remo
  Date: 05.05.2010
  Time: 00:04:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="pauldb2.Unternehmen" %>

<html>
  <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="dashboard" />
        <g:javascript src="unternehmen.js" />
        <g:set var="entityName" value="${message(code: 'unternehmen.label', default: 'Unternehmen')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
     <body>

          <div class="body">
          <h1>Unternehmen ohne aktive Betreuer</h1>
          <h2>Anzahl: ${anzahl}</h2>
          <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
          </g:if>

          <div id="mainlist" class="list">
          <table class="tableList">
            <thead>

                <g:sortableColumn property="name"  title="${message(code: 'unternehmen.name.label', default: 'Name')}" />
                <g:sortableColumn property="naechsterkontakt"  title="${message(code: 'unternehmen.naechsterKontakt.label', default: 'Nächster Kontakt')}" />
                <g:sortableColumn property="kontaktnoetig"  title="${message(code: 'unternehmen.kontaktNoetig.label', default: 'Kontakt nötig')}" />
                <th>Betreuer</th>
                <th></th>
            </thead>
              <g:each in="${unternehmenList}" status="i" var="unternehmen">
                <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                    <td>
                      <g:link action="show" id="${unternehmen.id}">${unternehmen.name}</g:link>
                    </td>
                    <td valign="top" class="value "><g:formatDate format="dd.MM.yyyy" date="${unternehmen.naechsterkontakt}" /></td>
                    <td>${unternehmen.kontaktnoetig}</td>
                    <td>
                        <ul class="noDeco">
                                  <g:each in="${unternehmen.betreuer}" var="t">
                                      <li>${t?.encodeAsHTML()}</li>
                                  </g:each>
                        </ul>
                    </td>
                    <td> <g:link controller="unternehmen" action="betreuerZuweisen" id="${unternehmen.id}" >Mir Zuweisen</g:link></td>

                </tr>
              </g:each>

          </table>

         </div>
         </div>

     </body>
</html>