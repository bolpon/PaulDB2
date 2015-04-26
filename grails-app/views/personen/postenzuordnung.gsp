<%--
  Created by IntelliJ IDEA.
  User: remo
  Date: 11.04.11
  Time: 10:46
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="dashboard" />
        <g:javascript src="personen.js" />
        <g:set var="entityName" value="${message(code: 'personen.label', default: 'Postenliste')}" />
        <title><g:message code="default.show.label" args="[entityName]" default="PAULDB2 - Postenliste"/></title>
  </head>
  <body>
  <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>

            <g:form method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        <g:each in="${postenList}" status="i" var="posten">
                            <tr class="prop">
                                <td valign="top" class="name">
                                  ${posten.postenName}:
                                </td>
                                <td valign="top">
                                    <g:textField class="postenZuordnungInput" pid="${posten.id}" name="person" maxlength="30" value="${posten?.person?.toList()[0]}" />
                                    <g:hiddenField name="posten.id" id="${'postenZuordnungHiddenPosten'+posten.id.toString()}" value="${posten?.id}" />
                                    <g:hiddenField name="person.id" id="${'postenZuordnungHiddenPerson'+posten.id.toString()}" value="${posten?.person?.toList()[0]?.id}" />
                                </td>
                            </tr>
                        </g:each>


                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <sec:ifAllGranted roles="ROLE_ADMIN"><span class="button"><g:actionSubmit class="save" action="postenzuordnungSave" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span></sec:ifAllGranted>
                </div>
            </g:form>
        </div>
  </body>
</html>