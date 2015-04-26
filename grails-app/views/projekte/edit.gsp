
<%@ page import="java.text.SimpleDateFormat; pauldb2.Projekte" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="dashboard" />
        <g:javascript src="projekte.js" />
        <g:javascript src="hilfeTexte.js" />
        <g:set var="entityName" value="${message(code: 'projekte.label', default: 'Projekte')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${projekteInstance}">
            <div class="errors">
                <g:renderErrors bean="${projekteInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${projekteInstance?.id}" />
                <g:hiddenField name="version" value="${projekteInstance?.version}" />
                <g:hiddenField name="plTmId" value="${projektleiter?.teammitglied?.id}" />
                <g:hiddenField name="plId" value="${projektleiter?.id}" />
                <div class="dialog">
                    <table>
                        <tbody>
                            <g:if test="${role.equals('admin')}">
                                <tr class="prop">
                                    <td valign="top" class="name">
                                        <g:message code="projekte.id.label" default="Id" />
                                    </td>
                                    <td valign="top" class="value">
                                        ${projekteInstance?.id}
                                    </td>
                                </tr>
                            </g:if>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="projektname"><g:message code="projekte.projektname.label" default="Projektname" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projekteInstance, field: 'projektname', 'errors')}">
                                    <g:textField name="projektname" maxlength="80" value="${projekteInstance?.projektname}" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <g:message code="projekte.unternehmen.label" default="Unternehmen" />
                                </td>
                                <td>
                                    <input type="text" name="unternehmenInput" id="projektCreateUnternehmenInput" />
                                    <input type="hidden" id="unternehmenInputHidden" value=""/>
                                    <button id="unternehmenCreateHilfe">Hilfe</button>
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name"></td>
                                <td valign="top" class="value">
                                    <table id="projektCreateUHinzuTable" class="fixWidth" style="width:500">
                                        <tr>
                                            <th>Name des Unternehmens</th>
                                            <th><a href="#" onclick="updateAnsprechpartner()"><img src="/pauldb2/images/icons/refresh.png" width="16" height="16" alt="löschen" </a></th>
                                        </tr>
                                        <g:each in="${projekteInstance.unternehmen}" var="u">
                                            <tr>
                                                <td>
                                                    <g:textField name="uName" value="${u.name}" style="width:450" readonly="true" class="unternehmen" />
                                                    <g:hiddenField name="uID" value="${u.id}" style="width:450" readonly="true" class="unternehmen_id" />
                                                </td>
                                                <td>
                                                    <a href="#" onclick="document.getElementById('projektCreateUHinzuTable').deleteRow(this.parentNode.parentNode.rowIndex);updateAnsprechpartner();return false"><img src="/pauldb2/images/icons/busy.png" width="16" height="16" alt="löschen" </a>


                                                </td>
                                            </tr>
                                        </g:each>
                                    </table>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="ansprechpartner"><g:message code="projekte.ansprechpartner.label" default="Ansprechpartner" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projekteInstance, field: 'mitarbeiter', 'errors')}">
                                    <g:select id="ansprechpartner" class="multiselect" name="projektAnsprechpartner" from="${mitarbeiter}" optionKey="id" multiple="yes" size="5" value="${projekteInstance?.ansprechpartner}" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="anfangsdatum"><g:message code="projekte.anfangsdatum.label" default="Anfangsdatum" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projekteInstance, field: 'anfangsdatum', 'errors')}">
                                    <input name="anfangsdatum" id="anfangsdatum" class="jqDatepicker" type="text" value="<%
                                     SimpleDateFormat germanDate = new SimpleDateFormat("dd.MM.yyyy");
                                     if (projekteInstance?.anfangsdatum != null)
                                      println(germanDate.format(projekteInstance?.anfangsdatum));
                                  %>"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="enddatum"><g:message code="projekte.enddatum.label" default="Enddatum" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projekteInstance, field: 'enddatum', 'errors')}">
                                    <input name="enddatum" id="enddatum" class="jqDatepicker" type="text" value="<%
                                     if (projekteInstance?.enddatum != null)
                                      println(germanDate.format(projekteInstance?.enddatum));
                                  %>"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="enddatumvertrag"><g:message code="projekte.enddatumvertrag.label" default="Enddatum laut Vertrag" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projekteInstance, field: 'enddatumvertrag', 'errors')}">
                                    <input name="enddatumvertrag" id="enddatumvertrag" class="jqDatepicker" type="text" value="<%
                                     if (projekteInstance?.enddatumvertrag != null)
                                      println(germanDate.format(projekteInstance?.enddatumvertrag));
                                  %>"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="btvertrag"><g:message code="projekte.btvertrag.label" default="BT laut Vertrag" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projekteInstance, field: 'btvertrag', 'errors')}">
                                    <g:textField name="btvertrag" value="${fieldValue(bean: projekteInstance, field: 'btvertrag')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="btreal"><g:message code="projekte.btreal.label" default="BT Real" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projekteInstance, field: 'btreal', 'errors')}">
                                    <g:textField name="btreal" value="${fieldValue(bean: projekteInstance, field: 'btreal')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="tagessatz"><g:message code="projekte.tagessatz.label" default="Tagessatz" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projekteInstance, field: 'tagessatz', 'errors')}">
                                    <g:textField name="tagessatz" value="${fieldValue(bean: projekteInstance, field: 'tagessatz')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="beschreibung"><g:message code="projekte.beschreibung.label" default="Beschreibung" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projekteInstance, field: 'beschreibung', 'errors')}">
                                    <g:textArea name="beschreibung" value="${projekteInstance?.beschreibung}" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name" >
                                    <label for="taetigkeitsfelder"><g:message code="projekte.taetigkeitsfelder.label" default="Tätigkeitsfelder" /></label>
                                </td>
                                <td valign="top" class="value">
                                    <table class="fixWidth600" style="width:600" name="tableTaetigkeitsfelder" id="tableTaetigkeitsfelder">
                                        <tr>
                                            <th>Tätkeitscluster</th>
                                            <th>Tätigkeitsfeld</th>
                                            <th><center><a href="#" id="projekteTaetigkeitsfelderHinzu" onClick="projekteTaetigkeitsfelderHinzu();return false;"><img src="/pauldb2/images/icons/plus.png" height="16" width="16"/></a></center></th>
                                        </tr>
                                        <% int taetFelderNum = 1; %>
                                        <g:each in="${projekteInstance?.taetigkeitsfeld}" var="tf">
                                            <tr>
                                                <td>
                                                    <g:select class="Taetigkeitscluster" id="${taetFelderNum}" name="taetigkeitsCluster" optionKey="id" optionValue="bezeichnung" from="${pauldb2.Taetigkeitscluster.list()}" value="${tf?.cluster.id}" style="width:250" />
                                                </td>
                                                <td>
                                                    <g:select class="Taetigkeitsfelder" id="feld${taetFelderNum}" name="taetigkeitsFelder" optionKey="id" optionValue="bezeichnung" from="${pauldb2.Taetigkeitsfeld.findAllByCluster(tf?.cluster)}" value="${tf?.id}" style="width:250" />
                                                </td>
                                                <td>
                                                    <a href="#" id="projekteTaetigkeitsfelderHinzu" onClick="document.getElementById('tableTaetigkeitsfelder').deleteRow(this.parentNode.parentNode.rowIndex);return false"><img src="/pauldb2/images/icons/busy.png" height="16" width="16"/></a>
                                                </td>
                                            </tr>
                                            <% taetFelderNum++; %>
                                        </g:each>
                                    </table>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="internextern"><g:message code="projekte.internextern.label" default="Projektart" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projekteInstance, field: 'internextern', 'errors')}">
                                    <g:select name="internextern" from="${projekteInstance?.constraints?.internextern.inList}" value="${projekteInstance?.internextern}" valueMessagePrefix="projekte.internextern"  />
                                </td>
                            </tr>


                            <tr>

                              <td>Teammitglieder</td>
                              <td>

                                <div >
                                <table class="fixWidth600" id="divTeammitglieder">
                                  <colgroup>
                                     <col width="120">
                                     <col width="85">
                                     <col width="85">
                                     <col width="70">
                                     <col width="100">
                                     <col width="100">
                                    
                                  </colgroup>
                                  <tr>
                                        <th>Name</th>
                                        <th>Von</th>
                                        <th>Bis</th>
                                        <th>Leiter</th>
                                        <th>Von</th>
                                        <th>Bis</th>
                                  </tr>

                                    <%
                                      int count = 0;
                                    %>
                                    <g:each in="${projekteInstance?.tm}" var="tm">

                                      <tr>
                                        <td>
                                          ${tm?.person}
                                          <g:hiddenField name="tmId" value="${tm?.id}" />

                                        </td>
                                        <td>
                                          <input name="tmVon" class="jqDatepicker inputKurz" type="text" value="<%

                                            if (tm?.von != null)
                                            println(germanDate.format(tm?.von));
                                          %>"/>

                                        </td>
                                        <td><input name="tmBis" class="jqDatepicker inputKurz" type="text" value="<%

                                              if (tm?.bis != null){
                                                println(germanDate.format(tm?.bis));
                                              }
                                            %>"/>
                                        </td>
                                        <td>
                                          <g:if test="${projektleiter?.teammitglied?.id == tm?.id}">
                                            <g:radio name="plGroup" value="${tm?.id}" checked="checked"/>

                                          </g:if>
                                          <g:else>
                                            <g:radio name="plGroup" value="${tm?.id}"/>
                                            
                                          </g:else>

                                        </td>

                                      <%
                                        if(count==0){
                                      %>
                                      <td>
                                        <input name="plVon" class="jqDatepicker inputKurz" type="text" value="<%

                                            if (projektleiter?.von != null)
                                            println(germanDate.format(projektleiter?.von));
                                          %>"/>
                                      </td>
                                      <td>
                                          <input name="plBis" class="jqDatepicker inputKurz" type="text" value="<%

                                            if (projektleiter?.bis != null)
                                            println(germanDate.format(projektleiter?.bis));
                                          %>"/>
                                      </td>
                                      <%
                                        }
                                        else{
                                      %>
                                      <td></td>
                                      <td></td>
                                      <%
                                        }
                                        count++;
                                      %>

                                    </g:each>
                                <tr>
                                  <td colspan ="4">
                                    <button id="projekteEditTmHinzu">Teammitglieder hinzufügen/löschen</button>
                                  </td>
                                </tr>
                                </table>
                               </div>
                              </td>

                            </tr>


                            <tr>

                              <td>Freie Mitarbeiter</td>
                              <td>

                                <div >
                                <table class="fixWidth600" id="divFreieMitarbeiter">
                                  <colgroup>
                                     <col width="120">
                                     <col width="85">
                                     <col width="85">
                                     <col width="270">

                                  </colgroup>
                                  <tr>
                                        <th>Name</th>
                                        <th>Von</th>
                                        <th>Bis</th>
                                        <th>Beschreibung</th>
                                  </tr>
                                    <g:each in="${freieMitarbeiterList}" var="fma">

                                      <tr>
                                        <td>
                                          ${fma?.person}
                                          <g:hiddenField name="fmaId" value="${fma?.id}" />
                                        </td>
                                        <td>
                                          <input name="fmaVon"  class="jqDatepicker inputKurz" type="text" value="<%

                                            if (fma?.von != null)
                                            println(germanDate.format(fma?.von));
                                          %>"/>

                                        </td>
                                        <td><input name="fmaBis"  class="jqDatepicker inputKurz" type="text" value="<%

                                              if (fma?.bis != null){
                                                println(germanDate.format(fma?.bis));
                                              }
                                            %>"/>
                                        </td>
                                        <td>
                                          <g:textArea class="small" name="fmaBemerkung" value="${fma?.bemerkung}" />

                                        </td>
                                      </tr>

                                    </g:each>
                                <tr>
                                  <td colspan ="4">
                                    <button id="projekteEditFMAHinzu">FMA hinzufügen/löschen</button>
                                  </td>
                                </tr>
                                </table>
                               </div>
                              </td>

                            </tr>





                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="coach.id"><g:message code="projekte.coach.label" default="Coach" /></label>
                                </td>

                                  <td valign="top" class="value ${hasErrors(bean: projekteInstance, field: 'coach', 'errors')}">

                                    <input type="text" name="coachInput" id="projekteEditCoach" value="${projekteInstance?.coach}"/>
                                    <input type="hidden" name="coach.id" id="projekteEditCoachHidden" value="${projekteInstance?.coach?.id}"/>

                                  </td>

                            </tr>


                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="projektentstandenam"><g:message code="projekte.projektentstandenam.label" default="Projekt entstanden am" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projekteInstance, field: 'projektentstandenam', 'errors')}">
                                    <input name="projektentstandenam" id="projektentstandenam" class="jqDatepicker" type="text" value="<%
                                     SimpleDateFormat pea = new SimpleDateFormat("dd.MM.yyyy");
                                     if (projekteInstance?.projektentstandenam != null)
                                      println(pea.format(projekteInstance?.projektentstandenam));
                                  %>"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="gbrname"><g:message code="projekte.gbrname.label" default="GbR Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projekteInstance, field: 'gbrname', 'errors')}">
                                    <g:textField name="gbrname" maxlength="80" value="${projekteInstance?.gbrname}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="gbranfangsdatum"><g:message code="projekte.gbranfangsdatum.label" default="GbR Anmeldung" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projekteInstance, field: 'gbranfangsdatum', 'errors')}">
                                    <input name="gbranfangsdatum" id="gbranfangsdatum" class="jqDatepicker" type="text" value="<%
                                     SimpleDateFormat gan = new SimpleDateFormat("dd.MM.yyyy");
                                     if (projekteInstance?.gbranfangsdatum != null)
                                      println(gan.format(projekteInstance?.gbranfangsdatum));
                                  %>"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="gbrenddatum"><g:message code="projekte.gbrenddatum.label" default="GbR Abmeldung" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projekteInstance, field: 'gbrenddatum', 'errors')}">
                                    <input name="gbrenddatum" id="gbrenddatum" class="jqDatepicker" type="text" value="<%
                                     SimpleDateFormat gab = new SimpleDateFormat("dd.MM.yyyy");
                                     if (projekteInstance?.gbrenddatum != null)
                                      println(gab.format(projekteInstance?.gbrenddatum));
                                  %>"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="referenzfreigabe"><g:message code="projekte.referenzfreigabe.label" default="Referenzfreigabe" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projekteInstance, field: 'referenzfreigabe', 'errors')}">
                                    <g:select name="referenzfreigabe" from="${projekteInstance?.constraints?.referenzfreigabe?.inList}" value="${projekteInstance?.referenzfreigabe}" valueMessagePrefix="projekte.referenzfreigabe"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="referenzbeschraenkung"><g:message code="projekte.referenzbeschraenkung.label" default="Referenzbeschränkung" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projekteInstance, field: 'referenzbeschraenkung', 'errors')}">
                                    <g:textArea name="referenzbeschraenkung" value="${projekteInstance?.referenzbeschraenkung}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="referenztext"><g:message code="projekte.referenztext.label" default="Referenztext" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projekteInstance, field: 'referenztext', 'errors')}">
                                    <g:textArea name="referenztext" value="${projekteInstance?.referenztext}" />
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="projektphase.id"><g:message code="projekte.projektphase.label" default="Projektphase" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projekteInstance, field: 'projektphase', 'errors')}">
                                    <g:select name="projektphase.id" from="${pauldb2.Projektphase.list()}" optionKey="id" value="${projekteInstance?.projektphase?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="projektanfrage.id"><g:message code="projekte.projektanfrage.label" default="Projektanfrage" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projekteInstance, field: 'projektanfrage', 'errors')}">
                                    <g:select name="projektanfrage.id" optionKey="id" from="${anfrageListe}" value="${projekteInstance?.projektanfrage?.id}"  />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <g:if test="${role.equals('admin')}"><span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span></g:if>
                </div>
            </g:form>

            <div id="dialog-form">
              <p style="padding-top:20px;">
              <g:select id="teammitglieder" class="multiselect" name="teammitglieder" from="${posTeammitglieder}" optionKey="id" multiple="yes" size="5" value="${projekteInstance?.tm?.person}" />
              </p>
              <g:hiddenField name="projektIdAJAX" value="${projekteInstance?.id}" />
            </div>
            <div id="dialog-form-fma">
              <p style="padding-top:20px;">
              <g:select id="fmaDialog" class="multiselect" name="fmaDialog" from="${posTeammitglieder}" optionKey="id" multiple="yes" size="5" value="${freieMitarbeiterList?.person}" />
              </p>

            </div>

            
        </div>
    </body>
</html>
