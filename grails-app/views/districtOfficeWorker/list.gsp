
<%@ page import="challan.DistrictOfficeWorker" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'districtOfficeWorker.label', default: 'DistrictOfficeWorker')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'districtOfficeWorker.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="username" title="${message(code: 'districtOfficeWorker.username.label', default: 'Username')}" />
                        
                            <g:sortableColumn property="password" title="${message(code: 'districtOfficeWorker.password.label', default: 'Password')}" />
                        
                            <g:sortableColumn property="accountExpired" title="${message(code: 'districtOfficeWorker.accountExpired.label', default: 'Account Expired')}" />
                        
                            <g:sortableColumn property="accountLocked" title="${message(code: 'districtOfficeWorker.accountLocked.label', default: 'Account Locked')}" />
                        
                            <th><g:message code="districtOfficeWorker.districtOffice.label" default="District Office" /></th>
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${districtOfficeWorkerInstanceList}" status="i" var="districtOfficeWorkerInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${districtOfficeWorkerInstance.id}">${fieldValue(bean: districtOfficeWorkerInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: districtOfficeWorkerInstance, field: "username")}</td>
                        
                            <td>${fieldValue(bean: districtOfficeWorkerInstance, field: "password")}</td>
                        
                            <td><g:formatBoolean boolean="${districtOfficeWorkerInstance.accountExpired}" /></td>
                        
                            <td><g:formatBoolean boolean="${districtOfficeWorkerInstance.accountLocked}" /></td>
                        
                            <td>${fieldValue(bean: districtOfficeWorkerInstance, field: "districtOffice.name")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${districtOfficeWorkerInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
