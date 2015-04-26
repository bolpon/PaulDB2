
<%@ page import="pauldb2.Aufgabe" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="dashboard" />
        <g:set var="entityName" value="${message(code: 'aufgabe.label', default: 'Aufgabe')}" />
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
                                <g:sortableColumn property="id" title="${message(code: 'aufgabe.id.label', default: 'Id')}" />
                            </g:if>
                        
                            <g:sortableColumn property="name" title="${message(code: 'aufgabe.name.label', default: 'Name')}" />

                            <th>Bearbeiter</th>
                            <th>Verwalter</th>
                            <g:sortableColumn property="start" title="${message(code: 'aufgabe.start.label', default: 'Start')}" />

                            <g:sortableColumn property="end" title="${message(code: 'aufgabe.end.label', default: 'Ende')}" />
                            <g:sortableColumn property="status" title="${message(code: 'aufgabe.status.label', default: 'Status')}" />
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${aufgabeInstanceList}" status="i" var="aufgabeInstance">


                       <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <g:if test="${role.equals('admin')}">
                                <td><g:link action="show" id="${aufgabeInstance.id}">${fieldValue(bean: aufgabeInstance, field: "id")}</g:link></td>
                            </g:if>
                        
                            <td><g:link action="show" id="${aufgabeInstance.id}">${fieldValue(bean: aufgabeInstance, field: "name")}</g:link>
                              <g:if test="${aufgabeInstance?.geschuetzt}">
                               <br />(geschützt)

                              </g:if>
                            </td>

                            <td>
                              <ul class="noDeco">
                                <g:each in="${aufgabeInstance.bearbeiter}" var="b">
                                    <li><g:link controller="personen" action="show" id="${b.id}">${b?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            <td>
                              <ul class="noDeco">
                                <g:each in="${aufgabeInstance.verwalter}" var="b">
                                    <li><g:link controller="personen" action="show" id="${b.id}">${b?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                        
                            <td><g:formatDate format="dd.MM.yyyy" date="${aufgabeInstance.start}" /></td>

                            <td><g:formatDate format="dd.MM.yyyy" date="${aufgabeInstance.end}" /></td>
                            <td>${aufgabeInstance.status}</td>
                        </tr>

                    </g:each>
                    </tbody>
                </table>
              <div class="paginateButtons">
                <g:paginate total="${aufgabeInstanceTotal}" />
            </div>
            </div>

        </div>
    </body>
</html>
