/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).ready(function()
    {


	 	$('#loginFormDiv').fadeIn('slow', function() {
	        // Animation complete
	      });



        //Funktion die Unternehmen und Logins aus der Datenbank abfragt, während der Nutzer seine Logindaten eingibt
        //Datenbankverbindung wird damit 'aufgewärmt' und die Daten landen im Cache
        // -> schnelle Anmeldung
        $.post("/pauldb2/dashboard/preloadDB", function(data){
           // alert("loaded..");

        });
    }



        
);