
<%@ page import="pauldb2.Projektanfrage" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="dashboard" />
        <g:set var="entityName" value="${message(code: 'projektanfrage.label', default: 'Projektanfrage')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
              <table  class="tableList">
                  <colgroup>
                    <col width="6%">
                    <col width="25%">
                    <col width="17%">
                    <col width="12%">
                    <col width="10%">
                    <col width="10%">
                    <col width="12%">
                  </colgroup>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" params="['anfragephaseProjekt':phase]" title="${message(code: 'projektanfrage.id.label', default: 'Id')}" />
                        
                            <th><g:message code="projektanfrage.unternehmen.label" default="Unternehmen" /></th>

                            <th><g:message code="projektanfrage.personen.label" default= "Personen" /></th>

                            <th><g:message code="projektanfrage.kontakt.id.label" default="Kontakt" /></th>

                            <g:sortableColumn property="projektanfragephase.id" params="['anfragephaseProjekt':phase]" title="${message(code: 'projektanfrage.projektanfragephase.id.label', default:'Projektanfragephase')}" />

                            <th><g:message code="projektanfrage.taetigkeitfeld.label" default="Taetigkeitsfeld" /></th>

                            <g:sortableColumn property="ablehnungsgrund" params="['anfragephaseProjekt':phase]" title="${message(code: 'projektanfrage.ablehnungsgrund.label', default: 'Ablehnungsgrund')}" />
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${projektanfrageInstanceList}" status="i" var="projektanfrageInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${projektanfrageInstance.id}">${fieldValue(bean: projektanfrageInstance, field: "id")}</g:link></td>
                        
                            <td>
                              <ul class="noDeco">
                                <g:each in="${projektanfrageInstance.unternehmen}" var="u">
                                    <li><g:link controller="unternehmen" action="show" id="${u.id}">${u?.encodeAsHTML()}</g:link></li>
                                </g:each>
                              </ul>
                            </td>

                            <td>
                              <ul class="noDeco">
                                <g:each in="${projektanfrageInstance.personen}" var="p">
                                    <li><g:link controller="personen" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></li>
                                </g:each>
                              </ul>
                            </td>

                            <td><g:link controller="kontakt" action="show" id="${projektanfrageInstance.kontakt.id}">
                                ${projektanfrageInstance.kontakt.toString()}</g:link></td>
                        
                            <td>${projektanfrageInstance.projektanfragephase.toString()}</td>

                                                        <td>
                              <ul class="noDeco">
                                <g:each in="${projektanfrageInstance.taetigkeitsfeld}" var="tf">
                                    <li>${tf?.encodeAsHTML()}</li>
                                </g:each>
                              </ul>
                            </td>

                            <td>${fieldValue(bean: projektanfrageInstance, field: "ablehnungsgrund")}</td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
                <div class="paginateButtons">
                    <g:paginate total="${projektanfrageInstanceTotal}" params="['anfragephaseProjekt':phase]" />
                </div>
            </div>
            <div id="widgets" class="widgetsRight">
              <div id="widget1" class="widget">
                <div class="nav">Filter</div>
                <div id="searchform">
                  <g:form name="searchForm" url="[action:'anfrageStatusSearch',controller:'projektanfrage']">
                    <g:select name="anfragephaseProjekt" from="${pauldb2.Projektanfragephase.list()}" optionKey="id" value="" id="filter1" style="width:200px"/>
                    <br />
                    <g:submitButton name="filter" value="Filtern" />
                  </g:form>
                </div>
              </div>
              <span style="clear:both"></span>


        </div>
    </body>
</html>
