<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="layout" content="dashboard" />
    <title>PAULDB2 Dashboard</title>
  </head>
  <body>
    <div id="mainContent">

      <div id="dashWidgets">

          <div id="aufgaben"  class="dashWidget2">
            <h2>Verwaltete Aufgaben</h2>
            <g:include controller="dashboard" action="aufgabenVerwaltenWidget" />
            <h2>Zu bearbeitende Aufgaben</h2>
            <g:include controller="dashboard" action="aufgabenBearbeitenWidget" />
          </div>



          <div id="unternehmen"  class="dashWidget2">
            <h2>Betreute Unternehmen</h2>
            <g:include controller="dashboard" action="unternehmenWidget" />

          </div>

          <div id="bday"  class="dashWidget1">
            <h2>Geburtstage</h2>
            <g:include controller="personen" action="birthdayTest" />

          </div>

      </div>
    </div>
  </body>
</html>
