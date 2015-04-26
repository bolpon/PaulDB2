
<%@ page import="java.text.SimpleDateFormat; pauldb2.Schulung" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="dashboard" />
        <g:set var="entityName" value="${message(code: 'schulung.label', default: 'Schulung')}" />
        <title><g:message code="default.create.label" args="[entityName]" default= "PaulDB2 Schulung anlegen"/></title>
    </head>
    <body>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" default= "Schulung anlegen"/></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${schulungInstance}">
            <div class="errors">
                <g:renderErrors bean="${schulungInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="bezeichnung"><g:message code="schulung.bezeichnung.label" default="Bezeichnung" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schulungInstance, field: 'bezeichnung', 'errors')}">
                                    <g:textField name="bezeichnung" cols="40" rows="5" value="${schulungInstance?.bezeichnung}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="termin"><g:message code="schulung.termin.label" default="Termin" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schulungInstance, field: 'termin', 'errors')}">
                                    <input name="termin" id="termin" class="jqDatepicker" type="text" value="<%
                                     SimpleDateFormat df = new SimpleDateFormat("dd.MM.yyyy");
                                     println(df.format(new Date()));
                                  %>"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="uhrzeit"><g:message code="schulung.uhrzeit.label" default="Uhrzeit" /></label>
                                </td>
                                <td valign="top" class="value">
                                    <input name="uhrzeit" id="uhrzeit" class="Time" type="text" value="<%
                                     SimpleDateFormat uhrzeit = new SimpleDateFormat("HH:mm");
                                     println(uhrzeit.format(new Date()));
                                  %>"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="status"><g:message code="schulung.status.label" default="Status" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schulungInstance, field: 'status', 'errors')}">
                                    <g:select name="status" from="${schulungInstance.constraints.status.inList}" value="${schulungInstance?.status}" valueMessagePrefix="schulung.status"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="beschreibung"><g:message code="schulung.beschreibung.label" default="Beschreibung" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schulungInstance, field: 'beschreibung', 'errors')}">
                                    <g:textArea name="beschreibung" value="${schulungInstance?.beschreibung}" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="teilnehmer"><g:message code="schulung.teilnehmer.label" default="Teilnehmer" /></label>
                                </td>

                                  <td valign="top" class="value ${hasErrors(bean: schulungInstance, field: 'teilnehmer', 'errors')}">

                                    <div id="ubw">
                                        <g:select id="schulungTeilnehmer" class="multiselect" name="teilnehmer" from="${posTeilnehmer}" optionKey="id" multiple="yes" size="5" value="${schulungInstance?.teilnehmer}" />
                                    </div>

                                  </td>

                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="leiter"><g:message code="schulung.leiter.label" default="Leiter" /></label>
                                </td>

                                  <td valign="top" class="value ${hasErrors(bean: schulungInstance, field: 'leiter', 'errors')}">

                                    <div id="ubw2">
                                        <g:select id="schulungLeiter" class="multiselect" name="leiter" from="${posTeilnehmer}" optionKey="id" multiple="yes" size="5" value="${schulungInstance?.leiter}" />
                                    </div>

                                  </td>

                            </tr>

                            <!--<tr class="prop">
                                <td valign="top" class="name">
                                    <label for="schulungbewertungstatus.id"><g:message code="schulung.schulungbewertungstatus.label" default="Schulungbewertungstatus" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schulungInstance, field: 'schulungbewertungstatus', 'errors')}">
                                    <g:select name="schulungbewertungstatus.id" from="${pauldb2.Schulungbewertungstatus.list()}" optionKey="id" value="${schulungInstance?.schulungbewertungstatus?.id}"  />
                                </td>
                            </tr>-->
                        
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
