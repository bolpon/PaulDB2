

<%@ page import="pauldb2.Aufgabenstatus; java.text.SimpleDateFormat; pauldb2.Aufgabe" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="dashboard" />
        <g:set var="entityName" value="${message(code: 'aufgabe.label', default: 'Aufgabe')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${aufgabeInstance}">
            <div class="errors">
                <g:renderErrors bean="${aufgabeInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${aufgabeInstance?.id}" />
                <g:hiddenField name="version" value="${aufgabeInstance?.version}" />
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
                                <td valign="top" class="name">
                                    <label for="status"><g:message code="aufgabe.status.label" default="Status" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: aufgabeInstance, field: 'status', 'errors')}">
                                  <g:select name="status" from="${Aufgabenstatus.list()}" optionKey="id" value="${aufgabeInstance?.status}" />

                                </td>
                            </tr>


                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="name"><g:message code="aufgabe.name.label" default="Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: aufgabeInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${aufgabeInstance?.name}" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="beschreibung"><g:message code="aufgabe.beschreibung.label" default="Beschreibung" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: aufgabeInstance, field: 'beschreibung', 'errors')}">
                                    <g:textArea name="beschreibung" value="${aufgabeInstance?.beschreibung}" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="start"><g:message code="aufgabe.start.label" default="Start" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: aufgabeInstance, field: 'start', 'errors')}">
                                    <input name="start" class="jqDatepicker" type="text" value="<%
                                     SimpleDateFormat df = new SimpleDateFormat("dd.MM.yyyy");
                                     Date d = new Date();
                                      println(df.format(d));
                                  %>"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="end"><g:message code="aufgabe.end.label" default="Ende" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: aufgabeInstance, field: 'end', 'errors')}">
                                    <input name="end" class="jqDatepicker" type="text" value="<%
                                      println(df.format(d));
                                  %>"/>
                                </td>
                            </tr>
                        


                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="verwalter.id"><g:message code="aufgabe.verwalter.label" default="Verwalter" /></label>
                                </td>

                                  <td valign="top" class="value ${hasErrors(bean: aufgabeInstance, field: 'verwalter', 'errors')}">

                                    <div>
                                        <g:select id="verwalter.id" class="multiselect" name="verwalter.id" from="${posPaulis}" optionKey="id" multiple="yes" size="5" value="${aufgabeInstance?.verwalter}" />
                                    </div>

                                  </td>

                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="bearbeiter.id"><g:message code="aufgabe.bearbeiter.label" default="Bearbeiter" /></label>
                                </td>

                                  <td valign="top" class="value ${hasErrors(bean: aufgabeInstance, field: 'bearbeiter', 'errors')}">

                                    <div>
                                        <g:select id="bearbeiter.id" class="multiselect" name="bearbeiter.id" from="${posPaulis}" optionKey="id" multiple="yes" size="5" value="${aufgabeInstance?.bearbeiter}" />
                                    </div>

                                  </td>

                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="geschuetzt"><g:message code="aufgabe.geschuetzt.label" default="Geschützt" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: aufgabeInstance, field: 'end', 'errors')}">
                                  <g:checkBox id="aufgabeEditZugriffCheckbox" name="geschuetzt" value="${aufgabeInstance?.geschuetzt}" />

                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="personenMitZugriff.id"><g:message code="aufgabe.personenMitZugriff.label" default="Zugriff" /></label>
                                </td>

                                  <td valign="top" class="value ${hasErrors(bean: aufgabeInstance, field: 'zugriff', 'errors')}">

                                    <div id="aufgabeEditZugriff">
                                        <g:select id="personenMitZugriff.id" class="multiselect" name="personenMitZugriff.id" from="${posPaulis}" optionKey="id" multiple="yes" size="5" value="${aufgabeInstance?.personenMitZugriff}" />
                                    </div>

                                  </td>

                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <g:if test="${role.equals('admin')}"><span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span></g:if>
                </div>
            </g:form>
        </div>
    </body>
</html>
