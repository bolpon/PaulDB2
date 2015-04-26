$(document).ready(function(){
  // Quicksearch

               //jQuery autocompleter überschreiben für Kategorien in der Quicksearch


               $('#loading')
                    .hide()  // hide it initially
                    .ajaxStart(function() {
                        $(this).show();
                    })
                    .ajaxStop(function() {
                        $(this).hide();
               });

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



                            /*
                            if(ui.item.art == "personen"){
                                form.setAttribute("action","/pauldb2/personen/show/"+ui.item.id)
                            }
                            else if (ui.item.art == "unternehmen"){
                                form.setAttribute("action","/pauldb2/unternehmen/show/"+ui.item.id)
                            }

                            */
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

                // Auswahlliste für multiple Select
                    $(".multiselect").multiselect();



});