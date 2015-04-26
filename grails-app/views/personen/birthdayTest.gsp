<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->


<table id="bdayTable">
  <thead>
  <tr>
  <th>Name</th>
  <th>Geburtstag</th>
  </tr>
  </thead>
    <g:each in="${personen}" status="i" var="person">
      <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
        <td>
          <g:link action="show" id="${person.person_id}">${person.vorname} ${person.nachname}</g:link>
        </td>
        <td>
        ${person.bday}
        </td>
        
        </tr>
    </g:each>
</table>
