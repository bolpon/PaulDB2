
<%@ page import="pauldb2.Adresse" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'adresse.label', default: 'Adresse')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'adresse.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="strasse" title="${message(code: 'adresse.strasse.label', default: 'Strasse')}" />
                        
                            <g:sortableColumn property="nummer" title="${message(code: 'adresse.nummer.label', default: 'Nummer')}" />
                        
                            <g:sortableColumn property="plz" title="${message(code: 'adresse.plz.label', default: 'Plz')}" />
                        
                            <g:sortableColumn property="stadt" title="${message(code: 'adresse.stadt.label', default: 'Stadt')}" />
                        
                            <g:sortableColumn property="land" title="${message(code: 'adresse.land.label', default: 'Land')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${adresseInstanceList}" status="i" var="adresseInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${adresseInstance.id}">${fieldValue(bean: adresseInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: adresseInstance, field: "strasse")}</td>
                        
                            <td>${fieldValue(bean: adresseInstance, field: "nummer")}</td>
                        
                            <td>${fieldValue(bean: adresseInstance, field: "plz")}</td>
                        
                            <td>${fieldValue(bean: adresseInstance, field: "stadt")}</td>
                        
                            <td>${fieldValue(bean: adresseInstance, field: "land")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${adresseInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
