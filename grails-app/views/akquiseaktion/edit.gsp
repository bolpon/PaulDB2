
<%@ page import="pauldb2.Akquiseaktion" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'akquiseaktion.label', default: 'Akquiseaktion')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${akquiseaktionInstance}">
            <div class="errors">
                <g:renderErrors bean="${akquiseaktionInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${akquiseaktionInstance?.id}" />
                <g:hiddenField name="version" value="${akquiseaktionInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="akquiseaktionId"><g:message code="akquiseaktion.akquiseaktionId.label" default="Akquiseaktion Id" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: akquiseaktionInstance, field: 'akquiseaktionId', 'errors')}">
                                    <g:textField name="akquiseaktionId" value="${fieldValue(bean: akquiseaktionInstance, field: 'akquiseaktionId')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="name"><g:message code="akquiseaktion.name.label" default="Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: akquiseaktionInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" maxlength="100" value="${akquiseaktionInstance?.name}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="beschreibung"><g:message code="akquiseaktion.beschreibung.label" default="Beschreibung" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: akquiseaktionInstance, field: 'beschreibung', 'errors')}">
                                    <g:textField name="beschreibung" value="${akquiseaktionInstance?.beschreibung}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="start"><g:message code="akquiseaktion.start.label" default="Start" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: akquiseaktionInstance, field: 'start', 'errors')}">
                                    <g:datePicker name="start" precision="day" value="${akquiseaktionInstance?.start}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="ende"><g:message code="akquiseaktion.ende.label" default="Ende" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: akquiseaktionInstance, field: 'ende', 'errors')}">
                                    <g:datePicker name="ende" precision="day" value="${akquiseaktionInstance?.ende}"  />
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
