<%--
  Created by IntelliJ IDEA.
  User: remo
  Date: 11.04.11
  Time: 10:46
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="dashboard" />
        <g:javascript src="personen.js" />
        <g:set var="entityName" value="${message(code: 'personen.label', default: 'Bilderwand')}" />
        <title><g:message code="default.show.label" args="[entityName]" default="PAULDB2 - Bilderwand"/></title>
  </head>
  <body>
  <div class="body">
              <h1>Bilderwand</h1>

              <g:if test="${flash.message}">
              <div class="message">${flash.message}</div>
              </g:if>


               <div id="">
                <div id="mainlist" class="postenListMain">
                   <table class="">

                     <colgroup>
                        <col width="19%">
                        <col width="19%">
                        <col width="19%">
                        <col width="19%">
                        <col width="19%">

                      </colgroup>

                        <tbody>
                            <g:each in="${member}" status="i" var="member">

                            <g:if test="${i % 5==0}">
                                <tr>
                            </g:if>
                             <td class="postenListeTD">

                                <div class="bilderListe">

                                   <g:each in="${member}" var="p">
                                       <div class="bilderListeFoto">

                                                <g:link controller="personen" action="show" id="${p.id}" class="listLink"><img src="${fotolist[p.id.toString()]}" alt="" height="100"/></g:link> <br />


                                       </div>
                                       <div class="bilderListeBeschreibung">
                                            <g:link controller="personen" action="show" id="${p.id}" class="listLink">${p?.encodeAsHTML()}</g:link>

                                       </div>
                                   </g:each>

                                </div>
                             </td>


                            <g:if test="${i % 5==4}">
                                </tr>
                            </g:if>



                        </g:each>

                        </tbody>
                    </table>

                </div>
              </div>




  </div>
  </body>
</html>