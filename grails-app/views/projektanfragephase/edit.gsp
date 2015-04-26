
<%@ page import="pauldb2.Projektanfragephase" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="dashboard" />
        <g:set var="entityName" value="${message(code: 'projektanfragephase.label', default: 'Projektanfragephase')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${projektanfragephaseInstance}">
            <div class="errors">
                <g:renderErrors bean="${projektanfragephaseInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${projektanfragephaseInstance?.id}" />
                <g:hiddenField name="version" value="${projektanfragephaseInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="bezeichnung"><g:message code="projektanfragephase.bezeichnung.label" default="Bezeichnung" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projektanfragephaseInstance, field: 'bezeichnung', 'errors')}">
                                    <g:textField name="bezeichnung" maxlength="50" value="${projektanfragephaseInstance?.bezeichnung}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="ordnung"><g:message code="projektanfragephase.ordnung.label" default="Ordnung" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projektanfragephaseInstance, field: 'ordnung', 'errors')}">
                                    <g:textField name="ordnung" value="${fieldValue(bean: projektanfragephaseInstance, field: 'ordnung')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="projektwand"><g:message code="projektanfragephase.projektwand.label" default="Projektwand" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projektanfragephaseInstance, field: 'projektwand', 'errors')}">
                                    <g:textField name="projektwand" value="${projektanfragephaseInstance?.projektwand}" />
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
