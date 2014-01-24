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
    <script type="text/javascript"
            src="${resource(dir: 'js', file: 'validation-en.js')}"></script>

    <script type="text/javascript"
            src="${resource(dir: 'js', file: 'validation-engine.js')}"></script>

</head>

<body>
<form id="formID1" >
    <table width="100%">
        <tr>
            <td colspan="4" style="text-align:center;font-weight:bold;">

                <div style="margin-bottom:10px;display:inline;" id="dateDiv"></div>
            </td>
            <input type="hidden" name="consumerType" value="${consumerType} "/>
            <input type="hidden" name="accountHeadId" value="${accountHeadId} "/>
        </tr>

        <tr>
            <td colspan="2"><strong>Superintendent Office :&nbsp;${districtOfficeName}</strong></td>  <td><div id=msg style="color:green;font-weight:bold;"></div></td>

        </tr>
        <tr>
            <td style="width:20%"> <label>Type : &nbsp; </label>
                <select id="accountHeadLiquorType1" name="accountHeadLiquorType" class="validate[required,custom[select]] text-input" >
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
                <label>Date:&nbsp;&nbsp;</label><input id="datePickerDate" name="selectionDate"type="text" readonly="true" class="validate[required,custom[selectDate]] text-input">
            </td>
        </tr>
        <tr>

            <td>Type : &nbsp;&nbsp;&nbsp;    ${consumerType} </td>
            <td>   Account Head :&nbsp;&nbsp; ${accountHeadId}</td>
            <td>
                <div style="float: right;padding-right: 30px">  <label style="width: 130px">Total Amount (Rs.) : &nbsp;</label><input type="text" placeholder="0.00" readonly="readonly"  name="total" id="total"  size="8"> </div>
            </td>

        </tr>
    </table>
    <div  id="accountHead" class="middleDiv">
    </div>
    <table style="border: none">
        <tr>
            <td colspan="4">
                <input type="submit" value="Submit" onclick="submitForm()" class="${classs} buttonCss" >
                <input type="button" value="Cancel" onclick="reset1()" class="${classs} buttonCss"/>

            </td>
        </tr>
    </table>
</form>

<script type="text/javascript">

   var index=0;
    $(document).ready(function () {

        AccountHeadDiv() ;


    });


    var flag = false;
    window.onbeforeunload = function () {
        $('#flashMsg').html('');
    };
    $('#dateDiv').html(getCurrentIST());
    //     $('#dateDiv').html(getTwoDigitDate());
    /*
     This function is written to get Indian Standard Time from
     visitor’s local computer time.

     Added getTimezoneOffset to get GMT/UTC
     Added +330 minutes (IST is +5.5 hrs ahead of GMT) to get IST
     */
    // $( "#datePickerDate" ).datepicker();
    // $('#datePickerDate').val(((theDate).getFullYear()) + '-' + getTwoDigitDate('' + ((theDate).getMonth() + 1)) + '-' + getTwoDigitDate('' + (theDate).getDate()));


    $("#datePickerDate").datepicker({ changeMonth:true, changeYear:true, dateFormat:'yy-mm-dd', minDate:-30, maxDate:"0", beforeShowDay:noSunday,yearRange:"2011:2012" });
    $('#example_filter').remove();


    function noSunday(date) {
        var day = date.getDay();
        return [(day > 0), ''];
    }
    $(".selector").datepicker({ beforeShowDay:$.datepicker.noWeekends });
    $(".selector").datepicker({ yearRange: "2011:2012" });
    // $("#datePickerDate").datepicker({ changeMonth: true,changeYear: true,dateFormat: 'yy-mm-dd' ,minDate: -30, maxDate: "0",beforeShowDay: noSunday });
    function total11(indx) {

        var temp = $('#accountHeadAmount' + indx).val();
        $('#total').attr('value', temp + '.00');
        var total = 0;
        var temp1;
        $('#accountHead div input[id^="accountHeadAmount"]').each(function () {
            temp1 = Math.round($(this).val() * 100) / 100;

            if (!isNaN(temp1)) {
                total += Math.round(parseFloat(temp1));

            }
        });


        $('#total').attr('value', total + '.00');


        var Amt = Math.round($('#accountHeadAmount' + indx).val());


        $.get('${createLink(controller: 'dataCollection', action: 'numToWords')}', {Amount:Amt}, function (response) {
            if (response.error == 'access denied') {
//                     alert("response");
                $('input[id="logoutSubmit"]').click();
            }

            $('#accountHeadAmountInWords' + indx).attr('value', response);

        });

        temp = Math.round(temp);
        $('#accountHeadAmount' + indx).attr('value', temp + '.00');

    }

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


    function submitForm() {
        var count=0;
        jQuery("#formID1").validationEngine('attach', {
            onValidationComplete: function(form, status){
                if (status == true) {

                    if(count==0){
                       count++
                    $.ajax({
                        type:"post",
                        url:'${createLink(controller: 'dataCollection', action: 'updateManufacturerDistributor')}',
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

    function AccountHeadDiv() {

        if (index == 0) {
            var temp = $('#accountHeadAmount1').val();
            $('#total').attr('value', temp);
        }
        index++;

        $('#accountHead').append('<div class="middleDiv" id="accountHead' + index + '" ></div>');
        var districtOfficeList = '${districtOfficeList}'.substring(1, '${districtOfficeList}'.length - 1);
        var districtOfficeArray = districtOfficeList.split(',');
        $('#accountHead' + index).append('<div style="width:80%"> <div class="districtDiv"><label>District :</label></div>' +
        '<div class="distSelectBox"><select  class="validate[required,custom[select]] text-input" name="districtOfficeList" id="accountHeadDistrict' + index + '" ><option>Choose a District</option></select></div> ');
        $.each(districtOfficeArray, function () {
            $('#accountHeadDistrict' + index).append('<option>' + (this) + '</option>');
        });

        $('#accountHead' + index).append(' <div class="treasureLabelDiv"> Treasury Challan Id: </div>' +
                '<div class="treasureInputDiv"><input type="text"  class="validate[required,custom[integer]] text-input"   style="width: 85px" name="accountHeadTreasureId" id="accountHeadTreasureId' + index + '" "/></div>');

        var list = '${consumerId}'.substring(1, '${consumerId}'.length - 1);
        var Array = list.split(',');

        $('#accountHead' + index).append('<div class="estIdLabel"> Establishment Id: </div> ' +
        '<div class="estIdSelect"> <select  class="validate[required,custom[select]] text-input" name="accountHeadConsumerId" id="accountHeadConsumerId' + index + '" onchange="Consumer(\'' + index + '\')"><option>Choose a Est Id</option></select> </div>');
        $.each(Array, function () {
            $('#accountHeadConsumerId' + index).append('<option>' + (this) + '</option>');

        });

        $('#accountHeadId' + index).html('');
        var accountHeadList = '${accountHeadList}'.substring(1, '${accountHeadList}'.length - 1);
        var accountHeadArray = accountHeadList.split(',');
        $.each(accountHeadArray, function () {
            $('#accountHeadId' + index).append('<option>' + (this) + '</option>');
        });

        $('#accountHead' + index).append('<div class="estNameLabel"> Establishment Name : </div> ' +
                '<div class="estNameBox"><input type="text"  size="17" readonly="true" name="accountHeadConsumerName" id="accountHeadConsumerName' + index + '" /></div></div>');

        if(index==1){
            $('#accountHead' + index).append('<div style="width:100%;float: left;padding-top: 2px"><div class="amountLabel">Amount (Rs.):</div>' +
                    ' <div class="amountBox"><input type="text" placeholder="0.00"  class="validate[required,custom[number]] text-input" style="width: 127px" name="accountHeadAmount" id="accountHeadAmount' + index + '"   onchange="total11(\'' + index + '\')"/></div>' +
                    '<div class="amountWordsLabel" >Amount in Words. (Rs.):</div><div class="amountWordsBox" ><input type="text" readonly="true" style="width:97%" name="accountHeadAmountInWords" id="accountHeadAmountInWords' + index + '" "/></div>' +
                    '<div class="addButton"> <input type="button" onclick="AccountHeadDiv()" value="+" style="color: red" id="removeButton' + index + '"  ></div></div>');
        }
        else{
            $('#accountHead' + index).append('<div style="width:100%;float: left;padding-top: 2px"><div class="amountLabel">Amount (Rs.):</div>' +
                    ' <div class="amountBox"><input type="text" placeholder="0.00"  class="validate[required,custom[number]] text-input" style="width: 127px" name="accountHeadAmount" id="accountHeadAmount' + index + '"   onchange="total11(\'' + index + '\')"/></div>' +
                    '<div class="amountWordsLabel" >Amount in Words. (Rs.):</div><div class="amountWordsBox" ><input type="text" readonly="true" style="width:97%" name="accountHeadAmountInWords" id="accountHeadAmountInWords' + index + '" "/></div>' +
                    '<div class="addButton"> <input type="button" value="-" onclick="removeAccountHead(\'' + index + '\')"/ style="color: red" id="removeButton' + index + '"  ></div></div>');

        }

    }

    /*function total1() {
     var total = 0;
     var temp1;
     // adding all the text boxes values


     $('#accountHead div input[id^="accountHeadAmount"]').each(function () {
     temp1 = Math.round($(this).val() * 100) / 100;

     if (!isNaN(temp1)) {
     total += Math.round(parseFloat(temp1));

     }
     });
     $('#total').attr('value', total + '.00');

     var Amt = $('#accountHeadAmount' + index).val();


     %{--$.get('${createLink(controller: 'dataCollection', action: 'numToWords')}', {Amount:Amt}, function (response) {--}%


     $('#accountHeadAmountInWords' + index).attr('value', response);


     });


     $('#accountHeadAmount' + index).attr('value', Amt + '.00');

     }*/

    function removeAccountHead(index) {

        temp1 = Math.round($('#accountHeadAmount' + index).val() * 100) / 100;
        if (!isNaN(temp1)) {
            totalamt = Math.round(parseFloat($('#total').val())) - Math.round(parseFloat(temp1));
            var tot = totalamt;
            if(isNaN(tot)){
                $('#total').val('');
            }
            else{
            $('#total').attr('value', tot);
            }
        }
        $('#accountHead' + index).remove();
    }

//    function fill() {
//
//        $('#accountHeadAmount1').attr('value', 0.00);
//    }
//
//    function fillWithZero() {
//
//
//        var accountHeadAmt = Math.round($('#accountHeadAmount1').val() * 100) / 100;
//        $('#accountHeadAmount1').attr('value', accountHeadAmt);
//
//    }
//


    function reset1() {
        $('#accountHeadTreasureId1').val('');
        $('#accountHeadConsumerId1').val('Choose A Est Id');
        $('#accountHeadLiquorType1').val(0)
        $('#accountHeadConsumerName1').val('');
        $('#accountHeadAmountInWords1').val('');
        $('#accountHeadDistrict1').val('Choose A District');
        $('#accountHeadAmount1').val('');
        $('#datePickerDate').val('');
        $('#accountHeadComment1').val('');
        $('#total').val('');
        $('#accountHead div').each(function () {
            if ($(this).attr('id') != "accountHead1" && $(this).attr('id') != undefined)
                $(this).remove();
        });

    }


</script>
</body>
</html>