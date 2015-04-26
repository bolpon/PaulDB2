$(document).ready(function()
    {
        // Projekte -> Edit -> Teammitglieder hinzu - Modaler Dialog

            $("#dialog-form").dialog({
                title: "Teammitglieder hinzufügen/löschen",
                autoOpen: false,
                height: 320,
                width: 470,
                modal: true,
                buttons: {
                    'Fertig': function() {
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

                                table.resize;

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

        // Projekt -> Edit -> Teammitglied hinzu - Knopf hinzufügen
            $('#projekteEditTmHinzu')
                .button()
                .click(function() {
                    $('#dialog-form').dialog('open');
                    return false;
                });




        // Projekte -> Edit -> FMA hinzu - Modaler Dialog

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

        // Projekt -> Edit -> FMA hinzu - Knopf hinzufügen

            $('#projekteEditFMAHinzu')
                .button()
                .click(function() {
                    $('#dialog-form-fma').dialog('open');
                    return false;
                });


        // Projekte -> Create -> FMA hinzu - Modaler Dialog

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
                    }
                },

                // Schließen Funktion (tut nichts, muss aber definiert werden)
                close: function() {}
            });

        // Projekt -> Create -> FMA hinzu - Knopf

            $('#projekteCreateFMAHinzu')
                .button()
                .click(function() {
                    $('#dialog-form-fma-create').dialog('open');
                    return false;
                });

        // Projekte -> Edit -> Taetigkeitsfeld - DropDown Zur Auswahl (OnChange Funktion für bestehende Tätigkeitscluster)

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
                        i0.setAttribute("value", ui.item.label );
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
                        updateAnsprechpartner();

                        document.getElementById("projektCreateUnternehmenInput").value ="";


                        return false;
                    },
                    minLength: 3
                });

            // Projekte -> Create -> Projektleiter

                $("#projekteCreateProjektleiter").autocomplete({
                    source: '/pauldb2/personen/getAktivePaulisByNameAsJSON',
                    minLength: 3,
                    select: function(event, ui){
                        $('#projekteCreateProjektleiterHidden').val(ui.item.id);
                    }
                });

            // Projekte -> Edit -> Coach

                $("#projekteEditCoach").autocomplete({
                    source: '/pauldb2/personen/getPaulisByNameAsJSON',
                    minLength: 3,
                    select: function(event, ui){
                        $('#projekteEditCoachHidden').val(ui.item.id);
                    }
                });

            // Projektanfrage -> Autocomplete -> Unternehmen

                $("#projektanfrageCreateUnternehmenInput").autocomplete({
                    source: '/pauldb2/projektanfrage/unternehmenAutoComplete', select: function(event, ui) {
                            var table = document.getElementById('projektCreateUHinzuTable');
                            var row = table.insertRow(table.rows.length);
                            var cell1 = row.insertCell(0);
                            var cell2 = row.insertCell(1);

                            var i0 = document.createElement("input");
                            i0.setAttribute("type", "text");
                            i0.setAttribute("name", "uName");
                            i0.setAttribute("style", "width:450")
                            i0.setAttribute("value", ui.item.label );
                            i0.setAttribute("readonly", "true");

                            var link = document.createElement("a");
                            link.setAttribute("href", "#");
                            link.setAttribute("onClick","document.getElementById('projektCreateUHinzuTable').deleteRow(this.parentNode.parentNode.rowIndex);updateKontakte();return false");

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
                            hiddenField.setAttribute("name", "unternehmen");
                            hiddenField.setAttribute("value", ui.item.id);
                            hiddenField.setAttribute("class", "unternehmen_id");

                            cell1.appendChild(hiddenField);
                            updateKontakte();

                            document.getElementById("projektanfrageCreateUnternehmenInput").value ="";


                            return false;
                        },
                        minLength: 3
                    });

            // Unternehmen auswählen -> Hilfe Knopf     unternehmenCreateOberunternehmenMHilfe
                $('#unternehmenHilfe')
                    .button()
                    .click(function() {
                    // Inputbox ist leer
                    var $dialog = $('<div></div>')
                        .html('Bitte wähle über das Eingabefeld links das Unternehmen aus. <br /> ' +
                            '<br /> Nach Eingabe der ersten drei Buchstaben, erhälst du passende Vorschläge.')

                    .dialog({
                        autoOpen: true,
                        title: 'Unternehmen auswählen'
                    });

                    return false;
                });

    }
);
//#################### end onDocumentReady ##################################


// Projekte -> Create & Edit -> Ansprechpartner: update multiselect

function updateAnsprechpartner() {
    // Zwischenspeicher für Mitarbeiter
    var to_display = new Array();

    // Leere Select Options
    $('#ansprechpartner').empty();
    select_feld = document.getElementById("projektanfrage.id");
    // Leere Feld-Select, Speichere ausgewählten Wert
    var selectSave
        if (select_feld.selectedIndex == -1) selectSave = -1
            else selectSave = select_feld.options[select_feld.selectedIndex].value;
    select_feld.options.length = 0;
    select_feld.options[0] = new Option('', null, true, false); //keine Angabe zulassen

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
        $.post("/pauldb2/projektanfrage/getProjektanfragenByUnternehmen/" + value.value, function(data) {

            // Schreibe in Feld-Select alle Daten welche die Datenbankabfrage ausgegeben hat
            for (i = 0; i < data.length; i++) {
                select_feld.options[i+1] = new Option(data[i].bezeichnung, data[i].id, (i == 0), (selectSave == data[i].id));
            }
        });
    });

    // Abschließendes Neuladen des Multiselect für den Fall, das die Liste der Unternehmen leer war
    $('#ansprechpartner').multiselect('destroy');
    $('#ansprechpartner').multiselect();
}

//Projektanfragen - Kontakte updaten
function updateKontakte(){
    // Leere Select Options
    select_feld = document.getElementById("kontakt.id");
    // Leere Feld-Select, Speichere ausgewählten Wert
    var selectSave
        if (select_feld.selectedIndex == -1) selectSave = -1
            else selectSave = select_feld.options[select_feld.selectedIndex].value;
    select_feld.options.length = 0;

    // Für jedes nternehmen:
    // Hole Daten aus der Datenbank (KontaktController)
    $.each(document.getElementsByClassName('unternehmen_id'), function(index, value) {
        $.post("/pauldb2/kontakt/getKontakteByUnternehmen/" + value.value, function(data) {

            // Schreibe in Feld-Select alle Daten welche die Datenbankabfrage ausgegeben hat
            for (i = 0; i < data.length; i++) {
                select_feld.options[i] = new Option(data[i].bezeichnung, data[i].id, (i == 0), (selectSave == data[i].id));
            }
        });
    });
}

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
}