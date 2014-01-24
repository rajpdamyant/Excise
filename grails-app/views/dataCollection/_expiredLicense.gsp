<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2/22/12
  Time: 2:07 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page import="challan.DistrictOffice;challan.HeadQuarter;" %>
<table cellpadding="0" cellspacing="0" border="1px;" class="display" id="example"
       style="margin: 5px;width: 99%;border: 1px solid #000000">
    %{--<table cellpadding="0" cellspacing="0" border="1px;" class="display" id="example" style="margin: 5px;width: 99%;">--}%
    <thead>
    <tr>
        <td>S.No</td>
        <td>Consumer ID</td>
        <td>Consumer Name</td>
        <td>License Expired Date</td>
        <td>Amount Due</td>
    </tr>
    </thead>
    <tbody>
    <g:each in="${districtOfficeList}" var="subDiv" status="i">
        <tr name="dataTr">
        %{--<td name="sNo" style="vertical-align:middle;color: #000">--}%
        %{--${i + 1}--}%
        %{--</td>--}%
            <g:if test="${districtOffice}">
            %{--<td name="districtOfficeName" rowspan="" style="vertical-align:middle;color: #000">--}%
            %{--${subDiv[0]}--}%
            %{--</td>--}%
            %{--<td name="revenueCollected">${subDiv[1]}</td>--}%

            </g:if>
            <g:elseif test="${districtOffice}">
            %{--<td name="districtOfficeName" rowspan="" style="vertical-align:middle;color: #000">--}%
            %{--${subDiv[0]}--}%
            %{--</td>--}%
            %{--<td name="revenueCollected">${subDiv[1]}</td>--}%

            </g:elseif>
            <g:else>
                <td name="revenueCollected">${subDiv[0]}</td>
            </g:else>
        </tr>
    </g:each>
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
                    <tr><td id="districtOfficeValue" colspan="2"></td></tr>
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
            "bJQueryUI": true
            ,"bSort": false
            ,"bLengthChange": false
            ,"bAutoWidth": false
            ,"bPaginate": false
            ,"sDom": '<"H"Tfr>t<"F"ip>'
            ,"oTableTools": {
                "sSwfPath": "${resource(dir: 'TableTools-2.0.1', file: 'media/swf/copy_cvs_xls_pdf.swf')}"
            }
        });

        /*
         search functionality removed  from dataTables.
         */
        $('#example_filter').remove();

        /*
         Depending on level, the table is manipulated to show the Superintendent Office under corresponding District HeadQuarter.
         The even-odd colouring or background color of the table is also handled here.
         */
        %{--if ('${districtOffice}') {--}%
        %{--setDistrictOfficeName();--}%
        %{--}--}%
        if ('${districtOffice}') {
            $('[name="districtOfficeName"]').each(function() {
                if ($(this).text().trim() == 'Grand Total') {
                    $(this).prev().text('-');
                    $(this).parent().attr('style', 'background-color:#aaaaaa');
                }
                else
                    $(this).parent().attr('style', 'background-color:' + '#ebf2f9');
            });
        }
        else {
            $('#example tbody tr').attr('style', 'background-color:' + '#ebf2f9');
        }
    });


    /*
     On click of a cell under revenue collection, a pop-up box comes up showing the breakup details of cash and cheque.
     */
    $('td[name="revenueCollected"]').live('click', function() {
        var value;
        var total = $(this).text().trim();
        var districtOfficeName = $(this).siblings('[name="districtOfficeName"]').text().trim();
        $('#districtOfficeValue').html('');
        $('#districtOfficeValue').html(districtOfficeName);

        $('#totalValue').html(total);
        $('#popUpOuterDiv h2 span p').html('Excise Collection (Rs.)');
        $('#pop_up').attr('style', 'display:inline');
    });
    /*
     This function is written to hide the pop-up box that appears on click of any cell of the table.
     */
    function hidePopUp() {
        $('#pop_up').attr('style', 'display:none');
    }



</script>