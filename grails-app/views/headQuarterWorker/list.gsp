
<%@ page import="challan.HeadQuarterWorker" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'headQuarterWorker.label', default: 'HeadQuarterWorker')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'headQuarterWorker.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="username" title="${message(code: 'headQuarterWorker.username.label', default: 'Username')}" />
                        
                            <g:sortableColumn property="password" title="${message(code: 'headQuarterWorker.password.label', default: 'Password')}" />
                        
                            <g:sortableColumn property="accountExpired" title="${message(code: 'headQuarterWorker.accountExpired.label', default: 'Account Expired')}" />
                        
                            <g:sortableColumn property="accountLocked" title="${message(code: 'headQuarterWorker.accountLocked.label', default: 'Account Locked')}" />
                        
                            <g:sortableColumn property="enabled" title="${message(code: 'headQuarterWorker.enabled.label', default: 'Enabled')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${headQuarterWorkerInstanceList}" status="i" var="headQuarterWorkerInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${headQuarterWorkerInstance.id}">${fieldValue(bean: headQuarterWorkerInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: headQuarterWorkerInstance, field: "username")}</td>
                        
                            <td>${fieldValue(bean: headQuarterWorkerInstance, field: "password")}</td>
                        
                            <td><g:formatBoolean boolean="${headQuarterWorkerInstance.accountExpired}" /></td>
                        
                            <td><g:formatBoolean boolean="${headQuarterWorkerInstance.accountLocked}" /></td>
                        
                            <td><g:formatBoolean boolean="${headQuarterWorkerInstance.enabled}" /></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${headQuarterWorkerInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
