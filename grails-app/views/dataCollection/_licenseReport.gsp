<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2/22/12
  Time: 2:00 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="challan.DistrictOffice;challan.HeadQuarter;" %>
<table cellpadding="0" cellspacing="0" border="1px;" class="display" id="example"
       style="margin: 5px;width: 99%;border: 1px solid #000000" align="center">
    <thead>
    <tr>
        <td><center>S.No</center></td>
        <sec:ifAllGranted roles="ROLE_HEADQUARTER">
            <g:if test="${!expire}">
                <td><center>District Name</center></td>
            </g:if>
        </sec:ifAllGranted>
        <td><center>Consumer Name</center></td>
        <g:if test="${!expire}">
            <td><center>Amount (Rs.)</center></td>
        </g:if>

    </tr>
    </thead>
    <tbody>
    <sec:ifAllGranted roles="ROLE_HEADQUARTER">
        <g:each in="${finalList}" var="license" status="i">
            <tr name="dataTr">
                <td name="sNo" style="vertical-align:middle;color: #000">
                    ${i + 1}
                </td>
                <g:if test="${!expire}">
                    <td name="districtName" rowspan="" style="vertical-align:middle;color: #000">
                        ${license[0]}
                    </td>
                </g:if>
                <td name="consumerName" rowspan="" style="vertical-align: middle;color:#000">
                    ${license[1]}
                </td>
                <g:if test="${!expire}">
                    <td name="amount">${license[2]}</td>
                </g:if>
            </tr>

        </g:each>
    </sec:ifAllGranted>

    <sec:ifAllGranted roles="ROLE_DISTRICT">

        <g:each in="${finalList}" var="license" status="i">
            <tr name="dataTr">
                <td name="sNo" style="vertical-align:middle;color: #000">
                    ${i + 1}
                </td>

                <td name="consumerName" rowspan="" style="vertical-align: middle;color:#000">
                    ${license[0]}
                </td>
                <g:if test="${!expire}">
                    <td name="amount">${license[1]}</td>
                </g:if>
            </tr>

        </g:each>

    </sec:ifAllGranted>
    </tbody>
</table>

<div>
    <div id="pop_up" class="blackOuterDiv" style="display: none;" onclick="hidePopUp()">
        <div id="popUpOuterDiv" class="DocumentLeftInner"
             style="width: 400px; height: 200px;z-index: 1000;position:absolute;top:250px;left:500px;">
            <h2 style="width: 402px;">
                <span style="width: 370px;border-top-left-radius: 8px;">
                    <p style="display:inline;">Information</p>
                    <a href="#"
                       style="text-decoration: none;float: right;font-weight:bold;color: #FFFFFF;display:inline;"
                       onclick="hidePopUp()">Close</a>
                </span>
            </h2>

            <div id="popUpInnerDiv" class="DocumentLeftCtn" style="width: 378px;height: 153px;float: left;">
                <table border="0" style="font-size: small; height: 150px;">
                    <sec:ifAllGranted roles = "ROLE_HEADQUARTER">
                     <tr><td>District Office: </td><td id="DistrictOfficevalue"></td></tr>
                        </sec:ifAllGranted>
                    <tr><td>Consumer Name:</td><td id="ConsumerNamevalue" colspan="2"></td></tr>
                    <tr><td>Total :</td><td id="totalValue"></td></tr>
                </table>
            </div>

            <div class="DocumentLeftBdrBtm" style="width: 402px;"><img alt="" src="../images/temp/BdrBtmLeft.jpg">
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    var previousBackGroundColor;
    $('#popUpOuterDiv').draggable();

    /*
     dataTable function is used to create a table with some more functionality, look and feel.
     Their is no sorting on any columns, and no pagination.

     The defination of dataTable is written in  jquery.dataTables.js
     */
    $(document).ready(function () {
        $('#example').dataTable({
            "bJQueryUI":true, "bSort":false, "bLengthChange":false, "bAutoWidth":false, "bPaginate":false, "sDom":'<"H"Tfr>t<"F"ip>', "oTableTools":{
                "sSwfPath":"${resource(dir: 'TableTools-2.0.1', file: 'media/swf/copy_cvs_xls_pdf.swf')}"
            }
        });

        /*
         search functionality removed  from dataTables.
         */
        $('#example_filter').remove();
    });


    /*
     On click of a cell under revenue collection, a pop-up box comes up showing the breakup details of cash and cheque.
     */

    $('td[name="amount"]').live('click', function () {
        var value;
        var total = $(this).text().trim();
        var consumerName = $(this).siblings('[name="consumerName"]').text().trim();
        var DistrictOfficevalue = $(this).siblings('[name="districtName"]').text().trim();
        $('#ConsumerNamevalue').html('');
        $('#ConsumerNamevalue').html(consumerName);

        $('#totalValue').html(total);
         $('#DistrictOfficevalue').html('');
        $('#DistrictOfficevalue').html(DistrictOfficevalue);
        $('#popUpOuterDiv h2 span p').html('Amount (Rs.)');
        $('#pop_up').attr('style', 'display:inline');

    });
    /*
     This function is written to hide the pop-up box that appears on click of any cell of the table.
     */
    function hidePopUp() {
        $('#pop_up').attr('style', 'display:none');
    }



</script>