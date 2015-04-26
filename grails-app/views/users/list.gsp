

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Users List</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${resource(dir:'')}">Home</a></span>
            <span class="menuButton"><g:link class="create" action="create">New Users</g:link></span>
        </div>
        <div class="body">
            <h1>Users List</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                   	        <g:sortableColumn property="id" title="Id" />

                   	        <g:sortableColumn property="matVertrag" title="matVertrag" />

                   	        <g:sortableColumn property="matReal" title="matReal" />

                   	        <g:sortableColumn property="tagessatz" title="tagessatz" />

                   	        <g:sortableColumn property="projektname" title="projektname" />

                   	        <g:sortableColumn property="gbRName" title="gbRName" />
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${usersInstanceList}" status="i" var="usersInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${usersInstance.id}">${fieldValue(bean:usersInstance, field:'id')}</g:link></td>
                            <td>${fieldValue(bean:usersInstance, field:'matVertrag')}</td>
                            <td>${fieldValue(bean:usersInstance, field:'matReal')}</td>
                            <td>${fieldValue(bean:usersInstance, field:'tagessatz')}</td>
                            <td>${fieldValue(bean:usersInstance, field:'projektname')}</td>
                            <td>${fieldValue(bean:usersInstance, field:'gbRName')}</td>
                            
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${usersInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
