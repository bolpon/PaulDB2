
<%@ page import="pauldb2.Projektanfragephase" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="dashboard" />
        <g:set var="entityName" value="${message(code: 'projektanfragephase.label', default: 'Projektanfragephase')}" />
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
                            <td valign="top" class="name"><g:message code="projektanfragephase.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: projektanfragephaseInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="projektanfragephase.bezeichnung.label" default="Bezeichnung" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: projektanfragephaseInstance, field: "bezeichnung")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="projektanfragephase.ordnung.label" default="Ordnung" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: projektanfragephaseInstance, field: "ordnung")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="projektanfragephase.projektwand.label" default="Projektwand" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: projektanfragephaseInstance, field: "projektwand")}</td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${projektanfragephaseInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <sec:ifAllGranted roles="ROLE_ADMIN"><span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span></sec:ifAllGranted>
                </g:form>
            </div>
        </div>
    </body>
</html>
