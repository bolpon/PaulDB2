<g:applyLayout name="dashboard">
	<head>
		<title><g:layoutTitle default="Statistiken" /></title>
		<link rel="stylesheet" href="${resource(dir:'css',file:'statistik.css')}" />
		<g:layoutHead />    
	</head>
	
	<body>
		<div class="body">
			<div class="list">
				<g:layoutBody />
			</div>
		
			<div id="widgets" class="widgetsRight">
				<div id="widget-statistik">
					<ul>
						<li>
							<h2>Personal</h2>
							<ul>
								<!--<li><a href="${createLink(uri: '/statistik/anwaerter')} ">TODO: Anwärter-Übersicht</a></li>-->
								<!--<li><a href="${createLink(uri: '/statistik/db')} ">TODO: Nicht ausgefüllte DB-Felder</a></li>-->
								<!--<li><a href="${createLink(uri: '/statistik/pl-coach')} ">TODO: PL und Coach</a></li>-->
								<li><a href="${createLink(uri: '/statistik/studiengaenge')} ">Studiengänge</a></li>
								<li><a href="${createLink(uri: '/statistik/mitglieder')} ">Mitgliederzahlen</a></li>
							</ul>
						</li>
						
						<li>
							<h2>Externes</h2>
							<ul>
								<!--<li><a href="${createLink(uri: '/statistik/projekte')} ">BT und Projekte</a></li>-->
								<li><a href="${createLink(uri: '/statistik/referenz')} ">Projekte mit Referenzfreigabe</a></li>
							</ul>
						</li>
						
						<!--<li>
							<h2>allgemeine Kennzahlen</h2>
							<ul>
								<li><a href="${createLink(uri: '/statistik/schwerpunkte')} ">TODO: Externe Projektschwerpunkte</a></li>
							</ul>
						</li>-->
		
						<!--<li>
							<h2>Wissen & Netzwerke</h2>
							<ul>
								<li><a href="${createLink(uri: '/statistik/schulungen')} ">TODO: gehaltene Schulungen</a></li>
								<li><a href="${createLink(uri: '/statistik/schulungsleiter')} ">TODO: Schulungsleiter</a></li>
							</ul>	
						</li>-->
					</ul>
				</div>
			</div>
		</div>
	</body>
</g:applyLayout>