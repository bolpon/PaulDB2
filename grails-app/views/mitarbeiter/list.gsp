
<%@ page import="pauldb2.Mitarbeiter" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'mitarbeiter.label', default: 'Mitarbeiter')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'mitarbeiter.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="anfang" title="${message(code: 'mitarbeiter.anfang.label', default: 'Anfang')}" />
                        
                            <g:sortableColumn property="ende" title="${message(code: 'mitarbeiter.ende.label', default: 'Ende')}" />
                        
                            <th><g:message code="mitarbeiter.person.label" default="Person" /></th>
                        
                            <th><g:message code="mitarbeiter.unternehmen.label" default="Unternehmen" /></th>
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${mitarbeiterInstanceList}" status="i" var="mitarbeiterInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${mitarbeiterInstance.id}">${fieldValue(bean: mitarbeiterInstance, field: "id")}</g:link></td>
                        
                            <td><g:formatDate date="${mitarbeiterInstance.anfang}" /></td>
                        
                            <td><g:formatDate date="${mitarbeiterInstance.ende}" /></td>
                        
                            <td>${fieldValue(bean: mitarbeiterInstance, field: "person")}</td>
                        
                            <td>${fieldValue(bean: mitarbeiterInstance, field: "unternehmen")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${mitarbeiterInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
