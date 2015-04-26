
<%@ page import="pauldb2.Personen" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="dashboard" />
        <g:javascript src="personen.js" />
        <g:set var="entityName" value="${message(code: 'personen.label', default: 'Personen')}" />
        <title>PAULDB2 - Telefonverzeichnis</title>




        </head>
    <body>

        <div class="body">
            <h1>Telefonverzeichnis</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>


            <div id="listContent">
              <div id="mainlist" class="list">
                 <table class="tableList">

                     <thead>
                          <tr>
                              <th class="sortable">Person</th>
                              <th class="sortable">Nummern</th>
                          </tr>
                      </thead>
                      <tbody>
                      <g:each in="${personenList}" status="i" var="person">
                          <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                              <td><g:link action="show" id="${person.id}">${person}</g:link></td>
                              <td>

                                <ul class="noDeco">
                                  <g:each in="${person.telefon}" var="t">
                                      <li>${t?.encodeAsHTML()}</li>
                                  </g:each>
                                </ul>

                              </td>

                          </tr>
                      </g:each>
                      </tbody>
                  </table>
            </div>
            </div>

        </div>
    </body>
</html>
