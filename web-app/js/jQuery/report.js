/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 6/14/13
 * Time: 1:55 PM
 * To change this template use File | Settings | File Templates.
 */

function showNewReport() {

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




}
//    $.ajax({
//        url:'${createLink(controller: 'dataCollection', action: 'getReportData')}',
//        type:"post",
//        data:{selectedOption:selectedOption,liquorType:liquorType,EstId:EstId,category:category, datePickerDate:datePickerDate,datePickerFrom:datePickerFrom,datePickerTo:datePickerTo },
//        success:function(data) {
//            alert(data[0]);
////                drawPieChart(data)
//            //  showGird()
//
//        }
//        ,error:function(XMLHttpRequest, textStatus, errorThrown) {}
//
//    });

}

function getSelectedRadio(selectedRadio) {
    var value = '';
    $('[name="' + selectedRadio + '"]').each(function() {
        if ($(this).attr('checked'))
            value = $(this).attr('value');
    });
    return value;
}

