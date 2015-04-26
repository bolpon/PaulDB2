
<%@ page import="java.text.SimpleDateFormat; pauldb2.Personen" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="dashboard" />
        <g:javascript src="personen.js" />
        <g:set var="entityName" value="${message(code: 'personen.label', default: 'Personen')}" />
        <title><g:message code="default.create.label" args="[entityName]" default= "PaulDB2 Person anlegen"/></title>
    </head>
    <body>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" default="Person anlegen"/></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${personenInstance}">
            <div class="errors">
                <g:renderErrors bean="${personenInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:hasErrors bean="${adresseInstance}">
            <div class="errors">
                <g:renderErrors bean="${adresseInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="personstatus.id"><g:message code="personen.personstatus.label" default="Status" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: personenInstance, field: 'personstatus', 'errors')}">
                                    <g:select name="personstatus.id" from="${pauldb2.Personstatus.list()}" optionKey="id" value="${personenInstance?.personstatus?.id}"  />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="anrede"><g:message code="personen.anrede.label" default="Anrede" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: personenInstance, field: 'anrede', 'errors')}">
                                    
                                    <g:select name="anrede" from="${personenInstance.constraints.anrede.inList}" value="${personenInstance?.anrede}" valueMessagePrefix="personen.anrede"  />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="titel"><g:message code="personen.titel.label" default="Titel" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: personenInstance, field: 'titel', 'errors')}">
                                    <g:textField name="titel" maxlength="30" value="${personenInstance?.titel}" />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="vorname"><g:message code="personen.vorname.label" default="Vorname*" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: personenInstance, field: 'vorname', 'errors')}">
                                    <g:textField name="vorname" maxlength="30" value="${personenInstance?.vorname}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="nachname"><g:message code="personen.nachname.label" default="Nachname*" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: personenInstance, field: 'nachname', 'errors')}">
                                    <g:textField name="nachname" maxlength="30" value="${personenInstance?.nachname}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="personEditGeburtsdatum"><g:message code="personen.geburtsdatum.label" default="Geburtsdatum" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: personenInstance, field: 'geburtsdatum', 'errors')}">
                                    
                                  <input name="geburtsdatum" id="personEditGeburtsdatum" class="jqDatepicker" type="text" value="01.05.1990"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="email.adresse"><g:message code="personen.email.label" default="Email*" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: personenInstance, field: 'nachname', 'errors')}">

                                   <table id="personenCreateEmailHinzuTable" class="personenCreate">
                                     <tr>
                                      <th>

                                      </th>
                                      <th>
                                        <a href="#" id="personenCreateEmailHinzu" onClick="personenCreateEmailHinzu()"><img src="/pauldb2/images/icons/plus.png" height="16" width="16"/></a>
                                      </th>
                                     </tr>
                                     <tr>
                                       <td><g:textField name="email.adresse" size="50" maxlength="50" value="${personenInstance?.emails}" /></td>
                                       <td> <center><a href="#" onclick="document.getElementById('personenCreateEmailHinzuTable').deleteRow(this.parentNode.parentNode.parentNode.rowIndex);return false"><img src="/pauldb2/images/icons/busy.png" alt="Email löschen" height="16" width="16"/></a></center></td>
                                     </tr>

                                   </table>

                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="telefon.nummer"><g:message code="telefon.nummer.label" default="Telefon" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: personenInstance, field: 'telefon', 'errors')}">

                                   <table id="personenCreateTelefonHinzuTable" class="personenCreate">
                                     <tr>
                                       <th>Nummer</th>
                                       <th>Bemerkung</th>
                                       <th> <a href="#" id="personenCreateTelefonHinzu" onClick="personenCreateTelefonHinzu();return false"><img src="/pauldb2/images/icons/plus.png" height="16" width="16"/></a></th>
                                     </tr>

                                     <tr>
                                       <td><g:textField name="telefon.nummer" maxlength="50" size="50" placeholder="Nummer" value="${personenInstance?.telefon?.nummer}" /></td>
                                       <td><g:textField name="telefon.bemerkung" maxlength="50" size="50" placeholder="Bemerkung" value="${personenInstance?.telefon?.bemerkung}" /></td>
                                       <td><center><a href="#" onclick="document.getElementById('personenCreateTelefonHinzuTable').deleteRow(this.parentNode.parentNode.parentNode.rowIndex);return false"><img src="/pauldb2/images/icons/busy.png" alt="Mitarbeiter löschen" height="16" width="16"/></a></center></td>
                                     </tr>

                                   </table>

                                </td>
                            </tr>

<!--
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="bemerkung"><g:message code="personen.bemerkung.label" default="Bemerkung" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: personenInstance, field: 'bemerkung', 'errors')}">
                                    <g:textField name="bemerkung" value="${personenInstance?.bemerkung}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="zielestudium"><g:message code="personen.zielestudium.label" default="Zielestudium" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: personenInstance, field: 'zielestudium', 'errors')}">
                                    <g:textField name="zielestudium" value="${personenInstance?.zielestudium}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="zielepaul"><g:message code="personen.zielepaul.label" default="Zielepaul" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: personenInstance, field: 'zielepaul', 'errors')}">
                                    <g:textField name="zielepaul" value="${personenInstance?.zielepaul}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="kritikpaul"><g:message code="personen.kritikpaul.label" default="Kritikpaul" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: personenInstance, field: 'kritikpaul', 'errors')}">
                                    <g:textField name="kritikpaul" value="${personenInstance?.kritikpaul}" />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="abschlussarbeit"><g:message code="personen.abschlussarbeit.label" default="Abschlussarbeit" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: personenInstance, field: 'abschlussarbeit', 'errors')}">
                                    <g:textField name="abschlussarbeit" value="${personenInstance?.abschlussarbeit}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="abschlussbetreuer"><g:message code="personen.abschlussbetreuer.label" default="Abschlussbetreuer" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: personenInstance, field: 'abschlussbetreuer', 'errors')}">
                                    <g:textField name="abschlussbetreuer" value="${personenInstance?.abschlussbetreuer}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="berufslaufbahn"><g:message code="personen.berufslaufbahn.label" default="Berufslaufbahn" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: personenInstance, field: 'berufslaufbahn', 'errors')}">
                                    <g:textField name="berufslaufbahn" value="${personenInstance?.berufslaufbahn}" />
                                </td>
                            </tr>
-->



<!--
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="adresseIdAdresse"><g:message code="personen.adresse.label" default="Adresse" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: personenInstance, field: 'adresse', 'errors')}">
                                    <g:select name="adresse.id" from="${pauldb2.Adresse.list()}" optionKey="id" value="${personenInstance?.adresse?.id}"  />
                                </td>
                            </tr>
                            <tr>
                              <td></td>
                              <td> <input type="button" name="huhu" value="Neue Adresse hinzufügen" onclick="addAddress();" /></td>

                            </tr>
                            <tr>
                              <td></td>
                              <td><div style="display:none;" id="newAddress"></div></td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="hobbys"><g:message code="personen.hobbys.label" default="Hobbys" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: personenInstance, field: 'hobbys', 'errors')}">
                                    <g:textField name="hobbys" value="${personenInstance?.hobbys}" />
                                </td>
                            </tr>
 -->

                          <tr class="prop">
                            <td valign="top" class="name">
                              <label for="strasse"><g:message code="adresse.strasse.label" default="Straße*" /></label>
                            </td>
                            <td valign="top" class="value ${hasErrors(bean: adresseInstance, field: 'strasse', 'errors')}">
                              <g:textField name="strasse" value="${adresseInstance?.strasse}" />
                            </td>
                          </tr>

                          <tr class="prop">
                            <td valign="top" class="name">
                              <label for="nummer"><g:message code="adresse.nummer.label" default="Nummer*" /></label>
                            </td>
                            <td valign="top" class="value ${hasErrors(bean: adresseInstance, field: 'nummer', 'errors')}">
                              <g:textField name="nummer" value="${adresseInstance?.nummer}" />
                            </td>
                          </tr>

                          <tr class="prop">
                            <td valign="top" class="name">
                              <label for="plz"><g:message code="adresse.plz.label" default="PLZ*" /></label>
                            </td>
                            <td valign="top" class="value ${hasErrors(bean: adresseInstance, field: 'plz', 'errors')}">
                              <g:textField name="plz" value="${adresseInstance?.plz}" />
                            </td>
                          </tr>

                          <tr class="prop">
                            <td valign="top" class="name">
                              <label for="stadt"><g:message code="adresse.stadt.label" default="Stadt*" /></label>
                            </td>
                            <td valign="top" class="value ${hasErrors(bean: adresseInstance, field: 'stadt', 'errors')}">
                              <g:textField name="stadt" value="${adresseInstance?.stadt}" />
                            </td>
                          </tr>

                          <tr class="prop">
                            <td valign="top" class="name">
                              <label for="land"><g:message code="adresse.land.label" default="Land*" /></label>
                            </td>
                            <td valign="top" class="value ${hasErrors(bean: adresseInstance, field: 'land', 'errors')}">
                              <g:textField name="land" value="Deutschland" />
                            </td>
                          </tr>
                    </tbody>
                    </table>
                </div>
                <div class="buttons">
                        <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Anlegen')}" /></span>
                </div>

                
            </g:form>
        </div>
    </body>
</html>
