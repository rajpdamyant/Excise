<%@ page import="challan.CreateAccount" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'createAccount.label', default: 'CreateAccount')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>
<body>
<div class="nav">
    <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
    <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]"/></g:link></span>
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

                <g:sortableColumn property="id" title="${message(code: 'createAccount.id.label', default: 'Id')}"/>

                <g:sortableColumn property="username" title="${message(code: 'createAccount.username.label', default: 'Username')}"/>

                <g:sortableColumn property="password" title="${message(code: 'createAccount.password.label', default: 'Password')}"/>

                <g:sortableColumn property="accountExpired" title="${message(code: 'createAccount.accountExpired.label', default: 'Account Expired')}"/>

                <g:sortableColumn property="accountLocked" title="${message(code: 'createAccount.accountLocked.label', default: 'Account Locked')}"/>

                <g:sortableColumn property="email" title="${message(code: 'createAccount.email.label', default: 'Email')}"/>

            </tr>
            </thead>
            <tbody>
            <g:each in="${createAccountInstanceList}" status="i" var="createAccountInstance">
                <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                    <td><g:link action="show" id="${createAccountInstance.id}">${fieldValue(bean: createAccountInstance, field: "id")}</g:link></td>

                    <td>${fieldValue(bean: createAccountInstance, field: "username")}</td>

                    <td>${fieldValue(bean: createAccountInstance, field: "password")}</td>

                    <td><g:formatBoolean boolean="${createAccountInstance.accountExpired}"/></td>

                    <td><g:formatBoolean boolean="${createAccountInstance.accountLocked}"/></td>

                    <td>${fieldValue(bean: createAccountInstance, field: "email")}</td>

                </tr>
            </g:each>
            </tbody>
        </table>
    </div>
    <div class="paginateButtons">
        <g:paginate total="${createAccountInstanceTotal}"/>
    </div>
</div>
</body>
</html>
