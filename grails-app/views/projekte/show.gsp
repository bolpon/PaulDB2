
<%@ page import="java.text.DecimalFormat; pauldb2.Projekte" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="dashboard" />
        <g:javascript src="projekte.js" />
        <g:set var="entityName" value="${message(code: 'projekte.label', default: 'Projekte')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>

        <div class="body">
            <h1> Detailansicht: ${fieldValue(bean: projekteInstance, field: "projektname")}</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>
                        <g:if test="${role.equals('admin')}">
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <g:message code="projekte.id.label" default="Id" />
                                </td>
                                <td valign="top" class="value">
                                    ${fieldValue(bean: projekteInstance, field: "id")}
                                </td>
                            </tr>
                        </g:if>

                        <tr class="prop">
                            <td valign="top" class="name">
                                <g:message code="projekte.projektname.label" default="Projektname" />
                            </td>
                            <td valign="top" class="value">
                                ${fieldValue(bean: projekteInstance, field: "projektname")}
                            </td>
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">
                                <g:message code="projekte.unternehmen.label" default="Unternehmen" />
                            </td>
                            <td valign="top" class="value">
                                <table class="fixWidth">
                                    <g:each in="${unternehmenList}" var="u">
                                        <tr>
                                            <td>
                                                <g:link controller="unternehmen" action="show" id="${u?.id}" class="listLink">
                                                    ${u?.encodeAsHTML()}
                                                </g:link>
                                            </td>
                                        </tr>
                                    </g:each>
                                </table>
                            </td>
                        </tr>

                        <g:if test="${ansprechpartnerList}">
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <g:message code="projekte.unternehmen.label" default="Ansprechpartner" />
                                </td>
                                <td>
                                    <table class="fixWidth">
                                        <g:each in="${ansprechpartnerList}" var="asp">
                                            <tr>
                                                <td>
                                                    <g:link controller="personen" action="show" id="${asp?.person?.id}" class="listLink">
                                                        ${asp?.person?.encodeAsHTML()}
                                                    </g:link> <br />
                                                    (<g:link controller="unternehmen" class="nonBold" action="show" id="${asp?.unternehmen?.id}">
                                                        ${asp?.unternehmen?.name}
                                                    </g:link>)
                                                </td>
                                            </tr>
                                        </g:each>
                                    </table>
                                </td>
                            </tr>
                        </g:if>


                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="projekte.anfangsdatum.label" default="Anfangsdatum" /></td>
                            
                            <td valign="top" class="value"><g:formatDate format="dd.MM.yyyy" date="${projekteInstance?.anfangsdatum}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="projekte.enddatum.label" default="Enddatum" /></td>
                            
                            <td valign="top" class="value"><g:formatDate format="dd.MM.yyyy" date="${projekteInstance?.enddatum}" /></td>
                            
                        </tr>
                    
                        <g:if test="${projekteInstance?.enddatumvertrag}">
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="projekte.enddatumvertrag.label" default="Enddatum laut Vertrag" /></td>

                                <td valign="top" class="value"><g:formatDate format="dd.MM.yyyy" date="${projekteInstance?.enddatumvertrag}" /></td>

                            </tr>
                        </g:if>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="projekte.btvertrag.label" default="BT laut Vertrag" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: projekteInstance, field: "btvertrag")}</td>
                            
                        </tr>

                        <g:if test="${projekteInstance?.btreal}">
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="projekte.btreal.label" default="BT Real" /></td>

                                <td valign="top" class="value">${fieldValue(bean: projekteInstance, field: "btreal")}</td>

                            </tr>
                        </g:if>

                        <g:if test="${projekteInstance?.tagessatz}">
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="projekte.tagessatz.label" default="Tagessatz" /></td>

                                <td valign="top" class="value">${fieldValue(bean: projekteInstance, field: "tagessatz")} <g:message code="projekte.waehrung.label" default="€" /></td>

                            </tr>
                            <g:if test="${projekteInstance?.btvertrag}">
                                <tr class="prop">
                                    <td valign="top" class="name">
                                        <g:message code="projekte.umsatz.label" default="Umsatz" />
                                    </td>
                                    <td valign="top" class="value">
                                        <%
                                            DecimalFormat df = new DecimalFormat('0.00')
                                            print df.format((projekteInstance?.tagessatz * projekteInstance?.btvertrag).round(2))
                                        %>
                                         <g:message code="projekte.waehrung.label" default="€" />
                                    </td>
                                </tr>
                            </g:if>
                        </g:if>

                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="projekte.beschreibung.label" default="Beschreibung" /></td>
                            
                            <td valign="top" class="value">
                              
                               <g:textArea readonly="readonly" name="beschreibung" value="${projekteInstance?.beschreibung}"/>
                            </td>
                            
                        </tr>


                        <g:if test="${projekteInstance?.taetigkeitsfeld}">
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="projekte.taetigkeitsfelder.label" default="Tätigkeitsfelder" /></td>

                                <td valign="top" class="value">

                                  <g:each in="${taetigkeitsfelderList}" var="tf">

                                      ${tf?.encodeAsHTML()} (<a href="todo">ähnliche finden</a>)

                                  </g:each>

                                </td>

                            </tr>
                        </g:if>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="projekte.internextern.label" default="Projektart" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: projekteInstance, field: "internextern")}</td>
                            
                        </tr>
                    
                        <g:if test="${projekteInstance?.projektentstandenam}">
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="projekte.projektentstandenam.label" default="Projekt entstanden am" /></td>

                                <td valign="top" class="value"><g:formatDate format="dd.MM.yyyy" date="${projekteInstance?.projektentstandenam}" /></td>

                            </tr>
                        </g:if>

                        <g:if test="${projekteInstance?.gbrname}">
                          <tr class="prop">
                              <td valign="top" class="name"><g:message code="projekte.gbrname.label" default="GbR Name" /></td>

                              <td valign="top" class="value">${fieldValue(bean: projekteInstance, field: "gbrname")}</td>

                          </tr>
                        </g:if>

                        <g:if test="${projekteInstance?.gbranfangsdatum}">
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="projekte.gbranfangsdatum.label" default="GbR Anmeldung" /></td>
                            
                            <td valign="top" class="value"><g:formatDate format="dd.MM.yyyy" date="${projekteInstance?.gbranfangsdatum}" /></td>
                            
                        </tr>
                        </g:if>

                        <g:if test="${projekteInstance?.gbrenddatum}">
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="projekte.gbrenddatum.label" default="GbR Abmeldung" /></td>
                            
                            <td valign="top" class="value"><g:formatDate format="dd.MM.yyyy" date="${projekteInstance?.gbrenddatum}" /></td>
                            
                        </tr>
                        </g:if>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="projekte.referenzfreigabe.label" default="Referenzfreigabe" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: projekteInstance, field: "referenzfreigabe")}</td>
                            
                        </tr>

                        <g:if test="${projekteInstance?.referenzbeschraenkung}">
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="projekte.referenzbeschraenkung.label" default="Referenzbeschränkung" /></td>

                                <td valign="top" class="value"><g:textArea name="referenzbeschraenkung" readonly="true">${fieldValue(bean: projekteInstance, field: "referenzbeschraenkung")}</g:textArea></td>

                            </tr>
                        </g:if>


                        <g:if test="${projekteInstance?.referenztext}">
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="projekte.referenztext.label" default="Referenztext" /></td>

                                <td valign="top" class="value"><g:textArea name="referenztext" readonly="true">${fieldValue(bean: projekteInstance, field: "referenztext")}</g:textArea></td>

                            </tr>
                        </g:if>

                        <tr>
                          <td>Teammitglieder</td>
                          <td>
                            <table class="tableShow">
                                 <tr>
                                   <th>Name</th>
                                   <th>Von</th>
                                   <th>Bis</th>
                                   <th>PL</th>
                                 </tr>

                                 <g:each in="${teammitgliedList}" status="ii" var="tm">
                                      <tr class="${(ii % 2) == 0 ? 'even' : 'odd'}">
                                        <td>
                                          <g:link controller="personen" action="show" id="${tm.person.id}" class="listLink">
                                            ${tm.person?.encodeAsHTML()}
                                          </g:link>
                                        </td>

                                        <td>
                                          <g:if test="${tm.von}">
                                            <g:formatDate format="dd.MM.yyyy" date="${tm.von}" />
                                          </g:if>
                                        </td>
                                        <td>
                                          <g:if test="${tm.bis}">
                                            <g:formatDate format="dd.MM.yyyy" date="${tm.bis}" />
                                          </g:if>
                                        </td>


                                        <td>
                                          <g:if test="${projektleiterList?.contains(tm.id)}">

                                                <g:if test="${!pauldb2.Projektleiter.findByTeammitglied(tm).von && !pauldb2.Projektleiter.findByTeammitglied(tm).bis}">
                                                  <center><img src="/pauldb2/images/icons/check.png" height="16" width="16" alt="yes" /></center>
                                                </g:if>
                                                <g:else>
                                                  <g:formatDate format="dd.MM.yyyy" date="${pauldb2.Projektleiter.findByTeammitglied(tm).von}" /> - <g:formatDate format="dd.MM.yyyy" date="${pauldb2.Projektleiter.findByTeammitglied(tm).bis}" />
                                                </g:else>
                                          </g:if>
                                        </td>

                                      </tr>
                                  </g:each>
                            </table>
                          </td>
                        </tr>

                        <g:if test="${freieMitarbeiterList}">
                          <tr class="prop">
                              <td valign="top" class="name"><g:message code="personen.freieMitarbeiter.label" default="Freie Mitarbeiter" /></td>

                              <td valign="top" class="value">


                               <table class="tableShow">

                                 <g:each in="${freieMitarbeiterList}" var="fm">
                                      <tr >
                                        <td class="header">
                                          <g:link controller="personen" action="show" id="${fm?.person?.id}" class="listLink">
                                            ${fm?.person?.encodeAsHTML()}
                                            
                                          </g:link>

                                          <g:if test="${!fm.von && !fm.bis}">
                                           (keine Datumsangabe)    
                                          </g:if>
                                          <g:else>
                                            <g:if test="${fm.von}">
                                            (<g:formatDate format="dd.MM.yyyy" date="${fm.von}" />
                                          </g:if>
                                          <g:if test="${fm.bis}">
                                            bis <g:formatDate format="dd.MM.yyyy" date="${fm.bis}" />)
                                          </g:if>

                                          </g:else>

                                        </td>
                                      </tr>
                                      <tr>
                                        <td>
                                         <g:textArea readonly="readonly" name="bemerkung" value="${fm?.bemerkung}"/>
                                        </td>

                                      </tr>
                                  </g:each>
                               </table>


                             </td>

                          </tr>
                        </g:if>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="projekte.coach.label" default="Coach" /></td>

                            <td valign="top" class="value"><g:link controller="personen" action="show" id="${projekteInstance?.coach?.id}">${projekteInstance?.coach?.encodeAsHTML()}</g:link></td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="projekte.projektphase.label" default="Projektphase" /></td>
                            
                            <td valign="top" class="value">${projekteInstance?.projektphase?.encodeAsHTML()}</td>
                            
                        </tr>
                    

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="projekte.projektanfrage.label" default="Projektanfrage" /></td>
                            
                            <td valign="top" class="value"><g:link controller="projektanfrage" action="show" id="${projekteInstance?.projektanfrage?.id}">${projekteInstance?.projektanfrage?.encodeAsHTML()}</g:link></td>
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${projekteInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                   <sec:ifAllGranted roles="ROLE_ADMIN"><span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span></sec:ifAllGranted>
                    

                </g:form>
            </div>

        </div>
    </body>
</html>
