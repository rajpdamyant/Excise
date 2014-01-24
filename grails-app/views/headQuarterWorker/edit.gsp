

<%@ page import="challan.HeadQuarterWorker" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'headQuarterWorker.label', default: 'HeadQuarterWorker')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${headQuarterWorkerInstance}">
            <div class="errors">
                <g:renderErrors bean="${headQuarterWorkerInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${headQuarterWorkerInstance?.id}" />
                <g:hiddenField name="version" value="${headQuarterWorkerInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="username"><g:message code="headQuarterWorker.username.label" default="Username" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: headQuarterWorkerInstance, field: 'username', 'errors')}">
                                    <g:textField name="username" value="${headQuarterWorkerInstance?.username}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="password"><g:message code="headQuarterWorker.password.label" default="Password" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: headQuarterWorkerInstance, field: 'password', 'errors')}">
                                    <g:textField name="password" value="${headQuarterWorkerInstance?.password}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="accountExpired"><g:message code="headQuarterWorker.accountExpired.label" default="Account Expired" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: headQuarterWorkerInstance, field: 'accountExpired', 'errors')}">
                                    <g:checkBox name="accountExpired" value="${headQuarterWorkerInstance?.accountExpired}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="accountLocked"><g:message code="headQuarterWorker.accountLocked.label" default="Account Locked" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: headQuarterWorkerInstance, field: 'accountLocked', 'errors')}">
                                    <g:checkBox name="accountLocked" value="${headQuarterWorkerInstance?.accountLocked}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="enabled"><g:message code="headQuarterWorker.enabled.label" default="Enabled" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: headQuarterWorkerInstance, field: 'enabled', 'errors')}">
                                    <g:checkBox name="enabled" value="${headQuarterWorkerInstance?.enabled}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="headQuarter"><g:message code="headQuarterWorker.headQuarter.label" default="Head Quarter" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: headQuarterWorkerInstance, field: 'headQuarter', 'errors')}">
                                    <g:select name="headQuarter.id" from="${challan.HeadQuarter.list()}" optionKey="id" optionValue="name" value="${headQuarterWorkerInstance?.headQuarter?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="passwordExpired"><g:message code="headQuarterWorker.passwordExpired.label" default="Password Expired" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: headQuarterWorkerInstance, field: 'passwordExpired', 'errors')}">
                                    <g:checkBox name="passwordExpired" value="${headQuarterWorkerInstance?.passwordExpired}" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
