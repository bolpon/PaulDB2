<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="layout" content="person" />
    <title>Person suchen</title>
  </head>
  <body>

    <div id="personSearch">
      <fieldset>
        <legend>Personensuche</legend>
        <table>
          <tr>
            <td>Status<td>
            <td>
              <select name="personStatus">
                <option>Anwärter</option>
                <option>Paulaner</option>
                <option>Paulumni</option>
                <option>Externer</option>
              </select>
            </td>
          </tr>
          <tr>
            <td>Vorname<td>
            <td><input type="text" name="personForeName"/><td>
          </tr>
          <tr>
            <td>Nachname<td>
            <td><input type="text" name="personSurName"/><td>
          </tr>
          <tr>
            <td>wasweißich<td>
            <td><input type="text" name="personBla"/><td>
          </tr>
          <tr>
            <td>und noch was<td>
            <td><input type="text" name="personBlubb"/><td>
          </tr>
        </table>
      </fieldset>
    </div>
  </body>
</html>
