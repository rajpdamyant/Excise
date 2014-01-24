
<%@ page import="challan.SuperintendentOfficeWorker" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'superintendentOfficeWorker.label', default: 'SuperintendentOfficeWorker')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'superintendentOfficeWorker.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="username" title="${message(code: 'superintendentOfficeWorker.username.label', default: 'Username')}" />
                        
                            <g:sortableColumn property="password" title="${message(code: 'superintendentOfficeWorker.password.label', default: 'Password')}" />
                        
                            <g:sortableColumn property="accountExpired" title="${message(code: 'superintendentOfficeWorker.accountExpired.label', default: 'Account Expired')}" />
                        
                            <g:sortableColumn property="accountLocked" title="${message(code: 'superintendentOfficeWorker.accountLocked.label', default: 'Account Locked')}" />
                        
                            <g:sortableColumn property="enabled" title="${message(code: 'superintendentOfficeWorker.enabled.label', default: 'Enabled')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${superintendentOfficeWorkerInstanceList}" status="i" var="superintendentOfficeWorkerInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${superintendentOfficeWorkerInstance.id}">${fieldValue(bean: superintendentOfficeWorkerInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: superintendentOfficeWorkerInstance, field: "username")}</td>
                        
                            <td>${fieldValue(bean: superintendentOfficeWorkerInstance, field: "password")}</td>
                        
                            <td><g:formatBoolean boolean="${superintendentOfficeWorkerInstance.accountExpired}" /></td>
                        
                            <td><g:formatBoolean boolean="${superintendentOfficeWorkerInstance.accountLocked}" /></td>
                        
                            <td><g:formatBoolean boolean="${superintendentOfficeWorkerInstance.enabled}" /></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${superintendentOfficeWorkerInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
