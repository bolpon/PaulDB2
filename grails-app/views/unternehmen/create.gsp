
<%@ page import="java.text.SimpleDateFormat; pauldb2.Unternehmen" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="dashboard" />
        <g:javascript src="unternehmen.js" />
        <g:javascript src="hilfeTexte.js" />
        <g:set var="entityName" value="${message(code: 'unternehmen.label', default: 'Unternehmen')}" />
        <title><g:message code="default.create.label" args="[entityName]" default= "PaulDB2 Unternehmen anlegen"/></title>
    </head>
    <body>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" default="Unternehmen anlegen"/></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${unternehmenInstance}">
            <div class="errors">
                <g:renderErrors bean="${unternehmenInstance}" as="list" />
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
                                    <label for="oberunternehmen"><g:message code="kontakt.oberunternehmen.label" default="Oberunternehmen" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: unternehmenInstance, field: 'oberunternehmen', 'errors')}">
                                   <form id="unternehmenCreateOberunternehmen">
                                      <input type="text" name="oberunternehmen.name" id="kontaktCreateOberunternehmenInput" />
                                      <input type="hidden" name="oberunternehmen.id"id="oberunternehmenInputHidden" value=""/>
                                      <button id="unternehmenCreateOberunternehmenHilfe">Hilfe</button>
                                    </form>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="unternehmenstyp.id"><g:message code="unternehmen.unternehmenstyp.label" default="Unternehmenstyp" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: unternehmenInstance, field: 'unternehmenstyp', 'errors')}">
                                    <g:select name="unternehmenstyp.id" from="${pauldb2.Unternehmenstyp.list().sort{it.unternehmenstyp}}" optionKey="id" value="${unternehmenInstance?.unternehmenstyp?.id}"  />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="unternehmensstatus.id"><g:message code="unternehmen.unternehmensstatus.label" default="Unternehmensstatus" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: unternehmenInstance, field: 'unternehmensstatus', 'errors')}">
                                    <g:select name="unternehmensstatus.id" from="${pauldb2.Unternehmensstatus.list()}" optionKey="id" value="${unternehmenInstance?.unternehmensstatus?.id!=null ? unternehmenInstance?.bewertung?.id:2}"  />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="unternehmensbewertung.id"><g:message code="unternehmen.unternehmensbewertung.label" default="Bewertung" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: unternehmenInstance, field: 'unternehmensstatus', 'errors')}">
                                    <g:select name="unternehmensbewertung.id" from="${pauldb2.BewertungUnternehmen.list()}" optionKey="id" value="${unternehmenInstance?.bewertung?.id!=null ? unternehmenInstance?.bewertung?.id:4}"  />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="unternehmenBranche"><g:message code="unternehmen.branche.label" default="Branche" /></label>
                                </td>

                                  <td valign="top" class="value ${hasErrors(bean: unternehmenInstance, field: 'branche', 'errors')}">

                                    <div>
                                        <g:select id="unternehmenBranche" class="multiselect" name="branche" from="${posBranche}" optionKey="id" multiple="yes" size="5" value="${unternehmenInstance?.branche}" />
                                    </div>
                                    <g:link controller="branche" action="create" class="branche" >Branche hinzufügen</g:link>
                                  </td>

                            </tr>



                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="bemerkung"><g:message code="unternehmen.bemerkung.label" default="Bemerkung" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: unternehmenInstance, field: 'bemerkung', 'errors')}">
                                    <g:textArea name="bemerkung" value="${unternehmenInstance?.bemerkung}" />
                                </td>
                            </tr>
                        
                            <%-- <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="naechsterkontakt"><g:message code="unternehmen.naechsterkontakt.label" default="Nächster Kontakt" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: unternehmenInstance, field: 'naechsterkontakt', 'errors')}">

                                    <input name="naechsterkontakt" id="naechsterkontakt" class="jqDatepicker" type="text" value="<%
                                     SimpleDateFormat df = new SimpleDateFormat("dd.MM.yyyy");
                                     println(df.format(new Date()));
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

                            <tr>
                              <td>Mitarbeiter</td>
                              <td>

                                    <form id="mitarbeiter">
                                      <input class="unternehmenMitarbeiterInput" type="text" name="unternehmenCreateMHinzuTable" id="unternehmenCreateMitarbeiterInput" />
                                      <input type="hidden" id="mitarbeiterInputHidden" value=""/>
                                      <button id="createMitarbeiterHilfe">Hilfe</button>
                                    </form>
                                    
                                    <table id="unternehmenCreateMHinzuTable" class="fixWidth">
                                      <tr>
                                        <th>Name</th>
                                        <th>Position</th>
                                        <th>von</th>
                                        <th>bis</th>
                                        <th></th>
                                      </tr>
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
                                    <label for="email.adresse"><g:message code="unternehmen.email.label" default="Email" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: unternehmenInstance, field: 'nachname', 'errors')}">

                                   <table id="untenehmenCreateEmailHinzuTable" class="personenCreate">
                                     <tr>
                                       <td><g:textField name="email.adresse" maxlength="30" value="Email-Addresse" /></td>
                                       <td><g:textField name="email.bemerkung" maxlength="30" value="Bemerkung" /></td>
                                       <td> <a href="#" id="unternehmenCreateEmailHinzu" onClick="unternehmenCreateEmailHinzu();return false"><img src="/pauldb2/images/icons/plus.png" height="16" width="16"/></a></td>
                                     </tr>

                                   </table>

                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="telefon.nummer"><g:message code="telefon.nummer.label" default="Telefon" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: unternehmenInstance, field: 'telefon', 'errors')}">

                                   <table id="unternehmenCreateTelefonHinzuTable" class="personenCreate">
                                     <tr>
                                       <td><g:textField name="telefon.nummer" maxlength="30" value="Nummer" /></td>
                                       <td><g:textField name="telefon.bemerkung" maxlength="30" value="Bemerkung" /></td>
                                       <td> <a href="#" id="unternehmenCreateTelefonHinzu" onClick="unternehmenCreateTelefonHinzu();return false"><img src="/pauldb2/images/icons/plus.png" height="16" width="16"/></a></td>
                                     </tr>

                                   </table>

                                </td>
                            </tr>


                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="homepage.url"><g:message code="unternehmen.homepage.label" default="Homepage" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: unternehmenInstance, field: 'homepage', 'errors')}">

                                   <table id="unternehmenCreateHomepageHinzuTable" class="personenCreate">
                                     <tr>
                                       <td><g:textField name="homepage.url" maxlength="30" value="Url" /></td>
                                       <td><g:textField name="homepage.bemerkung" maxlength="30" value="Bemerkung" /></td>
                                       <td> <a href="#" id="unternehmenCreateHomepageHinzu" onClick="unternehmenCreateHomepageHinzu();return false"><img src="/pauldb2/images/icons/plus.png" height="16" width="16"/></a></td>
                                     </tr>

                                   </table>

                                </td>
                            </tr>

                           
                            <tr class="prop">
                            <td valign="top" class="name">
                              <label for="adresse.strasse"><g:message code="adresse.strasse.label" default="Straße" /></label>
                            </td>
                            <td valign="top" class="value ${hasErrors(bean: adresseInstance, field: 'strasse', 'errors')}">
                              <g:textField name="adresse.strasse" value="${adresseInstance?.strasse}" />
                            </td>
                          </tr>

                          <tr class="prop">
                            <td valign="top" class="name">
                              <label for="adresse.nummer"><g:message code="adresse.nummer.label" default="Nummer" /></label>
                            </td>
                            <td valign="top" class="value ${hasErrors(bean: adresseInstance, field: 'nummer', 'errors')}">
                              <g:textField name="adresse.nummer" value="${adresseInstance?.nummer}" />
                            </td>
                          </tr>

                          <tr class="prop">
                            <td valign="top" class="name">
                              <label for="adresse.plz"><g:message code="adresse.plz.label" default="PLZ" /></label>
                            </td>
                            <td valign="top" class="value ${hasErrors(bean: adresseInstance, field: 'plz', 'errors')}">
                              <g:textField name="adresse.plz" value="${adresseInstance?.plz}" />
                            </td>
                          </tr>

                          <tr class="prop">
                            <td valign="top" class="name">
                              <label for="adresse.postfach"><g:message code="adresse.postfach.label" default="Postfach" /></label>
                            </td>
                            <td valign="top" class="value ${hasErrors(bean: adresseInstance, field: 'postfach', 'errors')}">
                              <g:textField name="adresse.postfach" value="${adresseInstance?.postfach}" />
                            </td>
                          </tr>

                          <tr class="prop">
                            <td valign="top" class="name">
                              <label for="adresse.stadt"><g:message code="adresse.stadt.label" default="Stadt" /></label>
                            </td>
                            <td valign="top" class="value ${hasErrors(bean: adresseInstance, field: 'stadt', 'errors')}">
                              <g:textField name="adresse.stadt" value="${adresseInstance?.stadt}" />
                            </td>
                          </tr>

                          <tr class="prop">
                            <td valign="top" class="name">
                              <label for="adresse.land"><g:message code="adresse.land.label" default="Land" /></label>
                            </td>
                            <td valign="top" class="value ${hasErrors(bean: adresseInstance, field: 'land', 'errors')}">
                              <g:textField name="adresse.land" value="Deutschland" />
                            </td>
                          </tr>
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>

            </g:form>
        </div>


    </body>
</html>
