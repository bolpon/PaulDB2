$(document).ready(function()
    {

        // Autovervollständigung für Vor- und Nachnamen
            $("#searchNachname").autocomplete({
                source: '/pauldb2/personen/nachnameAutoComplete',
                minLength: 2
            });

            $("#searchVorname").autocomplete({
                source: '/pauldb2/personen/vornameAutoComplete',
                minLength: 2
            });


        //jQuery autocompleter überschreiben für Kategorien in der Quicksearch
            $.widget("custom.catcomplete", $.ui.autocomplete, {
                _renderMenu: function( ul, items ) {
                    var self = this, currentCategory = "";
                    $.each( items, function( index, item ) {
                        if ( item.category != currentCategory ) {
                            ul.append( "<li class='ui-autocomplete-category'>" + item.category + "</li>" );
                            currentCategory = item.category;
                        }
                        self._renderItem( ul, item );
                    });
                }
            });

        // Quicksearch
            $("#quicksearchForm").catcomplete({
                source: '/pauldb2/dashboard/ajaxQuickSearch',
                minLength: 2,
                select: function(event, ui){

                    if(!ui.item.art)
                        return false;

                    var form = document.createElement("form");
                    form.setAttribute("method", "post");
                    form.setAttribute("action","/pauldb2/dashboard/processQuickSearch");

                    var hiddenField = document.createElement("input");
                    hiddenField.setAttribute("type", "hidden");
                    hiddenField.setAttribute("name", "id");
                    hiddenField.setAttribute("value", ui.item.id);

                    form.appendChild(hiddenField);

                    var hiddenField2 = document.createElement("input");
                    hiddenField2.setAttribute("type", "hidden");
                    hiddenField2.setAttribute("name", "art");
                    hiddenField2.setAttribute("value", ui.item.art);

                    form.appendChild(hiddenField2);

                    document.body.appendChild(form);
                    form.submit();
                }
            });


        // Datepicker auf deutsche Formate trimmen
            jQuery(function($){
                $.datepicker.regional['de'] = {
                    clearText: 'l�schen', clearStatus: 'aktuelles Datum l�schen',
                    closeText: 'schlie�en', closeStatus: 'ohne �nderungen schlie�en',
                    prevText: '&#x3c;zur�ck', prevStatus: 'letzten Monat zeigen',
                    nextText: 'Vor&#x3e;', nextStatus: 'n�chsten Monat zeigen',
                    currentText: 'heute', currentStatus: '',
                    monthNames: ['Januar','Februar','Maerz','April','Mai','Juni',
                    'Juli','August','September','Oktober','November','Dezember'],
                    monthNamesShort: ['Jan','Feb','Maer','Apr','Mai','Jun',
                    'Jul','Aug','Sep','Okt','Nov','Dez'],
                    monthStatus: 'anderen Monat anzeigen', yearStatus: 'anderes Jahr anzeigen',
                    weekHeader: 'Wo', weekStatus: 'Woche des Monats',
                    dayNames: ['Sonntag','Montag','Dienstag','Mittwoch','Donnerstag','Freitag','Samstag'],
                    dayNamesShort: ['So','Mo','Di','Mi','Do','Fr','Sa'],
                    dayNamesMin: ['So','Mo','Di','Mi','Do','Fr','Sa'],
                    dayStatus: 'Setze DD als ersten Wochentag', dateStatus: 'W�hle D, M d',
                    dateFormat: 'dd.mm.yy', firstDay: 1,
                    initStatus: 'W�hle ein Datum', isRTL: false
                };
                $.datepicker.setDefaults($.datepicker.regional['de']);
            });

        // Datepicker konfigurieren
            $(".jqDatepicker").datepicker({
                changeMonth: true,
                changeYear: true
            });


        // Kategorien zur Quicksearch
            $.widget("custom.catcomplete", $.ui.autocomplete, {
                _renderMenu: function( ul, items ) {
                    var self = this,
                    currentCategory = "";
                    $.each( items, function( index, item ) {
                        if ( item.category != currentCategory ) {
                            ul.append( "<li class='ui-autocomplete-category'>" + item.category + "</li>" );
                            currentCategory = item.category;
                        }
                        self._renderItem( ul, item );
                    });
                }
            });



        // Auswahlliste für multiple Select
            $(".multiselect").multiselect();


        // Unternehmen -> Show -> Kontakte

            // Kontakte-Div am Anfang ausblenden, bei Bedarf einblenden
            $("#unternehmenShowKontakte").hide();
            // Knopf für Anzeigen
            $("#unternehmenShowKontakteButtonShow")
                .button()
                .click(function() {
                    if ($("#unternehmenShowKontakte").is(":hidden")){
                        $("#unternehmenShowKontakte").slideDown(2000);
                    } else {
                        $("#unternehmenShowKontakte").slideUp("slow");
                    }
                return false;
            });

            // Knopf für Hinzufügen
            $("#unternehmenShowKontakteButtonHinzu")
                .button()
                .click(function(){
                     return false;
            });


        // Aufgabe -> Create -> Personen Mit Zugriff
            // Ausblenden und bei Bedarf einblenden
            $("#aufgabeCreateZugriff").hide();

            $("#aufgabeCreateZugriffCheckbox").change(function(){
                if ($("#aufgabeCreateZugriff").is(":hidden")){
                    $("#aufgabeCreateZugriff").slideDown(500);
                } else {
                    $("#aufgabeCreateZugriff").slideUp("slow");
                }
            });

        //-------------------- Aufgabe->edit->PersonenMitZugriff -------------------------------------------

            //wenn nicht geschützt, dann Auswahl ausblenden
            if(!$('#aufgabeEditZugriffCheckbox').attr('checked')){
                $("#aufgabeEditZugriff").hide();
            }


            //Bei Änderung des Statud die Auswahl ein oder ausblenden
            $("#aufgabeEditZugriffCheckbox").change(function(){
                if ($("#aufgabeEditZugriff").is(":hidden")){
                    $("#aufgabeEditZugriff").slideDown(500);
                } else {
                    $("#aufgabeEditZugriff").slideUp("slow");
                }
            });

        //-------------------- Modaler Dialog für Personen -> Show -> upload Foto hinzu -------------------------

            $("#personShowUploadFotoDialog").dialog({
                title: "Neues Foto hochladen",
                autoOpen: false,
                height: 320,
                width: 470,
                modal: true,
                buttons: {},
                close: function() {}
            });

            $('#personenShowFotoImg')
                .click(function() {
                    $('#personShowUploadFotoDialog').dialog('open');
                    return false;
                });


        //-------------------- Modaler Dialog für Projekte->Edit-> Teammitglieder hinzu ------------------------


            $("#dialog-form").dialog({
                title: "Teammitglieder hinzufügen/löschen",
                autoOpen: false,
                height: 320,
                width: 470,
                modal: true,
                buttons: {
                    'Fertig': function() {
                        alert("geht los?");
                        var tm = $('#teammitglieder').val();
                        var projektId = document.getElementsByName("projektIdAJAX")[0].value;

                        $.post("/pauldb2/projekte/editTeammitglieder",
                            {teammitglieder:tm, projektId:projektId},
                            function(data){

                                //bei erfolg Tabelle löschen und neu zeichnen
                                table = document.getElementById('divTeammitglieder');

                                while (table.rows.length> 2) {
                                    table.deleteRow(1);
                                }

                                for(var i =0; i<data.length;i++){

                                    var row = table.insertRow(1);
                                    var cell1 = row.insertCell(0);
                                    var cell2 = row.insertCell(1);
                                    var cell3 = row.insertCell(2);
                                    var cell4 = row.insertCell(3);
                                    cell1.innerHTML = data[i].vorname + " " + data[i].nachname;

                                    var i1 = document.createElement("input");
                                    i1.setAttribute("type", "text");
                                    i1.setAttribute("name", "tmVon");
                                    i1.setAttribute("class", "jqDatepicker inputKurz");
                                    i1.setAttribute("value", data[i].von);
                                    cell2.appendChild(i1);

                                    var i2 = document.createElement("input");
                                    i2.setAttribute("type", "text");
                                    i2.setAttribute("name", "tmBis");
                                    i2.setAttribute("class", "jqDatepicker inputKurz");
                                    i2.setAttribute("value", data[i].bis);
                                    cell3.appendChild(i2);

                                    var chkbox = document.createElement('input');
                                    chkbox.type = "radio";
                                    chkbox.name = 'plGroup';

                                    chkbox.setAttribute('value',data[i].tmId);

                                    //Teammitglied ist Projektleiter
                                    if(data[i].pl){
                                        chkbox.setAttribute('checked','checked');
                                    }

                                    cell4.appendChild(chkbox);

                                    var h = document.createElement("input");
                                    h.setAttribute("type", "hidden");
                                    h.setAttribute("name", "tmId");
                                    h.setAttribute("value", data[i].tmId);

                                    row.appendChild(h);

                                }

                                // datepicker für neue Zellen wieder aktivieren
                                $(".jqDatepicker").datepicker({
                                    changeMonth: true,
                                    changeYear: true

                                });

                            }, "json"
                        );
                        $(this).dialog('close');
                    },
                    'Abbrechen': function() {
                        $(this).dialog('close');
                    }
                },
                close: function() {}
            });

        // Projekt->Edit->Teammitglied hinzu Modaler Dialog
            $('#projekteEditTmHinzu')
                .button()
                .click(function() {
                    $('#dialog-form').dialog('open');
                    return false;
                });

       


        //-------------------- Modaler Dialog für Projekte->Edit-> FMA hinzu -------------------------------------------

            $("#dialog-form-fma").dialog({
                title: "FMA hinzufügen/löschen",
                autoOpen: false,
                height: 320,
                width: 470,
                modal: true,
                buttons: {
                    'Fertig': function() {
                        var fma = $('#fmaDialog').val();
                        var projektId = document.getElementsByName("projektIdAJAX")[0].value;

                        $.post("/pauldb2/projekte/editFMA",
                            {fma:fma, projektId:projektId},
                            function(data){
                                //bei erfolg Tabelle löschen und neu zeichnen
                                table = document.getElementById('divFreieMitarbeiter');

                                while (table.rows.length> 2) {
                                    table.deleteRow(1);
                                }

                                for(var i =0; i<data.length;i++){

                                    var row = table.insertRow(1);
                                    var cell1 = row.insertCell(0);
                                    var cell2 = row.insertCell(1);
                                    var cell3 = row.insertCell(2);
                                    var cell4 = row.insertCell(3);
                                    cell1.innerHTML = data[i].vorname + " " + data[i].nachname;

                                    var i1 = document.createElement("input");
                                    i1.setAttribute("type", "text");
                                    i1.setAttribute("name", "fmaVon");
                                    i1.setAttribute("class", "jqDatepicker inputKurz");
                                    i1.setAttribute("value", data[i].von);
                                    cell2.appendChild(i1);

                                    var i2 = document.createElement("input");
                                    i2.setAttribute("type", "text");
                                    i2.setAttribute("name", "fmaBis");
                                    i2.setAttribute("class", "jqDatepicker inputKurz");
                                    i2.setAttribute("value", data[i].bis);
                                    cell3.appendChild(i2);

                                    var i3 = document.createElement("textarea");
                                    i3.setAttribute("name", "fmaBemerkung");
                                    i3.setAttribute("class", "small");
                                    i3.innerHTML = data[i].bemerkung;
                                    cell4.appendChild(i3);

                                    var h = document.createElement("input");
                                    h.setAttribute("type", "hidden");
                                    h.setAttribute("name", "fmaId");
                                    h.setAttribute("value", data[i].fmaId);

                                    row.appendChild(h);
                                }

                                // datepicker für neue Zellen wieder aktivieren
                                $(".jqDatepicker").datepicker({
                                    changeMonth: true,
                                    changeYear: true
                                });
                            }, "json"
                        );
                        $(this).dialog('close');
                    },
                    'Abbrechen': function() {
                        $(this).dialog('close');
                    }
                },
                close: function() {

                }
            });

        // Projekt->Edit->Teammitglied hinzu Modaler Dialog

            $('#projekteEditFMAHinzu')
                .button()
                .click(function() {
                    $('#dialog-form-fma').dialog('open');
                    return false;
                });


        //-------------------- Modaler Dialog für Projekte->Create-> FMA hinzu -------------------------------------------


            $("#dialog-form-fma-create").dialog({
                title: "FMA hinzufügen/löschen",
                autoOpen: false,
                height: 330,
                width: 480,
                modal: true,
                buttons: {
                    'Fertig': function() {

                        // Personen IDs aus dem Multiselect der freien Mitarbeiter werden in die Liste fma geschrieben
                        var fma = $('#fmaDialog').val();
                        // Tabelle wird gelöscht, nur die Kopfzeile bleibt
                        table = document.getElementById('divFreieMitarbeiter');

                        while (table.rows.length> 2) {
                            table.deleteRow(1);
                        }

                        // Für jede Personen ID in der Liste fma...
                        for (var i=0;i<fma.length;i++) {

                            // Hole die entsprechende Person aus der Datenbank
                            $.post("/pauldb2/personen/get/"+fma[i], function(data){

                                // Erstelle Tabellenzeile...
                                var row = table.insertRow(1);
                                var cell1 = row.insertCell(0);
                                var cell2 = row.insertCell(1);
                                var cell3 = row.insertCell(2);
                                var cell4 = row.insertCell(3);

                                // Mit Vor- & Nachname,
                                cell1.innerHTML = data.vorname + " " + data.nachname;

                                // Anfangsdatum FMA,
                                var i1 = document.createElement("input");
                                i1.setAttribute("type", "text");
                                i1.setAttribute("name", "fmaVon");
                                i1.setAttribute("class", "jqDatepicker inputKurz");
                                i1.setAttribute("value", "");
                                cell2.appendChild(i1);

                                // Enddatum FMA
                                var i2 = document.createElement("input");
                                i2.setAttribute("type", "text");
                                i2.setAttribute("name", "fmaBis");
                                i2.setAttribute("class", "jqDatepicker inputKurz");
                                i2.setAttribute("value", "");
                                cell3.appendChild(i2);

                                // und Beschreibung
                                var i3 = document.createElement("textarea");
                                i3.setAttribute("name", "fmaBemerkung");
                                i3.setAttribute("class", "small");
                                i3.innerHTML = "";
                                cell4.appendChild(i3);

                                // Textfeld für Beschreibung
                                var h = document.createElement("input");
                                h.setAttribute("type", "hidden");
                                h.setAttribute("name", "fmaPersonId");
                                h.setAttribute("value", data.id);

                                // Hänge Zeile an Tabelle an
                                row.appendChild(h);

                                // Datumsauswahlfenster für Datumsfelder
                                // datepicker für neue Zellen wieder aktivieren
                                $(".jqDatepicker").datepicker({
                                    changeMonth: true,
                                    changeYear: true
                                });
                            }, "json");
                        }

                        // Fertig Knopf noch mit schließen Funktion versehen...
                        $(this).dialog('close');
                    },

                    // Abbrechen Knopf mit schließen Funktion versehen
                    'Abbrechen': function() {
                        $(this).dialog('close');
                    }/*,

                    // Easter Egg

                    'DB löschen': function() {
                        var fun = confirm("Wollen sie wirklich die komplette Datenbank löschen?");
                        if (fun) {
                            alert("Ääähhh...\nNEIN!\n\n\n\nIdiot!");
                        } else {
                            alert("braver Junge...");
                        }
                        $(this).dialog('close');
                    }
                    */
                },

                // Schließen Funktion (tut nichts, muss aber definiert werden)
                close: function() {}
            });

        // Projekt->Edit->Teammitglied hinzu Modaler Dialog

            $('#projekteCreateFMAHinzu')
                .button()
                .click(function() {
                    $('#dialog-form-fma-create').dialog('open');
                    return false;
                });

        //-------------------- DropDown Zur Auswahl, Projekte->Edit-> Taetigkeitsfeld -------------------------------------------

            // Funktion welche Änderungen im Cluster-Select überwacht (fast Gleiche Funktion weiter unten noch einmal erklärt)
            $('.Taetigkeitscluster').change(function() {
                select_cluster_id = $(this).attr('id')
                cluster_id = $(this).attr('value');
                select_feld = document.getElementById("feld" + select_cluster_id);
                selected = $(this).attr('id');
                $("select[id="+selected+"] option:selected").each(function() {
                    $.post("/pauldb2/projekte/getTaetigkeitsfeldByCluster/" + cluster_id, function(data) {
                        select_feld.options.length = 0;
                        for (i = 0; i < data.length; i++) {
                            select_feld.options[i] = new Option(data[i].bezeichnung, data[i].id, (i == 0), false)
                        }
                    });
                });
            });

        //-----------------------------------------------------------------------------------------------------------------------

            /**
            * Controller: Unternehmen
            * View: Create
            *
            * Mitarbeiter (fremde Personen) können dem Unternehmen hinzugewiesen werden
            * dazu wird ein Inputfeld mit Autocomplete zur Verfügung gestellt, dass seine Informationen aus unternehmenController/getMitarbeiter bekommt
            * Nach Auswählen wird Mitarbeiter automatisch in die Tabelle eingefügt
            * desweiteren werden für diese Person Auswahlboxen für die Position und die Dauer der Beschäftigung angelegt
            *
            * Im letzten Feld jeder Tabellenreihe wird ein Link zum Entfernen der Spalte generiert
            *
            * Ein hiddenField, was an jede Tabellenreihe angehangen wird, speichert die MitarbeiterID
            */

            // Unternehmen auswählen -> Autocomplete
            $(".unternehmenMitarbeiterInput").autocomplete({
                source: '/pauldb2/unternehmen/mitarbeiterAutoComplete', select: function(event, ui){

                    var tablename=event.target.name;
                    var table = document.getElementById(tablename);
                    var row = table.insertRow(table.rows.length);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    var cell5 = row.insertCell(4);

                    var i0 = document.createElement("input");
                    i0.setAttribute("type", "text");
                    i0.setAttribute("name", "m.Name");
                    i0.setAttribute("value", ui.item.value)

                    var i1 = document.createElement("input");
                    i1.setAttribute("type", "text");
                    i1.setAttribute("name", "m.anfang");
                    i1.setAttribute("class", "jqDatepicker inputKurz");
                    i1.setAttribute("value", "");


                    var i2 = document.createElement("input");
                    i2.setAttribute("type", "text");
                    i2.setAttribute("name", "m.ende");
                    i2.setAttribute("class", "jqDatepicker inputKurz");
                    i2.setAttribute("value", "");

                    var link = document.createElement("a");
                    link.setAttribute("href", "#");
                    link.setAttribute("onClick","document.getElementById('"+tablename+"').deleteRow(this.parentNode.parentNode.rowIndex);return false");

                    var button = document.createElement("input");
                    button.setAttribute("id", table.rows.length);
                    button.setAttribute("type", "button");
                    button.setAttribute("value","");
                    button.setAttribute("onClick","document.getElementById('"+tablename+"').deleteRow(this.parentNode.parentNode.rowIndex)");

                    var del = new Image();
                    del.src = "/pauldb2/images/icons/busy.png";
                    del.width=16;
                    del.height=16;
                    del.alt="löschen";
                    link.appendChild(del);

                    var position;
                    $.post("/pauldb2/unternehmen/getMitarbeiterPositionen", function(data){
                        for(var i=0;i<data.length;i++){
                            var op = document.createElement("option");
                            var text = document.createTextNode(data[i].position);
                            op.setAttribute('value',data[i].id)
                            op.appendChild(text);
                            select.appendChild(op);
                        }
                    }, "json" );

                    var select = document.createElement("select");
                    select.setAttribute("name","m.position");
                    select.setAttribute("size","1");

                    cell1.appendChild(i0);
                    cell2.appendChild(select);
                    cell3.appendChild(i1);
                    cell4.appendChild(i2);
                    cell5.appendChild(link);

                    $(".jqDatepicker").datepicker({
                        changeMonth: true,
                        changeYear: true

                    });

                    var hiddenField = document.createElement("input");
                    hiddenField.setAttribute("type", "hidden");
                    hiddenField.setAttribute("name", "p.id");
                    hiddenField.setAttribute("value", ui.item.id);

                    var hiddenField2 = document.createElement("input");
                    hiddenField2.setAttribute("type", "hidden");
                    hiddenField2.setAttribute("name", "m.id");
                    hiddenField2.setAttribute("value", "-1");

                    row.appendChild(hiddenField);
                    row.appendChild(hiddenField2);

                    document.getElementById("mitarbeiterInputHidden").value=ui.item.id;
                    document.getElementById("unternehmenCreateMitarbeiterInput").value ="";
                    return false;
                },
                minLength: 2

            });

            // Unternehmen auswählen -> Hilfe Knopf
            $('#unternehmenCreateMHilfe')
                .button()
                .click(function() {
                    // Inputbox ist leer
                    var $dialog = $('<div></div>')
                        .html('Bitte wähle über das Eingabefeld links das Unternehmen aus. <br /> ' +
                            '<br /> Nach Eingabe der ersten beiden Buchstaben, erhälst du passende Vorschläge.' +
                            ' Anschließend kannst du die passenden Mitarbeiter des Unternehmens auswählen ')
                        .dialog({
                            autoOpen: true,
                            title: 'Kein Mitarbeiter ausgewählt'
                        });

                    return false;
                });

            // Unternehmen -> Edit -> Oberunternehmen

                $("#unternehmenEditOberunternehmenInput").autocomplete({
                    source: '/pauldb2/unternehmen/unternehmenAutoComplete',
                    minLength: 3,
                    select: function(event, ui){
                        $('#oberunternehmenHidden').val(ui.item.id);
                    }
                });


            // Unternehmen -> Create -> Oberunternehmen


                $("#kontaktCreateOberunternehmenInput").autocomplete({
                    source: '/pauldb2/unternehmen/unternehmenAutoComplete',
                    minLength: 3,
                    select: function(event, ui){
                        $('#oberunternehmenInputHidden').val(ui.item.id);
                    }
                });

            // Kontakt -> Create -> Unternehmen Autocomplete und Mitarbeiter -----------------------------------------------------

                //$("#kontaktCreateMitarbeiterSelect").hide();

                $("#kontaktCreateUnternehmen").autocomplete({
                    source: '/pauldb2/kontakt/unternehmenList', select: function(event, ui) {
                        var sel = document.getElementById("ubw2");

                        if(sel.hasChildNodes()){
                            while (sel.childNodes.length>0){
                                sel.removeChild(sel.firstChild);
                            }
                        }

                        $.post("/pauldb2/unternehmen/getMitarbeiterByUnternehmenId",{uId: ui.item.id},
                        function(data){
                            var select = document.createElement("select");
                            select.setAttribute("name","mitarbeiter.id");
                            select.setAttribute("id","kontaktCreateMitarbeiterSelect");
                            select.setAttribute("size","5");
                            select.setAttribute("multible", "true");
                            select.setAttribute("class", "multiselect");

                            for(var i=0;i<data.length;i++){
                                var op = document.createElement("option");
                                op.setAttribute('value',data[i].id) ;
                                var text = document.createTextNode(data[i].vorname + " " + data[i].nachname);
                                op.appendChild(text);
                                select.appendChild(op);
                            }
                            document.getElementById('ubw2').appendChild(select);

                            $("#kontaktCreateMitarbeiterSelect").multiselect();
                        }, "json");
                    }
                });


            // Projekt -> Create -> Unternehmen Autocomplete

                $("#projektCreateUnternehmenInput").autocomplete({
                    source: '/pauldb2/projekte/unternehmenList', select: function(event, ui) {
                        var table = document.getElementById('projektCreateUHinzuTable');
                        var row = table.insertRow(table.rows.length);
                        var cell1 = row.insertCell(0);
                        var cell2 = row.insertCell(1);

                        var i0 = document.createElement("input");
                        i0.setAttribute("type", "text");
                        i0.setAttribute("name", "uName");
                        i0.setAttribute("style", "width:450")
                        i0.setAttribute("value",document.getElementById("projektCreateUnternehmenInput").value );
                        i0.setAttribute("readonly", "true");

                        var link = document.createElement("a");
                        link.setAttribute("href", "#");
                        link.setAttribute("onClick","document.getElementById('projektCreateUHinzuTable').deleteRow(this.parentNode.parentNode.rowIndex);updateAnsprechpartner();return false");

                        var del = new Image();
                        del.src = "/pauldb2/images/icons/busy.png";
                        del.width=16;
                        del.height=16;
                        del.alt="löschen";
                        link.appendChild(del);

                        cell1.appendChild(i0);
                        cell2.appendChild(link);

                        var hiddenField = document.createElement("input");
                        hiddenField.setAttribute("type", "hidden");
                        hiddenField.setAttribute("name", "uID");
                        hiddenField.setAttribute("value", ui.item.id);
                        hiddenField.setAttribute("class", "unternehmen_id");

                        cell1.appendChild(hiddenField);

                        document.getElementById("projektCreateUnternehmenInput").value ="";

                        updateAnsprechpartner();
                        return false;
                    },
                    minLength: 3
                });

            // Personen -> Create -> Projektleiter

                $("#projekteCreateProjektleiter").autocomplete({
                    source: '/pauldb2/personen/getAktivePaulisByNameAsJSON',
                    minLength: 3,
                    select: function(event, ui){
                        $('#projekteCreateProjektleiterHidden').val(ui.item.id);
                    }
                });

            // Personen -> Edit -> Coach

                $("#projekteEditCoach").autocomplete({
                    source: '/pauldb2/personen/getPaulisByNameAsJSON',
                    minLength: 3,
                    select: function(event, ui){
                        $('#projekteEditCoachHidden').val(ui.item.id);
                    }
                });

            // Personen -> update -> email Adresse hinzufügen button

                $('#personenEditEmailHinzu')
                    .button()
                    .click(function(){
                        var td = document.getElementById("personEditEmailTD");

                        var input = document.createElement("input");
                        input.setAttribute("type", "text");
                        input.setAttribute("name", "email.mailAdresse");

                        var hiddenField = document.createElement("input");
                        hiddenField.setAttribute("type", "hidden");
                        hiddenField.setAttribute("name", "email.id");
                        hiddenField.setAttribute("value", "-1");

                        td.appendChild(input);
                        td.appendChild(hiddenField);
                        td.appendChild(document.createElement("br"));

                        return false;
                    });
    }
);
//#################### end onDocumentReady ##################################

// Funktion fügt Homepages, Telefonnumer, E-Mail Adressen hinzu
// (Namen der zu benutzenden Elemente werden mittels übergebenen Parameter zusammengebaut)
function unternehmenEditHinzu(name){

    //ersten Buchstaben groß schreiben
    var nameCap = name.charAt(0).toUpperCase() + name.slice(1);
    var t = 'unternehmenEdit'+nameCap+'HinzuTable';

    var table = document.getElementById(t);
    var row = table.insertRow(table.rows.length);

    var i0 = document.createElement("input");
        i0.setAttribute("type", "text");
        i0.setAttribute("name", name+".nummer");
        i0.setAttribute("value","" );
        i0.setAttribute("size", "50");

    var i1 = document.createElement("input");
        i1.setAttribute("type", "text");
        i1.setAttribute("name", name+".bemerkung");
        i1.setAttribute("value","" );
        i1.setAttribute("size", "50");

    var hiddenField = document.createElement("input");
        hiddenField.setAttribute("type", "hidden");
        hiddenField.setAttribute("name", name+".id");
        hiddenField.setAttribute("value", "-1");

    var center = document.createElement("center");

    var link = document.createElement("a");
        link.setAttribute("href", "#");
        link.setAttribute("onClick","document.getElementById('"+t+"').deleteRow(this.parentNode.parentNode.parentNode.rowIndex);return false");

    var del = new Image();
        del.src = "/pauldb2/images/icons/busy.png";
        del.width=16;
        del.height=16;
        del.alt="löschen";

    center.appendChild(link);
    link.appendChild(del);

    var cell0 = row.insertCell(0);
    var cell1 = row.insertCell(1);
    var cell2 = row.insertCell(2);

    cell0.appendChild(i0);
    cell0.appendChild(hiddenField);
    cell1.appendChild(i1);
    cell2.appendChild(center);

    return false;
};

// Person -> Create -> E-Mail hinzufügen
function personenCreateEmailHinzu(){
    var table = document.getElementById('personenCreateEmailHinzuTable');
    var row = table.insertRow(table.rows.length);

    var i0 = document.createElement("input");
        i0.setAttribute("type", "text");
        i0.setAttribute("name", "email.adresse");
        i0.setAttribute("value","" );
        i0.setAttribute("size", "50");

    var hiddenField = document.createElement("input");
        hiddenField.setAttribute("type", "hidden");
        hiddenField.setAttribute("name", "email.id");
        hiddenField.setAttribute("value", "-1");

    var center = document.createElement("center");
    var link = document.createElement("a");
        link.setAttribute("href", "#");
        link.setAttribute("onClick","document.getElementById('personenCreateEmailHinzuTable').deleteRow(this.parentNode.parentNode.parentNode.rowIndex);return false");

    var del = new Image();
        del.src = "/pauldb2/images/icons/busy.png";
        del.width=16;
        del.height=16;
        del.alt="löschen";

    center.appendChild(link)
    link.appendChild(del);

    var cell0 = row.insertCell(0);
        cell0.appendChild(i0);
        cell0.appendChild(hiddenField);

    row.appendChild(cell0);

    var cell1 = row.insertCell(1);
        cell1.appendChild(center);

    return false;
};

// Person -> Create -> Telefon hinzufügen
function personenCreateTelefonHinzu(){

    var table = document.getElementById('personenCreateTelefonHinzuTable');
    var row = table.insertRow(table.rows.length);

    var i0 = document.createElement("input");
        i0.setAttribute("type", "text");
        i0.setAttribute("name", "telefon.nummer");
        i0.setAttribute("value","" );
        i0.setAttribute("size", "50");

    var i1 = document.createElement("input");
        i1.setAttribute("type", "text");
        i1.setAttribute("name", "telefon.bemerkung");
        i1.setAttribute("value","" );
        i1.setAttribute("size", "50");

    var hiddenField = document.createElement("input");
        hiddenField.setAttribute("type", "hidden");
        hiddenField.setAttribute("name", "telefon.id");
        hiddenField.setAttribute("value", "-1");

    var center = document.createElement("center");
    var link = document.createElement("a");
        link.setAttribute("href", "#");
        link.setAttribute("onClick","document.getElementById('personenCreateTelefonHinzuTable').deleteRow(this.parentNode.parentNode.parentNode.rowIndex);return false");

    var del = new Image();
        del.src = "/pauldb2/images/icons/busy.png";
        del.width=16;
        del.height=16;
        del.alt="löschen";

    center.appendChild(link)
    link.appendChild(del);

    var cell0 = row.insertCell(0);
        cell0.appendChild(i0);
        cell0.appendChild(hiddenField);

    var cell1 = row.insertCell(1);
        cell1.appendChild(i1);

    var cell2 = row.insertCell(2);
        cell2.appendChild(center);

    return false;
};

// Tabellenzeile Löschen
function deleteTablerow(tableID,rownumber){

    var a = document.getElementById('unternehmenEditMitarbeiter');
    var b = parseInt(rownumber)+parseInt(0);
    a.deleteRow(b);
    return false;
};

// Unternehmen -> Create -> Email
function unternehmenCreateEmailHinzu(){


           var table = document.getElementById('untenehmenCreateEmailHinzuTable');
           var row = table.insertRow(table.rows.length);


           var i0 = document.createElement("input");
                        i0.setAttribute("type", "text");
                        i0.setAttribute("name", "email.adresse");
                        i0.setAttribute("value","" );

           var i1 = document.createElement("input");
                        i1.setAttribute("type", "text");
                        i1.setAttribute("name", "email.bemerkung");
                        i1.setAttribute("value","" );

           var cell0 = row.insertCell(0);
           var cell1 = row.insertCell(1);


           cell0.appendChild(i0);
           cell1.appendChild(i1);

           return false;
};



//Unternehmen -> Create -> Telefon
function unternehmenCreateTelefonHinzu(){

    var table = document.getElementById('unternehmenCreateTelefonHinzuTable');
    var row = table.insertRow(table.rows.length);


    var i0 = document.createElement("input");
        i0.setAttribute("type", "text");
        i0.setAttribute("name", "telefon.nummer");
        i0.setAttribute("value","" );

    var i1 = document.createElement("input");
        i1.setAttribute("type", "text");
        i1.setAttribute("name", "telefon.bemerkung");
        i1.setAttribute("value","" );

    var cell0 = row.insertCell(0);
    var cell1 = row.insertCell(1);

    cell0.appendChild(i0);
    cell1.appendChild(i1);

    return false;
};

// Unternemene -> Create -> Homepage
function unternehmenCreateHomepageHinzu(){

    var table = document.getElementById('unternehmenCreateHomepageHinzuTable');
    var row = table.insertRow(table.rows.length);

    var i0 = document.createElement("input");
        i0.setAttribute("type", "text");
        i0.setAttribute("name", "homepage.url");
        i0.setAttribute("value","" );

    var i1 = document.createElement("input");
        i1.setAttribute("type", "text");
        i1.setAttribute("name", "homepage.bemerkung");
        i1.setAttribute("value","" );

    var cell0 = row.insertCell(0);
    var cell1 = row.insertCell(1);

    cell0.appendChild(i0);
    cell1.appendChild(i1);

    return false;
};

// Projekte -> Create & Edit -> Tätigkeitsfelder hinzufügen
function projekteTaetigkeitsfelderHinzu() {

    // Suche Tabelle mit der ID: tableTaetigkeitsfelder
    var table = document.getElementById("tableTaetigkeitsfelder");
    // Erzeuge eine neue Zeile
    var tr = table.insertRow(table.rows.length);

    var td1 = tr.insertCell(0);
    var td2 = tr.insertCell(1);
    var td3 = tr.insertCell(2);

    // Erzeuge Inhalt der Datenfelder (Select-Element mit id, name, class, value, style_Breite)
    // Cluster-Select
    var cluster = document.createElement("select");
        cluster.setAttribute("id", table.rows.length);
        cluster.setAttribute("name", "taetigkeitsCluster");
        cluster.setAttribute("class", "Taetigkeitscluster");
        cluster.setAttribute("value","Cluster");
        cluster.setAttribute("style", "width:250")

    // Feld-Select
    var feld = document.createElement("select");
        feld.setAttribute("id", "feld"+table.rows.length);
        feld.setAttribute("name", "taetigkeitsFelder");
        feld.setAttribute("class", "Taetigkeitsfeld");
        feld.setAttribute("value","Taetigkeits");
        feld.setAttribute("style", "width:250")

    var del = new Image();
        del.src = "/pauldb2/images/icons/busy.png";
        del.width=16;
        del.height=16;
        del.alt="löschen";

    var link = document.createElement("a");
        link.setAttribute("href", "#");
        link.setAttribute("onClick","document.getElementById('tableTaetigkeitsfelder').deleteRow(this.parentNode.parentNode.rowIndex);return false");
        link.appendChild(del);

    // Hänge Inhalt an Datenfelder an
    td1.appendChild(cluster);
    td2.appendChild(feld);
    td3.appendChild(link);


    // DropDown Zur Auswahl, zu füllende Daten beim hinzufügen einer neuen Tabellenzeile
    // Datenbankabfrage: Gebe alle Cluster
    $.post("/pauldb2/projekte/getTaetigkeitscluster", function(data) {

        // Nehme letztes Element aus der Tabelle
        select = document.getElementById(table.rows.length);

        // Leere das Cluster-Select
        select.options.length = 0;

        // Schreibe ins Cluster-Select alle Cluster welche die Datenbankabfrage ausgegeben hat
        for(i = 0; i < data.length; i++) {
            select.options[i] = new Option(data[i].bezeichnung, data[i].id, (i==0), false)
        }

        // Wähle Feld-Select welches zum Cluster-Select gehört (Cluster und Feld sind nebeneinander in der Tabelle und ähnlich benannt)
        select_feld = document.getElementById("feld"+table.rows.length);

        // Datenbankabfrage: Gebe alle Felder im Cluster aus
        $.post("/pauldb2/projekte/getTaetigkeitsfeldByCluster/" + data[0].id, function(data2) {

            // Leere Feld-Select
            select_feld.options.length = 0;

            // Schreibe in Feld-Select alle Daten welche die Datenbankabfrage ausgegeben hat
            for (i = 0; i < data2.length; i++) {
                select_feld.options[i] = new Option(data2[i].bezeichnung, data2[i].id, (i == 0), false);
            }
        });
    });


    // DropDown Zur Auswahl, Methode welche beim Ändern des Tätigkeitscluster anspringt
    // OnChange Methode für alle Elemente der Klasse Taetigkeitscluster
    $('.Taetigkeitscluster').change(function() {

        //Identifiziere Element anhand der ID
        select_cluster_id = $(this).attr('id')

        // Lese aus Element entsprechende ID in der Datenbank (mit im Select-Element gespeichert)
        cluster_id = $(this).attr('value');

        // Wähle Taetigkeitsfeld-Select welches zum Cluster-Select gehört
        select_feld = document.getElementById("feld" + select_cluster_id);

        // Nehme den Namen
        selected = $(this).attr('id');

        // Welcher Cluster ist ausgewählt, mache für diese folgendes (in unserem Fall nur einer)
        $("select[id="+selected+"] option:selected").each(function() {

            // Datenbankabfragefunktion für alle Felder mit dem Cluster cluster_id
            $.post("/pauldb2/projekte/getTaetigkeitsfeldByCluster/" + cluster_id, function(data) {

                // Lösche alle bisherigen Options aus dem Feld-Select
                select_feld.options.length = 0;

                // Schreibe neue Options die sich im Cluster befinden
                for (i = 0; i < data.length; i++) {
                    select_feld.options[i] = new Option(data[i].bezeichnung, data[i].id, (i == 0), false)
                }
            });
        });
    });
    return false;
};

// Projekte -> Create & Edit -> Ansprechpartner: update multiselect

function updateAnsprechpartner() {

    // Zwischenspeicher für Mitarbeiter
    var to_display = new Array();

    // Leere Select Options
    $('#ansprechpartner').empty();

    // Für jedes nternehmen:
    // Hole Daten aus der Datenbank (ProjektController)
    // Schreibe sie in einen Zwischenspeicher
    // Schreibe Zwischenspeicher in eine Option
    // Zeichne Multiselect neu
    $.each(document.getElementsByClassName('unternehmen_id'), function(index, value) {
        $.post("/pauldb2/projekte/getMitarbeiterByUnternehmen/" + value.value, function(data) {
            for(i=0; i<data.length; i++) {
                to_display[i] = data[i];

            }
            for (i = 0; i<to_display.length; i++) {
                $('#ansprechpartner').append($('<option></option>').val(to_display[i].mid).html((to_display[i].vorname+' '+to_display[i].nachname).toString()));
                $('#ansprechpartner').multiselect('destroy');
                $('#ansprechpartner').multiselect();
            }
        });
    });

    // Abschließendes Neuladen des Multiselect für den Fall, das die Liste der Unternehmen leer war
    $('#ansprechpartner').multiselect('destroy');
    $('#ansprechpartner').multiselect();
};