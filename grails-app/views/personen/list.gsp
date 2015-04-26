
<%@ page import="pauldb2.Personen" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="dashboard" />
        <g:javascript src="personen.js" />
        <g:set var="entityName" value="${message(code: 'personen.label', default: 'Personen')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
  
        


        </head>
    <body>
  
        <div class="body">
            <h1>Personen</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>


            <div id="listContent">
              <div id="mainlist" class="list">
                 <table class="tableList">

                   <colgroup>
                      <col width="7%">
                      <col width="8%">
                      <col width="12%">
                      <col width="12%">
                      <col width="30%">
                      <col width="30%">
                    </colgroup>


                     <thead>
                          <tr>
                          <sec:ifAllGranted roles="ROLE_ADMIN">
                              <g:sortableColumn property="id" params="['personstatus':opt, 'searchVorname':params.searchVorname, 'searchNachname':params.searchNachname]" title="${message(code: 'personen.id.label', default: 'Id')}" />
                          </sec:ifAllGranted>
                              <g:sortableColumn property="anrede" params="['personstatus':opt, 'searchVorname':params.searchVorname, 'searchNachname':params.searchNachname]" title="${message(code: 'personen.anrede.label', default: 'Anrede')}" />

                              <g:sortableColumn property="vorname" params="['personstatus':opt, 'searchVorname':params.searchVorname, 'searchNachname':params.searchNachname]" title="${message(code: 'personen.vorname.label', default: 'Vorname')}" />

                              <g:sortableColumn property="nachname" params="['personstatus':opt, 'searchVorname':params.searchVorname, 'searchNachname':params.searchNachname]" title="${message(code: 'personen.nachname.label', default: 'Nachname')}" />



                              <th class="sortable"> Email </th>

                              <th class="sortable"> Telefon </th>
                          </tr>
                      </thead>
                      <tbody>
                      <g:each in="${personenInstanceList}" status="i" var="personenInstance">
                          <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                              <sec:ifAllGranted roles="ROLE_ADMIN">
                                <td><g:link action="show" id="${personenInstance.id}">${fieldValue(bean: personenInstance, field: "id")}</g:link></td>
                              </sec:ifAllGranted>

                              <td>${fieldValue(bean: personenInstance, field: "anrede")}</td>

                              <td><g:link action="show" id="${personenInstance.id}">${fieldValue(bean: personenInstance, field: "vorname")}</g:link></td>

                              <td><g:link action="show" id="${personenInstance.id}">${fieldValue(bean: personenInstance, field: "nachname")}</g:link></td>



                              <td>

                                <ul class="noDeco">
                                  <g:each in="${personenInstance.emails}" var="e">
                                      <li><a href="mailto:${e?.encodeAsHTML()}">${e?.encodeAsHTML()}</a></li>
                                  </g:each>
                                </ul>

                              </td>

                              <td>

                                <ul class="noDeco">
                                  <g:each in="${personenInstance.telefon}" var="t">
                                      <li>${t?.encodeAsHTML()}</li>
                                  </g:each>
                                </ul>

                              </td>

                          </tr>
                      </g:each>
                      </tbody>
                  </table>
                <div class="paginateButtons">
                  <g:paginate total="${personenInstanceTotal}" params="['personstatus':opt, 'searchVorname':params.searchVorname, 'searchNachname':params.searchNachname]"/>
                </div>
              </div>

              <div id="widgets" class="widgetsRight">
              <div id="widget1" class="widget">
                <div class="nav">Filter</div>
                <div id="searchform">
                  <g:form name="searchForm" url="[action:'personSearch',controller:'personen']">
                    <g:select name="personstatus" from="${pauldb2.Personstatus.list()}" optionKey="id" value="" id="filter1"  />
                    <br />
                    <g:submitButton name="filter" value="Filtern" />
                  </g:form>
                  <!-- Ajax Variante -->
                  <!--<button onClick="filter()">Filter</button> -->
                </div>
              </div>
              <span style="clear:both"></span>

              <div id="widget2" class="widget">
               <div class="nav">Suche</div>
                <g:form name="searchForm2" url="[action:'personSearch2',controller:'personen']">
                <table>
                 <tr>
                   <td>
                     Vorname:
                   </td>
                   <td>
                     <input id="searchVorname" name="searchVorname" type="text" size="20" maxlength="30">
                   </td>
                 </tr>
                  <tr>
                   <td>
                      Nachname:
                   </td>
                   <td>
                     <input id="searchNachname" name="searchNachname" type="text" size="20" maxlength="30">
                   </td>
                 </tr>
                 <tr>
                   <td colspan="2"><g:submitButton name="suchen" value="Suchen" /></td>
                 </tr>

                </table>
                </g:form>
              </div>

            </div>
            </div>
            
        </div>
    </body>
</html>
