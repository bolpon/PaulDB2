
<%@ page import="pauldb2.Aufgabe" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="dashboard" />
        <g:set var="entityName" value="${message(code: 'aufgabe.label', default: 'Aufgabe')}" />
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
                        <g:if test="${role.equals('admin')}">
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="aufgabe.id.label" default="Id" /></td>

                                <td valign="top" class="value">${fieldValue(bean: aufgabeInstance, field: "id")}</td>

                            </tr>
                        </g:if>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="aufgabe.name.label" default="Name" /></td>

                            <td valign="top" class="value">${fieldValue(bean: aufgabeInstance, field: "name")}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="aufgabe.beschreibung.label" default="Beschreibung" /></td>
                            
                            <td valign="top" class="value">
                              <g:textArea readonly="readonly" name="beschreibung" value="${aufgabeInstance?.beschreibung}"/>
                            </td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="aufgabe.verwalter.label" default="Verwalter" /></td>

                            <td valign="top" style="text-align: left;" class="value">
                                <ul class="noDeco">
                                <g:each in="${aufgabeInstance.verwalter}" var="v">
                                    <li><g:link controller="personen" action="show" id="${v.id}">${v?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="aufgabe.bearbeiter.label" default="Bearbeiter" /></td>

                            <td valign="top" style="text-align: left;" class="value">
                                <ul class="noDeco">
                                <g:each in="${aufgabeInstance.bearbeiter}" var="b">
                                    <li><g:link controller="personen" action="show" id="${b.id}">${b?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>

                        </tr>



                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="aufgabe.start.label" default="Start" /></td>
                            
                            <td valign="top" class="value"><g:formatDate format="dd.MM.yyyy" date="${aufgabeInstance?.start}" /></td>
                            
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="aufgabe.end.label" default="Ende" /></td>

                            <td valign="top" class="value"><g:formatDate format="dd.MM.yyyy" date="${aufgabeInstance?.end}" /></td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="aufgabe.status.label" default="Status" /></td>

                            <td valign="top" class="value">${fieldValue(bean: aufgabeInstance, field: "status")}</td>

                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="aufgabe.geschuetzt.label" default="Geschützt" /></td>

                            <td valign="top" class="value">${fieldValue(bean: aufgabeInstance, field: "geschuetzt")}</td>

                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="aufgabe.personenMitZugriff.label" default="Zugriff" /></td>

                            <td valign="top" style="text-align: left;" class="value">
                                <ul class="noDeco">
                                <g:each in="${aufgabeInstance.personenMitZugriff}" var="b">
                                    <li><g:link controller="personen" action="show" id="${b.id}">${b?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>

                        </tr>

                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${aufgabeInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <sec:ifAllGranted roles="ROLE_ADMIN"><span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span></sec:ifAllGranted>
                </g:form>
            </div>
        </div>
    </body>
</html>
