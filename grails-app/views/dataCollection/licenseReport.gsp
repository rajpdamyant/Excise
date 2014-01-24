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
        <td style="padding-top: 1%;width:1%">
            Type : </td>
        <td style="width: 4%">
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
        <td  style="width:2%;padding-top: 1%">
            Establishment :
        </td>
        <td style="width:30%">
            <Select id="EstId1">
                <option value="100">Distilleries</option>
                <option value="101">Bonded Warehouse</option>
                <option value="103">RetailerON</option>
                <option value="105">RetailerOFF</option>
            </select>
        </td>
    </tr>
</table>
<table style="border: none;padding-top: 1%">
    <tr>
        <td style="width:20px;" ><g:radio value="active" name="selectedOption" checked="checked"/> <label>Active</label>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<g:radio value="expired" name="selectedOption"/> <label>Expired</label></td>

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
                    <th style="text-align: center">Consumer Name</th>
                    <th style="text-align: center">Amount (Rs.)</th>
                </tr>
                </thead>
                <tbody></tbody>


            </table>
            <div id="totalDiv" style="float:right;padding-right: 18%"></div>
        </div>
    </div>
    <div id="leftDiv"  class="chartDiv">
        <div class="heading" style="width: 100%"><label style="text-align: center;;widthpadding-right: 100px;width:270px " >Chart Representation</label></div>
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

            drawPieChart(jsonData,chartType,"License Collection")

        })

        $("#myTable").tablesorter();


    })

    var theDate = new Date();
    theDate.setTime(theDate.getTime() + (theDate.getTimezoneOffset() + 330) * 60 * 1000);      //converting to IST Time Zone.
    $('#DateTd').html('License Status Report On Date : ' + ((theDate).getFullYear()) + '-' + (getTwoDigitDate('' + (theDate).getMonth() + 1)) + '-' + getTwoDigitDate('' + (theDate).getDate()));
    function noSunday(date) {
        var day = date.getDay();
        return [(day > 0),''];
    }
    $(".selector").datepicker({ beforeShowDay:$.datepicker.noWeekends })
    /*
     On change of the option for the reporting, corresponding divs appears up, and others hide up.
     */
    $('#selectedOption').live('change', function () {
        var selectedOption = getSelectedRadio('selectedOption');
        if (selectedOption == 'active') {
            $('#dailyCollectionTr').attr('style', 'display:inline');
            $('#dateRangeCollectionTr').attr('style', 'display:none');
        }
        else if (selectedOption == 'expired') {
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


    /*
     This function is written to return the selected radio button value.
     */
    function getSelectedRadio(selectedRadio) {
        var value = '';
        $('[name="' + selectedRadio + '"]').each(function () {
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

            var category = $('#EstId1').val();
            var selectedOption = getSelectedRadio('selectedOption');
            var liquorType = $('#LiquorType1').val();

            $.ajax({
                url:'${createLink(controller: 'dataCollection', action: 'getLicenseReportData')}',
                type:"post",
                data:{selectedOption:selectedOption,liquorType:liquorType,category:category},
                success:function(data) {
//                    $('#DateTd').html('');




                    if(data.length>0)
                    {
                        $('#msg').hide() ;
                        $('#gridDiv').show();
                        $('#myTable tr:not(:first)').remove();
                        var tempArray=[];
                        var jsonArray=[];
                        for(var i=0;i<data.length;i++){
                            var j=i;
                            ++j;
                            $('#myTable tbody').append('<tr><td style="text-align: center">'+j+'</td><td style="text-align: center">'+data[i][0]+'</td><td style="text-align: center">'+data[i][1]+'</td><td style="text-align: center">'+data[i][2]+'.00'+'</td></tr>')
                            jsonArray.push(tempArray.push(data[i][0],data[i][2]))
//
//                            jsonArray.push(tempArray)
//                            alert(jsonArray[1])
//                            alert(jsonArray)
                        }
                        $('#totalDiv').html('');
//                        $('#totalDiv').append(data[6][0]+' = '+ data[6][1])
                        $("#myTable").trigger("update");

                        changeData(data);
                        jsonData=data;
                        drawPieChart(data,"Pie","License Collection");

//                        showGird()
                    }
                    else{
                        $('#msg').show();
                        $('#gridDiv').hide();
                        $('#leftDiv').hide();
                    }

                }
                ,error:function(XMLHttpRequest, textStatus, errorThrown) {},
                complete:function(xhr,status) {
                }

            });


        }

    function changeData (myArr) {

         for (var i =0; i < myArr.length; i++) {
         myArr[i][1]=myArr[i][2] ;
            delete(myArr[i][2])

        }
        return myArr;
    }



    function showGird(){

//        $('#gridList').dialog({
//            modal: true,
//            backgroundColor:"blue",
//            title :"Total Revenue List",
//            height: '620',
//            width:'640',
//            autoResize: false,
//            position: [40,55]
//        });

        $('#gridDiv').show()
        $('#gridList').show()
        <jqgrid:grid
                    id="ChallanCollectionDetails"
                    url="'${createLink(controller: 'dataCollection', action: 'totalExciseList')}'"
                    colNames="'S.No','District', 'TotalRevenue (Rs)'"
                    colModel="{name:'id', editable: false, width:5, align:'center',key:true, edittype: 'text'},
                    {name:'districtId', editable: false, width:10, align:'center', edittype: 'text'},
                    {name:'accountHeadAmount', editable: false, width:10, align:'center', edittype: 'text'}"

                    sortname="'id'"
                    height="250"
                    width="657"
                    autowidth="false"
                    scrollOffset="0"
                    viewrecords="true"
                    showPager="true"
                    datatype="'json'">
        <jqgrid:filterToolbar id="ChallanCollectionDetails" searchOnEnter="true"/>
        <jqgrid:navigation id="ChallanCollectionDetails" add="false" edit="false"
                          del="false" search="false" refresh="true"/>
        </jqgrid:grid>

        %{--$('#${attrs.id}Grid').trigger('reloadGrid');--}%
//        $("#gridList").jqGrid('setGridParam',{url:"dataCollection/totalExciseList", datatype:"json", page:1}).trigger("reloadGrid");
        %{--$("#list").jqGrid({--}%
        %{--url: "'${createLink(controller: 'dataCollection', action: 'totalExciseList')}'",--}%
        %{--mtype: 'GET',--}%
        %{--colNames: ['id', 'accountHeadAmount', 'categoryType'],--}%
        %{--colModel: [--}%
        %{--{ name: 'ID', index: 'invid', width: 55 },--}%
        %{--{ name: 'accountHeadAmount', index: 'invdate', width: 90 },--}%
        %{--{ name: 'categoryType', index: 'amount', width: 80, align: 'right' }],--}%
        %{--pager: jQuery('#pager'),--}%
        %{--postData: { "testvar": "whatever" },--}%
        %{--rowNum: 10,--}%
        %{--rowList: [10, 20, 30],--}%
        %{--sortname: 'id',--}%
        %{--sortorder: "desc",--}%
        %{--viewrecords: true,--}%
        %{--imgpath: 'themes/sand/images',--}%
        %{--caption: 'My first grid',--}%
        %{--gridComplete: function() {--}%
        %{--var recs = $("#list").getGridParam("records");--}%
        %{--if (recs == 0) {--}%
        %{--$("#list").hide();--}%
        %{--}--}%
        %{--else {--}%
        %{--alert('records > 0');--}%
        %{--}--}%
        %{--}--}%
        %{--});--}%
//        startAutoRefreshing()

    }


</script>


%{--<table id="list" class="scroll"></table>--}%
%{--<div id="pager" class="scroll" style="text-align:center;"></div>--}%

</body>
</html>