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
<form id=formID1>
    <table style="border: none">
        <tr>
            <td colspan="4" style="text-align:center;font-weight:bold;">

                <div style="margin-bottom:10px;display:inline;" id="dateDiv"></div>
            </td>
            <input type="hidden" name="consumerType" value="${consumerType} "/>
        </tr>

        <tr>
            <td><strong>Superintendent Office:&nbsp;${districtOfficeName}</strong></td>
        </tr>

        <tr>
            <td style="width:20%"> <label>Type : &nbsp; </label>
                <select id="accountHeadLiquorType1" name="accountHeadLiquorType" class="validate[required,custom[select]] text-input">
                    <option value="0">Choose a Liquor</option>
                    <option value="1">IMFL</option>
                    <option value="2">Country Spirit</option>
                    <option value="3">Denatured Spirit</option>
                    <option value="4">Para_Military</option>
                    <option value="5">Narcotics</option>
                    <option value="6">Rectified Spirit</option></select>
            </td>
            <td colspan="2">
                <label>Date:&nbsp;&nbsp;</label><input id="datePickerDate" name="selectionDate" type="text" readonly="true" class="validate[required,custom[selectDate]] text-input">
            </td>
        </tr>

        <tr>
            <td>Type:&nbsp;&nbsp;&nbsp; ${consumerType}</td>
            <td> <div style="float: right"><label style="width: 110px">Total Excise (Rs):</label>&nbsp;<input type="text" name="total" id="total" placeholder="0.00" readonly="true"
                                                size="6"></div></td>
            <td style="width:15%"> <div style="float: right"><label style="width: 90px">Total VAT (Rs):</label>&nbsp;<input type="text" name="total1" id="total1" placeholder="0.00" readonly="true" size="6"></div></td>

        </tr>

     </table>
</table>
    <div class="middleDiv" id="accountHead">
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


<g:form controller="logout" style="display:none;">
    <input type="submit" id="logoutSubmit"/>
</g:form>
<script type="text/javascript">
   var index=0;
    $(document).ready(function(){
       AccountHeadDiv();
   })


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


    $("#datePickerDate").datepicker({ changeMonth:true, changeYear:true, dateFormat:'yy-mm-dd', minDate:-30, maxDate:"0", beforeShowDay:noSunday ,yearRange:"2011:2012"});
    $('#example_filter').remove();
    function noSunday(date) {
        var day = date.getDay();
        return [(day > 0), ''];
    }
    $(".selector").datepicker({ beforeShowDay:$.datepicker.noWeekends }) ;
      $( ".selector" ).datepicker({ yearRange: "2011:2012" });
     $.get('${createLink(controller: 'dataCollection', action: 'numToWords')}', {Amount:Amt}, function (response) {
     $('#amountInWordsExcise'+indx).attr('value', response);
     });
     $('#accountHeadExcise'+indx).attr('value', temp + '.00');
     function total2(indx) {
     var temp = $('#accountHeadVat'+indx).val();
     $('#total1').attr('value', temp + '.00');
     var total1 = 0;
     var temp1;
     $('#accountHead div input[id^="accountHeadVat"]').each(function () {
     temp1 = Math.round($(this).val() * 100) / 100;
     if (!isNaN(temp1)) {
     total1 += Math.round(parseFloat(temp1));
     }
     });
     $('#total1').attr('value', total1 + '.00');
     var Abc = $('#accountHeadVat'+indx).val();
     $.get('${createLink(controller: 'dataCollection', action: 'numToWords')}', {Amount:Abc}, function (response) {
     $('#AmountInWordsVat'+indx).attr('value', response);
     });
     $('#accountHeadVat'+indx).attr('value', temp + '.00');
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
        if (index == 0) {
            var temp = $('#accountHeadAmount1').val();
            $('#total').attr('value', temp);
        }
        index++;

        $('#accountHead').append('<div class="middleDiv" id="accountHead' + index + '" ></div>');
        // account head 1 div
        var districtOfficeList = '${districtOfficeList}'.substring(1, '${districtOfficeList}'.length - 1);
        var districtOfficeArray = districtOfficeList.split(',');
        // append
        $('#accountHead' + index).append(' <div style="width:80%"> <div class="districtDiv1"><label>District:</label></div>' +
                '<div class="distSelectBox1"> <select class="validate[required,custom[select]] text-input" name="districtOfficeList" id="accountHeadDistrict' + index + '"><option>Choose a District</option></select></div> ');
        $.each(districtOfficeArray, function () {
            $('#accountHeadDistrict' + index).append('<option>' + (this) + '</option>');
        });
        var retailerlist = '${consumerId}'.substring(1, '${consumerId}'.length - 1);
        var retailerArray = retailerlist.split(',');

        $('#accountHead' + index).append('<div class="treasureLabelDiv1"> Treasury Challan Id:</div>' +
                '<div class="treasureInputDiv1"><input type="text" style="width: 130px" class="validate[required,custom[integer]] text-input" name="accountHeadTreasureId" id="accountHeadTreasureId' + index + '" "/></div>');
        $('#accountHead' + index).append('<div class="estIdLabel1">Establishment Id:</div>' +
                '<div style="width:10%;float: left"> <select class="validate[required,custom[select]] text-input" name="accountHeadConsumerId" id="accountHeadConsumerId' + index + '" onchange="Consumerretail(\'' + index + '\')"><option>Choose a Est Id</option></select> </div>');
        $.each(retailerArray, function () {
            $('#accountHeadConsumerId' + index).append('<option>' + (this) + '</option>');
        });


        $('#accountHead' + index).append('<div style="width:129px;float: left;padding-top: 5px"> Establishment Name : </div> ' +
                '<div style="width:13%;float: left"><input type="text"  size="17" readonly="true" name="accountHeadConsumerName" id="accountHeadConsumerName' + index + '" /></div></div>');
        if(index==1){
        $('#accountHead' + index).append('<div style="width:100%;float: left;padding-top: 2px"> <div style="width:195px;float: left;padding-top: 5px;"> Account Head Excise :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${accountHeadId1}</div>'+
                '<div style="width:123px;float: left;padding-top: 5px;">Amount (Rs.):</div>' +
                '<div style="width:143px;float: left"><input type="text" placeholder="0.00" class="validate[required,custom[number]] text-input"  style="width: 130px" name="accountHeadExcise" id="accountHeadExcise' + index + '" onchange="totalExcise(\'' + index + '\')"/></div>' +
                '<div style="width:11%;float: left;padding-top: 5px;">Amount in Words. (Rs.):</div><div style="width:30%;float: left;"><input type="text" readonly="true" style="width:97%" name="accountHeadAmountInWordsExcise" id="accountHeadAmountInWordsExcise' + index + '" "/></div>' +
                '</div>');

        $('#accountHead' + index).append('<div style="width:100%;float: left;padding-top: 2px"> <div style="width:195px;float: left;padding-top: 5px;"> Account Head VAT &nbsp;&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ${accountHeadId2}</div>'+
                '<div style="width:123px;float: left;padding-top: 5px;">Amount (Rs.):</div>' +
                '<div style="width:143px;float: left"><input type="text" style="width: 130px" placeholder="0.00" class="validate[required,custom[number]] text-input"  name="accountHeadVat" id="accountHeadVat' + index + '"   onchange="total5(\'' + index + '\')"/></div>' +
                '<div style="width:11%;float: left;padding-top: 5px;">Amount in Words. (Rs.):</div><div style="width:27%;float: left;"><input type="text" readonly="true" style="width:97%" name="accountHeadAmountInWordsVat" id="accountHeadAmountInWordsVat' + index + '" "/></div>' +
                '<div style="float: left;padding-left: 11px"> <input type="button" style="color: red" id="AccountHeadButton1" value="+" onclick="AccountHeadDiv()"/></div></div>');

        }
        else{
            $('#accountHead' + index).append('<div style="width:100%;float: left;padding-top: 2px"> <div style="width:195px;float: left;padding-top: 5px;"> Account Head Excise :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${accountHeadId1}</div>'+
                    '<div style="width:123px;float: left;padding-top: 5px;">Amount (Rs.):</div>' +
                    '<div style="width:143px;float: left"><input type="text" placeholder="0.00" class="validate[required,custom[number]] text-input"  style="width: 130px" name="accountHeadExcise" id="accountHeadExcise' + index + '" onchange="totalExcise(\'' + index + '\')"/></div>' +
                    '<div style="width:11%;float: left;padding-top: 5px;">Amount in Words. (Rs.):</div><div style="width:30%;float: left;"><input type="text" readonly="true" style="width:97%" name="accountHeadAmountInWordsExcise" id="accountHeadAmountInWordsExcise' + index + '" "/></div>' +
                    '</div>');

            $('#accountHead' + index).append('<div style="width:100%;float: left;padding-top: 2px"> <div style="width:195px;float: left;padding-top: 5px;"> Account Head VAT &nbsp;&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ${accountHeadId2}</div>'+
                    '<div style="width:123px;float: left;padding-top: 5px;">Amount (Rs.):</div>' +
                    '<div style="width:143px;float: left"><input type="text" style="width: 130px" class="validate[required,custom[number]] text-input"  placeholder="0.00" name="accountHeadVat" id="accountHeadVat' + index + '"   onchange="total5(\'' + index + '\')"/></div>' +
                    '<div style="width:11%;float: left;padding-top: 5px;">Amount in Words. (Rs.):</div><div style="width:27%;float: left;"><input type="text" readonly="true" style="width:97%" name="accountHeadAmountInWordsVat" id="accountHeadAmountInWordsVat' + index + '" "/></div>' +
                    '<div style="float: left;padding-left: 11px"> <input type="button" style="color: red" id="removeButton' + index + '" value="-" onclick="removeAccountHead(\'' + index + '\')"/></div></div>');

        }

    }

    function totalExcise(indx) {
        var total2 = 0;
        var temp1;
        var Amt = Math.round($('#accountHeadExcise' + indx).val());
        $.get('${createLink(controller: 'dataCollection', action: 'numToWords')}', {Amount:Amt}, function (response) {
            if (response.error == 'access denied') {
                $('input[id="logoutSubmit"]').click();
            }
            $('#accountHeadAmountInWordsExcise' + indx).attr('value', response);
        });
        $('#accountHead div input[id^="accountHeadExcise"]').each(function () {
            temp1 = Math.round($(this).val() * 100) / 100;
            if (!isNaN(temp1)) {
                total2 += Math.round(parseFloat(temp1));
            }
        });
        $('#total').attr('value', total2 + '.00');
        $('#total').attr('value', total2 + '.00');
        var temp = Math.round($('#accountHeadExcise' + indx).val());
        $('#accountHeadExcise' + indx).attr('value', temp + '.00');
    }


    function total5(indx) {
        var total2 = 0;
        var temp1;
        // adding all the text boxes values
        $('#accountHead div input[id^="accountHeadVat"]').each(function () {
            temp1 = Math.round($(this).val() * 100) / 100;
            if (!isNaN(temp1)) {
                total2 += Math.round(parseFloat(temp1));
            }
        });
        $('#total1').attr('value', total2 + '.00');
        var Amt = Math.round($('#accountHeadVat' + indx).val());
        $.get('${createLink(controller: 'dataCollection', action: 'numToWords')}', {Amount:Amt}, function (response) {
            $('#accountHeadAmountInWordsVat' + indx).attr('value', response);
        });
        var temp = Math.round($('#accountHeadVat' + indx).val());
        $('#accountHeadVat' + indx).attr('value', temp + '.00');
        $('#total1').attr('value', total2 + '.00');
    }


    function Consumerretail(indx) {
        var consumerId1 = $('#accountHeadConsumerId' + indx).val();
        $.get('${createLink(controller: 'dataCollection', action: 'autoPopulate')}', {consumerId:consumerId1}, function (response) {
            if (response.error == 'access denied') {
                $('input[id="logoutSubmit"]').click();
            }
            else {
                $('#accountHeadConsumerName' + indx).attr('value', response);
            }
        });
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
        $('#accountHeadExcise').attr('value', 0.00);
        $('#accountHeadVat').attr('value', 0.00);
    }

    function fillWithZero() {
        var accountHeadAmt = Math.round($('#accountHeadAmount1').val() * 100) / 100;
        $('#accountHeadAmount1').attr('value', accountHeadAmt);
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
                           url:'${createLink(controller: 'dataCollection', action: 'updateRetailer')}',
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
        $('#accountHeadConsumerId1').val('');
        $('#accountHeadConsumerName1').val('');
        $('#accountHeadAmountInWordsExcise1').val('');
        $('#accountHeadAmountInWordsVat1').val('');
        $('#accountHeadLiquorType1').val('Choose a Liquor');
        $('#datePickerDate').val('');
        $('#accountHeadExcise1').val('');
        $('#accountHeadDistrict1').val('Choose A District');
        $('#total').val('')
        $('#accountHeadVat1').val('');
        $('#total1').val('')
        $('#accountHead div').each(function () {
            if ($(this).attr('id') != "accountHead1" && $(this).attr('id') != undefined)
                $(this).remove();
        });
    }
</script>
</body>
</html>