<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Time: 11:14 AM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Online Excise Reporting System</title>
    <g:javascript library="jquery" plugin="jquery"/>
    <meta name="layout" content="main"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
</head>

<body>
<table style="min-width: 1000px; border: 0px none;">
    <sec:ifAllGranted roles="ROLE_ADMIN,ROLE_HEADQUARTER">
        <tr><td>
            <g:link controller="districtOffice" action="list" style="text-decoration: none;">
                Manage District Office
            </g:link>
        </td></tr>
        <tr><td>
            <g:link controller="districtOfficeWorker" action="list" style="text-decoration: none;">
                Manage District Office Worker
            </g:link>
        </td></tr>
    </sec:ifAllGranted>
    <sec:ifAllGranted roles="ROLE_ADMIN">
        <sec:ifAnyGranted roles="ROLE_HEADQUARTER,ROLE_DISTRICT">
        </sec:ifAnyGranted>
    </sec:ifAllGranted>
</table>
<script type="text/javascript">

</script>
</body>
</html>