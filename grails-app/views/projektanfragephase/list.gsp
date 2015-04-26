
<%@ page import="pauldb2.Projektanfragephase" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="dashoard" />
        <g:set var="entityName" value="${message(code: 'projektanfragephase.label', default: 'Projektanfragephase')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'projektanfragephase.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="bezeichnung" title="${message(code: 'projektanfragephase.bezeichnung.label', default: 'Bezeichnung')}" />
                        
                            <g:sortableColumn property="ordnung" title="${message(code: 'projektanfragephase.ordnung.label', default: 'Ordnung')}" />
                        
                            <g:sortableColumn property="projektwand" title="${message(code: 'projektanfragephase.projektwand.label', default: 'Projektwand')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${projektanfragephaseInstanceList}" status="i" var="projektanfragephaseInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${projektanfragephaseInstance.id}">${fieldValue(bean: projektanfragephaseInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: projektanfragephaseInstance, field: "bezeichnung")}</td>
                        
                            <td>${fieldValue(bean: projektanfragephaseInstance, field: "ordnung")}</td>
                        
                            <td>${fieldValue(bean: projektanfragephaseInstance, field: "projektwand")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${projektanfragephaseInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
