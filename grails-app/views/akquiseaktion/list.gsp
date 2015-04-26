
<%@ page import="pauldb2.Akquiseaktion" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="dashboard" />
        <g:set var="entityName" value="${message(code: 'akquiseaktion.label', default: 'Akquiseaktion')}" />
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
                            <g:sortableColumn property="name" title="${message(code: 'akquiseaktion.name.label', default: 'Name')}" />
                        
                            <th><g:message code="akquiseaktion.beschreibung.label" default="Beschreibung" /></th>
                        
                            <g:sortableColumn property="start" title="${message(code: 'akquiseaktion.start.label', default: 'Start')}" />
                        
                            <g:sortableColumn property="ende" title="${message(code: 'akquiseaktion.ende.label', default: 'Ende')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${akquiseaktionInstanceList}" status="i" var="akquiseaktionInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                            <td><g:link action="show" id="${akquiseaktionInstance.id}">${akquiseaktionInstance.name}</g:link></td>
                        
                            <td><g:textArea readonly="readonly" name="beschreibung" cols="5" value="${akquiseaktionInstance.beschreibung}" /></td>
                        
                            <td><g:formatDate date="${akquiseaktionInstance.start}" /></td>
                        
                            <td><g:formatDate date="${akquiseaktionInstance.ende}" /></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${akquiseaktionInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
