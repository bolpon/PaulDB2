
<%@ page import="pauldb2.Login" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="dashboard" />
        <g:set var="entityName" value="${message(code: 'login.label', default: 'Login')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="body">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="login.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: loginInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="login.loginname.label" default="Loginname" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: loginInstance, field: "loginname")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="login.person.label" default="Person" /></td>
                            
                            <td valign="top" class="value"><g:link controller="personen" action="show" id="${loginInstance?.person?.id}">${loginInstance?.person?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="login.role.label" default="Rolle" /></td>

                            <td valign="top" class="value">${fieldValue(bean: loginInstance, field: "role")}</td>

                        </tr>


                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="login.password.label" default="Password" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: loginInstance, field: "password")}</td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${loginInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <sec:ifAllGranted roles="ROLE_ADMIN"><span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span></sec:ifAllGranted>
                </g:form>
            </div>
        </div>
    </body>
</html>
