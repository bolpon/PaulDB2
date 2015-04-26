$(document).ready(function()
{
    $("#search2").hide();

    $("#searchFor").change(function() {
        if ($("#searchFor").val() == "Schulung") {
            $("#search2").hide();
            $("#search1_name").text('Name');

        } else {
            $("#search2").show();
            $("#search1_name").text('Vorname');
        }
    });

});





