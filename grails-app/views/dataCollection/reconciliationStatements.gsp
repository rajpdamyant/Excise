
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
        margin-left: 194px;
        position: relative;
        text-align: center;
        text-decoration: none !important;
        border-radius: 4px;
        color: #555555;
        font-weight: normal;
        background-color: #e8e6e6;
        font-size: 14px;
        width: 250px;

    }

    .mainDiv1{
        margin-left: 300px;

        }
    </style>
</head>

<body>
<div class="mainDiv1" style="width:48%;border: 1px solid #000000">
<table style="width:100%; border: 0px none;" >
    <tr>
        <td>Select :
            <g:radio value="district" name="selectedOption" checked="checked"/> District
        </td>
        <td>
           <label>Select Option : </label>
            <select id="selectedOptionList">
                        <option>Choose A District</option>
                        <g:each in="${districtList}" var="district">
                            <option>${district}</option>
                        </g:each>
            </select>
        </td>
    </tr>

    <tr>
        <td>
           <label>Year : </label>
            <select id="year">
                <option>- Choose A Year -</option>
                <g:each in="${2005 .. 2020}" var="year">
                    <option>${year}</option>
                </g:each>
            </select>
        </td>
        <td>
           <label> Month : </label>
            <select id="month" style="margin-left: 42px;width:128px">
                <option>Choose a Month</option>
                <g:each in="${monthList}" var="month">
                    <option value="${month.value}">${month.key}</option>
                </g:each>
            </select>
        </td>
    </tr>
    <tr >
        <td colspan="2">
            <input  type="button" value="Show Reconciliation Statements"  class="buttonCss" id="showButton"/>
        </td>
    </tr>
</table>
 </div>
<table style="width: 500px; border: 0px none; margin-top: 50px;" id="reconciliationStatementTable">
    <g:each in="${statementList}" var="statement" status="i">
        <tr>
            <td>
                <g:form controller="dataCollection" action="downloadStatement">
                    <input type="hidden" name="fileName" value="${statement[0]}"/>
                    <input type="hidden" name="filePath" value="${statement[1]}"/>
                    <input type="submit" id="submit${i}" style="display:none"/>
                    <a href="#" onclick="download(${i})">Download ${statement[0]}</a>
                </g:form>
            </td>
        </tr>
    </g:each>
</table>
<g:form controller="logout" style="display:none;">
    <input type="submit" id="logoutSubmit"/>
</g:form>
<script type="text/javascript">
    $('#year').attr('value', (new Date()).getYear() + 1900);
    $('#month').attr('value', (new Date()).getMonth() + 1);

    /*
     On change of the option for circle, division, sub-division or irca
     the selectedOptionList select box is filled.
     */
    $('[name="selectedOption"]').live('change', function() {
        var selectedOption = getSelectedRadio('selectedOption');
        $('#selectedOptionList').html('<option>-Choose An Option-</option>');
        if (selectedOption == 'headQuarter') {
            $('#selectedOptionList').append('<g:each in="${districtList}" var="circle"><option>${district}</option></g:each>');
        }

    });


    $('#showButton').click(function() {
        var year = $('#year').val();
        var month = $('#month').val();
        var domain = $('#selectedOptionList').val();
        var selectedOption = getSelectedRadio('selectedOption');
        var selectedOptionList = $('#selectedOptionList').val().trim();
        if (selectedOptionList == '- Choose An Option -') {
            alert('Please Choose An Option');
        }
        else if (year == '- Choose A Year -') {
            alert('Please Choose A Year');
        }
        else if (year > (new Date()).getYear()+1900) {
            alert('Please Choose Current Or Previous Year');
        }
        else if (month == '- Choose A Month -') {
            alert('Please Choose A Month');
        }
        else if (year==((new Date()).getYear()+1900) && month > (new Date()).getMonth()+1) {
            alert('Please Choose Current Or Previous Month');
        }
        else {
            $.get('${createLink(controller: 'dataCollection', action: 'getStatements')}', {year:year,month:month,domain:domain,selectedOption:selectedOption}, function(response) {
                if (response.error == 'access denied') {
                    $('input[id="logoutSubmit"]').click();
                }
                else {
                    $('#reconciliationStatementTable').html('');
                    for (var i = 0; i < response.length; i++) {
                        $('#reconciliationStatementTable').append('<tr><td id="td' + i + '"></td></tr>');
                        $('#td' + i).append('<g:form controller="dataCollection" action="downloadStatement" id="form' + i + '" name="form' + i + '"></g:form>');
                        $('#form' + i).append('<input type="hidden" name="fileName" value="' + response[i][0] + '"/>');
                        $('#form' + i).append('<input type="hidden" name="filePath" value="' + response[i][1] + '"/>');
                        $('#form' + i).append('<input type="submit"  style="display:none" id="submit' + i + '"/>');
                        $('#form' + i).append('<a href="#" onclick="download(' + i + ')">Download ' + response[i][0] + '</a>');
                    }
                    if($('#reconciliationStatementTable').html()==''){
                         $('#reconciliationStatementTable').append('<tr><td>No Statements Uploaded For '+selectedOption+' : '+domain+' In '+getTwoDigitDate(month)+' / '+year+'</td></tr>');
                    }
                }
            });
        }
    });

    /*
     This function is written to return the selected radio button value.
     */
    function getSelectedRadio(selectedRadio) {
        var value = '';
        $('[name="' + selectedRadio + '"]').each(function() {
            if ($(this).attr('checked'))
                value = $(this).attr('value');
        });
        return value;
    }
    function download(i) {
        $('#submit' + i).click();
    }

    /*
     This function is written to return a two digit value appending zero before the single digit value.
     */
    function getTwoDigitDate(date) {
        return (date.length < 2) ? ('0' + date) : date
    }
</script>
</body>
</html>