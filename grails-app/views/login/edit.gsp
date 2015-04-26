
<%@ page import="pauldb2.Login" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="dashboard" />
        <g:set var="entityName" value="${message(code: 'login.label', default: 'Login')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${loginInstance}">
            <div class="errors">
                <g:renderErrors bean="${loginInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${loginInstance?.id}" />
                <g:hiddenField name="version" value="${loginInstance?.version}" />
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
                                  <label for="person.id"><g:message code="login.person.label" default="Person" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: loginInstance, field: 'person', 'errors')}">
                                    <g:select name="person.id" from="${pauldb2.Personen.list()}" optionKey="id" value="${loginInstance?.person?.id}"  />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="role"><g:message code="login.person.label" default="Rolle" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: loginInstance, field: 'role', 'errors')}">
                                    <g:select name="role" from="${loginInstance.constraints.role.inList}" value="${loginInstance?.role}" valueMessagePrefix="login.role" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="newPassword"><g:message code="login.password.label" default="Neues Password" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: loginInstance, field: 'password', 'errors')}">
                                    <g:textField name="newPassword" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
