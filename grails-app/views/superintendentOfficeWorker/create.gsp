

<%@ page import="challan.SuperintendentOfficeWorker" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'superintendentOfficeWorker.label', default: 'SuperintendentOfficeWorker')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${superintendentOfficeWorkerInstance}">
            <div class="errors">
                <g:renderErrors bean="${superintendentOfficeWorkerInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="username"><g:message code="superintendentOfficeWorker.username.label" default="Username" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: superintendentOfficeWorkerInstance, field: 'username', 'errors')}">
                                    <g:textField name="username" value="${superintendentOfficeWorkerInstance?.username}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="password"><g:message code="superintendentOfficeWorker.password.label" default="Password" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: superintendentOfficeWorkerInstance, field: 'password', 'errors')}">
                                    <g:textField name="password" value="${superintendentOfficeWorkerInstance?.password}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="accountExpired"><g:message code="superintendentOfficeWorker.accountExpired.label" default="Account Expired" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: superintendentOfficeWorkerInstance, field: 'accountExpired', 'errors')}">
                                    <g:checkBox name="accountExpired" value="${superintendentOfficeWorkerInstance?.accountExpired}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="accountLocked"><g:message code="superintendentOfficeWorker.accountLocked.label" default="Account Locked" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: superintendentOfficeWorkerInstance, field: 'accountLocked', 'errors')}">
                                    <g:checkBox name="accountLocked" value="${superintendentOfficeWorkerInstance?.accountLocked}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="enabled"><g:message code="superintendentOfficeWorker.enabled.label" default="Enabled" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: superintendentOfficeWorkerInstance, field: 'enabled', 'errors')}">
                                    <g:checkBox name="enabled" value="${superintendentOfficeWorkerInstance?.enabled}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="passwordExpired"><g:message code="superintendentOfficeWorker.passwordExpired.label" default="Password Expired" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: superintendentOfficeWorkerInstance, field: 'passwordExpired', 'errors')}">
                                    <g:checkBox name="passwordExpired" value="${superintendentOfficeWorkerInstance?.passwordExpired}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="superintendentOffice"><g:message code="superintendentOfficeWorker.superintendentOffice.label" default="Superintendent Office" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: superintendentOfficeWorkerInstance, field: 'superintendentOffice', 'errors')}">
                                    <g:select name="superintendentOffice.id" from="${challan.SuperintendentOffice.list()}" optionKey="id" optionValue="name" value="${superintendentOfficeWorkerInstance?.superintendentOffice?.id}"  />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
