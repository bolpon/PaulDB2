$(document).ready(function()
    {
        // Kontakt -> Create -> Unternehmen Autocomplete und Mitarbeiter -----------------------------------------------------

            $("#kontaktCreateUnternehmen").autocomplete({
                source: '/pauldb2/kontakt/unternehmenList', select: function(event, ui) {
                    $.post("/pauldb2/unternehmen/getMitarbeiterByUnternehmenId",{uId: ui.item.id},
                    function(data){
                          for(var i=0;i<data.length;i++){
                                $('#mitarbeiter').append($('<option></option>').val(data[i].id).html((data[i].vorname + " " + data[i].nachname).toString()));
                                $('#mitarbeiter').multiselect('destroy');
                                $('#mitarbeiter').multiselect();
                            }
                            $('#mitarbeiter').multiselect('destroy');
                            $('#mitarbeiter').multiselect();
                    });
                document.getElementById("kontaktCreateUnternehmen").value ="";
                return false;
                },
                 minLength: 3
            });

    }
);
//#################### end onDocumentReady ##################################


