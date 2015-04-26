<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>Studiengänge</title> 
        <g:if test="${statistik}">      
	        <script type="text/javascript" src="https://www.google.com/jsapi"></script>
	    	<script type="text/javascript"><!--
	    		// Google Charts API laden
	      		google.load("visualization", "1", {packages:["corechart"]});
	      		google.setOnLoadCallback(drawChart);
	
	      		// Wird aufgerufen, wenn die Seite fertiggeladen ist und das Chart gezeichnet werden kann
		      	function drawChart() {
			      	// Daten laden
		        	var data = google.visualization.arrayToDataTable([
		          		['Studienfach', 'Anzahl'],
		          		<g:each in="${statistik}">
							['${it.studienfach}', ${it.anzahl}],
						</g:each>
		       		]);
	
		        	// Optionen festlegen
			        var options = {
			        	pieSliceText: 'none',
				        chartArea: {left: 20, top: 0, width: '80%'},
			        	legend: {position: 'right', alignment: 'center'}
			        };
	
			    	// Chart erstellen und zeichnen
		        	new google.visualization.PieChart(document.getElementById('studiengaengeChart')).draw(data, options);
		      }
	    	--></script>
	    </g:if>
    </head>
    <body>
    	<h1>Studiengänge</h1>
		<g:if test="${flash.message}">
			<div class="message">${flash.message}</div>
		</g:if>
		
		<div class="statistik statistikMitGrafik">
			<form id="options" name="options" method="POST">
				<input type="hidden" name="angepasst" value="${true}" />
				<p class="option singleLine"><input type="checkbox" name="zusammenfassen" <% if (params.zusammenfassen) print('checked="checked" ') %>onclick="options.submit()" />Sonstige zusammenfassen</p>
				<% // Personen-Parameter in Array umwandeln
					if (params.personen)
						params.personen = params.personen instanceof String ? [params.personen] : params.personen.toList()
				%>
				<p class="option"><input type="checkbox" name="personen" value="mitglieder" <% if (params.personen?.contains('mitglieder')) print('checked="checked" ') %>onclick="options.submit()" />aktive Mitglieder</p>
				<p class="option"><input type="checkbox" name="personen" value="aoler" <% if (params.personen?.contains('aoler')) print('checked="checked" ') %>onclick="options.submit()" />inaktive Mitglieder</p>
				<p class="option"><input type="checkbox" name="personen" value="anwaerter" <% if (params.personen?.contains('anwaerter')) print('checked="checked" ') %>onclick="options.submit()" />Anwärter</p>
				<p class="option"><input type="checkbox" name="personen" value="ehrenmitglieder" <% if (params.personen?.contains('ehrenmitglieder')) print('checked="checked" ') %>onclick="options.submit()" />Ehrenmitglieder</p>
				<p class="option"><input type="checkbox" name="personen" value="paulumni" <% if (params.personen?.contains('paulumni')) print('checked="checked" ') %>onclick="options.submit()" />Paulumni</p>

				<button class="export" name="export" value="export">Statistik exportieren</button>
			</form>
		
			<g:if test="${statistik}">
				<table>
					<thead>
						<tr>
							<th>Studienfach</th>
							<th>Anzahl</th>
							<th>Anteil</th>
						</tr>
					</thead>
					
					<tbody>
						<g:each in="${statistik}" status="i" var="var">
							<tr class="${i & 1 ? 'odd' : 'even'}">
								<td>${var.studienfach}</td>
								<td>${var.anzahl}</td>
								<td>${var.anteil} %</td>
							</tr>
						</g:each>
					</tbody>
					
					<tfoot>
						<tr>
							<td>Gesamt</td>
							<td>${gesamt}</td>
							<td>&nbsp;</td>
						</tr>
					</tfoot>
				</table>
				
				<div class="grafikContainer" id="studiengaengeChart">Kuchen wird gebacken...</div>
			</g:if>
		</div>
    </body>    
</html>
