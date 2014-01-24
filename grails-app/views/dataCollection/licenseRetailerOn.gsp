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
            src="${resource(dir: 'js/jQuery', file: 'jquery.ui.core.js')}"></script>
    <link rel="stylesheet" type="text/css"
          href="${resource(dir: 'css', file: 'jquery-ui-1.8.16.custom.css')}"/>
    <script type="text/javascript"
            src="${resource(dir: 'js', file: 'validation-en.js')}"></script>
    <script type="text/javascript"
            src="${resource(dir: 'js', file: 'validation-engine.js')}"></script>

</head>

<body>
<form id="formID1">

    <table width="100%">
        <tr>
            <td colspan="4" style="text-align:center;font-weight:bold;">

                <div style="margin-bottom:10px;display:inline;" id="dateDiv"></div>
            </td>
            <input type="hidden" name="accountHeadId" value="${accountHeadId2}"/>
        </tr>
        <tr>
            <td><strong>Superintendent Office:  ${districtOfficeName}</strong></td>

        </tr>
        <tr>
            <td style="width:20%"> <label>Type : &nbsp; </label>
                <select class="validate[required,custom[select]]text-input" id="accountHeadLiquorType1" name="accountHeadLiquorType" >
                    <option value="0">Choose a Liquor</option>
                    <option value="1">IMFL</option>
                    <option value="2">Country Spirit</option>
                    <option value="3">Denatured Spirit</option>
                    <option value="4">Para_Military</option>
                    <option value="5">Narcotics</option>
                    <option value="6">Rectified Spirit</option>
                </select>
            </td>
            <td colspan="2">
                <label>Date:&nbsp;&nbsp;</label><input name="selectedDate" id="datePickerDate" type="text" readonly="true" class="validate[required,custom[selectDate]]text-input">
            </td>
        </tr>
        <tr>
            <td>
                Account Head :&nbsp;&nbsp;   ${accountHeadId2}

            </td>
        </tr>
    </table>

    <div class="middleDiv" id="accountHead">

    </div>
    <table style="border: none">
        <tr>
            <td colspan="4">
                <input type="submit" value="Submit" onclick="submitForm()" class="${classs} buttonCss"/>
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
    var index=0;
    $(document).ready(function () {

        AccountHeadDiv() ;
    })



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
    // $( "#datePickerDate" ).datepicker();
    // $('#datePickerDate').val(((theDate).getFullYear()) + '-' + getTwoDigitDate('' + ((theDate).getMonth() + 1)) + '-' + getTwoDigitDate('' + (theDate).getDate()));


    $("#datePickerDate").datepicker({ changeMonth:true, changeYear:true, dateFormat:'yy-mm-dd', minDate:-30, maxDate:"0", beforeShowDay:noSunday,yearRange:"2011:2012" });


    function noSunday(date) {
        var day = date.getDay();
        return [(day > 0), ''];
    }
    $(".selector").datepicker({ beforeShowDay:$.datepicker.noWeekends })
      $( ".selector" ).datepicker({ yearRange: "2011:2012" });
    // $("#datePickerDate").datepicker({ changeMonth: true,changeYear: true,dateFormat: 'yy-mm-dd' ,minDate: -30, maxDate: "0",beforeShowDay: noSunday });


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
        // var dateString = '';
        return(dateString);
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
        //$('input[name="AccountHeadDetails"]').attr("value", value);

    }



    function AccountHeadDiv() {

        if (index == 0) {
            var temp = $('#accountHeadAmount1').val();
            $('#total').attr('value', temp);
        }
        index++;

        $('#accountHead').append('<div class="middleDiv" id="accountHead' + index + '" ></div>');
        var districtOfficeList = '${districtOfficeList}'.substring(1, '${districtOfficeList}'.length - 1);
        var districtOfficeArray = districtOfficeList.split(',');
        $('#accountHead' + index).append('<div style="width:80%"> <div class="districtDiv"><label>District :</label></div>'+
                '<div class="distSelectBox"><select style="width: 130px" class="validate[required,custom[select]] text-input" name="districtOfficeList" id="accountHeadDistrict' + index + '"><option>Choose a District</option></select></div> ');
        $.each(districtOfficeArray, function () {
        $('#accountHeadDistrict' + index).append('<option>' + (this) + '</option>');
        });


        $('#accountHead' + index).append('<div class="treasureLabelDiv"> Treasury Challan Id: </div>' +
                '<div class="treasureInputDiv2"><input type="text" class="validate[required,custom[integer]] text-input" style="width: 150px" name="accountHeadTreasureId" id="accountHeadTreasureId' + index + '" "/></div>');


        var list = '${consumerId}'.substring(1, '${consumerId}'.length - 1);
        var Array = list.split(',');


        $('#accountHead' + index).append('<div class="estIdLabel2"> Establishment Id: </div> ' +
        '<div class="estIdSelect1"><select style="width:125px" class="validate[required,custom[select]] text-input" name="accountHeadConsumerId" id="accountHeadConsumerId' + index + '" onchange="Consumer(\'' + index + '\')"><option>Choose a Est Id</option></select></div> ');
        $.each(Array, function () {
            $('#accountHeadConsumerId' + index).append('<option>' + (this) + '</option>');

        });


        $('#accountHead' + index).append('<div class="estNameLabel"> Establishment Name : </div> ' +
                '<div class="estNameBox"><input type="text" style="width: 124px" readonly="true" name="accountHeadConsumerName" id="accountHeadConsumerName' + index + '" /></div>');

        if(index==1){
            $('#accountHead' + index).append('<div style="width:100%;float: left;padding-top: 2px"><div class="amountLabel">Amount (Rs.):</div>' +
                    ' <div class="amountBox"><input type="text" placeholder="0.00" style="width: 130px" class="validate[required,custom[number]] text-input" name="accountHeadAmount" id="accountHeadAmount' + index + '" onchange="total1(\'' + index + '\')"/></div>' +
                    '<div class="amountwordslabel">Amount in Words. (Rs.):</div><div class="amountWordsBox1"><input type="text" readonly="true" style="width:95%" name="accountHeadAmountInWords" id="accountHeadAmountInWords' + index + '" "/></div>' +
                    '<div class="durationDiv">Duration:&nbsp;&nbsp;<select name="duration" class="validate[required,custom[select]] text-input" id="accountHeadduration' + index + ' "><option>Choose a Duration</option><option>2010-2011</option><option>2011-2012</option> </select></div>'+
                    '<div style="float: left;padding-left: 4px"> <input type="button" style="color: red" onclick="AccountHeadDiv()"  value="+" /></div></div>');
                   }
        else{
            $('#accountHead' + index).append('<div style="width:100%;float: left;padding-top: 2px"><div class="amountLabel">Amount (Rs.):</div>' +
                    ' <div class="amountBox"><input type="text" placeholder="0.00" style="width: 130px" class="validate[required,custom[number]] text-input" name="accountHeadAmount" id="accountHeadAmount' + index + '" onchange="total1(\'' + index + '\')"/></div>' +
                    '<div class="amountwordslabel">Amount in Words. (Rs.):</div><div class="amountWordsBox1"><input type="text" readonly="true" style="width:95%" name="accountHeadAmountInWords" id="accountHeadAmountInWords' + index + '" "/></div>' +
                    '<div class="durationDiv">Duration:&nbsp;<select name="duration" class="validate[required,custom[select]] text-input" id="accountHeadduration' + index + ' "><option>Choose a Duration</option><option>2010-2011</option><option>2011-2012</option> </select></div>'+
                    '<div style="float: left;padding-left: 11px"> <input type="button" style="color: red" id="removeButton' + index + '" value="-" onclick="removeAccountHead(\'' + index + '\')"/></div></div>');

        }


    }

    function total1(indx) {

        var temp1;
        var Amt = Math.round($('#accountHeadAmount' + indx).val());
        $.get('${createLink(controller: 'dataCollection', action: 'numToWords')}', {Amount:Amt}, function (response) {
            if (response.error == 'access denied') {
//                     alert("response");
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


    function Consumer(indx) {

        var consumerId = $('#accountHeadConsumerId' + indx).val();

        $.get('${createLink(controller: 'dataCollection', action: 'autoPopulate')}', {consumerId:consumerId}, function (response) {
            if (response.error == 'access denied') {
//                     alert("response");
                $('input[id="logoutSubmit"]').click();
            }
            else {
                $('#accountHeadConsumerName' + indx).attr('value', response);

            }

        });


    }

    function submitForm() {

        var count=0;
        jQuery("#formID1").validationEngine('attach', {
            onValidationComplete: function(form, status){
                if (status == true) {

                    if(count==0){
                        count++
                        $.ajax({
                            type:"post",
                            url:'${createLink(controller: 'dataCollection', action: 'licenseFee')}',
                            data:$('#formID1').serialize() ,
                            success:function (response) {
                                reset1();
                                $('#msg').html(response);

                            }
                            ,error:function(XMLHttpRequest, textStatus, errorThrown) {
                            }
                        });
                    }

                }
            }
        });

    }


    function reset1() {
        $('#accountHeadTreasureId1').val('');
        $('#accountHeadAmount1').val('');
        $('#accountHeadAmountInWords1').val('');
        $('#duration1').val('Choose a Duration');
        $('#accountHeadDistrict1').val('Choose a District');
        $('#accountHeadConsumerId1').val(' ');
        $('#accountHeadConsumerName1').val(' ');
        $('#accountHeadduration1').val('Choose a Duration') ;
        $('#accountHeadLiquorType1').val(0)
        $('#datePickerDate').val('');

        $('#accountHead div').each(function () {
            if ($(this).attr('id') != "accountHead1" && $(this).attr('id') != undefined)
                $(this).remove();
        });
    }


</script>
</body>
</html>