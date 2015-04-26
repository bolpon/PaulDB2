<table>
      <colgroup>
        <col width="100px">
        <col width="50px">
        <col width="100px">

      </colgroup>
      <thead>
       <tr>
        <th>Name</th>

        <th>Status</th>
        <th>Fällig Bis</th>

       </tr>
      </thead>
       <g:each in="${aufgabenVerwaltenList}" status="i" var="a">
          <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
              <td valign="top" class="name">
                <g:link controller="aufgabe" action="show" id="${a.id}">
                  ${a.name}
                </g:link>

              </td>

              <td>
                ${a?.status}
              </td>

              <%
                            c ="";
                            msg = "";

                            now = new Date();
                            if (now.getTime()>a.end.getTime()){
                              c ="error";
                              msg = "Termin überschritten";
                            }

                            if(a.end == NULL){
                              msg = "Kein Termin angegeben";
                              c = "";
                            }
              %>
              <td valign="top" style="text-align: left;" class="value <% println c;%>">
                      <g:formatDate format="dd.MM.yyyy" date="${a?.end}" />
                      <% println msg;

                      %>
              </td>



          </tr>
       </g:each>



</table>
