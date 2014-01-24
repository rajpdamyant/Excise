<%@ page import="challan.DataEntryWorker" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'dataEntryWorker.label', default: 'DataEntryWorker')}"/>
    <title><g:message code="default.create.label" args="[entityName]"/></title>
</head>

<body>
<div class="nav">
    <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
    </span>
    <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label"
                                                                           args="[entityName]"/></g:link></span>
</div>

<div class="body">
    <h1><g:message code="default.create.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${dataEntryWorkerInstance}">
        <div class="errors">
            <g:renderErrors bean="${dataEntryWorkerInstance}" as="list"/>
        </div>
    </g:hasErrors>
    <g:form action="save">
        <div class="dialog">
            <table>
                <tbody>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="username"><g:message code="dataEntryWorker.username.label"
                                                         default="Username"/></label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: dataEntryWorkerInstance, field: 'username', 'errors')}">
                        <g:textField name="username" value="${dataEntryWorkerInstance?.username}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="password"><g:message code="dataEntryWorker.password.label"
                                                         default="Password"/></label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: dataEntryWorkerInstance, field: 'password', 'errors')}">
                        <g:textField name="password" value="${dataEntryWorkerInstance?.password}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="accountExpired"><g:message code="dataEntryWorker.accountExpired.label"
                                                               default="Account Expired"/></label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: dataEntryWorkerInstance, field: 'accountExpired', 'errors')}">
                        <g:checkBox name="accountExpired" value="${dataEntryWorkerInstance?.accountExpired}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="accountLocked"><g:message code="dataEntryWorker.accountLocked.label"
                                                              default="Account Locked"/></label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: dataEntryWorkerInstance, field: 'accountLocked', 'errors')}">
                        <g:checkBox name="accountLocked" value="${dataEntryWorkerInstance?.accountLocked}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="districtOffice"><g:message code="dataEntryWorker.districtOffice.label"
                                                               default="District Office"/></label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: dataEntryWorkerInstance, field: 'districtOffice', 'errors')}">
                        <g:select name="districtOffice.id" from="${challan.DistrictOffice.list()}" optionKey="id"
                                  value="${dataEntryWorkerInstance?.districtOffice?.id}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="enabled"><g:message code="dataEntryWorker.enabled.label" default="Enabled"/></label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: dataEntryWorkerInstance, field: 'enabled', 'errors')}">
                        <g:checkBox name="enabled" value="${dataEntryWorkerInstance?.enabled}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="passwordExpired"><g:message code="dataEntryWorker.passwordExpired.label"
                                                                default="Password Expired"/></label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: dataEntryWorkerInstance, field: 'passwordExpired', 'errors')}">
                        <g:checkBox name="passwordExpired" value="${dataEntryWorkerInstance?.passwordExpired}"/>
                    </td>
                </tr>

                </tbody>
            </table>
        </div>

        <div class="buttons">
            <span class="button"><g:submitButton name="create" class="save"
                                                 value="${message(code: 'default.button.create.label', default: 'Create')}"/></span>
        </div>
    </g:form>
</div>
</body>
</html>
