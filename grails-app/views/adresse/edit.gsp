
<%@ page import="pauldb2.Adresse" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="dashboard" />
        <g:set var="entityName" value="${message(code: 'adresse.label', default: 'Adresse')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${adresseInstance}">
            <div class="errors">
                <g:renderErrors bean="${adresseInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${adresseInstance?.id}" />
                <g:hiddenField name="version" value="${adresseInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="strasse"><g:message code="adresse.strasse.label" default="Strasse" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: adresseInstance, field: 'strasse', 'errors')}">
                                    <g:textField name="strasse" maxlength="50" value="${adresseInstance?.strasse}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="nummer"><g:message code="adresse.nummer.label" default="Nummer" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: adresseInstance, field: 'nummer', 'errors')}">
                                    <g:textField name="nummer" maxlength="20" value="${adresseInstance?.nummer}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="plz"><g:message code="adresse.plz.label" default="Plz" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: adresseInstance, field: 'plz', 'errors')}">
                                    <g:textField name="plz" maxlength="5" value="${adresseInstance?.plz}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="stadt"><g:message code="adresse.stadt.label" default="Stadt" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: adresseInstance, field: 'stadt', 'errors')}">
                                    <g:textField name="stadt" maxlength="100" value="${adresseInstance?.stadt}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="land"><g:message code="adresse.land.label" default="Land" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: adresseInstance, field: 'land', 'errors')}">
                                    <g:textField name="land" maxlength="25" value="${adresseInstance?.land}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="postfach"><g:message code="adresse.postfach.label" default="Postfach" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: adresseInstance, field: 'postfach', 'errors')}">
                                    <g:textField name="postfach" maxlength="8" value="${adresseInstance?.postfach}" />
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
