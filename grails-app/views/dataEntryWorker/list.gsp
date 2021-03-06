<%@ page import="challan.DataEntryWorker" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'dataEntryWorker.label', default: 'DataEntryWorker')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<div class="nav">
    <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
    </span>
    <span class="menuButton"><g:link controller="dataEntryWorker" action="create"><g:message code="default.new.label"
                                                                               args="[entityName]"/></g:link></span>
</div>

<div class="body">
    <h1><g:message code="default.list.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <div class="list">
        <table>
            <thead>
            <tr>

                <g:sortableColumn property="id" title="${message(code: 'dataEntryWorker.id.label', default: 'Id')}"/>

                <g:sortableColumn property="username"
                                  title="${message(code: 'dataEntryWorker.username.label', default: 'Username')}"/>

                <g:sortableColumn property="password"
                                  title="${message(code: 'dataEntryWorker.password.label', default: 'Password')}"/>

                <g:sortableColumn property="accountExpired"
                                  title="${message(code: 'dataEntryWorker.accountExpired.label', default: 'Account Expired')}"/>

                <g:sortableColumn property="accountLocked"
                                  title="${message(code: 'dataEntryWorker.accountLocked.label', default: 'Account Locked')}"/>

                <th><g:message code="dataEntryWorker.districtOffice.label" default="District Office"/></th>

            </tr>
            </thead>
            <tbody>
            <g:each in="${dataEntryWorkerInstanceList}" status="i" var="dataEntryWorkerInstance">
                <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                    <td><g:link action="show"
                                id="${dataEntryWorkerInstance.id}">${fieldValue(bean: dataEntryWorkerInstance, field: "id")}</g:link></td>

                    <td>${fieldValue(bean: dataEntryWorkerInstance, field: "username")}</td>

                    <td>${fieldValue(bean: dataEntryWorkerInstance, field: "password")}</td>

                    <td><g:formatBoolean boolean="${dataEntryWorkerInstance.accountExpired}"/></td>

                    <td><g:formatBoolean boolean="${dataEntryWorkerInstance.accountLocked}"/></td>

                    <td>${fieldValue(bean: dataEntryWorkerInstance, field: "districtOffice")}</td>

                </tr>
            </g:each>
            </tbody>
        </table>
    </div>

    <div class="paginateButtons">
        <g:paginate total="${dataEntryWorkerInstanceTotal}"/>
    </div>
</div>
</body>
</html>
