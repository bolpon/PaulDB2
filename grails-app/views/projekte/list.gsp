
<%@ page import="pauldb2.Projekte" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="dashboard" />
        <g:javascript src="projekte.js" />
        <g:set var="entityName" value="${message(code: 'projekte.label', default: 'Projekte')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list" id="mainlist">
              <table  class="tableList">
                  <colgroup>
                    <col width="7%">
                    <col width="8%">
                    <col width="12%">
                    <col width="12%">
                    <col width="20%">
                    <col width="20%">
                    <col width="20%">
                  </colgroup>
                    <thead>
                        <tr>
                            <g:if test="${role.equals('admin')}">
                                <g:sortableColumn property="id" title="${message(code: 'projekte.id.label', default: 'Id')}" />
                            </g:if>

                            <g:sortableColumn property="projektname" title="${message(code: 'projekte.projektname.label', default: 'Projektname')}" />

                            <g:sortableColumn property="internextern" title="${message(code: 'projekte.internextern.label', default: 'Projektart')}" />

                            <th><g:message code="projekte.unternehmen.label" default= "Unternehmen" /></th>

                            <th><g:message code="projekte.team.label" default= "Team" /></th>

                            <g:sortableColumn property="referenzfreigabe" title="${message(code: 'projekte.referenzfreigabe.label', default: 'Referenzfreigabe')}" />
                        
                            <g:sortableColumn property="beschreibung" title="${message(code: 'projekte.beschreibung.label', default: 'Beschreibung')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${projekteInstanceList}" status="i" var="projekteInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <g:if test="${role.equals('admin')}">
                                <td><g:link action="show" id="${projekteInstance.id}">${fieldValue(bean: projekteInstance, field: "id")}</g:link></td>
                            </g:if>

                            <td><g:link action="show" id="${projekteInstance.id}">${fieldValue(bean: projekteInstance, field: "projektname")}</g:link></td>

                            <td>${fieldValue(bean: projekteInstance, field: "internextern")}</td>



                            <td>

                              <ul class="noDeco">
                                <g:each in="${projekteInstance.unternehmen}" var="u">
                                    <li><g:link controller="unternehmen" action="show" id="${u.id}">${u?.encodeAsHTML()}</g:link></li>
                                </g:each>
                              </ul>

                            </td>

                            <td>

                               <ul class="noDeco">
                                <g:each in="${projekteInstance.tm}" var="t">
                                    <li><g:link controller="personen" action="show" id="${t.person.id}">${t.person?.encodeAsHTML()}</g:link></li>
                                </g:each>
                              </ul>

                            </td>

                            <td>${fieldValue(bean: projekteInstance, field: "referenzfreigabe")}</td>
                        
                            <td>
                              <g:if test="${projekteInstance?.beschreibung}">
                                    <g:textArea readonly="readonly" name="beschreibung" style='width: 230px; height: 100px;' value="${projekteInstance?.beschreibung}"/>
                               </g:if>
                            </td>
                        
                        </tr>
                    </g:each>
                    </tbody>
              </table>

              <div class="paginateButtons">
                   <g:paginate total="${projekteInstanceTotal}" params="['intern':params.intern, 'extern':params.extern, 'teammitglied':params.teammitglied, 'tmfilter':params.tmfilter]" />
              </div>
            </div>

            <div id="widgets" class="widgetsRight">
              <div id="widget1" class="widget">
                <div class="nav">Filter</div>
                <div id="searchform">
                  <g:form name="searchForm" url="[action:'filter',controller:'projekte']">
                    <g:checkBox name="intern" value="${params.intern}" /> Intern <br />
                    <g:checkBox name="extern" value="${params.extern}" /> Extern <br />
                    <g:checkBox name="tmfilter" value="${params.tmfilter}" /> Nach Pauli filtern? <br />
                    <g:select name="teammitglied" from="${ projekteInstancePaulis }" optionKey="id" value="${params.teammitglied}" id="filter1"  />
                    <br />
                    <g:submitButton name="filter" value="Filtern" />
                  </g:form>
                  <!-- Ajax Variante -->
                  <!--<button onClick="filter()">Filter</button> -->
                </div>
              </div>


%{--              <div id="widget2" class="widget">
               <div class="nav">Suche</div>
                <g:form name="searchForm2" url="[action:'personSearch2',controller:'personen']">
                <table>
                 <tr>
                   <td>
                     Vorname:
                   </td>
                   <td>
                     <input id="searchVorname" name="searchVorname" type="text" size="30" maxlength="30">
                   </td>
                 </tr>
                  <tr>
                   <td>
                      Nachname:
                   </td>
                   <td>
                     <input id="searchNachname" name="searchNachname" type="text" size="30" maxlength="30">
                   </td>
                 </tr>
                 <tr>
                   <td colspan="2"><g:submitButton name="suchen" value="Suchen" /></td>
                 </tr>
                  <tr>
                    <td colspan="2">



                    </td>
                  </tr>
                </table>
                </g:form>
              </div>--}%

            </div>

        </div>
    </body>
</html>
