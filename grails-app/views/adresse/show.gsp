
<%@ page import="pauldb2.Adresse" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="dashboard" />
        <g:set var="entityName" value="${message(code: 'adresse.label', default: 'Adresse')}" />
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
                            <td valign="top" class="name"><g:message code="adresse.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: adresseInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="adresse.strasse.label" default="Strasse" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: adresseInstance, field: "strasse")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="adresse.nummer.label" default="Nummer" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: adresseInstance, field: "nummer")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="adresse.plz.label" default="Plz" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: adresseInstance, field: "plz")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="adresse.stadt.label" default="Stadt" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: adresseInstance, field: "stadt")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="adresse.land.label" default="Land" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: adresseInstance, field: "land")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="adresse.postfach.label" default="Postfach" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: adresseInstance, field: "postfach")}</td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${adresseInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <sec:ifAllGranted roles="ROLE_ADMIN"><span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span></sec:ifAllGranted>
                </g:form>
            </div>
        </div>
    </body>
</html>
