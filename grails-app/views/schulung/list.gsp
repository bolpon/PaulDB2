
<%@ page import="pauldb2.Schulung" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="dashboard" />
        <g:javascript src="schulungen.js" />
        <g:set var="entityName" value="${message(code: 'schulung.label', default: 'Schulung')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                            <g:if test="${role.equals('admin')}">
                                <g:sortableColumn property="id" title="${message(code: 'schulung.id.label', default: 'Id')}" />
                            </g:if>
                        
                            <g:sortableColumn property="bezeichnung" title="${message(code: 'schulung.bezeichnung.label', default: 'Bezeichnung')}" />
                        
                            <g:sortableColumn property="termin" title="${message(code: 'schulung.termin.label', default: 'Termin')}" />
                        
                            <g:sortableColumn property="status" title="${message(code: 'schulung.status.label', default: 'Status')}" />
                        
                            <g:sortableColumn property="beschreibung" title="${message(code: 'schulung.beschreibung.label', default: 'Beschreibung')}" />
                        
                            
                   	    
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${schulungInstanceList}" status="i" var="schulungInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                            <g:if test="${role.equals('admin')}">
                                <td><g:link action="show" id="${schulungInstance.id}">${fieldValue(bean: schulungInstance, field: "id")}</g:link></td>
                            </g:if>

                            <td><g:link action="show" id="${schulungInstance.id}">${fieldValue(bean: schulungInstance, field: "bezeichnung")}</g:link></td>
                        
                            <td><g:formatDate format="dd.MM.yyyy" date="${schulungInstance.termin}" /></td>
                        
                            <td>${fieldValue(bean: schulungInstance, field: "status")}</td>
                        
                            <td>
                              <g:if test="${schulungInstance?.beschreibung}">
                                    <g:textArea readonly="readonly" name="bemerkung" value="${schulungInstance?.beschreibung}"/>
                               </g:if>
                            </td>
                        

                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            <div class="paginateButtons">
                <g:paginate total="${schulungInstanceTotal}" params="['status':status, 'name':name, 'nachname':nachname]" />
            </div>
            </div>
            <div id="widgets" class="widgetsRight">
              <div id="widget1" class="widget">
                <div class="nav">Filter</div>
                <div id="filterform">
                  <g:form name="filterForm" url="[action:'filter',controller:'schulung']">
                      <table>
                          <tr>
                              <td>Status</td>
                              <td>
                                  <g:select name="status" from="${['intern','extern']}" optionKey="value" id="filter1" />
                              </td>
                          </tr>
                          <tr>
                              <td>Sortierung</td>
                              <td>
                                  <g:select name="order_by" from="${['Termin','Name']}" optionKey="value" id="filter2" />
                              </td>
                          </tr>
                          <tr>
                              <td>&nbsp;</td>
                              <td>
                                  <g:select name="order_by_order" from="${['absteigend','aufsteigend']}" optionValue="value" id="filter3" />
                              </td>
                          </tr>
                      </table>
                    <g:submitButton name="filter" value="Filtern" />
                  </g:form>
                </div>
              </div>

              <div id="widget2" class="widget">
                <div class="nav">Suche</div>
                <div id="searchform">
                  <g:form name="searchForm" url="[action:'suche',controller:'schulung']">
                      <table>
                          <tr>
                              <td>Suche nach</td>
                              <td>
                                  <g:select name="searchFor" from="${['Schulung','Teilnehmer']}" optionKey="value" id="searchFor" />
                              </td>
                          </tr>
                          <tr id="search1">
                              <td id="search1_name">Name</td>
                              <td>
                                  <input id="searchInput1" name="searchInput1" type="text" size="20" maxlength="30">
                              </td>
                          </tr>
                          <tr id="search2">
                              <td>Nachname</td>
                              <td>
                                  <input id="searchInput2" name="searchInput2" type="text" size="20" maxlength="30">
                              </td>
                          </tr>
                          <tr>
                              <td>Sortierung</td>
                              <td>
                                  <g:select name="order_by" from="${['Termin','Name']}" optionKey="value" id="filter2" />
                              </td>
                          </tr>
                          <tr>
                              <td>&nbsp;</td>
                              <td>
                                  <g:select name="order_by_order" from="${['absteigend','aufsteigend']}" optionValue="value" id="filter3" />
                              </td>
                          </tr>
                      </table>
                    <g:submitButton name="search" value="Suchen" />
                  </g:form>
                </div>
              </div>
        </div>
    </body>
</html>
