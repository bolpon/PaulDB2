

<%@ page import="java.text.SimpleDateFormat; pauldb2.Aufgabe" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="dashboard" />
        <g:set var="entityName" value="${message(code: 'aufgabe.label', default: 'Aufgabe')}" />
        <title><g:message code="default.create.label" args="[entityName]" default="Neue Aufgabe"/></title>
    </head>
    <body>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" default="Neue Aufgabe" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${aufgabeInstance}">
            <div class="errors">
                <g:renderErrors bean="${aufgabeInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name"><g:message code="aufgabe.name.label" default="Titel" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: aufgabeInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${aufgabeInstance?.name}" maxlength="95"/>
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
                                  <g:checkBox id="aufgabeCreateZugriffCheckbox" name="geschuetzt" value="${aufgabeInstance?.geschuetzt}" />

                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="personenMitZugriff.id"><g:message code="aufgabe.personenMitZugriff.label" default="Zugriff" /></label>
                                </td>

                                  <td valign="top" class="value ${hasErrors(bean: aufgabeInstance, field: 'zugriff', 'errors')}">

                                    <div id="aufgabeCreateZugriff">
                                        <g:select id="personenMitZugriff.id" class="multiselect" name="personenMitZugriff.id" from="${posPaulis}" optionKey="id" multiple="yes" size="5" value="${aufgabeInstance?.personenMitZugriff}" />
                                    </div>

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
