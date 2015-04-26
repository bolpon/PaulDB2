
<%@ page import="pauldb2.Projektanfrage" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="dashboard" />
        <g:javascript src="projekte.js" />
        <g:javascript src="hilfeTexte.js" />
        <g:set var="entityName" value="${message(code: 'projektanfrage.label', default: 'Projektanfrage')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${projektanfrageInstance}">
            <div class="errors">
                <g:renderErrors bean="${projektanfrageInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${projektanfrageInstance?.id}" />
                <g:hiddenField name="version" value="${projektanfrageInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                            <g:if test="${role.equals('admin')}">
                                <tr class="prop">
                                    <td valign="top" class="name">
                                        <g:message code="projektanfrage.id.label" default="Id" />
                                    </td>
                                    <td valign="top" class="value">
                                        ${projektanfrageInstance?.id}
                                    </td>
                                </tr>
                            </g:if>

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
                                  <label for="personen"><g:message code="projektanfrage.personen.label" default="Teammitglieder" /></label>
                                </td>

                                  <td valign="top" class="value ${hasErrors(bean: projektanfrageInstance, field: 'personen', 'errors')}">

                                    <div id="projektanfrageCreateTeammitglieder">
                                        <g:select id="personen" class="multiselect" name="personen" from="${posTeammitglieder}" optionKey="id" multiple="yes" size="5" value="${projektanfrageInstance?.personen}" />
                                    </div>

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
                                        <g:each in="${projektanfrageInstance.unternehmen}" var="u">
                                            <tr>
                                                <td>
                                                    <g:textField name="uName" value="${u.name}" style="width:450" readonly="true" class="unternehmen" />
                                                    <g:hiddenField name="unternehmen" value="${u.id}" style="width:450" readonly="true" class="unternehmen_id" />
                                                </td>
                                                <td>
                                                    <a href="#" onclick="document.getElementById('projektCreateUHinzuTable').deleteRow(this.parentNode.parentNode.rowIndex);updateKontakte();return false"><img src="/pauldb2/images/icons/busy.png" width="16" height="16" alt="löschen" </a>


                                                </td>
                                            </tr>
                                        </g:each>
                                    </table>
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
                                <td valign="top" class="value ${hasErrors(bean: projektanfrageInstance, field: 'kontaktIdKontakt', 'errors')}">
                                    <g:select name="kontakt.id" from="${kontaktlist}" optionKey="id" value="${projektanfrageInstance?.kontakt?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="projektanfragephase.id"><g:message code="projektanfrage.projektanfragephase.id.label" default="Projektanfragephase" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projektanfrageInstance, field: 'projektanfragephaseIdProjektanfragephase', 'errors')}">
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
                                        <% int taetFelderNum = 1; %>
                                        <g:each in="${projektanfrageInstance?.taetigkeitsfeld}" var="tf">
                                            <tr>
                                                <td>
                                                    <g:select class="Taetigkeitscluster" id="${taetFelderNum}" name="taetigkeitsCluster" optionKey="id" optionValue="bezeichnung" from="${pauldb2.Taetigkeitscluster.list()}" value="${tf?.cluster.id}" style="width:250" />
                                                </td>
                                                <td>
                                                    <g:select class="Taetigkeitsfelder" id="feld${taetFelderNum}" name="taetigkeitsFelder" optionKey="id" optionValue="bezeichnung" from="${pauldb2.Taetigkeitsfeld.findAllByCluster(tf?.cluster)}" value="${tf?.id}" style="width:250" />
                                                </td>
                                                <td>
                                                    <a href="#" id="projektanfrageTaetigkeitsfelderHinzu" onClick="document.getElementById('tableTaetigkeitsfelder').deleteRow(this.parentNode.parentNode.rowIndex);return false"><img src="/pauldb2/images/icons/busy.png" height="16" width="16"/></a>
                                                </td>
                                            </tr>
                                            <% taetFelderNum++; %>
                                        </g:each>
                                    </table>
                                </td>
                            </tr>

                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <g:if test="${role.equals('admin')}"><span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span></g:if>                </div>
            </g:form>
        </div>
    </body>
</html>
