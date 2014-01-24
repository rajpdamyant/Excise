
<%@ page import="challan.DistrictOffice" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'districtOffice.label', default: 'DistrictOffice')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'districtOffice.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="name" title="${message(code: 'districtOffice.name.label', default: 'Name')}" />
                        
                            <th><g:message code="districtOffice.headquarter.label" default="Headquarter" /></th>
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${districtOfficeInstanceList}" status="i" var="districtOfficeInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${districtOfficeInstance.id}">${fieldValue(bean: districtOfficeInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: districtOfficeInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: districtOfficeInstance, field: "headQuarter.name")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${districtOfficeInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
