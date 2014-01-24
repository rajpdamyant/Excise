<%--
  Created by IntelliJ IDEA.
  User: damyant
  Date: 1/30/12
  Time: 6:21 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Online Challan Collection System</title>
    <g:javascript library="jquery" plugin="jquery"/>
    <meta name="layout" content="main"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <script type="text/javascript"
            src="${resource(dir: 'js/jQuery', file: 'jquery.ui.datepicker.js')}"></script>
    <script type="text/javascript"
            src="${resource(dir: 'js/jQuery', file: 'jquery.ui.core.js')}"></script>
    <link rel="stylesheet" type="text/css"
          href="${resource(dir: 'css', file: 'jquery-ui-1.8.16.custom.css')}"/>
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
<g:form controller="dataCollection" action="updateCollectionDetails" method="post" id="form" name="form">
    <table style="min-width: 1000px; border: 0px none;">
        <tr>
            <td colspan="4" style="text-align:center;font-weight:bold;">
                <div style="margin-bottom:10px;display:inline;">Data Entry Date :</div>

                <div style="margin-bottom:10px;display:inline;" id="dateDiv"></div>
            </td>
            <input type="hidden" name="dataEnteredDate" value=""/>
        </tr>

        <tr>
            <td><strong>District HQ:</strong></td>
            <td style="text-align: left">
                ${districtOfficeName}
            </td>

        </tr>

        <tr>
            <td colspan="4">
                <div id="accountHead">
                    <div id="accountHead1">

                        Treasury Challan Id: <input type="text" name="treasureId" id="treasureId" maxlength="6"
                                                    size="6">
                        AccountHead&nbsp&nbsp: <input type="text" name="treasureId" id="treasureId" maxlength="6"
                                                      size="6">
                        Amount (Rs.)&nbsp&nbsp :<input type="text" name="accountHeadAmount" id="accountHeadAmount1"
                                                       value="0.00" onchange="total11()" size="6"> &nbsp&nbsp
                    Amount In words&nbsp&nbsp :<input type="text" name="accountHeadAmount" id="accountHeadAmount1"
                                                      onchange="total11()" size="6">
                        Consumer Id &nbsp&nbsp :<input type="text" name="accountHeadAmount" id="accountHeadAmount1"
                                                       value="0.00" onchange="total11()" size="6">
                        Consumer Name &nbsp&nbsp :<input type="text" name="accountHeadAmount" id="accountHeadAmount1"
                                                         onchange="total11()" size="6">


                        <input type="button" value="+" onclick="AccountHeadDiv()"
                               id="AccountHeadButton1"/>&nbsp&nbsp
                    Total(Rs)&nbsp&nbsp :<input type="text" name="total" id="total" value="0.00" readonly="true"
                                                size="6">
                    </div>
                    <input type="hidden" name="AccountHeadDetails" value=""/>

                </div>
            </td>
        </tr>
        <tr>
            <td colspan="4">
                <input type="button" value="Submit" onclick="submitForm1()" class="${classs} buttonCss"/>
                <input type="button" value="Cancel" onclick="reset1()" class="${classs} buttonCss"/>
                <input type="submit" id="submitForm" style="display:none;"/>
            </td>
        </tr>
        <g:if test="${flash.message}">
            <tr><td colspan="4">
                <div style="color:green;font-weight:bold;" id="flashMsg">
                    ${flash.message}
                </div>
            </td></tr>
        </g:if>
    </table>
</g:form>
<g:form controller="logout" style="display:none;">
    <input type="submit" id="logoutSubmit"/>
</g:form>
<script type="text/javascript">
    var index;
    //var oldamt;
    // var flag= "false";
    index = 1;
    var flag = false;
    //   var totalamt = 0;
    window.onbeforeunload = function () {
        $('#flashMsg').html('');
    };
    $('#dateDiv').html(getCurrentIST());

    /*
     This function is written to get Indian Standard Time from
     visitor’s local computer time.

     Added getTimezoneOffset to get GMT/UTC
     Added +330 minutes (IST is +5.5 hrs ahead of GMT) to get IST
     */
    function total11() {

        var temp = $('#accountHeadAmount1').val();
        $('#accountHeadAmount1').attr('value', temp + '.00');
        $('#total').attr('value', temp + '.00');
        var total = 0;
        var temp1;
        $('#accountHead div input[id^="accountHeadAmount"]').each(function() {
            temp1 = Math.round($(this).val() * 100) / 100;

            if (!isNaN(temp1)) {
                total += Math.round(parseFloat(temp1));

            }
        });

        $('#total').attr('value', total + '.00');
    }

    function getCurrentIST() {
        var date = new Date();
        date.setTime(date.getTime() + (date.getTimezoneOffset() + 330) * 60 * 1000);

        var dateString = (1900 + date.getYear()) + "-" + (getTwoDigitDate('' + (date.getMonth() + 1))) + "-" + getTwoDigitDate('' + date.getDate()) + " " + date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds();
        return(dateString);
    }

    /*
     This function is written to return a two digit value appending zero before the single digit value.
     */
    function getTwoDigitDate(date) {
        return (date.length < 2) ? ('0' + date) : date;
    }

    function submitForm1() {


        var date = new Date();
        date.setTime(date.getTime() + (date.getTimezoneOffset() + 330) * 60 * 1000);
        var dateString = (1900 + date.getYear()) + "-" + (getTwoDigitDate('' + (date.getMonth() + 1))) + "-" + getTwoDigitDate('' + date.getDate()) + " " + date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds();
        var Id = $('#treasureId').val();
        var accountHeadId = $('#accountHeadId1').val();
        var accountHeadAmt = $('#accountHeadAmount1').val();
        var comments = $('#accountHeadComment1').val();

        $('input[name="dataEnteredDate"]').attr('value', $('#dateDiv').text().trim());

        fillWithZero();

        if (Id == '') {
            alert(" Please fill in the treasure id");
        }
        else if ($('#treasureId').val().trim() < 0) {
            alert(" Please enter some positive number");
        }
        else if (accountHeadAmt == '') {
            alert(" Please enter the amount");
        }
        else if (($('#accountHeadAmount1').val().trim()) <= 0) {
            alert("Please enter a number greater than 0 ");

        }
        else if (isNaN(accountHeadAmt)) {
            alert("Please enter a number");
            fill();
        }

        else if (!check()) {
            alert("inside check");
        }
        else {

            $.get('${createLink(controller: 'dataCollection', action: 'checkDataEnteredDate')}', {dataEnteredDate:dateString}, function (response) {
                alert("response is " + response);

                if (response == 'true') {
                    if (confirm('Collection For Current Date Exists, Do You Want To Overwrite?')) {
                        if (confirm('You Are Going To Save Collection Details For This superintendent Office')) {

                            accountHeadIdAmtComments();
                            $('#submitForm').click();

                        }
                    }
                }
                else {
                    if (confirm('You Are Going To Save Collection Details For this Superinterdent Office ')) {
                        accountHeadIdAmtComments();
                        $('#submitForm').click();

                    }
                }

            });
        }
    }


    function accountHeadIdAmtComments() {
        var value = '';
        $('#accountHead > div').each(function () {
            $(this).children().each(function () {
                value += $(this).val() + ','
            });
            value = value.substring(0, value.length - 3) + ';';
        });
        $('input[name="AccountHeadDetails"]').attr("value", value);
    }


    function AccountHeadDiv() {

        if (index == 1) {
            var temp = $('#accountHeadAmount1').val();
            $('#total').attr('value', temp);
        }
        index++;

        $('#accountHead').append('<div id="accountHead' + index + '" ></div>');
        $('#accountHead' + index).append('&nbsp Treasury Challan ID&nbsp&nbsp :<input type="text" name="accountHeadAmount' + index + '" id="accountHeadAmount' + index + '"   onchange="total1()"/>&nbsp&nbsp');

        $('#accountHeadId' + index).html('');
        var accountHeadList = '${accountHeadList}'.substring(1, '${accountHeadList}'.length - 1);
        var accountHeadArray = accountHeadList.split(',');

        $.each(accountHeadArray, function () {
            $('#accountHeadId' + index).append('<option>' + (this) + '</option>');
        });

        $('#accountHead' + index).append('&nbsp&nbsp&nbsp&nbsp Amount (Rs.)&nbsp&nbsp :<input type="text" name="accountHeadAmount' + index + '" id="accountHeadAmount' + index + '"   onchange="total1()"/>&nbsp&nbsp');
        $('#accountHead' + index).append('&nbsp&nbsp&nbsp&nbsp Amount in words&nbsp&nbsp :<input type="text" name="accountHeadAmount' + index + '" id="accountHeadAmountinwords ' + index + '" "/>&nbsp&nbsp');

        $('#accountHead' + index).append('&nbsp&nbsp ConsumerID&nbsp&nbsp :<input type="text" name="accountHeadComment' + index + '" id="accountHeadComment' + index + '" />');
        $('#accountHead' + index).append('&nbsp&nbsp ConsumerName&nbsp&nbsp :<input type="text" name="accountHeadComment' + index + '" id="accountHeadComment' + index + '" />');

        $('#accountHead' + index).append('<input type="button" id="removeButton' + index + '" value="-" onclick="removeAccountHead(\'' + index + '\')"/>');

    }

    function total1() {
        var total = 0;
        var temp1;
        // adding all the text boxes values

        $('#accountHead div input[id^="accountHeadAmount"]').each(function() {
            temp1 = Math.round($(this).val() * 100) / 100;

            if (!isNaN(temp1)) {
                total += Math.round(parseFloat(temp1));

            }
        });
        $('#total').attr('value', total + '.00');
    }

    function removeAccountHead(index) {

        temp1 = Math.round($('#accountHeadAmount' + index).val() * 100) / 100;
        if (!isNaN(temp1)) {
            totalamt = Math.round(parseFloat($('#total').val())) - Math.round(parseFloat(temp1));
            var tot = totalamt;
            $('#total').attr('value', tot);
        }
        $('#accountHead' + index).remove();
    }

    function fill() {

        $('#accountHeadAmount1').attr('value', 0.00);
    }

    function fillWithZero() {


        var accountHeadAmt = Math.round($('#accountHeadAmount1').val() * 100) / 100;
        $('#accountHeadAmount1').attr('value', accountHeadAmt);

    }


    function check() {
        var name = '';
        var returnResult = true;
        $('#accountHead div').each(function () {
            if (returnResult) {
                $(this).children('input[id^="accountHead"]').each(function () {
                    name = $(this).attr('id');
                    name = name.substring(name.indexOf('accountHead') + 11);
                    name = name.substring(0, name.length - 1);
                    if ($(this).val() == '') {
                        name = $(this).attr('id');
                        name = name.substring(name.indexOf('accountHead') + 11);
                        name = name.substring(0, name.length - 1);
                        alert('Please Enter the ' + name);
                        returnResult = false;
                        return false;
                    }
                    else if (name == "Amount") {
                        if (isNaN($(this).val())) {
                            alert(" please enter a valid number");

                            returnResult = false;
                            return false;
                        }
                        else if ($(this).val() <= 0) {
                            alert("please enter a positive value");

                            returnResult = false;
                            return false;
                        }
                    }
                });
            }
            else {
                return false;
            }
        });

        return returnResult
    }


    function reset1() {
        $('#treasureId').val('');
        $('#accountHeadAmount1').val('0.00');
        $('#accountHeadComment1').val('')
        $('#total').val('0.00')


        $('#accountHead div').each(function () {
            if ($(this).attr('id') != "accountHead1")
                $(this).remove();
        });
    }

    /*
     function setVal()
     {
     var newamt=
     if(flag== false)
     {
     oldamt=  $('#accountHead' + index).val();
     flag=true;

     }

     else if(flag==true)
     {



     }



     }
     */




</script>
</body>
</html>