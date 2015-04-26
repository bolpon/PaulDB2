
<%@ page import="pauldb2.Unternehmen; pauldb2.Unternehmensscoring; pauldb2.Kontaktscoring" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="dashboard" />
        <g:javascript src="unternehmen.js" />
        <g:set var="entityName" value="${message(code: 'unternehmen.label', default: 'Unternehmen')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" default="Unternehmen" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                            <% // Nicht benötigte Parameter aus dem Query-String bereinigen
							    def cleanedParams = params
								cleanedParams.remove('filter')
								cleanedParams.remove('max')
						    %>
                        
                            <sec:ifAllGranted roles="ROLE_ADMIN">
                                <g:sortableColumn property="id" params="${cleanedParams}" title="${message(code: 'unternehmen.id.label', default: 'Id')}" />
                            </sec:ifAllGranted>

                            <g:sortableColumn property="name" params="${cleanedParams}" title="${message(code: 'unternehmen.name.label', default: 'Name')}" />
                        
                            <g:sortableColumn property="kurzname" params="${cleanedParams}" title="${message(code: 'unternehmen.kurzname.label', default: 'Kurzname')}" />
							
							<g:sortableColumn property="naechsterkontakt" params="${cleanedParams}" title="${message(code: 'unternehmen.naechsterkontakt.label', default: 'Nächster Kontakt')}" />
							
							<g:sortableColumn property="unternehmensscoring" params="${cleanedParams}" title="${message(code: 'unternehmen.scoring.label', default: 'Scoring')}" />						
                                                        
                            <%--<g:sortableColumn property="letzteaktualisierung" params="${cleanedParams}" title="${message(code: 'unternehmen.letzteaktualisierung.label', default: 'Letzte Aktualisierung')}" />--%>
                        
                            <g:sortableColumn property="bemerkung" params="${cleanedParams}" title="${message(code: 'unternehmen.bemerkung.label', default: 'Bemerkung')}" />
                        </tr>
                    </thead>
                    <tbody>

                    <g:each in="${unternehmenInstanceList}" status="i" var="unternehmenInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                            <sec:ifAllGranted roles="ROLE_ADMIN">
                                <td><g:link action="show" id="${unternehmenInstance.id}">${unternehmenInstance.id}</g:link></td>
                            </sec:ifAllGranted>

                            <td><g:link action="show" id="${unternehmenInstance.id}">${unternehmenInstance.name}</g:link></td>
                        
                            <td><g:link action="show" id="${unternehmenInstance.id}">${unternehmenInstance.kurzname}</g:link></td>
                        	
                            <td${(unternehmenInstance?.naechsterkontakt < new Date()) ? ' class="error"' : ''}><g:link action="show" id="${unternehmenInstance.id}"><g:formatDate format="dd.MM.yyyy" date="${unternehmenInstance.naechsterkontakt}" /></g:link></td>
                        	
							<td><g:link action="show" id="${unternehmenInstance.id}">${unternehmenInstance.unternehmensscoring} ${unternehmenInstance?.letzterkontakt?.kontaktscoring}</g:link></td>
							                            
							<%--<td><g:formatDate format="dd.MM.yyyy" date="${unternehmenInstance.letzteaktualisierung}" /></td>--%>
                            						
                            <td>
                               <g:if test="${unternehmenInstance?.bemerkung}">
                                    <g:textArea  readonly="readonly" name="bemerkung" style='width: 230px; height: 100px;' value="${unternehmenInstance?.bemerkung}"/>
                               </g:if>
                            </td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            <div class="paginateButtons">
                <g:paginate total="${unternehmenInstanceTotal}" params="['unternehmenName':params.unternehmenName,'unternehmensscoring':params.unternehmensscoring,'kontaktscoring':params.kontaktscoring]" />
            </div>
            </div>

            <div id="widgets" class="widgetsRight">
            
             <!--
              <div id="widget1" class="widget">
              <div class="nav">Filter</div>
              <div id="searchform">
                <g:form name="searchForm" url="[action:'personSearch',controller:'personen']">
                  <g:select name="personstatus" from="${pauldb2.Personstatus.list()}" optionKey="id" value="" id="filter1"  />
                  <br />
                  <g:submitButton name="filter" value="Filtern" />
                </g:form>

              </div>
              </div>
              -->
              <div id="widget2" class="widget">
               <div class="nav">Suche</div>
                <g:form name="searchForm2" url="[action:'unternehmenSearch2',controller:'unternehmen']">
                <table>
                 <tr>
                   <td>
                     Name:
                   </td>
                   <td>
                     <input name="unternehmenName" type="text" size="20" maxlength="30">
                   </td>
                 </tr>

                 <!--<tr>
                   <td>
                     whatsoever:
                   </td>
                   <td>
                     <input name="whatsoever" type="text" size="20" maxlength="30">
                   </td>
                 </tr>-->
                 <tr>
                   <td colspan="2"><g:submitButton name="suchen" value="Suchen" /></td>
                 </tr>
                </table>
                </g:form>
              </div>


              <div id="widget1" class="widget">
                <div class="nav">Filter</div>
                <div id="filterform">
                  <g:form name="filterForm" url="[action:'filter',controller:'unternehmen']">
                      <table>
                          <tr>
                              <td>Unternehmensbewertung</td>
                              <td>
                                  <g:select name="unternehmensscoring" noSelection="${['': '-']}" from="${Unternehmensscoring.list()}" value="${params.unternehmensscoring}" optionKey="bezeichnung" valueKey="bezeichnung" id="filter1" />
                              </td>
                          </tr>
                          <tr>
                              <td>Kontaktbewertung</td>
                              <td>
                                  <g:select name="kontaktscoring" noSelection="${['': '-']}" from="${Kontaktscoring.list()}" value="${params.kontaktscoring}" optionKey="bezeichnung" valueKey="bezeichnung" id="filter2" />
                              </td>
                          </tr>
                          
                          <!-- <tr>
                              <td>Sortieren</td>
                              <td>
                                  <g:select name="sort" from="${['Nächster Kontakt','Späteste Kontakt']}" optionKey="value" id="filter3" />
                              </td>
                          </tr>-->
                      </table>
                    <g:submitButton name="filter" value="Filtern" />
                  </g:form>
                </div>
              </div>

            </div>

        </div>
    </body>
</html>
