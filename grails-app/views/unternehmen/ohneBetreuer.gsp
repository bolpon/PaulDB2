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
          <h1>Unternehmen ohne Betreuer</h1>
          <h2>Anzahl: ${anzahl}</h2>
          <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
          </g:if>

          <div id="mainlist" class="list">
          <table class="tableList">
            <thead><tr>
                <g:sortableColumn property="name"  title="${message(code: 'unternehmen.name.label', default: 'Name')}" />
                <g:sortableColumn property="unternehmensscoring"  title="${message(code: 'unternehmen.scoring.label', default: 'Scoring')}" />
                <g:sortableColumn property="naechsterkontakt"  title="${message(code: 'unternehmen.naechsterKontakt.label', default: 'Nächster Kontakt')}" />
                <th></th>
            </tr></thead>
            <tbody>
              <g:each in="${unternehmenList}" status="i" var="unternehmen">
                <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                    <td>
                      <g:link action="show" id="${unternehmen.id}">${unternehmen.name}</g:link>
                    </td>
					<td>${unternehmen.unternehmensscoring} ${unternehmen?.letzterkontakt?.kontaktscoring}</td>
                    <td valign="top" class="value "><g:formatDate format="dd.MM.yyyy" date="${unternehmen.naechsterkontakt}" /></td>
                    <td> <g:link controller="unternehmen" action="betreuerZuweisen" id="${unternehmen.id}" >Mir Zuweisen</g:link></td>
                </tr>
              </g:each>
			</tbody>
          </table>

         </div>
         </div>

     </body>
</html>