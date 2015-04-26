<table class="tableList">
                    <thead>
                        <tr>
                            <g:sortableColumn property="id" title="${message(code: 'personen.id.label', default: 'Id')}" />

                            <g:sortableColumn property="anrede" title="${message(code: 'personen.anrede.label', default: 'Anrede')}" />

                            <g:sortableColumn property="vorname" title="${message(code: 'personen.vorname.label', default: 'Vorname')}" />

                            <g:sortableColumn property="nachname" title="${message(code: 'personen.nachname.label', default: 'Nachname')}" />

                            <g:sortableColumn property="hobbys" title="${message(code: 'personen.hobbys.label', default: 'Hobbys')}" />

                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${personenInstanceList}" status="i" var="personenInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                            <td><g:link action="show" id="${personenInstance.id}">${fieldValue(bean: personenInstance, field: "id")}</g:link></td>

                            <td>${fieldValue(bean: personenInstance, field: "anrede")}</td>

                            <td><g:link action="show" id="${personenInstance.id}">${fieldValue(bean: personenInstance, field: "vorname")}</g:link></td>

                            <td><g:link action="show" id="${personenInstance.id}">${fieldValue(bean: personenInstance, field: "nachname")}</g:link></td>

                            <td>${fieldValue(bean: personenInstance, field: "hobbys")}</td>

                        </tr>
                    </g:each>
                    </tbody>
                </table>
              <div class="paginateButtons" params="['personstatus':opt]" action="ajaxList">
                <g:paginate total="${personenInstanceTotal}" wahl="${wahl}" />
              </div>