

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
     <title>Online Excise Reporting System</title>
    <g:javascript library="jquery" plugin="jquery"/>
    <meta name="layout" content="main"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <script type="text/javascript"
            src="${resource(dir: 'DataTables-1.8.2', file: 'media/js/jquery.dataTables.js')}"></script>
    <script type="text/javascript"
            src="${resource(dir: 'DataTables-1.8.2', file: 'media/js/jquery.jquery.js')}"></script>
    <script type="text/javascript"
            src="${resource(dir: 'TableTools-2.0.1', file: 'media/js/TableTools.js')}"></script>
    <script type="text/javascript"
            src="${resource(dir: 'TableTools-2.0.1', file: 'media/js/ZeroClipboard.js')}"></script>
    <script type="text/javascript"
            src="${resource(dir: 'js/jQuery', file: 'jquery.ui.datepicker.js')}"></script>
    <script type="text/javascript"
            src="${resource(dir: 'js/jQuery', file: 'jquery.ui.core.js')}"></script>
    <script type="text/javascript"
            src="${resource(dir: 'js/jQuery', file: 'jquery-ui-1.8.15.custom.js')}"></script>
    <link rel="stylesheet" type="text/css"
          href="${resource(dir: 'DataTables-1.8.2', file: 'media/css/demo_table.css')}"/>
    <link rel="stylesheet" type="text/css"
          href="${resource(dir: 'DataTables-1.8.2', file: 'media/css/demo_page.css')}"/>
    <link rel="stylesheet" type="text/css"
          href="${resource(dir: 'DataTables-1.8.2', file: 'examples/examples_support/themes/redmond/jquery-ui-1.8.16.custom.css')}"/>
    <link rel="stylesheet" type="text/css"
          href="${resource(dir: 'TableTools-2.0.1', file: 'media/css/TableTools.css')}"/>
    <style type="text/css">


    class for hover
    input.buttonCss:hover {
        color: #999999;
        border: 1px solid #999999;
        font-weight: bold;
    }

    input.buttonCss {
        cursor: pointer;
        display: inline;
        overflow: visible;
        padding: 4px;
        position: relative;
        text-align: center;
        text-decoration: none !important;
        border-radius: 4px;
        color: #555555;
        font-weight: normal;
        background-color: #e8e6e6;
        font-size: 14px;
        width: 120px;
    }
    </style>
</head>

<body>
%{--<form id="form" name="form">--}%
<table style="width: 500px; border: 0px none; margin-left: 350px; margin-top: 50px;">
    <g:form controller="dataCollection" action="saveStatement" enctype="multipart/form-data" method="post">

        <tr>
            <td style="font-size:14px;">
                Upload File :
            </td>
            <td>
                <input type="file" name="reconciliationStatementFile" id="reconciliationStatementFile" size="25"/>
            </td>
        </tr>
        <tr>
            <td colspan="2" style="text-align:center;">
                <input type="submit" value="Upload" id="uploadButton" style="display:none;" />
                <input type="button" value="Upload" class="buttonCss" onclick="upload();"/>
            </td>
        </tr>
    </g:form>
    <tr>
        <td colspan="2" style="text-align:center;color:green;font-weight:bold;font-size:14px;">
            ${flash.message}
        </td>
    </tr>
</table>
<script type="text/javascript">
    function upload() {
        var reconciliationStatementFile = $('#reconciliationStatementFile').attr('value');
        if (reconciliationStatementFile == '') {
             alert('Please Browse A File To Upload.');
        }
        else{
//            alert("upload");
            $('#uploadButton').click();
        }
    }
</script>
 %{--</form>--}%
</body>
</html>