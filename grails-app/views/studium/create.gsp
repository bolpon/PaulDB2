
<%@ page import="java.text.SimpleDateFormat; pauldb2.Studium" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="dashboard" />
        <g:set var="entityName" value="${message(code: 'studium.label', default: 'Studium')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" default="Studium anlegen"/></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${studiumInstance}">
            <div class="errors">
                <g:renderErrors bean="${studiumInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="schwerpunkt"><g:message code="studium.schwerpunkt.label" default="Schwerpunkt" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: studiumInstance, field: 'schwerpunkt', 'errors')}">
                                    <g:textField name="schwerpunkt" value="${studiumInstance?.schwerpunkt}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="anfang"><g:message code="studium.anfang.label" default="Anfang" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: studiumInstance, field: 'anfang', 'errors')}">
                                    <input name="anfang" id="anfang" class="jqDatepicker" type="text" value="<%
                                     SimpleDateFormat df = new SimpleDateFormat("dd.MM.yyyy");
                                     println(df.format(new Date()));
                                  %>"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="status.id"><g:message code="studium.status.label" default="Status" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: studiumInstance, field: 'status', 'errors')}">
                                    <g:select name="status.id" from="${pauldb2.Studiumstatus.list()}" optionKey="id" value="${studiumInstance?.status?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="fakultaet.id"><g:message code="studium.fakultaet.label" default="FakultäSt" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: studiumInstance, field: 'fakultaet', 'errors')}">
                                    <%-- <g:select name="fakultaet.id" from="${pauldb2.Fakultaet.list()}" optionKey="id" value="${studiumInstance?.fakultaet?.id}"  /> --%>
                                    <select name="fakultaet.id" id="fakultaet.id">
                                    	<% def isNotFirst = false %>
										<g:each in="${pauldb2.Hochschule.list()}" var="hochschule">
											<g:if test="${isNotFirst}"><optgroup></optgroup></g:if><% isNotFirst = true; %>
											<optgroup label="${hochschule.name.encodeAsHTML()}">
												<g:each in="${hochschule.fakultaeten.sort{ it.bezeichnung }}" var="fakultaet">
													<option value="${fakultaet.id}">${fakultaet.bezeichnung.encodeAsHTML()}</option>
												</g:each>
											</optgroup>
									    </g:each>
									</select>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="studienfach.id"><g:message code="studium.studienfach.label" default="Studienfach" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: studiumInstance, field: 'studienfach', 'errors')}">
                                    <g:select name="studienfach.id" from="${pauldb2.Studienfach.list().sort{it.bezeichnung}}" optionKey="id" value="${studiumInstance?.studienfach?.id}"  />
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
