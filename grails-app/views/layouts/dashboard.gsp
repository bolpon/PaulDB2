<html>
    <head>
        <title><g:layoutTitle default="PaulDb2" /></title>
        <link rel="stylesheet" href="${resource(dir:'css',file:'main.css')}" />
        <link rel="stylesheet" href="${resource(dir:'css',file:'jquery-ui-1.8.11.custom.css')}" />
        <link rel="shortcut icon" href="${resource(dir:'images',file:'favicon.ico')}" type="image/x-icon" />
        <g:javascript src="jquery/jquery-1.5.2.min.js" />
        <g:javascript src="jquery-ui-1.8.11.custom.min.js" />
        <g:javascript src="global.js" />
        <g:javascript src="ui.multiselect.js" />


<g:layoutHead />
        
        
    </head>

    <body>
        <div id="heading">
           <span style="font-size: 26; color: #fff">PAUL DB2</span>
           <div id="perMenu">

             <g:if test="${session.userperson}">
              <g:link action="show" controller="personen" id="${session.userperson.id}">Profil</g:link>
             </g:if>

             <a href="${createLink(uri: '/logout')}" >Abmelden</a>
           </div>
        </div>

         <div id="headNavigation" class="nav">
              <div id="headmenu" >

              <ul>
                <li><a href="${createLink(uri: '/dashboard')}" >Start</a></li>
                <li>
                  <a href ="${createLink(uri: '/personen/listMemberOnly')}">Personen</a>
                  <ul>
                    <li><a href="${createLink(uri: '/personen/list')} ">Alle anzeigen</a></li>
                    <li><a href="${createLink(uri: '/personen/create')}">Anlegen</a></li>
                    <li><a href="${createLink(uri: '/personen/postenliste')}">Postenliste</a></li>
                    <sec:ifAllGranted roles="ROLE_ADMIN"><li><a href="${createLink(uri: '/personen/postenzuordnung')}">Postenzuordnung</a></li></sec:ifAllGranted>
                    <li><a href="${createLink(uri: '/personen/bilderwand')}">Bilderwand</a></li>
                    <li><a href="${createLink(uri: '/personen/telefonverzeichnis')}">Telefonverzeichnis</a></li>

                  </ul>
                </li>
                <li> <a href="${createLink(uri: '/unternehmen/list')} ">Unternehmen</a>
                  <ul>
                    <li><a href="${createLink(uri: '/unternehmen/list')} ">Alle anzeigen</a></li>
                    <li><a href="${createLink(uri: '/unternehmen/create')}">Anlegen</a></li>
                    <li><a href="${createLink(uri: '/unternehmen/ohneBetreuer')}">Ohne Betreuer</a></li>
                    <li><a href="${createLink(uri: '/unternehmen/inaktiveBetreuer')}">Inaktive Betreuer</a></li>
                    <sec:ifAllGranted roles="ROLE_ADMIN"><li><a href="${createLink(uri: '/branche/list')} ">Branchen</a></li>></sec:ifAllGranted>
                  </ul>
                </li>
                <li>
                  <a href="${createLink(uri: '/projekte/list')} ">Projekte</a>
                  <ul>
                    <li><a href="${createLink(uri: '/projektanfrage/list')} ">Anfragen anzeigen</a></li>
                    <li><a href="${createLink(uri: '/projektanfrage/create')} ">Anfrage anlegen</a></li>
                    <li><a href="${createLink(uri: '/projekte/list')} ">Projekte anzeigen</a></li>
                    <li><a href="${createLink(uri: '/projekte/create')} ">Projekt anlegen</a></li>
                  </ul>
                </li>
                <li>
                  <a href="${createLink(uri: '/kontakt/list')} ">Kontakte</a>
                  <ul>
                    <li><a href="${createLink(uri: '/kontakt/list')} ">Alle anzeigen</a></li>
                    <li><a href="${createLink(uri: '/kontakt/create')} ">Anlegen</a></li>
                    <sec:ifAllGranted roles="ROLE_ADMIN"><li><a href="${createLink(uri: '/kontakt/nameUpdate')}" >KontakteNeuBennenen</a></li></sec:ifAllGranted>
                  </ul>
                </li>
                <li>
                  <a href="${createLink(uri: '/schulung/list')} ">Schulungen</a>
                  <ul>
                    <li><a href="${createLink(uri: '/schulung/list')} ">Alle anzeigen</a></li>
                    <li><a href="${createLink(uri: '/schulung/create')} ">Anlegen</a></li>
                  </ul>
                </li>
                <li>
                  <a href="${createLink(uri: '/aufgabe/list')} ">Aufgaben</a>
                  <ul>
                    <li><a href="${createLink(uri: '/aufgabe/list')} ">Alle anzeigen</a></li>
                    <li><a href="${createLink(uri: '/aufgabe/create')} ">Anlegen</a></li>
                  </ul>
                </li>
        
				<%--<li>
                  <a href="${createLink(uri: '/akquiseaktion/list')} ">Akquiseaktionen</a>
                  <ul>
                    <li><a href="${createLink(uri: '/akquiseaktion/list')} ">Alle anzeigen</a></li>
                    <li><a href="${createLink(uri: '/akquiseaktion/create')} ">Anlegen</a></li>
                  </ul>
                </li>--%>
                
               	<li>
                  <a href="${createLink(uri: '/statistik')} ">Statistiken</a>
                </li>
				
              </ul>
             </div>

              <div id="quicksearch">
                <div id="quicksearchLabel">Quicksearch</div>
                <div><form><input type="text" name="quicksearchForm" id="quicksearchForm" /></form></div>
              </div>
         </div>


      <g:layoutBody />
      
		<div id="loading">
			<h2>loading..</h2>
		</div>
    </body>
</html>