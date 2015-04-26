<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>Mitgliederzahlen</title>
    </head>
    <body>
    	<h1>Mitgliederzahlen</h1>
		<g:if test="${flash.message}">
			<div class="message">${flash.message}</div>
		</g:if>
		
		<div class="statistik narrow">
			<form id="options" name="options" method="POST">				
				<button class="export" name="export" value="export">Statistik exportieren</button>
			</form>
		
			<table>
				<thead>
					<tr>
						<th>Status</th>
						<th>Anzahl</th>
					</tr>
				</thead>
				
				<tbody>
					<g:each in="${statistik}" status="i" var="var">
						<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
							<td>${var.status}</td>
							<td>${var.anzahl}</td>
						</tr>
					</g:each>
				</tbody>
				
				<tfoot>
					<tr>
						<td>Gesamt</td>
						<td>${gesamt}</td>
					</tr>
				</tfoot>
			</table>
		</div>
    </body>    
</html>
