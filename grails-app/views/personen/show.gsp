
<%@ page import="pauldb2.Personen" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="dashboard" />
        <g:javascript src="personen.js" />
        <g:set var="entityName" value="${message(code: 'personen.label', default: 'Personen')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="body">
            <h1>Details zu ${fieldValue(bean: personenInstance, field: "vorname")} ${fieldValue(bean: personenInstance, field: "nachname")}</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">

                <div id="personenShowFoto">
                     <img id="personenShowFotoImg" src="${linkfoto}" alt="portrait" title="Zum Ändern Klicken" />
                </div>
                <div>
                <table>
                    <tbody>
                        <g:if test="${role.equals('admin')}">
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="personen.id.label" default="Id" /></td>

                                <td valign="top" class="value">${fieldValue(bean: personenInstance, field: "id")}</td>

                            </tr>
                        </g:if>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="personen.Name.label" default="Name" /></td>

                            <td valign="top" class="value">
                              (${fieldValue(bean: personenInstance, field: "anrede")})
                              <g:if test="${personenInstance?.titel}">
                              ${fieldValue(bean: personenInstance, field: "titel")}
                              </g:if>
                              ${fieldValue(bean: personenInstance, field: "vorname")} ${fieldValue(bean: personenInstance, field: "nachname")}
                            </td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="personen.personstatus.label" default="Status" /></td>

                            <td valign="top" class="value">${personenInstance?.personstatus?.encodeAsHTML()}</td>

                        </tr>

                        <g:if test="${personenInstance?.posten}">
                        <tr class="prop">
                            <td valign="top" class="name">
                                <g:message code="personen.posten.label" default="Posten" />
                            </td>
                            <td valign="top" class="value">
                                <ul class="noDeco">
                                    <g:each in="${personenInstance?.posten}" var="posten">
                                        <li>${posten?.postenName}</li>
                                    </g:each>
                                </ul>
                            </td>

                        </tr>
                        </g:if>

                        <g:if test="${personenInstance.mitarbeiter}">

                          <tr class="prop">
                            <td valign="top" class="name"><g:message code="personen.unternehmen.label" default="Unternehmen" /></td>

                            <td valign="top" class="value">

                              <ul class="noDeco">
                                <g:each in="${personenInstance?.mitarbeiter?.unternehmen}" var="u">
                                  <li><g:link controller="unternehmen" action="show" id="${u?.id}" class="listLink">${u?.encodeAsHTML()}</g:link></li>
                                </g:each>
                              </ul>

                            </td>

                          </tr>

                          <tr class="prop">
                            <td valign="top" class="name"><g:message code="personen.mitarbeiterPosition.label" default="Position" /></td>

                            <td valign="top" class="value">

                              <ul class="noDeco">
                                <g:each in="${personenInstance?.mitarbeiter?.position}" var="position">
                                  <li>${position?.encodeAsHTML()}</li>
                                </g:each>
                              </ul>
                            </td>

                          </tr>
                        </g:if>

                        <g:if test="${teammitgliedList}">
                          <tr class="prop">
                              <td valign="top" class="name"><g:message code="personen.projekte.label" default="Projekte" /></td>

                              <td valign="top" class="value">


                               <table class="tableShow">
                                <tr>
                                 <th>Name</th>
                                 <th>Von</th>
                                 <th>Bis</th>
                                 <th>Leiter</th>
                                </tr>
                                 <g:each in="${teammitgliedList}" status="ii" var="tm">
                                      <tr class="${(ii % 2) == 0 ? 'even' : 'odd'}">
                                        <td>
                                          <g:link controller="projekte" action="show" id="${tm.projekt.id}" class="listLink">
                                            ${tm.projekt?.encodeAsHTML()}
                                          </g:link>
                                        </td>

                                        <td>
                                          <g:if test="${tm.von}">
                                            von: <g:formatDate format="dd.MM.yyyy" date="${tm.von}" />
                                          </g:if>
                                        </td>
                                        <td>
                                          <g:if test="${tm.bis}">
                                            bis: <g:formatDate format="dd.MM.yyyy" date="${tm.bis}" />
                                          </g:if>
                                        </td>
                                        <td>
                                          <g:if test="${plMap[tm.id]}">
                                            <center><img src="/pauldb2/images/icons/check.png" height="16" width="16" alt="yes" /></center>
                                          </g:if>

                                        </td>

                                      </tr>
                                  </g:each>
                               </table>


                             </td>

                          </tr>
                        </g:if>

                         <g:if test="${freieMitarbeiterList}">
                          <tr class="prop">
                              <td valign="top" class="name"><g:message code="personen.freieMitarbeiter.label" default="Freier Mitarbeiter" /></td>

                              <td valign="top" class="value">


                               <table class="tableShow">
                                
                                 <g:each in="${freieMitarbeiterList}" var="fm">
                                      <tr >
                                        <td class="header">
                                          <g:link controller="projekte" action="show" id="${fm?.projekt?.id}" class="listLink">
                                            ${fm?.projekt?.encodeAsHTML()}
                                          </g:link>
                                          <g:if test="${fm.von}">
                                            (<g:formatDate format="dd.MM.yyyy" date="${fm.von}" />
                                          </g:if>
                                          <g:if test="${fm.bis}">
                                            bis <g:formatDate format="dd.MM.yyyy" date="${fm.bis}" />)
                                          </g:if>
                                        </td>
                                      </tr>
                                      <tr>
                                        <td>
                                         <g:textArea readonly="readonly" name="bemerkung" value="${fm?.bemerkung}"/>
                                        </td>
                                           <%
                                             
                                           %>
                                      </tr>
                                  </g:each>
                               </table>


                             </td>

                          </tr>
                        </g:if>


                        <g:if test="${personenInstance?.coachProjekte}">
                          <tr class="prop">
                              <td valign="top" class="name"><g:message code="personen.coachProjekte.label" default="Coach" /></td>

                              <td valign="top" class="value">

                                <ul class="noDeco">
                                  <g:each in="${personenInstance.coachProjekte}" var="cp">
                                      <li><g:link controller="projekte" action="show" id="${cp.id}" class="listLink">${cp?.encodeAsHTML()}</g:link></li>
                                  </g:each>
                                  </ul>

                              </td>

                          </tr>
                        </g:if>

                        <g:if test="${beutreuteUnternehmenList}">

                          <tr class="prop">
                              <td valign="top" class="name"><g:message code="personen.betreuteUnternehmen.label" default="betreute Unternehmen" /></td>

                              <td valign="top" class="value">

                                <ul class="noDeco">
                                  <g:each in="${beutreuteUnternehmenList}" var="bu">
                                      <li><g:link controller="unternehmen" action="show" id="${bu.id}" class="listLink">${bu?.encodeAsHTML()}</g:link></li>
                                  </g:each>
                                  </ul>

                              </td>

                          </tr>
                        </g:if>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="personen.email.label" default="Email" /></td>

                            <td valign="top" class="value">

                              <ul class="noDeco">
                                <g:each in="${personenInstance.emails}" var="e">
                                    <li><a href="mailto:${e?.encodeAsHTML()}">${e?.encodeAsHTML()}</a></li>
                                </g:each>
                                </ul>

                            </td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="personen.adresse.label" default="Adresse" /></td>

                            <td valign="top" class="value">
                              ${personenInstance?.adresse?.encodeAsHTML()}
                            </td>
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="personen.geburtsdatum.label" default="Geburtsdatum" /></td>

                            <td valign="top" class="value"><g:formatDate format="dd.MM.yyyy" date="${personenInstance?.geburtsdatum}" /></td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="personen.telefon.label" default="Telefon" /></td>

                            <td valign="top" class="value">

                              <ul class="noDeco">
                                <g:each in="${personenInstance.telefon}" var="t">
                                    <li>${t?.encodeAsHTML()}</li>
                                </g:each>
                              </ul>

                            </td>

                        </tr>

                        <g:if test="${personenInstance?.hobbys}">
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="personen.hobbys.label" default="Hobbys" /></td>
                            
                            <td valign="top" class="value">
                              <g:if test="${personenInstance?.hobbys}">
                                    <g:textArea readonly="readonly" name="hobbys" value="${personenInstance?.hobbys}"/>
                               </g:if>
                             </td>
                            
                        </tr>
                        </g:if>

                        <g:if test="${personenInstance?.ausbildung}">
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="personen.ausbildung.label" default="Ausbildung" /></td>
                            
                            <td valign="top" class="value">
                              <g:if test="${personenInstance?.ausbildung}">
                                    <g:textArea readonly="readonly" name="ausbildung" value="${personenInstance?.ausbildung}"/>
                               </g:if>
                             </td>
                            
                        </tr>
                        </g:if>
                        <!--
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="personen.visitenkarte.label" default="Visitenkarte" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: personenInstance, field: "visitenkarte")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="personen.foto.label" default="Foto" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: personenInstance, field: "foto")}</td>
                            
                        </tr>
                        -->

                        <g:if test="${personenInstance?.bemerkung}">
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="personen.bemerkung.label" default="Bemerkung" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: personenInstance, field: "bemerkung")}</td>
                            
                        </tr>
                        </g:if>


                        <tr class="prop">
                              <td valign="top" class="name"><g:message code="personen.studium.label" default="Studium" /></td>

                              <td valign="top" class="value">

                                <ul class="noDeco">
                                  <g:each in="${personenInstance.studium}" var="s">
                                      <li>${s?.studienfach.encodeAsHTML()}</li>
                                      <li>${s?.fakultaet?.hochschule.encodeAsHTML()}</li>
                                      <li>${s?.status.encodeAsHTML()}</li>
                                      <li> Begonnen am: <g:formatDate format="dd.MM.yyyy" date="${s?.anfang}" /></li>
                                      <li> Schwerpunkt: ${s?.schwerpunkt.encodeAsHTML()}</li>
                                  </g:each>
                                  </ul>

                              </td>

                          </tr>

                        <g:if test="${personenInstance?.zielestudium}">
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="personen.zielestudium.label" default="Ziele im Studium" /></td>
                            
                            <td valign="top" class="value">
                              <g:if test="${personenInstance?.zielestudium}">
                                    <g:textArea readonly="readonly" name="zielestudium" value="${personenInstance?.zielestudium}"/>
                               </g:if>
                             </td>
                            
                        </tr>
                        </g:if> 

                        <tr class="prop">
                              <td valign="top" class="name"><g:message code="personen.schulungen.label" default="Schulungen" /></td>

                              <td valign="top" class="value">

                                <table class="fixWidth">

                                  <tr>
                                    <th>Schulung</th>
                                    <th>Datum</th>
                                  </tr>
                                  <g:each in="${personenInstance.schulungen}" status="ii" var="s">

                                      <tr class="${(ii % 2) == 0 ? 'even' : 'odd'}">
                                        <td> <g:link controller="schulung" action="show" id="${s.id}" class="listLink">${s?.encodeAsHTML()}</g:link></td>
                                        <td> <g:formatDate format="dd.MM.yyyy" date="${s?.termin}" /> </td>
                                      </tr>
                                  </g:each>
                                </table>
                              </td>

                        </tr>

                        <g:if test="${personenInstance.geleiteteSchulungen}">

                          <tr class="prop">
                                <td valign="top" class="name"><g:message code="personen.geleiteteSchulungen.label" default="geleitete Schulungen" /></td>

                                <td valign="top" class="value">

                                  <table class="fixWidth">

                                    <tr>
                                      <th>Schulung</th>
                                      <th>Datum</th>
                                    </tr>
                                    <g:each in="${personenInstance.geleiteteSchulungen}" status="ii" var="s">

                                        <tr class="${(ii % 2) == 0 ? 'even' : 'odd'}">
                                          <td> <g:link controller="schulung" action="show" id="${s.id}" class="listLink">${s?.encodeAsHTML()}</g:link></td>
                                          <td> <g:formatDate format="dd.MM.yyyy" date="${s?.termin}" /> </td>
                                        </tr>
                                    </g:each>
                                  </table>
                                </td>

                          </tr>
                        </g:if>

                        <g:if test="${personenInstance?.zielepaul}">
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="personen.zielepaul.label" default="Ziele bei PAUL" /></td>
                            
                            <td valign="top" class="value">
                              <g:if test="${personenInstance?.zielepaul}">
                                    <g:textArea readonly="readonly" name="zielepaul" value="${personenInstance?.zielepaul}"/>
                               </g:if>
                             </td>
                            
                        </tr>
                        </g:if>

                        <g:if test="${personenInstance?.kritikpaul}">
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="personen.kritikpaul.label" default="Kritik an PAUL" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: personenInstance, field: "kritikpaul")}</td>
                            
                        </tr>
                        </g:if>


                        <g:if test="${personenInstance?.abschlussarbeit}">
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="personen.abschlussarbeit.label" default="Abschlussarbeit" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: personenInstance, field: "abschlussarbeit")}</td>
                            
                        </tr>
                        </g:if>

                        <g:if test="${personenInstance?.abschlussbetreuer}">
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="personen.abschlussbetreuer.label" default="Abschlussbetreuer" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: personenInstance, field: "abschlussbetreuer")}</td>
                            
                        </tr>
                        </g:if>

                        <g:if test="${personenInstance?.berufslaufbahn}">
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="personen.berufslaufbahn.label" default="Berufslaufbahn" /></td>
                            
                            <td valign="top" class="value">
                              <g:if test="${personenInstance?.berufslaufbahn}">
                                    <g:textArea readonly="readonly" name="berufslaufbahn" value="${personenInstance?.berufslaufbahn}"/>
                               </g:if>
                             </td>
                            
                        </tr>
                        </g:if> 


                        <g:if test="${historyList}">
                          <tr class="prop">
                              <td valign="top" class="name"><g:message code="personen.Historie.label" default="Historie" /></td>

                              <td valign="top" class="value">


                               <table class="tableShow">
                                <tr>
                                 <th>Status</th>
                                 <th>Von</th>
                                 <th>Bis</th>
                                 <th>Ressort</th>
                                </tr>
                                 <g:each in="${historyList}" status="ii" var="hl">
                                      <tr class="${(ii % 2) == 0 ? 'even' : 'odd'}">
                                        <td>
                                          <g:if test="${hl.personstatus}">
                                            ${hl.personstatus.bezeichnung}
                                          </g:if>
                                        </td>

                                        <td>
                                          <g:if test="${hl.von}">
                                            von: <g:formatDate format="dd.MM.yyyy" date="${hl.von}" />
                                          </g:if>
                                        </td>
                                        <td>
                                          <g:if test="${hl.bis}">
                                            bis: <g:formatDate format="dd.MM.yyyy" date="${hl.bis}" />
                                          </g:if>
                                        </td>

                                        <td>
                                          <g:if test="${hl.postenressort}">
                                            ${hl.postenressort.toString()}
                                          </g:if>
                                        </td>
                                      </tr>
                                  </g:each>
                               </table>


                             </td>

                          </tr>
                        </g:if>


                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="personen.letzteaktualisierung.label" default="Letzte Aktualisierung" /></td>

                            <td valign="top" class="value"><g:formatDate format="dd.MM.yyyy ' um ' HH:mm ' Uhr'" date="${personenInstance?.letzteaktualisierung}" /></td>
                        </tr>


                    </tbody>
                </table>
                </div>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${personenInstance?.id}" />
                    <g:if test="${idZul}"><span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span></g:if>
                    <sec:ifAllGranted roles="ROLE_ADMIN"><span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span></sec:ifAllGranted>
                </g:form>
            </div>
        </div>
        <g:if test="${idZul}">
        <div id="personShowUploadFotoDialog">

             <h2> Bitte wähle ein Foto aus und klicke auf 'senden'.</h2>

              <br /><br />
              <g:form action="fotoUpload" method="post" enctype="multipart/form-data">
                  <input type="file" name="myFile" />  <br /> <br />
                  <g:hiddenField name="fotoId" value="${personenInstance?.id}" />
                  <input type="submit" />
              </g:form>

        </div>
        </g:if>
    </body>
</html>
