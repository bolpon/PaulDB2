
<%@ page import="pauldb2.Schulungstyp" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'schulungstyp.label', default: 'Schulungstyp')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'schulungstyp.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="name" title="${message(code: 'schulungstyp.name.label', default: 'Name')}" />
                        
                            <g:sortableColumn property="beschreibung" title="${message(code: 'schulungstyp.beschreibung.label', default: 'Beschreibung')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${schulungstypInstanceList}" status="i" var="schulungstypInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${schulungstypInstance.id}">${fieldValue(bean: schulungstypInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: schulungstypInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: schulungstypInstance, field: "beschreibung")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${schulungstypInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
