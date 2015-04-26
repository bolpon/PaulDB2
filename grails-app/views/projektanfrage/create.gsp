
<%@ page import="pauldb2.Projektanfrage" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="dashboard" />
        <g:javascript src="projekte.js" />
        <g:javascript src="hilfeTexte.js" />
        <g:set var="entityName" value="${message(code: 'projektanfrage.label', default: 'Projektanfrage')}" />
        <title><g:message code="default.create.label" args="[entityName]" default= "PaulDB2 Projektanfrage anlegen" /></title>
    </head>
    <body>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" default = "Projektanfrage anlegen"/></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${projektanfrageInstance}">
            <div class="errors">
                <g:renderErrors bean="${projektanfrageInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="beschreibung"><g:message code="projektanfrage.beschreibung.label" default="Beschreibung" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projektanfrageInstance, field: 'beschreibung', 'errors')}">
                                    <g:textArea name="beschreibung" value="${projektanfrageInstance?.beschreibung}" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <g:message code="projekte.unternehmen.label" default="Unternehmen" />
                                </td>
                                <td>
                                    <input type="text" name="unternehmenInput" id="projektanfrageCreateUnternehmenInput" />
                                    <input type="hidden" id="unternehmenInputHidden" value=""/>
                                    <button id="unternehmenCreateHilfe">Hilfe</button>
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name"></td>
                                <td valign="top" class="value">
                                    <table id="projektCreateUHinzuTable" class="fixWidth" style="width:500">
                                        <tr>
                                            <th>Name des Unternehmens</th>
                                            <th><a href="#" onclick="updateKontakte()"><img src="/pauldb2/images/icons/refresh.png" width="16" height="16" alt="löschen" </a></th>
                                        </tr>
                                    </table>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="personen"><g:message code="projektanfrage.personen.label" default="Paulis" /></label>
                                </td>

                                  <td valign="top" class="value ${hasErrors(bean: projektanfrageInstance, field: 'personen', 'errors')}">

                                    <div id="projektanfrageCreateTeammitglieder">
                                        <g:select id="personen" class="multiselect" name="personen" from="${posTeammitglieder}" optionKey="id"
                                                  multiple="yes" size="5" value="${projektanfrageInstance?.personen}" />
                                    </div>

                                  </td>

                            </tr>

                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="ablehnungsgrund"><g:message code="projektanfrage.ablehnungsgrund.label" default="Ablehnungsgrund" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projektanfrageInstance, field: 'ablehnungsgrund', 'errors')}">
                                    <g:textField name="ablehnungsgrund" value="${projektanfrageInstance?.ablehnungsgrund}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="kontakt.id"><g:message code="projektanfrage.kontakt.id.label" default="Kontakt" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projektanfrageInstance, field: 'kontakt.id', 'errors')}">
                                    <g:select name="kontakt.id" from="${kontaktlist}" optionKey="id" value="${projektanfrageInstance?.kontakt?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="projektanfragephase.id"><g:message code="projektanfrage.projektanfragephase.id.label" default="Projektanfragephase" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projektanfrageInstance, field: 'projektanfragephase.id', 'errors')}">
                                    <g:select name="projektanfragephase.id" from="${pauldb2.Projektanfragephase.list()}" optionKey="id" value="${projektanfrageInstance?.projektanfragephase?.id}"  />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name" >
                                    <label for="taetigkeitsfelder"><g:message code="projektanfrage.taetigkeitsfelder.label" default="Tätigkeitsfelder" /></label>
                                </td>
                                <td valign="top" class="value">
                                    <table class="fixWidth600" style="width:600" name="tableTaetigkeitsfelder" id="tableTaetigkeitsfelder">
                                        <tr>
                                            <th>Tätkeitscluster</th>
                                            <th>Tätigkeitsfeld</th>
                                            <th><center><a href="#" id="projektanfrageTaetigkeitsfelderHinzu" onClick="projekteTaetigkeitsfelderHinzu();return false;"><img src="/pauldb2/images/icons/plus.png" height="16" width="16"/></a></center></th>
                                        </tr>
                                    </table>
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
