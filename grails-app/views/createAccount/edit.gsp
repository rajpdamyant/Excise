<%@ page import="challan.CreateAccount" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'createAccount.label', default: 'CreateAccount')}"/>
    <title><g:message code="default.edit.label" args="[entityName]"/></title>
</head>
<body>
<div class="nav">
    <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
    <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]"/></g:link></span>
    <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]"/></g:link></span>
</div>
<div class="body">
    <h1><g:message code="default.edit.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${createAccountInstance}">
        <div class="errors">
            <g:renderErrors bean="${createAccountInstance}" as="list"/>
        </div>
    </g:hasErrors>
    <g:form method="post">
        <g:hiddenField name="id" value="${createAccountInstance?.id}"/>
        <g:hiddenField name="version" value="${createAccountInstance?.version}"/>
        <div class="dialog">
            <table>
                <tbody>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="username"><g:message code="createAccount.username.label" default="Username"/></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: createAccountInstance, field: 'username', 'errors')}">
                        <g:textField name="username" value="${createAccountInstance?.username}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="password"><g:message code="createAccount.password.label" default="Password"/></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: createAccountInstance, field: 'password', 'errors')}">
                        <g:textField name="password" value="${createAccountInstance?.password}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="accountExpired"><g:message code="createAccount.accountExpired.label" default="Account Expired"/></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: createAccountInstance, field: 'accountExpired', 'errors')}">
                        <g:checkBox name="accountExpired" value="${createAccountInstance?.accountExpired}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="accountLocked"><g:message code="createAccount.accountLocked.label" default="Account Locked"/></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: createAccountInstance, field: 'accountLocked', 'errors')}">
                        <g:checkBox name="accountLocked" value="${createAccountInstance?.accountLocked}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="email"><g:message code="createAccount.email.label" default="Email"/></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: createAccountInstance, field: 'email', 'errors')}">
                        <g:textField name="email" value="${createAccountInstance?.email}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="enabled"><g:message code="createAccount.enabled.label" default="Enabled"/></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: createAccountInstance, field: 'enabled', 'errors')}">
                        <g:checkBox name="enabled" value="${createAccountInstance?.enabled}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="passwordExpired"><g:message code="createAccount.passwordExpired.label" default="Password Expired"/></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: createAccountInstance, field: 'passwordExpired', 'errors')}">
                        <g:checkBox name="passwordExpired" value="${createAccountInstance?.passwordExpired}"/>
                    </td>
                </tr>

                </tbody>
            </table>
        </div>
        <div class="buttons">
            <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}"/></span>
            <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/></span>
        </div>
    </g:form>
</div>
</body>
</html>
