$(document).ready(function()
    {
        // Kontakte
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

        // Projektanfrage / Projekte
                    $('#unternehmenCreateHilfe')
                        .button()
                        .click(function() {
                            // Inputbox ist leer
                            var $dialog = $('<div></div>')
                                .html('Bitte wähle über das Eingabefeld links das Unternehmen aus. <br /> ' +
                                    '<br /> Nach Eingabe der ersten beiden Buchstaben, erhälst du passende Vorschläge.')
                                .dialog({
                                    autoOpen: true,
                                    title: 'Kein Unternehmen ausgewählt'
                                });

                            return false;
                    });

        // Unternehmen Oberunternehmen -> Hilfe Knopf
            $('#unternehmenCreateOberunternehmenHilfe')
                .button()
                .click(function() {
                    // Inputbox ist leer
                    var $dialog = $('<div></div>')
                        .html('Bitte wähle über das Eingabefeld links das Unternehmen aus. <br /> ' +
                            '<br /> Nach Eingabe der ersten beiden Buchstaben, erhälst du passende Vorschläge.' +
                            'Falls das Unternehmen kein Oberunternehmen hat, lass das Feld einfach leer')

                        .dialog({
                            autoOpen: true,
                            title: 'Oberunternehmen auswählen'
                        });

                    return false;
                });


            $('#createMitarbeiterHilfe')
                        .button()
                        .click(function() {
                            // Inputbox ist leer
                            var $dialog = $('<div></div>')
                                .html('Bitte wähle über das Eingabefeld links den Mitarbeiter aus. <br /> ' +
                                    '<br /> Nach Eingabe der ersten beiden Buchstaben, erhälst du passende Vorschläge.')
                                .dialog({
                                    autoOpen: true,
                                    title: 'Kein Mitarbeiter ausgewählt'
                                });

                            return false;
            });
    }
);
//#################### end onDocumentReady ##################################
