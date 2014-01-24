
<%--
  Created by IntelliJ IDEA.
  User: damyant
  Date: 2/25/12
  Time: 3:48 PM
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
<form id="form" name="form">
    <table>
        <tr>
            <td colspan="4" style="text-align:center;font-weight:bold;">

                <div style="margin-bottom:10px;display:inline;" id="dateDiv"></div>
            </td>
            <input type="hidden" name="accountHeadId" value=""/>
        </tr>
        <tr>
            <td>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp;
                <center>Date:<input id="datePickerDate" type="text" readonly="true"></center>

            </td>
        </tr>
        <tr>
            <td><strong>Superintendent Office: &nbsp&nbsp&nbsp ${districtOfficeName}</strong></td>
        </tr>
        <tr>
            <td>Type :
                <select id="accountHeadLiquorType1" name="accountHeadLiquorType1">
                    %{--<option value="0">Choose a Liquor</option>--}%
                    <option value="1">IMFL</option>
                    <option value="2">Country Spirit</option>
                    <option value="3">Denatured Spirit</option>
                    <option value="4">Para_Military</option>
                    <option value="5">Narcotics</option>
                    <option value="6">Rectified Spirit</option>
            </td>
        </tr>
        <tr>
            <td>
                Account Head :&nbsp&nbsp   ${accountHeadId2}
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            </td>
        </tr>
        <tr>
            <td colspan="4">
                <div id="accountHead">
                    <div id="accountHead1">
                        District: <select id="accountHeadDistrictOfficeList1" name="accountHeadDistrictOfficeList1">
                        <option>Choose A District</option>
                        <g:each in="${districtOfficeList}" var="district">
                            <option>${district.name}</option>
                        </g:each>
                    </select>
                        &nbsp&nbsp; Treasury Challan Id:<input type="text" name="accountHeadTreasureId1"
                                                              id="accountHeadTreasureId1"
                                                              maxlength="6" size="6">
                        &nbsp&nbsp;
                        Establishment Id :
                        <select id="accountHeadConsumerId1" name="accountHeadConsumerId1" onchange="Consumer('1')">
                            <option>Choose a Est Id</option>
                            <g:each in="${consumerId}" var="consumerId">
                                <option>${consumerId}</option>
                            </g:each>
                        </select>
                        &nbsp   Establishment Name :<input type="text" name="accountHeadConsumerName1" readonly="true"
                                                           id="accountHeadConsumerName1" size="32">
                        <br> Amount (Rs.):<input type="text" name="accountHeadAmount1" id="accountHeadAmount1" value=""
                                                 onchange="total1('1') " size="10"> &nbsp&nbsp
                      Amount in Words (Rs.):<input type="text" name="accountHeadAmountInWords1"
                                                           id="accountHeadAmountInWords1" value="" size="65"
                                                           readonly="true">
                        Duration:<select id="accountHeadduration1">
                        <option>Choose A Duration</option>
                        <option>2010-2011</option>
                        <option>2011-2012</option>
                    </select>
                        &nbsp; <input type="button" value="+" onclick="AccountHeadDiv()" style="color: red;"
                                      id="AccountHeadButton1"/>&nbsp&nbsp
                    </div>
                    <input type="hidden" name="AccountHeadDetails" value=""/>
                </div>
            </td>
        </tr>
        <tr>
            <td colspan="4">
                <input type="button" value="Submit" onclick="submitForm1()" class="${classs} buttonCss"/>
                <input type="button" value="Cancel" onclick="reset1()" class="${classs} buttonCss"/>
            </td>
        </tr>
            <tr><td colspan="4">
                <div style="color:green;font-weight:bold;" id="flashMsg">
                    ${flash.message}
                </div>
            </td></tr>
    </table>
</form>
<g:form controller="logout" style="display:none;">
    <input type="submit" id="logoutSubmit"/>
</g:form>
<script type="text/javascript">

    $.ready(function () {
        $('#form').submit(function () {
            return false;
        })
    })


    var index;
    index = 1;
    var flag = false;
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

    $("#datePickerDate").datepicker({ changeMonth:true, changeYear:true, dateFormat:'yy-mm-dd', minDate:-30, maxDate:"0", beforeShowDay:noSunday,yearRange:"2011:2012" });


    function noSunday(date) {
        var day = date.getDay();
        return [(day > 0), ''];
    }
    $(".selector").datepicker({ beforeShowDay:$.datepicker.noWeekends })
      $( ".selector" ).datepicker({ yearRange: "2011:2012" });

    /*
     This function is written to return a two digit value appending zero before the single digit value.
     */
    function getTwoDigitDate(date) {
        return (date.length < 2) ? ('0' + date) : date;
    }

    function getCurrentIST() {
        var date = new Date();
        date.setTime(date.getTime() + (date.getTimezoneOffset() + 330) * 60 * 1000);
        var dateString = (1900 + date.getYear()) + "-" + (getTwoDigitDate('' + (date.getMonth() + 1))) + "-" + getTwoDigitDate('' + date.getDate()) + " " + date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds();
        return(dateString);
    }


    function submitForm1() {
        var k = 1;
        var date = new Date();
        date.setTime(date.getTime() + (date.getTimezoneOffset() + 330) * 60 * 1000);
        var dateString = (1900 + date.getYear()) + "-" + (getTwoDigitDate('' + (date.getMonth() + 1))) + "-" + getTwoDigitDate('' + date.getDate()) + " " + date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds();
        var Id = $('#treasureId1').val();
        var accountHeadAmt = $('#accountHeadAmount1').val();
        $('input[name="dataEnteredDate"]').attr('value', $('#dateDiv').text().trim());

        fillWithZero();

        if (Id == '') {
            alert(" Please fill in the treasure id");
        }
        else if ($('#accountHeadTreasureId1').val().trim() < 0) {
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
         else if ($('#accountHeadduration1').val() == 'Choose A Duration ') {

            alert(" Please select Duration");

        }

        else if ($('#accountHeadDistrictOfficeList1').val() == 'Choose A District') {
            alert(" Please fill in the district");
        }
        else if ($('#accountHeadConsumerId1').val() == ' ') {

            alert(" Please fill in the consumer id");

        }
        else if ($('#datePickerDate').val()== '') {
                   alert("Please select the data entry date")
               }

        else if ($('#ConsumerName1').val() == ' ') {

            alert("Please fill in the consumer name");

        }
        else if (!check()) {
//            alert("inside check");
        }

        else {

            var flag = 0;
            var accountHeadId =${accountHeadId2};
            var value = '';
            var consumerId = '';
            var DataEntry = $('#datePickerDate').val();
            var liquorId = $('#accountHeadLiquorType1').val();
            // retrieving the value for customer id for  each row  and passing to the controller
            $('#accountHead > div').each(function () {
                value = customerDetails($(this).attr('id'));
                consumerId = value.split(',')[1];
                $.ajax({
                    url:'${createLink(controller: 'dataCollection', action: 'licenseFee')}',
                    type:"post",
                    data:{dataEnteredDate:dateString, dataEntry:DataEntry,liquorId:liquorId, value:value, accountHeadId:accountHeadId },
                    async:true,
                    success:function (response) {
                        //entry for consumer in current date exists
                               $('#flashMsg').html(response);
                    }
                });
            });
            reset1();
        }
    }


    function customerDetails(id) {
        var value = '';
        // retrieving the value for one particular row
        $('#' + id).each(function () {
            $(this).children().each(function () {
                value += $(this).val() + ','
            });

        });
        return value;
    }


    function check() {
        var name = '';
        var returnResult = true;
        $('#accountHead div').each(function () {
            if (returnResult) {
                $(this).children('[id^="accountHead"]').each(function () {
                    name = $(this).attr('id');
                    name = name.substring(name.indexOf('accountHead') + 11);
                    name = name.substring(0, name.length - 1);

                    if ($(this).val() == '' || $(this).val() == 'Choose A Duration') {
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
                     else if($(this).val() == 'Choose A District') {
                        name = $(this).attr('id');
                        name = name.substring(name.indexOf('accountHead') + 11);
                        name = name.substring(0, name.length - 1);
                        alert('Please Enter the ' + name);
                        returnResult = false;
                        return false;
                    }
                });
            }
            else {
                return false;
            }
        });
        return returnResult
    }


    function AccountHeadDiv() {
        if (index == 1) {
            var temp = $('#accountHeadAmount1').val();
            $('#total').attr('value', temp);
        }
        index++;

        $('#accountHead').append('<div id="accountHead' + index + '" ></div>');
        var districtOfficeList = '${districtOfficeList}'.substring(1, '${districtOfficeList}'.length - 1);
        var districtOfficeArray = districtOfficeList.split(',');
        $('#accountHead' + index).append(' District: <select id="accountHeadDistrict' + index + '"><option>Choose A District</option></select> ');
        $.each(districtOfficeArray, function () {
            $('#accountHeadDistrict' + index).append('<option>' + (this) + '</option>');
        });
        $('#accountHead' + index).append('&nbsp;&nbsp; Treasury Challan Id:<input type="text" size="6"name="accountHeadTreasureId' + index + '" id="accountHeadTreasureId' + index + '" "/>&nbsp&nbsp');
        var list = '${consumerId}'.substring(1, '${consumerId}'.length - 1);
        var Array = list.split(',');
        $('#accountHead' + index).append('&nbsp; Establishment Id: <select id="accountHeadConsumerId' + index + '" onchange="Consumer(\'' + index + '\')"><option>Choose a Est Id</option></select> ');
        $.each(Array, function () {
            $('#accountHeadConsumerId' + index).append('<option>' + (this) + '</option>');
        });
        $('#accountHead' + index).append('&nbsp&nbsp  Establishment Name :<input type="text"  size="32" readonly="true" name="accountHeadConsumerName' + index + '" id="accountHeadConsumerName' + index + '" />');
        $('#accountHead' + index).append('<br> Amount (Rs.):<input type="text" size="10" name="accountHeadAmount' + index + '" id="accountHeadAmount' + index + '"   onchange="total1(\'' + index + '\')"/>&nbsp&nbsp');
        $('#accountHead' + index).append('&nbsp&nbsp;Amount in Words(Rs.):<input type="text" size="65" readonly="true" name="accountHeadAmountInWords' + index + '" id="accountHeadAmountInWords' + index + '" "/>&nbsp');
        $('#accountHead' + index).append('Duration:<select id="accountHeadduration' + index + ' "><option>Choose A Duration</option><option>2010-2011</option><option>2011-2012</option> </select> ');
        $('#accountHead' + index).append('&nbsp;<input type="button" style="color: red;" id="removeButton' + index + '" value="-" onclick="removeAccountHead(\'' + index + '\')"/>');
    }

    function total1(indx) {
        var temp1;
        var Amt = Math.round($('#accountHeadAmount' + indx).val());
        $.get('${createLink(controller: 'dataCollection', action: 'numToWords')}', {Amount:Amt}, function (response) {
            if (response.error == 'access denied') {
                $('input[id="logoutSubmit"]').click();
            }
            else {
                $('#accountHeadAmountInWords' + indx).attr('value', response);
            }
        });
        $('#accountHeadAmount' + indx).attr('value', Amt + '.00');
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


    function Consumer(indx) {
        var consumerId = $('#accountHeadConsumerId' + indx).val();
        $.get('${createLink(controller: 'dataCollection', action: 'autoPopulate')}', {consumerId:consumerId}, function (response) {
            if (response.error == 'access denied') {
                $('input[id="logoutSubmit"]').click();
            }
            else {
                $('#accountHeadConsumerName' + indx).attr('value', response);

            }

        });
    }


    function reset1() {
        $('#accountHeadTreasureId1').val('');
        $('#accountHeadAmount1').val('0.00');
        $('#accountHeadAmountInWords1').val('');
        $('#duration1').val('Choose A Duration');
        $('#accountHeadDistrictOfficeList1').val('Choose a District');
        $('#accountHeadConsumerId1').val(' ');
        $('#accountHeadConsumerName1').val(' ');
        $('#accountHead div').each(function () {
            if ($(this).attr('id') != "accountHead1")
                $(this).remove();
        });
    }

</script>
</body>
</html>