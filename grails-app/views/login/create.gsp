
<%@ page import="pauldb2.Login" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'login.label', default: 'Login')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${loginInstance}">
            <div class="errors">
                <g:renderErrors bean="${loginInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="loginname"><g:message code="login.loginname.label" default="Loginname" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: loginInstance, field: 'loginname', 'errors')}">
                                    <g:textField name="loginname" value="${loginInstance?.loginname}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="person"><g:message code="login.person.label" default="Person" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: loginInstance, field: 'person', 'errors')}">
                                    <g:select name="person.id" from="${pauldb2.Personen.list()}" optionKey="id" value="${loginInstance?.person?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="password"><g:message code="login.password.label" default="Password" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: loginInstance, field: 'password', 'errors')}">
                                    <g:textField name="password" value="${loginInstance?.password}" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
