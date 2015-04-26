
<%@ page import="pauldb2.Projektanfrage" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="dashboard" />
        <g:set var="entityName" value="${message(code: 'projektanfrage.label', default: 'Projektanfrage')}" />
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
                            <td valign="top" class="name"><g:message code="projektanfrage.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: projektanfrageInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="projektanfrage.beschreibung.label" default="Beschreibung" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: projektanfrageInstance, field: "beschreibung")}</td>
                            
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="projektanfrage.unternehmen.label" default="Unternehmen" /></td>

                            <td valign="top" class="value">
                                <table class="fixWidth">
                                    <g:each in="${projektanfrageInstance?.unternehmen}" var="u">
                                        <tr>
                                            <td>
                                                <g:link controller="unternehmen" action="show" id="${u?.id}" class="listLink">
                                                    ${u?.encodeAsHTML()}
                                                </g:link>
                                            </td>
                                        </tr>
                                    </g:each>
                                </table>
                            </td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="projektanfrage.personen.label" default="Personen" /></td>

                            <td valign="top" class="value">
                                <table class="fixWidth">
                                    <g:each in="${projektanfrageInstance?.personen}" var="p">
                                        <tr>
                                            <td>
                                                <g:link controller="personen" action="show" id="${p?.id}" class="listLink">
                                                    ${p?.encodeAsHTML()}
                                                </g:link>
                                            </td>
                                        </tr>
                                    </g:each>
                                </table>
                            </td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="projektanfrage.kontakt.id.label" default="Kontakt" /></td>
                            
                            <td valign="top" class="value"><g:link controller="kontakt" action="show" id="${projektanfrageInstance.kontakt?.id}">${projektanfrageInstance.kontakt?.toString()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="projektanfrage.projektanfragephase.id.label" default="Projektanfragephase" /></td>
                            
                            <td valign="top" class="value">${projektanfrageInstance?.projektanfragephase?.encodeAsHTML()}</td>
                        </tr>

                        <g:if test="${projektanfrageInstance?.taetigkeitsfeld}">
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="projekte.taetigkeitsfelder.label" default="Tätigkeitsfelder" /></td>

                                <td valign="top" class="value">

                                  <g:each in="${projektanfrageInstance?.taetigkeitsfeld}" var="tf">

                                      ${tf?.encodeAsHTML()}

                                  </g:each>

                                </td>

                            </tr>
                        </g:if>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="projektanfrage.ablehnungsgrund.label" default="Ablehnungsgrund" /></td>

                            <td valign="top" class="value">${fieldValue(bean: projektanfrageInstance, field: "ablehnungsgrund")}</td>

                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${projektanfrageInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <sec:ifAllGranted roles="ROLE_ADMIN"><span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span></sec:ifAllGranted>
                </g:form>
            </div>
        </div>
    </body>
</html>
