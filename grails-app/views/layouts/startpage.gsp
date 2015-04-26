<html>
    <head>
        <title><g:layoutTitle default="PaulDb2" /></title>
        <link rel="stylesheet" href="${resource(dir:'css',file:'main.css')}" />
        <link rel="stylesheet" href="${resource(dir:'css',file:'jquery-ui-1.8.11.custom.css')}" />
        <link rel="shortcut icon" href="${resource(dir:'images',file:'favicon.ico')}" type="image/x-icon" />
        <g:layoutHead />
        <g:javascript src="jquery/jquery-1.5.2.min.js" />
        <g:javascript src="jquery-ui-1.8.11.custom.min.js" />
        <g:javascript src="startpage.js"/>
    </head>
    <body>
        <div id="spinner" class="spinner" style="display:none;">
            <img src="${resource(dir:'images',file:'spinner.gif')}" alt="Spinner" />
        </div>
        <g:layoutBody />
    </body>
</html>