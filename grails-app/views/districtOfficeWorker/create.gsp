

<%@ page import="challan.DistrictOfficeWorker" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'districtOfficeWorker.label', default: 'DistrictOfficeWorker')}" />
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
            <g:hasErrors bean="${districtOfficeWorkerInstance}">
            <div class="errors">
                <g:renderErrors bean="${districtOfficeWorkerInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="username"><g:message code="districtOfficeWorker.username.label" default="Username" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: districtOfficeWorkerInstance, field: 'username', 'errors')}">
                                    <g:textField name="username" value="${districtOfficeWorkerInstance?.username}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="password"><g:message code="districtOfficeWorker.password.label" default="Password" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: districtOfficeWorkerInstance, field: 'password', 'errors')}">
                                    <g:textField name="password" value="${districtOfficeWorkerInstance?.password}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="accountExpired"><g:message code="districtOfficeWorker.accountExpired.label" default="Account Expired" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: districtOfficeWorkerInstance, field: 'accountExpired', 'errors')}">
                                    <g:checkBox name="accountExpired" value="${districtOfficeWorkerInstance?.accountExpired}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="accountLocked"><g:message code="districtOfficeWorker.accountLocked.label" default="Account Locked" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: districtOfficeWorkerInstance, field: 'accountLocked', 'errors')}">
                                    <g:checkBox name="accountLocked" value="${districtOfficeWorkerInstance?.accountLocked}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="districtOffice"><g:message code="districtOfficeWorker.districtOffice.label" default="District Office" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: districtOfficeWorkerInstance, field: 'districtOffice', 'errors')}">
                                    <g:select name="districtOffice.id" from="${challan.DistrictOffice.list()}" optionKey="id" optionValue="name" value="${districtOfficeWorkerInstance?.districtOffice?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="enabled"><g:message code="districtOfficeWorker.enabled.label" default="Enabled" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: districtOfficeWorkerInstance, field: 'enabled', 'errors')}">
                                    <g:checkBox name="enabled" value="${districtOfficeWorkerInstance?.enabled}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="passwordExpired"><g:message code="districtOfficeWorker.passwordExpired.label" default="Password Expired" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: districtOfficeWorkerInstance, field: 'passwordExpired', 'errors')}">
                                    <g:checkBox name="passwordExpired" value="${districtOfficeWorkerInstance?.passwordExpired}" />
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
