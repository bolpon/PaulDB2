
<%@ page import="pauldb2.Akquiseaktion; java.text.SimpleDateFormat" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="dashboard" />
        <g:set var="entityName" value="${message(code: 'akquiseaktion.label', default: 'Akquiseaktion')}" />
        <title><g:message code="default.create.label" args="[entityName]" default= "PaulDB2 Akquiseaktion anlegen" /></title>
    </head>
    <body>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" default="Akquiseaktion anlegen" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${akquiseaktionInstance}">
            <div class="errors">
                <g:renderErrors bean="${akquiseaktionInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>                        
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
                                    <g:textArea name="beschreibung" value="${akquiseaktionInstance?.beschreibung}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="start"><g:message code="akquiseaktion.start.label" default="Beginn" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: kontaktInstance, field: 'start', 'errors')}">
                                    <input name="start" id="start" class="jqDatepicker" type="text" value="<%
                                     SimpleDateFormat d = new SimpleDateFormat("dd.MM.yyyy");
                                     if (akquiseaktionInstance?.start != null)
                                     	println(d.format(akquiseaktionInstance.start));
                                  %>"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="ende"><g:message code="akquiseaktion.ende.label" default="Ende" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: kontaktInstance, field: 'ende', 'errors')}">
                                    <input name="ende" id="ende" class="jqDatepicker" type="text" value="<%
                                     if (akquiseaktionInstance?.ende != null)
                                     	println(d.format(akquiseaktionInstance.ende));
                                  %>"/>
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
