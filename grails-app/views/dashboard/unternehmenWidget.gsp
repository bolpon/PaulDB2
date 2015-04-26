<table>
      <colgroup>
        <col width="100px">
        <col width="200px">
      </colgroup>
      <thead>
        <tr>
        <th>Unternehmen</th>
        <th>Kontakt</th>
        <th>Aktion</th>
        </tr>
      </thead>
      <g:each in="${unternehmen}" status="i" var="b">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
            <td valign="top" class="name">
              <g:link controller="unternehmen" action="show" id="${b.id}">
                ${b.name}
              </g:link>
            </td>


            <%
                          Date now = new Date();
                          String c ="";
                          String msg="";

                          if(b.naechsterkontakt == NULL){
                            msg = "Kein Termin angegeben";
                            c = "";
                          }

                          else if (now.getTime()>b.naechsterkontakt.getTime()){
                            c ="error";
                            msg = "Termin überschritten";
                          }


            %>
            <td valign="top" style="text-align: left;" class="value <% println c;%>">
                    <g:formatDate format="dd.MM.yyyy" date="${b?.naechsterkontakt}" />
                    <% println msg;%>
            </td>
            <td>
             <g:link controller="kontakt" action="abgeben" params="[uid: b.id, pid: session.userperson.id]" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">
                 Kontakt abgeben
             </g:link>
            </td>

        </tr>
       </g:each>
</table>
