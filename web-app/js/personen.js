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

        //----Autocomplete für Personen->Postenzuordnung

                $(".postenZuordnungInput").each(function(){

                    var pid = $(this).attr('pid');

                    $(this).autocomplete({

                        source: '/pauldb2/personen/getAktivePaulisByNameAsJSON',
                        minLength: 2,
                        select: function(event, ui){
                            $('#postenZuordnungHiddenPerson'+pid).val(ui.item.id);
                        }
                    });
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
}

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
}