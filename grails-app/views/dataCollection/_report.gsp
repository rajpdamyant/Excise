<%@ page import="challan.DistrictOffice;challan.HeadQuarter;" %>

<table cellpadding="0" cellspacing="0" border="1px;" class="display" id="example"
       style="margin: 5px;width: 29%;border: 1px solid #000000" align="center">
    <thead>
    <tr>

        <td style="width: 3%"><center>S.Noooo</center></td>
        <td style="width: 14%"><center>District Office Name</center></td>
        <g:if test="${districtOfficeList}">

        </g:if>
        %{--<sec:ifAllGranted roles="ROLE_DISTRICT">--}%
         %{--<td><center>Consumer Name</center></td>--}%
            %{--</sec:ifAllGranted>--}%
        <td style="width: 8%"><center>Excise Collection (Rs.)</center></td>

    </tr>
    </thead>
    <tbody>
    <g:each in="${districtOfficeList}" var="subDiv" status="i">
        <tr name="dataTr">
            <td name="sNo" style="vertical-align:middle;color: #000">
                ${i + 1}
            </td>
            <g:if test="${districtOffice}">
                <td name="districtOfficeName" rowspan="" style="vertical-align:middle;color: #000">
                    ${subDiv[0]}
                </td>
                %{--<td name="consumerName">${subDiv[1]}</td>--}%

                     <td name="revenueCollected">${subDiv[1]}</td>

            </g:if>
            <g:elseif test="${districtOffice}">
                <td name="districtOfficeName" rowspan="" style="vertical-align:middle;color: #000">
                    ${subDiv[0]}
                </td>
                <td name="revenueCollected">${subDiv[3]}</td>

            </g:elseif>
            <g:else>
                <td name="revenueCollected">${subDiv[0]}</td>
            </g:else>
        </tr>
    </g:each>
    </tbody>
</table>

<div id="container" style="width: 700px;height: 300px; margin: 0 auto"></div>
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
                       %{--<tr><td id="consumerNameValue" colspan="3"></td></tr>--}%
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





    //            var data = [
//                ['Heavy Industry', 12],['Retail', 9], ['Light Industry', 14],
//                ['Out of home', 16],['Commuting', 7], ['Orientation', 9]
//            ];
//            var plot1 = $.jqplot ('chart1', [data],
//                    {
//                        seriesDefaults: {
//                            // Make this a pie chart.
//                            renderer: jQuery.jqplot.PieRenderer,
//                            rendererOptions: {
//                                // Put data labels on the pie slices.
//                                // By default, labels show the percentage of the slice.
//                                showDataLabels: true
//                            }
//                        },
//                        legend: { show:true, location: 'e' }
//                    }
//            );



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
         Depending on level, the table is manipulated to show the  District Office.
         The even-odd colouring or background color of the table is also handled here.
         */
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
     On click of a cell under excise collection, a pop-up box comes up showing the breakup details.
     */
    $('td[name="revenueCollected"]').live('click', function() {
        var value;
        var total = $(this).text().trim();
        var districtOfficeName = $(this).siblings('[name="districtOfficeName"]').text().trim();
          var consumerName = $(this).siblings('[name="consumerName"]').text().trim();
        $('#districtOfficeValue').html('');
        $('#districtOfficeValue').html(districtOfficeName);
        $('#consumerNameValue').html('');
              $('#consumerNameValue').html(consumerName);

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