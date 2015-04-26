
<%@ page import="pauldb2.Login" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="dashboard" />
        <g:set var="entityName" value="${message(code: 'login.label', default: 'Login')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'login.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="loginname" title="${message(code: 'login.loginname.label', default: 'Loginname')}" />
                        
                            <th><g:message code="login.person.label" default="Person" /></th>
                   	    
                            <g:sortableColumn property="password" title="${message(code: 'login.password.label', default: 'Password')}" />
                        
                            <th>Login loeschen</th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${loginInstanceList}" status="i" var="loginInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="edit" id="${loginInstance.id}">${fieldValue(bean: loginInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: loginInstance, field: "loginname")}</td>
                        
                            <td>${fieldValue(bean: loginInstance, field: "person")}</td>
                        
                            <td>${fieldValue(bean: loginInstance, field: "password")}</td>

                            <td> <g:link controller="login" action="deleteAcc" id="${loginInstance.id}">löschen</g:link> </td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
              <div class="paginateButtons">
                  <g:paginate total="${loginInstanceTotal}" />
              </div>

            </div>

        </div>
    </body>
</html>
