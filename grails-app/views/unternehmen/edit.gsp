
<%@ page import="pauldb2.Branche; java.text.SimpleDateFormat; pauldb2.Unternehmen" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="dashboard" />
        <g:javascript src="unternehmen.js" />
        <g:javascript src="hilfeTexte.js" />
        <g:set var="entityName" value="${message(code: 'unternehmen.label', default: 'Unternehmen')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[unternehmenInstance.name]" />
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
            <g:hasErrors bean="${unternehmenInstance}">
            <div class="errors">
                <g:renderErrors bean="${unternehmenInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${unternehmenInstance?.id}" />
                <g:hiddenField name="version" value="${unternehmenInstance?.version}" />
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
                                <td valign="top" class="name">
                                  <label for="name"><g:message code="unternehmen.name.label" default="Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: unternehmenInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" maxlength="100" value="${unternehmenInstance?.name}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="kurzname"><g:message code="unternehmen.kurzname.label" default="Kurzname" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: unternehmenInstance, field: 'kurzname', 'errors')}">
                                    <g:textField name="kurzname" maxlength="30" value="${unternehmenInstance?.kurzname}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="unternehmenstyp"><g:message code="unternehmen.unternehmenstyp.label" default="Unternehmenstyp" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: unternehmenInstance, field: 'unternehmenstyp', 'errors')}">
                                    <g:select name="unternehmenstyp" from="${pauldb2.Unternehmenstyp.list()}" optionKey="id" value="${unternehmenInstance?.unternehmenstyp?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="unternehmensstatus"><g:message code="unternehmen.unternehmensstatus.label" default="Unternehmensstatus" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: unternehmenInstance, field: 'unternehmensstatus', 'errors')}">
                                    <g:select name="unternehmensstatus" from="${pauldb2.Unternehmensstatus.list()}" optionKey="id" value="${unternehmenInstance?.unternehmensstatus?.id}"  />
                                </td>
                            </tr>

                            <tr>
                              <td>Oberunternehmen</td>
                              <td>

                                    <form id="oberunternehmen">
                                      <input type="text" name="oberunternehmenInput" id="unternehmenEditOberunternehmenInput" value="${fieldValue(bean: unternehmenInstance, field: "oberunternehmen")}"/>
                                      <input type="hidden" name="oberunternehmenHidden" id="oberunternehmenHidden" value=""/>
                                      <button id="unternehmenCreateOberunternehmenHilfe">Hilfe</button>
                                    </form>

                              </td>

                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="branche"><g:message code="unternehmen.branche.label" default="Branche" /></label>
                                </td>

                                  <td valign="top" class="value ${hasErrors(bean: unternehmenInstance, field: 'branche', 'errors')}">

                                    <div id="unternehmenEditBranche">
                                        <g:select id="unternehmenBetreuer" class="multiselect" name="branche" from="${Branche.list().sort{it.branche}}" optionKey="id" multiple="yes" size="5" value="${unternehmenInstance?.branche}" />
                                    </div>

                                  </td>

                            </tr>


                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="bewertung"><g:message code="unternehmen.bewertung.label" default="Bewertung" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: unternehmenInstance, field: 'unternehmensstatus', 'errors')}">
                                    <g:select name="bewertung" from="${pauldb2.BewertungUnternehmen.list()}" optionKey="id" value="${unternehmenInstance?.bewertung?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="bemerkung"><g:message code="unternehmen.bemerkung.label" default="Bemerkung" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: unternehmenInstance, field: 'bemerkung', 'errors')}">
                                    <g:textArea name="bemerkung" value="${unternehmenInstance?.bemerkung}" cols="" rows=""/>
                                </td>
                            </tr>
                           
                            <%--<tr class="prop">
                                <td valign="top" class="name">
                                  <label for="logo"><g:message code="unternehmen.logo.label" default="Logo" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: unternehmenInstance, field: 'logo', 'errors')}">
                                    <g:textField name="logo" value="${unternehmenInstance?.logo}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="veroeffentlichung"><g:message code="unternehmen.veroeffentlichung.label" default="Veröffentlichung" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: unternehmenInstance, field: 'veroeffentlichung', 'errors')}">
                                    <g:textField name="veroeffentlichung" value="${unternehmenInstance?.veroeffentlichung}" />
                                </td>
                            </tr> --%>
                            
                            <%-- <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="naechsterkontakt"><g:message code="unternehmen.naechsterkontakt.label" default="Nächster Kontakt" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: unternehmenInstance, field: 'naechsterkontakt', 'errors')}">

                                    <input name="naechsterkontakt" id="naechsterkontakt" class="jqDatepicker" type="text" value="<%
                                     SimpleDateFormat df = new SimpleDateFormat("dd.MM.yyyy");
                                     if (unternehmenInstance?.naechsterkontakt != null)
                                      println(df.format(unternehmenInstance?.naechsterkontakt));
                                  %>"/>
                                </td>
                            </tr> --%>
                          
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="kontaktnoetig"><g:message code="unternehmen.kontaktnoetig.label" default="Kontakt nötig" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: unternehmenInstance, field: 'kontaktnoetig', 'errors')}">
                                    <g:select name="kontaktnoetig" from="${unternehmenInstance.constraints.kontaktnoetig.inList}" value="${unternehmenInstance?.kontaktnoetig}" valueMessagePrefix="unternehmen.kontaktnoetig"  />
                                </td>
                            </tr>

                            <tr class="prop">
                              <td valign="top" class="name"><g:message code="unternehmen.mitarbeiter.label" default="Mitarbeiter" /></td>

                              <td valign="top" style="text-align: left;" class="value">

                                <form id="mitarbeiter">
                                      <input class="unternehmenMitarbeiterInput" type="text" name="unternehmenEditMitarbeiter" id="unternehmenUpdateMitarbeiterInput" />
                                      <input type="hidden" id="mitarbeiterInputHidden" value=""/>
                                      <button id="createMitarbeiterHilfe">Hilfe</button>
                                </form>

                                <table class="tableShow" id="unternehmenEditMitarbeiter">
                                  <th>Name</th>
                                  <th>Position</th>
                                  <th>Von</th>
                                  <th>Bis</th>
                                  <th></th>
                                  <g:each in="${mitarbeiter}" status="ii" var="m">
                                      <tr class="${(ii % 2) == 0 ? 'odd' : 'even'}">
                                        <td><g:link controller="personen" action="show" id="${m.person.id}">${m?.encodeAsHTML()}</g:link></td>
                                        <td>
                                          <g:select name="m.position" from="${pauldb2.MitarbeiterPosition.list()}" optionKey="id" value="${m?.position.id}"  />

                                        </td>
                                        <td>



                                            <input name="m.anfang" class="jqDatepicker inputKurz" type="text" value="<%
                                                        SimpleDateFormat germanDate = new SimpleDateFormat("dd.MM.yyyy");
                                                        if(m?.anfang != null && m?.anfang!=""){
                                                          println(germanDate.format(m?.anfang));
                                                        }

                                            %>"/>



                                        </td>
                                        <td>

                                            <input name="m.ende" class="jqDatepicker inputKurz" type="text" value="<%

                                                        if (m?.ende != null && m?.ende!=""){
                                                          println(germanDate.format(m?.ende));

                                                        }

                                            %>"/>


                                        </td>
                                        <td>
                                          <g:hiddenField name="m.id" value="${m.id}" />
                                          <g:hiddenField name="p.id" value="${m.person.id}" />
                                          <a href="#" onclick="document.getElementById('unternehmenEditMitarbeiter').deleteRow(this.parentNode.parentNode.rowIndex);return false"><img src="/pauldb2/images/icons/busy.png" alt="Mitarbeiter löschen" height="16" width="16"/></a>
                                        </td>
                                      </tr>


                                  </g:each>
                                </table>


                               </td>

                            </tr>



                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="betreuer"><g:message code="unternehmen.betreuer.label" default="Betreuer" /></label>
                                </td>

                                  <td valign="top" class="value ${hasErrors(bean: unternehmenInstance, field: 'betreuer', 'errors')}">

                                    <div id="ubw">
                                        <g:select id="unternehmenBetreuer" class="multiselect" name="betreuer" from="${posBetreuer}" optionKey="id" multiple="yes" size="5" value="${unternehmenInstance?.betreuer}" />
                                    </div>

                                  </td>

                            </tr>



                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="telefon.nummer"><g:message code="unternehmen.telefon.label" default="Telefon" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: unternehmenInstance, field: 'telefon', 'errors')}">

                                   <table id="unternehmenEditTelefonHinzuTable" class="personenCreateBig">
                                     <colgroup>
                                       <col width="337px">
                                       <col width="337px">
                                       <col width="21px">
                                     </colgroup>
                                     <tr>
                                       <th>Nummer</th>
                                       <th>Bemerkung</th>
                                       <th><a href="#" id="unternehmenEditTelefoneHinzu" onClick="unternehmenEditHinzu('telefon');return false"><img src="/pauldb2/images/icons/plus.png" height="16" width="16"/></a></th>
                                     </tr>

                                     <g:each in="${unternehmenInstance.telefon}" var="t">
                                       <tr>
                                         <td>
                                           <g:textField name="telefon.nummer" size="50" maxlength="50" value="${t.nummer}" />
                                           <g:hiddenField name="telefon.id" value="${t.id}" />
                                         </td>
                                         <td>
                                           <g:textField name="telefon.bemerkung" size="50" maxlength="50" value="${t.bemerkung}" />
                                         </td>
                                         <td> <center><a href="#" onclick="document.getElementById('unternehmenEditTelefonHinzuTable').deleteRow(this.parentNode.parentNode.parentNode.rowIndex);return false"><img src="/pauldb2/images/icons/busy.png" alt="Telefon löschen" height="16" width="16"/></a></center></td>
                                       </tr>
                                     </g:each>
                                   </table>

                                </td>
                            </tr>


                            <tr class="prop">

                                <td valign="top" class="name">
                                    <label for="email.nummer"><g:message code="unternehmen.mail.label" default="Email*" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: unternehmenInstance, field: 'emails', 'errors')}">

                                   <table id="unternehmenEditEmailHinzuTable" class="personenCreateBig">
                                     <colgroup>
                                       <col width="337px">
                                       <col width="337px">
                                       <col width="21px">
                                     </colgroup>
                                     <tr>
                                       <th>Email</th>
                                       <th>Bemerkung</th>
                                       <th><a href="#" id="unternehmenEditEmailHinzu" onClick="unternehmenEditHinzu('email');return false"><img src="/pauldb2/images/icons/plus.png" height="16" width="16"/></a></th>
                                     </tr>

                                     <g:each in="${unternehmenInstance.emails}" var="e">
                                       <tr>
                                         <td>
                                           <g:textField name="email.nummer" size="50" maxlength="50" value="${e.mailAdresse}" />
                                           <g:hiddenField name="email.id" value="${e.id}" />
                                         </td>
                                         <td>
                                           <g:textField name="email.bemerkung" size="50" maxlength="50" value="${e.bemerkung}" />
                                         </td>
                                         <td> <center><a href="#" onclick="document.getElementById('unternehmenEditEmailHinzuTable').deleteRow(this.parentNode.parentNode.parentNode.rowIndex);return false"><img src="/pauldb2/images/icons/busy.png" alt="Email löschen" height="16" width="16"/></a></center></td>
                                       </tr>
                                     </g:each>
                                   </table>

                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="homepage.nummer"><g:message code="unternehmen.homepage.label" default="Homepage" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: unternehmenInstance, field: 'homepages', 'errors')}">

                                   <table id="unternehmenEditHomepageHinzuTable" class="personenCreateBig">
                                     <colgroup>
                                       <col width="337px">
                                       <col width="337px">
                                       <col width="21px">
                                     </colgroup>
                                     <tr>
                                       <th>Homepage</th>
                                       <th>Bemerkung</th>
                                       <th><a href="#" id="unternehmenEditHomepagelHinzu" onClick="unternehmenEditHinzu('homepage');return false"><img src="/pauldb2/images/icons/plus.png" height="16" width="16"/></a></th>
                                     </tr>

                                     <g:each in="${unternehmenInstance.homepages}" var="h">
                                       <tr>
                                         <td>
                                           <g:textField name="homepage.nummer" size="50" maxlength="50" value="${h.url}" />
                                           <g:hiddenField name="homepage.id" value="${h.id}" />
                                         </td>
                                         <td>
                                           <g:textField name="homepage.bemerkung" size="50" maxlength="50" value="${h.bemerkung}" />
                                         </td>
                                         <td> <center><a href="#" onclick="document.getElementById('unternehmenEditHomepageHinzuTable').deleteRow(this.parentNode.parentNode.parentNode.rowIndex);return false"><img src="/pauldb2/images/icons/busy.png" alt="Homepage löschen" height="16" width="16"/></a></center></td>
                                       </tr>
                                     </g:each>
                                   </table>

                                </td>
                            </tr>

                            <g:each in="${unternehmenInstance?.adresse}" var="a">
                              <tr class="prop">
                                  <td valign="top" class="name">
                                    <label for="adresse.strasse"><g:message code="adresse.strasse.label" default="Strasse" /></label>
                                  </td>
                                  <td valign="top" class="value ${hasErrors(bean: adresseInstance, field: 'strasse', 'errors')}">
                                      <g:textField name="adresse.strasse" maxlength="50" value="${a?.strasse}" />
                                  </td>
                              </tr>

                              <tr class="prop">
                                  <td valign="top" class="name">
                                    <label for="adresse.nummer"><g:message code="adresse.nummer.label" default="Nummer" /></label>
                                  </td>
                                  <td valign="top" class="value ${hasErrors(bean: adresseInstance, field: 'nummer', 'errors')}">
                                      <g:textField name="adresse.nummer" maxlength="20" value="${a?.nummer}" />
                                  </td>
                              </tr>

                              <tr class="prop">
                                  <td valign="top" class="name">
                                    <label for="adresse.plz"><g:message code="adresse.plz.label" default="Plz" /></label>
                                  </td>
                                  <td valign="top" class="value ${hasErrors(bean: adresseInstance, field: 'plz', 'errors')}">
                                      <g:textField name="adresse.plz" maxlength="5" value="${a?.plz}" />
                                  </td>
                              </tr>

                              <tr class="prop">
                                  <td valign="top" class="name">
                                    <label for="adresse.stadt"><g:message code="adresse.stadt.label" default="Stadt" /></label>
                                  </td>
                                  <td valign="top" class="value ${hasErrors(bean: adresseInstance, field: 'stadt', 'errors')}">
                                      <g:textField name="adresse.stadt" maxlength="100" value="${a?.stadt}" />
                                  </td>
                              </tr>

                              <tr class="prop">
                                  <td valign="top" class="name">
                                    <label for="adresse.land"><g:message code="adresse.land.label" default="Land" /></label>
                                  </td>
                                  <td valign="top" class="value ${hasErrors(bean: adresseInstance, field: 'land', 'errors')}">
                                      <g:textField name="adresse.land" maxlength="25" value="${a?.land}" />
                                  </td>
                              </tr>

                              <tr class="prop">
                                  <td valign="top" class="name">
                                    <label for="adresse.postfach"><g:message code="adresse.postfach.label" default="Postfach" /></label>
                                  </td>
                                  <td valign="top" class="value ${hasErrors(bean: adresseInstance, field: 'postfach', 'errors')}">
                                      <g:textField name="adresse.postfach" maxlength="8" value="${a?.postfach}" />
                                      <g:hiddenField name="adresse.id" value="${a.id}" />
                                  </td>
                              </tr>

                            </g:each>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <g:if test="${role.equals('admin')}"><span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span></g:if>
                </div>
            </g:form>
        </div>
    </body>
</html>
