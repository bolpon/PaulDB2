
<%@ page import="pauldb2.Projektphase" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'projektphase.label', default: 'Projektphase')}" />
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
            <g:hasErrors bean="${projektphaseInstance}">
            <div class="errors">
                <g:renderErrors bean="${projektphaseInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="bezeichnung"><g:message code="projektphase.bezeichnung.label" default="Bezeichnung" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projektphaseInstance, field: 'bezeichnung', 'errors')}">
                                    <g:textField name="bezeichnung" maxlength="30" value="${projektphaseInstance?.bezeichnung}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="benoetigt"><g:message code="projektphase.benoetigt.label" default="Benoetigt" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projektphaseInstance, field: 'benoetigt', 'errors')}">
                                    <g:textField name="benoetigt" value="${projektphaseInstance?.benoetigt}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="ordnung"><g:message code="projektphase.ordnung.label" default="Ordnung" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projektphaseInstance, field: 'ordnung', 'errors')}">
                                    <g:textField name="ordnung" value="${fieldValue(bean: projektphaseInstance, field: 'ordnung')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="projektwand"><g:message code="projektphase.projektwand.label" default="Projektwand" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projektphaseInstance, field: 'projektwand', 'errors')}">
                                    <g:textField name="projektwand" value="${projektphaseInstance?.projektwand}" />
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
