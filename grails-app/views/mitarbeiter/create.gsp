

<%@ page import="pauldb2.Mitarbeiter" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'mitarbeiter.label', default: 'Mitarbeiter')}" />
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
            <g:hasErrors bean="${mitarbeiterInstance}">
            <div class="errors">
                <g:renderErrors bean="${mitarbeiterInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="anfang"><g:message code="mitarbeiter.anfang.label" default="Anfang" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: mitarbeiterInstance, field: 'anfang', 'errors')}">
                                    <g:datePicker name="anfang" precision="day" value="${mitarbeiterInstance?.anfang}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="ende"><g:message code="mitarbeiter.ende.label" default="Ende" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: mitarbeiterInstance, field: 'ende', 'errors')}">
                                    <g:datePicker name="ende" precision="day" value="${mitarbeiterInstance?.ende}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="person"><g:message code="mitarbeiter.person.label" default="Person" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: mitarbeiterInstance, field: 'person', 'errors')}">
                                    <g:select name="person.id" from="${pauldb2.Personen.list()}" optionKey="id" value="${mitarbeiterInstance?.person?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="unternehmen"><g:message code="mitarbeiter.unternehmen.label" default="Unternehmen" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: mitarbeiterInstance, field: 'unternehmen', 'errors')}">
                                    <g:select name="unternehmen.id" from="${pauldb2.Unternehmen.list()}" optionKey="id" value="${mitarbeiterInstance?.unternehmen?.id}"  />
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
