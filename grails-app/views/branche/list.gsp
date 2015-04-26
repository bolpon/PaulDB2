

<html>
   <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="dashboard" />
        <g:set var="entityName" value="${message(code: 'branche.label', default: 'Branche')}" />
        <title><g:message code="Brachen Übersicht" args="[entityName]" /></title>
    </head>
    <body>

        <div class="body">
            <h1><g:message code="Übersicht Branchen" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'branche.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="branche" title="${message(code: 'branche.branche.label', default: 'Branche')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${brancheInstanceList}" status="i" var="brancheInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${brancheInstance.id}">${fieldValue(bean: brancheInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: brancheInstance, field: "branche")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
              <div class="paginateButtons">
                <g:paginate total="${brancheInstanceTotal}" />
              </div>
            </div>
        </div>

    </body>
</html>
