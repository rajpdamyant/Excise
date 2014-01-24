<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 10/22/11
  Time: 10:45 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="challan.ChallanCollectionDetails" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Online Excise Reporting System</title>
    <jq:resources />
    <jqui:resources />
    <jqgrid:resources />
    <g:javascript library="jquery" plugin="jquery"/>
    %{--<script type="text/javascript" src="/path/to/jquery-latest.js"></script>--}%
    <script type="text/javascript" src="${resource(dir: 'js', file: 'tablesorter.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.jqGrid.min.js')}"></script>
    %{--<script type="text/javascript" src="${resource(dir: 'jquery', file: 'jquery.form.js')}"></script>--}%
    <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.jqGrid.fluid.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'grid.locale-en.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.jqGrid.min.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'jQuery/report.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'hightchart.js')}"></script>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'ui.jqgrid.css')}"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'jqgrid.css')}"/>

    <meta name="layout" content="main"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>

    %{--<script src="http://code.highcharts.com/modules/exporting.js"></script>--}%
    <script type="text/javascript"
            src="${resource(dir: 'js', file: 'displayChart.js')}"></script>
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
    <link rel="stylesheet" type="text/css"
          href="${resource(dir: 'css', file: 'tableOrder.css')}"/>
    <style type="text/css">

    th.header {
        /*background-image: url(../img/small.gif);*/
        cursor: pointer;
        font-weight: bold;
        background-repeat: no-repeat;
        background-position: center left;
        padding-left: 20px;
        border-right: 1px solid #dad9c7;
        margin-left: -1px;
    }
    th.headerSortUp {
        background-image: url(../images/skin/sorted_asc.gif);
        background-color: #3399FF;
        background-position: top right;
    }

    </style>
</head>

<body id="body">


<table style="width:80%;border: none;margin-top: 20px;">
       <div style="margin-bottom:10px;display:inline;" id="dateDiv"></div>
    <tr>
         <input type="hidden" name="dataEnteredDate" value=""/>
        <td style="padding-top: 1%;width:2%">
            Type : </td>
        <td style="width: 10%">
            <select id="LiquorType1" name="LiquorType1" style="vertical-align: top" >
                <option value="0">Choose a Liquor</option>
                <option value="1">IMFL</option>
                <option value="2">Country Spirit</option>
                <option value="3">Denatured Spirit</option>
                <option value="4">Para_Military</option>
                <option value="5">Narcotics</option>
                <option value="6">Rectified Spirit</option>
                </select>
        </td>
        <td  style="width:3%;padding-top: 1%">
            Establishment :
        </td>
            <td style="width:40%">
            <Select id="EstId1">
                <option >Distilleries</option>
                <option >Bonded Warehouse</option>
                <option >RetailerOn</option>
                <option >RetailerOFF</option>
            </select>
        </td>
    </tr>
     </table>
<table style="border: none;padding-top: 1%">
    <tr>
        <td style="width:20px;" > <g:radio value="daily" name="selectedOption" checked="checked" /><label style="width: 100px"> Daily Collection </label>
       &nbsp; <g:radio value="dateRange" name="selectedOption"/> <label style="width: 140px">Date Range Collection </label>
            &nbsp;<g:radio value="all" name="selectedOption"/> <label style="width: 140px"> Cumulative Collection</label></td>

        <td  style="width:20%" id="dailyCollectionTr">
           <label>Date :</label>  &nbsp; <input id="datePickerDate" type="text" readonly="true">
        </td>
        <td id="dateRangeCollectionTr" style="display: none;" valign="top">
           <label>From : </label> <input id="datePickerFrom" type="text" readonly="true">&nbsp;
           <label>To :</label> <input id="datePickerTo" type="text" readonly="true">
        </td>
        <td valign="top" style="padding:0;"><input type="button" value="Show Report" onclick="showReport()"
                                                   class="buttonCss"/></td>
    </td>
    </tr>
</table>

<div id="DateTd" style="font-weight: bolder; font-size: 15px; text-align: center; margin: 5px;"></div>

%{--<div id="reportDiv">--}%
    %{--<g:render template="report"/>--}%

%{--</div>--}%
<div class="gridChartDiv">
<div id="gridDiv" class="gridDiv">

    <div class="heading" style="width: 100%"><label style="text-align: center;padding-right: 100px;width: 270px " >Grid Representation</label></div>
 <div style="padding-top: 50px">
    %{--<g:render template="grid_List"/>--}%
    %{--<g:render template="report"/>--}%
     <table id="myTable" class="tablesorter" style="height: 300px">
         <thead>
         <tr>
             <th style="text-align: center;width: 12%">S.No</th>
             <th style="text-align: center">District Office Name</th>
             <th style="text-align: center">Excise Collection (Rs.)</th>
         </tr>
         </thead>
     <tbody></tbody>


     </table>
     <div id="totalDiv" style="float:right;padding-right: 18%"></div>
 </div>
</div>
 <div id="leftDiv"  class="chartDiv">
     <div class="heading" style="width: 100%"><label style="text-align: center;;widthpadding-right: 100px;width: 270px " >Chart Representation</label></div>
     <div style="float: right;padding-top: 5px">
          <labe>Select Chart Type : &nbsp;</labe><select id="chartType" style="width:90px">
             <option>Pie</option>
             <option>Bar</option>
             <option>TimeLine</option>
         </select>
     </div>
     <div id="chartDiv" style="width: 80%;float: left;"> </div>

 </div>
    <div id="msg" style="display: none;padding-top: 10px"><h2 style="text-align: center">No collection found</h2></div>
</div>
<g:form controller="logout" style="display:none;">
    <input type="submit" id="logoutSubmit"/>
</g:form>
<script type="text/javascript">
var jsonData={};
    $(document).ready(function(){

        $('#chartType').change(function(){
           var chartType=$('#chartType option:selected').text();
            drawPieChart(jsonData,chartType,"Excise Collection")

        })

        $("#myTable").tablesorter();


    })

    var checkFlag="false";
    var theDate = new Date();
    theDate.setTime(theDate.getTime() + (theDate.getTimezoneOffset() + 330) * 60 * 1000);      //converting to IST Time Zone.
    $('#DateTd').html('Collections On Date : ' + ((theDate).getFullYear()) + '-' + (getTwoDigitDate('' + ((theDate).getMonth() + 1))) + '-' + getTwoDigitDate('' + (theDate).getDate()-1));
    $('#datePickerDate').val(((theDate).getFullYear()) + '-' + getTwoDigitDate('' + ((theDate).getMonth() + 1)) + '-' + getTwoDigitDate('' + (theDate).getDate()-1));
    $("#datePickerDate").datepicker({ changeMonth: true,changeYear: true,dateFormat: 'yy-mm-dd' , maxDate: "0",beforeShowDay: noSunday });
    $("#datePickerFrom").datepicker({ changeMonth: true,changeYear: true ,dateFormat: 'yy-mm-dd', maxDate: "0",beforeShowDay: noSunday  });
    $("#datePickerTo").datepicker({ changeMonth: true,changeYear: true,dateFormat: 'yy-mm-dd', maxDate: "0",beforeShowDay: noSunday   });
    $('#example_filter').remove();

    function noSunday(date) {
        var day = date.getDay();
        return [(day > 0), ''];
    }
    $(".selector").datepicker({ beforeShowDay: $.datepicker.noWeekends });
    /*
     On change of the option for the reporting, corresponding divs appears up, and others hide up.
     */
    $('#selectedOption').live('change', function() {
        var selectedOption = getSelectedRadio('selectedOption');
        if (selectedOption == 'all') {
            $('#dailyCollectionTr').attr('style', 'display:none');
            $('#dateRangeCollectionTr').attr('style', 'display:none');
        }
        else if (selectedOption == 'daily') {
            $('#dailyCollectionTr').attr('style', 'display:inline');
            $('#dateRangeCollectionTr').attr('style', 'display:none');
        }
        else if (selectedOption == 'dateRange') {
            $('#dailyCollectionTr').attr('style', 'display:none');
            $('#dateRangeCollectionTr').attr('style', 'display:inline');
        }
    });

    /*
     This function is written to return a two digit value appending zero before the single digit value.
     */
    function getTwoDigitDate(date) {
        return (date.length < 2) ? ('0' + date) : date

    }

     function getCurrentIST() {
        var date = new Date();
        date.setTime(date.getTime() + (date.getTimezoneOffset() + 330) * 60 * 1000);
        var dateString = (1900 + date.getYear()) + "-" + (getTwoDigitDate('' + (date.getMonth() + 1))) + "-" + getTwoDigitDate('' + date.getDate()) + " " + date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds();
        // var dateString = '';
        return(dateString);
    }
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

    /*
     This function is written to get the data for report through an ajax call,
     and then passing the response data to the div required to show the report.

     Here, the response comes in the form of template.
     */
    function showReport() {

        var selectedOption = getSelectedRadio('selectedOption');
        var selectedDate = $('#datePickerDate').val().trim().replace('-', '').replace('-', '');
        var selectedFromDate = $('#datePickerFrom').val().trim().replace('-', '').replace('-', '');
        var selectedToDate = $('#datePickerTo').val().trim().replace('-', '').replace('-', '');
        var category=$('#EstId1').attr('value');
        if (selectedOption == 'dailry' && $('#datePickerDate').val().trim() == '') {
            alert('Please Select A Date');
        }
        else if (selectedOption == 'dateRange' && ($('#datePickerFrom').val().trim() == '' || $('#datePickerTo').val().trim() == '')) {
            alert('Please Select Both From And To Date');
        }
        else if (selectedOption == 'dateRange' && (selectedFromDate > selectedToDate)) {
            alert('Please Select From Date Lesser Than To Date');
        }
        else if (selectedOption == 'dateRange' && selectedFromDate > selectedToDate) {
            alert('Please Select From Date Lesser Than To Date');
        }
        else {

            var datePickerDate = $('#datePickerDate').val().trim();
            var datePickerFrom = $('#datePickerFrom').val().trim();
            var datePickerTo = $('#datePickerTo').val().trim();
            var liquorType = $('#LiquorType1').val().trim();
            var EstId = $('#EstId1').val().trim();


            $.ajax({
                url:'${createLink(controller: 'dataCollection', action: 'getReportData')}',
                type:"post",
                data:{selectedOption:selectedOption,liquorType:liquorType,EstId:EstId,category:category, datePickerDate:datePickerDate,datePickerFrom:datePickerFrom,datePickerTo:datePickerTo },
                success:function(data) {
                    $('#DateTd').html('');
                    if (selectedOption == 'dateRange')
                        $('#DateTd').html('Collections From Date : ' + datePickerFrom + 'To Date : ' + datePickerTo);
                    else if (selectedOption == 'daily')
                        $('#DateTd').html('Collections On Date : ' + datePickerDate);
                    else {
                        theDate = new Date();
                        theDate.setTime(theDate.getTime() + (theDate.getTimezoneOffset() + 330) * 60 * 1000);      //converting to IST Time Zone.
//                        theDate.setDate(theDate.getDate()-1);
                        $('#DateTd').html('Cumulative Collections Of FY ' + ((theDate).getFullYear()) + ' Till ' + ((theDate).getFullYear()) + '-' + (getTwoDigitDate('' + ((theDate).getMonth() + 1))) + '-' + getTwoDigitDate('' + (theDate).getDate()));
                    }
                    jsonData=data;

                    if(data[6][1]!=="<strong>0</strong>")
                    {
                        $('#msg').hide()
                        $('#gridDiv').show()
                        $('#myTable tr:not(:first)').remove()


                        for(var i=0;i<data.length-1;i++){
                            var j=i
                            ++j
                            $('#myTable tbody').append('<tr><td style="text-align: center">'+j+'</td><td style="text-align: center">'+data[i][0]+'</td><td style="text-align: center">'+data[i][1]+'.00'+'</td></tr>')

                        }

                        $('#totalDiv').html('')
                        $('#totalDiv').append(data[6][0]+' = '+ data[6][1])
                        $("#myTable").trigger("update");

                        drawPieChart(data,"Pie","Excise Collection")

                    }
                    else{
                        $('#msg').show()
                        $('#gridDiv').hide()
                        $('#leftDiv').hide()
                    }

                }
                ,error:function(XMLHttpRequest, textStatus, errorThrown) {},
                complete:function(xhr,status) {
                       }

            });


        }
    }






</script>


</body>
</html>