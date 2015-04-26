<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>BT und Projekte</title>
    </head>
    <body>
    	<h1>BT und Projekte</h1>
		<g:if test="${flash.message}">
			<div class="message">${flash.message}</div>
		</g:if>
		
		<div class="statistik narrow">
			<form id="options" name="options" method="POST">
				<p class="option" style="float:left;line-height:32px;margin-right:6px;">Nur Projekte in die Statistik einbeziehen, die zwischen dem <input name="datumAnfang" class="jqDatepicker" type="text" size="10" style="text-align:center" value="${params.datumAnfang}" onchange="options.submit()" /> und dem <input name="datumEnde" class="jqDatepicker" type="text" size="10" style="text-align:center" value="${params.datumEnde}" onchange="options.submit()" /></p>
				<p style="float:left;line-height:16px;">
					<input type="radio" style="margin-right:4px;" name="status" value="angefangen" id="statusAngefangen" <% if (params.status != 'abgeschlossen') print('checked="checked" ') %>onclick="options.submit()"><label for="statusAngefangen">angefangen</label>
					<br>
					<input type="radio" style="margin-right:4px;" name="status" value="abgeschlossen" id="statusAbgeschlossen" <% if (params.status == 'abgeschlossen') print('checked="checked" ') %>onclick="options.submit()"><label for="statusAbgeschlossen">abgeschlossen</label>
				</p>
				<p style="float:left;line-height:32px;padding-left:4px;">wurden.</p>
				
				<button class="export" name="export" value="export">Statistik exportieren</button>
			</form>
			
			<g:if test="${statistik && (statistik.extern + statistik.intern)}">
				<table>				
					<thead><tr>
						<th>&nbsp;</th>
						<th>Projekte</th>
						<th>BT (Vertrag)</th>
						<th>BT (real)</th>
					</tr></thead>
					
					<tbody>
						<tr class="odd">
							<td>Extern</td>
							<td>${statistik.extern}</td>
							<td>${statistik.btExtern}</td>
							<td>${statistik.btRealExtern}</td>
						</tr>
						
						<tr class="even">
							<td>Intern</td>
							<td>${statistik.intern}</td>
							<td>${statistik.btIntern}</td>
							<td>${statistik.btRealIntern}</td>
						</tr>
					</tbody>
					
					<tfoot><tr>
						<td>Gesamt</td>
						<td>${statistik.gesamt}</td>
						<td>${statistik.btGesamt}</td>
						<td>${statistik.btRealGesamt}</td>
					</tr></tfoot>
				</table>
			</g:if>
			<g:else>
				<p>Keine Projekte gefunden.</p>
			</g:else>
		</div>
    </body>    
</html>
