$(document).ready(function(){


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
}

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
}

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
}