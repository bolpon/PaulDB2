
<%@ page import="pauldb2.Projektphase" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'projektphase.label', default: 'Projektphase')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'projektphase.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="bezeichnung" title="${message(code: 'projektphase.bezeichnung.label', default: 'Bezeichnung')}" />
                        
                            <g:sortableColumn property="benoetigt" title="${message(code: 'projektphase.benoetigt.label', default: 'Benoetigt')}" />
                        
                            <g:sortableColumn property="ordnung" title="${message(code: 'projektphase.ordnung.label', default: 'Ordnung')}" />
                        
                            <g:sortableColumn property="projektwand" title="${message(code: 'projektphase.projektwand.label', default: 'Projektwand')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${projektphaseInstanceList}" status="i" var="projektphaseInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${projektphaseInstance.id}">${fieldValue(bean: projektphaseInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: projektphaseInstance, field: "bezeichnung")}</td>
                        
                            <td>${fieldValue(bean: projektphaseInstance, field: "benoetigt")}</td>
                        
                            <td>${fieldValue(bean: projektphaseInstance, field: "ordnung")}</td>
                        
                            <td>${fieldValue(bean: projektphaseInstance, field: "projektwand")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${projektphaseInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
