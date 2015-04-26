
<%@ page import="pauldb2.Personstatus; java.text.SimpleDateFormat; pauldb2.Personen" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="dashboard" />
        <g:javascript src="personen.js" />
        <g:set var="entityName" value="${message(code: 'personen.label', default: 'Personen')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${personenInstance}">
            <div class="errors">
                <g:renderErrors bean="${personenInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${personenInstance?.id}" />
                <g:hiddenField name="version" value="${personenInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                            <%
                                boolean nichtfremd = (personenInstance.personstatus.bezeichnung != "fremd")
                            %>
                            <g:if test="${role.equals('admin')}">
                                <tr class="prop">
                                    <td valign="top" class="name"><g:message code="personen.id.label" default="Id" /></td>

                                    <td valign="top" class="value">${fieldValue(bean: personenInstance, field: "id")}</td>

                                </tr>
                            </g:if>

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
                                  <label for="vorname"><g:message code="personen.vorname.label" default="Vorname" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: personenInstance, field: 'vorname', 'errors')}">
                                    <g:textField name="vorname" maxlength="30" value="${personenInstance?.vorname}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="nachname"><g:message code="personen.nachname.label" default="Nachname" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: personenInstance, field: 'nachname', 'errors')}">
                                    <g:textField name="nachname" maxlength="30" value="${personenInstance?.nachname}" />
                                </td>
                            </tr>

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
                                  <label for="personEditGeburtsdatum"><g:message code="personen.geburtsdatum.label" default="Geburtsdatum" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: personenInstance, field: 'geburtsdatum', 'errors')}">
                                  <input name="geburtsdatum" id="personEditGeburtsdatum" class="jqDatepicker" type="text" value="<%
                                     SimpleDateFormat df = new SimpleDateFormat("dd.MM.yyyy");
                                     if (personenInstance?.geburtsdatum != null)
                                      println(df.format(personenInstance?.geburtsdatum));
                                  %>"/>
                                </td>
                            </tr>




                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="email.adresse"><g:message code="personen.email.label" default="Email*" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: personenInstance, field: 'nachname', 'errors')}">

                                   <table id="personenCreateEmailHinzuTable" class="personenCreate">
                                     <tr>
                                       <th></th>
                                       <th><a href="#" id="personenCreateEmailHinzu" onClick="personenCreateEmailHinzu();return false"><img src="/pauldb2/images/icons/plus.png" height="16" width="16"/></a></th>
                                     </tr>

                                     <g:each in="${personenInstance.emails}" var="e">
                                       <tr>
                                         <td>
                                           <g:textField name="email.adresse" size="50" maxlength="50" value="${e.mailAdresse}" />
                                           <g:hiddenField name="email.id" value="${e.id}" />
                                         </td>
                                         <td> <center><a href="#" onclick="document.getElementById('personenCreateEmailHinzuTable').deleteRow(this.parentNode.parentNode.parentNode.rowIndex);return false"><img src="/pauldb2/images/icons/busy.png" alt="Email löschen" height="16" width="16"/></a></center></td>
                                       </tr>
                                     </g:each>
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
                                        <g:each in="${personenInstance.telefon}" var="t">
                                            <tr>
                                                <td><g:textField name="telefon.nummer" maxlength="50" size="50" placeholder="Nummer" value="${t?.nummer}" />
                                                    <g:hiddenField name="telefon.id" value="${t.id}" />
                                                </td>
                                                <td>
                                                    <g:textField name="telefon.bemerkung" maxlength="50" size="50" placeholder="Bemerkung" value="${t?.bemerkung}" />
                                                </td>
                                                <td>
                                                    <center><a href="#" onclick="document.getElementById('personenCreateTelefonHinzuTable').deleteRow(this.parentNode.parentNode.parentNode.rowIndex);return false"><img src="/pauldb2/images/icons/busy.png" alt="Telefon löschen" height="16" width="16"/></a></center>
                                                </td>
                                            </tr>
                                        </g:each>
                                    </table>

                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="ressorts"><g:message code="personen.ressorts.label" default="Ressorts" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: personenInstance, field: 'ressorts', 'errors')}">
                                  <g:each status="i" in="${ressortList}" var="ressort">
                                     <g:checkBox name="ressortMitglied_${ressort.id}" value="${ressortMitglied[i]}" />  ${ressort.toString()} <br />
                                  </g:each>
                                </td>
                            </tr>



                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="bemerkung"><g:message code="personen.bemerkung.label" default="Bemerkung" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: personenInstance, field: 'bemerkung', 'errors')}">
                                    <g:textArea name="bemerkung" value="${personenInstance?.bemerkung}" />
                                </td>
                            </tr>

                            <g:if test="${nichtfremd}">
                                <tr class="prop">
                                    <td valign="top" class="name">
                                        <label for="hobbys"><g:message code="personen.hobbys.label" default="Hobbys" /></label>
                                    </td>
                                    <td valign="top" class="value ${hasErrors(bean: personenInstance, field: 'hobbys', 'errors')}">
                                        <g:textArea name="hobbys" value="${personenInstance?.hobbys}" />
                                    </td>
                                </tr>


                                <tr class="prop">
                                    <td valign="top" class="name">
                                        <label for="ausbildung"><g:message code="personen.ausbildung.label" default="Ausbildung" /></label>
                                    </td>
                                    <td valign="top" class="value ${hasErrors(bean: personenInstance, field: 'ausbildung', 'errors')}">
                                        <g:textArea name="ausbildung" value="${personenInstance?.ausbildung}" />
                                    </td>
                                </tr>

                                <tr class="prop">
                                    <td valign="top" class="name">
                                     <label for="zielestudium"><g:message code="personen.zielestudium.label" default="Ziele im Studium" /></label>
                                    </td>
                                    <td valign="top" class="value ${hasErrors(bean: personenInstance, field: 'zielestudium', 'errors')}">
                                     <g:textArea name="zielestudium" value="${personenInstance?.zielestudium}" />
                                    </td>
                                </tr>

                                <tr class="prop">
                                    <td valign="top" class="name">
                                        <label for="zielepaul"><g:message code="personen.zielepaul.label" default="Ziele bei Paul" /></label>
                                    </td>
                                    <td valign="top" class="value ${hasErrors(bean: personenInstance, field: 'zielepaul', 'errors')}">
                                        <g:textArea name="zielepaul" value="${personenInstance?.zielepaul}" />
                                    </td>
                                </tr>

                                <tr class="prop">
                                    <td valign="top" class="name">
                                        <label for="kritikpaul"><g:message code="personen.kritikpaul.label" default="Kritik an Paul" /></label>
                                    </td>
                                    <td valign="top" class="value ${hasErrors(bean: personenInstance, field: 'kritikpaul', 'errors')}">
                                        <g:textArea name="kritikpaul" value="${personenInstance?.kritikpaul}" />
                                    </td>
                                </tr>

                                <tr class="prop">
                                    <td valign="top" class="name">
                                        <label for="abschlussarbeit"><g:message code="personen.abschlussarbeit.label" default="Abschlussarbeit" /></label>
                                    </td>
                                    <td valign="top" class="value ${hasErrors(bean: personenInstance, field: 'abschlussarbeit', 'errors')}">
                                        <g:textArea name="abschlussarbeit" value="${personenInstance?.abschlussarbeit}" />
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
                                        <g:textArea name="berufslaufbahn" value="${personenInstance?.berufslaufbahn}" />
                                    </td>
                                </tr>
                            </g:if>

                                <tr class="prop">
                                    <td valign="top" class="name"><g:message code="personen.studium.label" default="Studium" /></td>

                                        <td valign="top" class="value">

                                            <ul class="noDeco">
                                            <g:each in="${personenInstance.studium}" var="s">
                                            <li> <g:link controller="studium" action="edit" id="${s.id}" class="listLink" params="['pid':personenInstance.id]">${s?.studienfach.encodeAsHTML()} </g:link> </li>
                                            <li>${s?.fakultaet?.hochschule.encodeAsHTML()}</li>	
                                            <li>${s?.status.encodeAsHTML()}</li>
                                            <li> Begonnen am: <g:formatDate format="dd.MM.yyyy" date="${s?.anfang}" /></li>
                                            <li> Schwerpunkt: ${s?.schwerpunkt.encodeAsHTML()}</li>
                                            </g:each>
                                            </ul>

                                        </td>

                                </tr>

                                <tr class="prop">
                                    <td valign="top" class="name">
                                        <!--<label for="studium.hinzu"><g:message code="studium.hinzu.label" default="Studium" /></label> -->
                                    </td>
                                    <td valign="top" class="name">
                                        <g:link controller="studium" action="create" class="listLink" params="['pid':personenInstance.id]">Studium hinzufügen</g:link>
                                    </td>
                                </tr>

                            <g:each in="${personenInstance?.adresse}" var="a">
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
