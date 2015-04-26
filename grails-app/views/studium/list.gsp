
<%@ page import="pauldb2.Studium" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'studium.label', default: 'Studium')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'studium.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="schwerpunkt" title="${message(code: 'studium.schwerpunkt.label', default: 'Schwerpunkt')}" />
                        
                            <g:sortableColumn property="anfang" title="${message(code: 'studium.anfang.label', default: 'Anfang')}" />
                        
                            <th><g:message code="studium.status.label" default="Status" /></th>
                   	    
                            <th><g:message code="studium.studienfach.label" default="Studienfach" /></th>
                   	    
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${studiumInstanceList}" status="i" var="studiumInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${studiumInstance.id}">${fieldValue(bean: studiumInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: studiumInstance, field: "schwerpunkt")}</td>
                        
                            <td><g:formatDate date="${studiumInstance.anfang}" /></td>
                        
                            <td>${fieldValue(bean: studiumInstance, field: "status")}</td>
                        
                            <td>${fieldValue(bean: studiumInstance, field: "studienfach")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${studiumInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
