<%@ page import="pauldb2.Unternehmen" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="dashboard" />
        <g:javascript src="unternehmen.js" />
        <g:set var="entityName" value="${message(code: 'unternehmen.label', default: 'Unternehmen')}" />
        <title>PAULDB2 - ${fieldValue(bean: unternehmenInstance, field: "name")}</title>
    </head>
    <body>
        
        <div class="body">
            <h1><g:message code="default.show.label" args="[unternehmenInstance.name]" />
			    <span class="scoring"><g:link action="show" id="${unternehmenInstance.id}">${unternehmenInstance.unternehmensscoring}-Kunde</g:link></span>
				
				<span class="scoring">
				    <g:if test="${unternehmenInstance.letzterkontakt}">
				        <g:link controller="kontakt" action="show" id="${unternehmenInstance.letzterkontakt.id}">Letzter Kontakt: ${unternehmenInstance.letzterkontakt.kontaktscoring ?: 'nicht bewertet'}</g:link>
				    </g:if>
				    <g:else>bisher kein Kontakt</g:else>
				</span>
			</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>
                        <g:if test="${role.equals('admin')}">
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="unternehmen.id.label" default="Id" /></td>

                                <td valign="top" class="value">${fieldValue(bean: unternehmenInstance, field: "id")}</td>

                            </tr>
                        </g:if>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="unternehmen.name.label" default="Name" /></td>
                            
                            <td valign="top" class="value"> ${fieldValue(bean: unternehmenInstance, field: "name")} (${fieldValue(bean: unternehmenInstance, field: "kurzname")})</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="unternehmen.unternehmenstyp.label" default="Unternehmenstyp" /></td>

                            <td valign="top" class="value">${fieldValue(bean: unternehmenInstance, field: "unternehmenstyp")}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="unternehmen.unternehmensstatus.label" default="Unternehmensstatus" /></td>

                            <td valign="top" class="value">${fieldValue(bean: unternehmenInstance, field: "unternehmensstatus")}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="unternehmen.oberunternehmen.label" default="Teil von" /></td>

                            <td valign="top" class="value"><g:link action="show" id="${unternehmenInstance?.oberunternehmen?.id}">${fieldValue(bean: unternehmenInstance, field: "oberunternehmen")}</g:link></td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="unternehmen.subunternehmen.label" default="Subunternehmen" /></td>

                            <td valign="top" class="value">

                              <ul class="noDeco">
                                <g:each in="${subunternehmenList}" var="s">
                                    <li><g:link action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>

                            </td>

                         </tr>


                         <tr class="prop">
                            <td valign="top" class="name"><g:message code="unternehmen.branche.label" default="Branche" /></td>

                            <td valign="top" class="value">

                              <ul class="noDeco">
                                <g:each in="${unternehmenInstance.branche}" var="b">
                                    <li>${b?.encodeAsHTML()}</li>
                                </g:each>
                                </ul>

                            </td>

                         </tr>




                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="unternehmen.kontakte.label" default="Kontakte" /></td>

                            <td valign="top" style="text-align: left;" class="value">
                               <button id="unternehmenShowKontakteButtonShow"> Anzeigen</button>
                               <!--<button id="unternehmenShowKontakteButtonHinzu"> Neuer Kontakt</button>-->
                               <div id="unternehmenShowKontakte">
                               <% int i = 0;%>
                                  <table class="unternehmenKontakt">
                                    <tr>

                                       <g:each in="${kontakteList}" var="k">
                                          <td>
                                            <table class="unternehmenKontaktEinzeln">
                                              <tr class="unternehmenKontaktHeading">
                                                <td colspan="2"><strong><g:formatDate format="dd.MM.yyyy" date="${k?.datum}" /></strong>
                                                  <span style="float:right"><g:link class="whiteLink" controller="kontakt" action="edit" id="${k.id}">Bearbeiten</g:link></span>
                                                </td>

                                              </tr>
                                              <tr>
                                                <td><strong>Paulis</strong></td>
                                                <td><strong>Unternehmer</strong></td>
                                              </tr>
                                              <tr>
                                                <td>
                                                  <g:if test="${k.personen}">
                                                    <ul class="noDeco">
                                                      <g:each in="${k.personen}" var="p">
                                                          <li>${p.toString()}</li>
                                                       </g:each>
                                                      </ul>
                                                   </g:if>
                                                </td>
                                                <td>
                                                  <g:if test="${k.mitarbeiter}">
                                                    <ul class="noDeco">
                                                      <g:each in="${k.mitarbeiter}" var="m">
                                                        <li>${m.toString()}</li>
                                                      </g:each>
                                                    </ul>
                                                   </g:if>
                                                </td>
                                              </tr>
                                              <tr>
                                                <td colspan="2">
                                                  <g:textArea readonly="readonly" name="beschreibung" value="${k?.beschreibung}"/>
                                                </td>
                                              </tr>
                                              <tr class="unternehmenFooter">
                                                <td><strong>Kontaktart:</strong> ${k?.kontaktart}</td>
                                                <td><strong>Kontaktzweck:</strong> ${k?.kontaktzweck}</td>
                                              </tr>
                                            </table>


                                          </td>


                                          <%
                                             i+=1;
                                             if(i%2==0){
                                               println("</tr><tr>");
                                             }
                                          %>

                                       </g:each>

                                    </tr>
                                  </table>
                                </div>
                            </td>

                        </tr>

                        <%
                          Date now = new Date();
                          String c = "huh";
                          if (now>unternehmenInstance?.naechsterkontakt)
                            c ="error";

                        %>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="unternehmen.naechsterkontakt.label" default="Nächster Kontakt" /></td>

                            <td valign="top" class="value <% println c;%>"><g:formatDate format="dd.MM.yyyy" date="${unternehmenInstance?.naechsterkontakt}" /></td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="unternehmen.kontaktnoetig.label" default="Kontakt nötig" /></td>

                            <td valign="top" class="value">${fieldValue(bean: unternehmenInstance, field: "kontaktnoetig")}</td>

                        </tr>


                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="unternehmen.bemerkung.label" default="Bemerkung" /></td>
                            
                            <td valign="top" class="value"><g:textArea readonly="readonly" name="bemerkung" value="${unternehmenInstance?.bemerkung}"/></td>
                            
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="unternehmen.bewertung.label" default="Bewertung" /></td>

                            <td valign="top" class="value">${fieldValue(bean: unternehmenInstance, field: "bewertung")}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="unternehmen.telefon.label" default="Telefon" /></td>

                            <td valign="top" class="value">

                              <ul class="noDeco">
                                <g:each in="${unternehmenInstance.telefon}" var="t">
                                    <li>${t?.encodeAsHTML()}</li>
                                </g:each>
                                </ul>

                            </td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="unternehmen.homepage.label" default="Homepage" /></td>

                            <td valign="top" class="value">

                              <ul class="noDeco">
                                <g:each in="${unternehmenInstance.homepages}" var="h">
                                    <li>${h?.url?.encodeAsHTML()}</li>

                                        <g:if test="${h?.bemerkung}">
                                            - ${h?.bemerkung?.encodeAsHTML()}
                                        </g:if>
                                    </li>
                                </g:each>
                                </ul>

                            </td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="unternehmen.email.label" default="Email" /></td>

                            <td valign="top" class="value">

                              <ul class="noDeco">
                                <g:each in="${unternehmenInstance.emails}" var="e">
                                    <li><a href="mailto:${e?.mailAdresse?.encodeAsHTML()}">${e?.mailAdresse?.encodeAsHTML()}</a>
                                        <g:if test="${e?.bemerkung}">
                                            - ${e?.bemerkung.encodeAsHTML()}
                                        </g:if>
                                    </li>
                                </g:each>
                                </ul>

                            </td>

                        </tr>


                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="unternehmen.adresse.label" default="Adresse" /></td>

                            <td valign="top" class="value">${unternehmenInstance?.adresse?.encodeAsHTML()}</td>

                        </tr>

                        <!--
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="unternehmen.logo.label" default="Logo" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: unternehmenInstance, field: "logo")}</td>
                            
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="unternehmen.veroeffentlichung.label" default="Veroeffentlichung" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: unternehmenInstance, field: "veroeffentlichung")}</td>
                            
                        </tr>
                        -->

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="unternehmen.betreuer.label" default="Betreuer" /></td>

                            <td valign="top" style="text-align: left;" class="value">
                                <ul class="noDeco">
                                <g:each in="${unternehmenInstance.betreuer}" var="b">
                                    <li><g:link controller="personen" action="show" id="${b.id}">${b?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>

                        </tr>


                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="unternehmen.mitarbeiter.label" default="Mitarbeiter" /></td>

                            <td valign="top" style="text-align: left;" class="value">

                                <table class="tableShow">
                                  <tr>
                                     <th>Name</th>
                                     <th>Position</th>
                                     <th>Von</th>
                                     <th>Bis</th>
                                  </tr>

                                  <g:each in="${mitarbeiter}" status="ii" var="m">
                                      <tr class="${(ii % 2) == 0 ? 'odd' : 'even'}">
                                        <td><g:link controller="personen" action="show" id="${m.person.id}">${m?.encodeAsHTML()}</g:link></td>
                                        <td>${m.position}</td>
                                        <td><g:formatDate format="dd.MM.yyyy" date="${m.anfang}" /></td>
                                        <td><g:formatDate format="dd.MM.yyyy" date="${m.ende}" /></td>
                                      </tr>
                                    
                                  </g:each>
                                </table>


                            </td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="unternehmen.projekte.label" default="Projekte" /></td>

                            <td valign="top" style="text-align: left;" class="value">

                                <table class="tableShow">
                                  <tr>
                                    <th>Name</th>
                                    <th>Status</th>
                                    <th>Von</th>
                                    <th>Bis</th>
                                  </tr>
                                  <g:each in="${projekteList}" status="iii" var="pl">
                                      <tr class="${(iii % 2) == 0 ? 'odd' : 'even'}">
                                        <td><g:link controller="projekte" action="show" id="${pl?.id}">${pl?.encodeAsHTML()}</g:link></td>
                                        <td>${pl.projektphase}</td>
                                        <td><g:formatDate format="dd.MM.yyyy" date="${pl.anfangsdatum}" /></td>
                                        <td><g:formatDate format="dd.MM.yyyy" date="${pl.enddatum}" /></td>
                                      </tr>

                                  </g:each>
                                </table>


                            </td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="unternehmen.projektanfragen.label" default="Projektanfragen" /></td>

                            <td valign="top" style="text-align: left;" class="value">

                                <table class="tableShow">
                                  <tr>
                                    <th>Bezeichnung</th>
                                  </tr>
                                  <g:each in="${unternehmenInstance.projektanfragen}" status="iii" var="panf">
                                      <tr class="${(iii % 2) == 0 ? 'odd' : 'even'}">
                                        <td><g:link controller="projektanfrage" action="show" id="${panf?.id}">${panf?.encodeAsHTML()}</g:link></td>
                                      </tr>

                                  </g:each>
                                </table>


                            </td>

                        </tr>



                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="unternehmen.letzteaktualisierung.label" default="Letzte Aktualisierung" /></td>

                            <td valign="top" class="value"><g:formatDate format="dd.MM.yyyy 'um' HH:mm 'Uhr' " date="${unternehmenInstance?.letzteaktualisierung}" /></td>

                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${unternehmenInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <sec:ifAllGranted roles="ROLE_ADMIN"><span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span></sec:ifAllGranted>
                </g:form>
            </div>
        </div>
    </body>
</html>
