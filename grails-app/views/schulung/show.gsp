
<%@ page import="pauldb2.Schulung" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="dashboard" />
        <g:set var="entityName" value="${message(code: 'schulung.label', default: 'Schulung')}" />
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
                                <td valign="top" class="name"><g:message code="schulung.id.label" default="Id" /></td>

                                <td valign="top" class="value">${fieldValue(bean: schulungInstance, field: "id")}</td>
                            </tr>
                        </g:if>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="schulung.bezeichnung.label" default="Bezeichnung" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: schulungInstance, field: "bezeichnung")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="schulung.termin.label" default="Termin" /></td>
                            
                            <td valign="top" class="value"><g:formatDate format="dd.MM.yyyy hh:mm" date="${schulungInstance?.termin}" /></td>
                            
                        </tr>


                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="schulung.status.label" default="Status" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: schulungInstance, field: "status")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="schulung.beschreibung.label" default="Beschreibung" /></td>
                            
                            <td valign="top" class="value">
                              
                              <g:textArea readonly="readonly" name="beschreibung" value="${schulungInstance?.beschreibung}"/>
                            </td>
                            
                        </tr>

                        <tr class="prop">
                              <td valign="top" class="name"><g:message code="schulung.teilnehmer.label" default="Teilnehmer" /></td>

                              <td valign="top" class="value">

                                <ul class="noDeco">

                                  <g:each in="${schulungInstance.teilnehmer}" var="t">
                                    <li> <g:link controller="personen" action="show" id="${t.id}" class="listLink">${t?.encodeAsHTML()}</g:link></li> 
                                  </g:each>
                                
                              </td>

                        </tr>

                        <tr class="prop">
                              <td valign="top" class="name"><g:message code="schulung.leiter.label" default="Leiter" /></td>

                              <td valign="top" class="value">

                                <ul class="noDeco">

                                  <g:each in="${schulungInstance.leiter}" var="l">
                                    <li> <g:link controller="personen" action="show" id="${l.id}" class="listLink">${l?.encodeAsHTML()}</g:link></li> 
                                  </g:each>

                              </td>

                        </tr>



                        <!--<tr class="prop">
                            <td valign="top" class="name"><g:message code="schulung.schulungstyp.label" default="Schulungstyp" /></td>
                            
                            <td valign="top" class="value"><g:link controller="schulungstyp" action="show" id="${schulungInstance?.schulungstyp?.id}">${schulungInstance?.schulungstyp?.encodeAsHTML()}</g:link></td>
                            
                        </tr>  -->
                    
                        <!--<tr class="prop">
                            <td valign="top" class="name"><g:message code="schulung.schulungbewertungstatus.label" default="Schulungbewertungstatus" /></td>
                            
                            <td valign="top" class="value"><g:link controller="schulungbewertungstatus" action="show" id="${schulungInstance?.schulungbewertungstatus?.id}">${schulungInstance?.schulungbewertungstatus?.encodeAsHTML()}</g:link></td>
                            
                        </tr>-->
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${schulungInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <sec:ifAllGranted roles="ROLE_ADMIN"><span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></sec:ifAllGranted>
                </g:form>
            </div>
        </div>
    </body>
</html>
