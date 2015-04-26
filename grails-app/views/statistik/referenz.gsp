<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>Projekte mit Referenzfreigabe</title>
    </head>
    <body>
    	<h1>Projekte mit Referenzfreigabe</h1>
		<g:if test="${flash.message}">
			<div class="message">${flash.message}</div>
		</g:if>
		
		<div class="statistik">
			<form id="options" name="options" method="POST">
				<p class="option"><input type="checkbox" name="einschraenken" <% if (params.einschraenken) print('checked="checked" ') %>onclick="options.submit()" />Datum einschränken</p>
				<g:if test="${params.einschraenken}">
					<p class="option">Nur Projekte in die Liste einbeziehen, die nach dem <input name="datum" class="jqDatepicker" type="text" size="10" style="text-align:center" value="${params.datum}" onchange="options.submit()" /> abgeschlossen wurden.</p>
				</g:if>
				<g:elseif test="${params.datum}">
					<input name="datum" type="hidden" value="${params.datum}" />
				</g:elseif>
				
				<button class="export" name="export" value="export">Statistik exportieren</button>
			</form>
					
			<table>
				<colgroup>
					<col width="30%">
					<col width="20%">
					<col width="5%">
					<col width="5%">
					<col width="40%">
				</colgroup>
			
				<thead><tr>
					<th>Unternehmen</th>
					<th>Projekt</th>
					<th>Abschluss</th>
					<th>BT</th>
					<th>Beschreibung</th>
				</tr></thead>
				
				<tbody>
					<g:each in="${projekte}" status="i" var="var"><tr class="${i & 1 ? 'odd' : 'even'}">
						<td><g:link controller="unternehmen" action="show" id="${var.unternehmenid}">${var.unternehmenname}</g:link></td>
						<td><g:link controller="projekte" action="show" id="${var.id}">${var.projektname}</g:link></td>
						<td>${var.enddatum?.format('dd.MM.yyyy')}</td>
						<td>${var.btvertrag}</td>
						<td style="white-space: pre-wrap;">${var.beschreibung}</td>
					</tr></g:each>
				</tbody>
			</table>
		</div>
    </body>    
</html>
