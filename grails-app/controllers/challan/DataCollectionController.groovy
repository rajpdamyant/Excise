package challan

import grails.converters.deep.JSON
import java.text.SimpleDateFormat
import javax.servlet.ServletOutputStream
import org.apache.commons.io.IOUtils
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils

//import org.codehaus.plexus.component.configurator.converters.basic.StringBufferConverter


import org.codehaus.groovy.grails.commons.ConfigurationHolder as CH
import grails.plugins.springsecurity.Secured
import org.apache.log4j.Logger

class DataCollectionController {
    def challanCollectionService;
    def springSecurityService
    static defaultAction = 'dataEnter'


    /*
   This action is written in order to initialize the data entry page for superintendent Office level workers.
    */


    @Secured('IS_AUTHENTICATED_FULLY')
    def updateRetailer = {
        println"params-------"+params;
        DistrictOffice districtOffice = springSecurityService.currentUser.districtOffice;

        Boolean flag = (challanCollectionService.updateRetailerDetails(params, districtOffice));
        if (flag) {
            render "Collection Saved"
        }
        else {
            render "Collection Not Saved"
        }
    }

    @Secured('IS_AUTHENTICATED_FULLY')
    def updateManufacturerDistributor = {
           println("params=="+params)
        DistrictOffice districtOffice = springSecurityService.currentUser.districtOffice;

        Boolean flag = (challanCollectionService.updateCollectionDetails(params, districtOffice));
        if (flag) {
           render "Collection Saved"
        }
        else {
            render "Collection Details Not Saved"
        }
    }


    def checkDataEnteredDate = {
        println "<<check entered date >>"
        DistrictOffice districtOffice = springSecurityService.currentUser.districtOffice
        params.sort().each {println "::" + it}
        println "params ++++++++++++" + params;
        if (challanCollectionService.checkDataEnteredDate(params, districtOffice))
            render "true"
        else
            render "false"
    }

    def overwriteCollection = {
        DistrictOffice districtOffice = springSecurityService.currentUser.districtOffice
        if (challanCollectionService.updateCollectionDetails(params, districtOffice))
            render "true"
        else
            render "false"
    }
    def dataEnter = {
        DistrictOffice districtOffice = springSecurityService.currentUser.districtOffice;
        String districtOfficeName = districtOffice.name
        String districtOfficeType = districtOffice.Type
        List accountHeadList = ['100', '101']
        println "districOfficeName :" + districtOfficeName
        [districtOfficeName: districtOfficeName, districtOfficeType: districtOfficeType, accountHeadList: accountHeadList]
    }

    def manufacturer = {
        int accountHeadId = CH.config.manufacturer.accounthead.id
        String consumerType = CH.config.manufacturer.accounthead.type
        println "ConsumerType >> ${consumerType}"
        DistrictOffice districtOffice = springSecurityService.currentUser.districtOffice;
        println "springSecurityService.currentUser${springSecurityService.currentUser}";
        String districtOfficeName = districtOffice.name
        println "districtOfficeName${districtOffice.name}"
        List<DistrictOffice> districtOfficeList = DistrictOffice.list();
        List consumer = Consumer.findAllByType("Manufacturer");
        List consumerId = consumer.consumerId;
        [accountHeadId: accountHeadId, consumerType: consumerType, districtOfficeName: districtOfficeName, districtOfficeList: districtOfficeList, consumerId: consumerId];
    }

    def distributor = {
        int accountHeadId = CH.config.distributor.accounthead.id
        String consumerType = CH.config.distributor.accounthead.type
        DistrictOffice districtOffice = springSecurityService.currentUser.districtOffice;
        String districtOfficeName = districtOffice.name;
        List<DistrictOffice> districtOfficeList = DistrictOffice.list();
        List consumer = Consumer.findAllByType("Distributor");
        List consumerId = consumer.consumerId;
        [accountHeadId: accountHeadId, consumerType: consumerType, districtOfficeName: districtOfficeName, districtOfficeList: districtOfficeList, consumerId: consumerId];
    }

    def retailerOn = {
        int accountHeadId1 = CH.config.retailerOn.accounthead.Exciseid
        int accountHeadId2 = CH.config.retailerOn.accounthead.VATid
        String consumerType = CH.config.retailerOn.accounthead.type
        println "ConsumerType >> ${consumerType}"
        DistrictOffice districtOffice = springSecurityService.currentUser.districtOffice;
        String districtOfficeName = districtOffice.name
        List<DistrictOffice> districtOfficeList = DistrictOffice.list();
        List consumer = Consumer.findAllByType("Retailer");
        List consumerId = consumer.consumerId;
        [accountHeadId1: accountHeadId1, accountHeadId2: accountHeadId2, consumerType: consumerType, districtOfficeName: districtOfficeName, districtOfficeList: districtOfficeList, consumerId: consumerId];
    }

    /*
   This action is written in order to provide a response to an ajax call requesting
   to save the details of revenue collection, misc. collection and deposited at bank entered by the sub-division level worker.
   This ajax call comes from data entry page.
    */
    def updateCollectionDetails = {
        println "params";
        String treasureid = params.treasureId;
        ChallanCollectionDetails chcd = ChallanCollectionDetails.findByConsumerID(params.consumerId);
        if (chcd) {
            flash.message = "The challan Id already exist please enter a new challan Id";
        }
        else {
            println "do nothing";
        }
    }

    /*
    This action is used for report page.
    */
    def report = {
        println "params report....${params}"
        if(params.rows){
            def sortIndex = params.sidx ?: 'name'
            def sortOrder  = params.sord ?: 'asc'
            def maxRows = Integer.valueOf(params.rows)
            def currentPage = Integer.valueOf(params.page) ?: 1
            def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

            String strSQL = "from ChallanCollectionDetails" ;

            if (params.id)
                strSQL = strSQL + " where id like '" + "%${params.id}%" + "'"

            if (params.accountHeadAmount)
                strSQL = strSQL + " where accountHeadAmount like '" + "%${params.accountHeadAmount}%" + "' "

            if (params.categoryType)
                strSQL = strSQL + " where categoryType like '" + "%${params.categoryType}%" + "' "


            strSQL = strSQL + " order by " + sortIndex + " " + sortOrder

            def clientInstance = ChallanCollectionDetails.executeQuery(strSQL, [max: maxRows, offset: rowOffset])

            def totalRows = ChallanCollectionDetails.findAll().size()

            def numberOfPages = Math.ceil(totalRows / maxRows)

            def jsonCells = clientInstance.collect
                    {
                        [
                                cell:
                                        [
                                                it.id,
                                                it.accountHeadAmount,
                                                it.categoryType

                                        ],
                                id: it.id
                        ]
                    }

            def jsonData= [rows: jsonCells, page: currentPage, records: totalRows, total: numberOfPages]

            render jsonData as grails.converters.JSON
        }
        else{
            String fromDateString = '', toDateString = ''
            Date fromDate = null, toDate = null;
            // getting the date
            Date theDate = new Date();
            //set the time
            theDate.setTime(theDate.getTime() + (theDate.getTimezoneOffset() + 330) * 60 * 1000);      //converting to IST Time Zone.
            // getting the hours part of the date if its less than 18
            if (theDate.getHours() < 18) {
                theDate.setDate(theDate.getDate() - 1);        //showing data till yesterday's date
            }
            Liquor liquor = new Liquor();
            fromDateString = ((theDate).getYear() + 1900) + "-" + ((theDate).getMonth() + 1) + "-" + ((theDate).getDate()) + " 00:00:00"
            toDateString = ((theDate).getYear() + 1900) + "-" + ((theDate).getMonth() + 1) + "-" + ((theDate).getDate()) + " 23:59:59"
            fromDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(fromDateString)
            toDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(toDateString)
            Map returnMap = [:];
            returnMap
        }

    }

/*
This function is written in order to provide a list of lists
containing name,excise collection for the domain(s)
depending on the user working level(headquarter/districtOffice).
This function is used at the time of report generation.
*/
    @Secured('IS_AUTHENTICATED_FULLY')
    def getReportData = {
        println "params reportData....${params}"
        String fromDateString = '', toDateString = ''
        Date fromDate = null, toDate = null
        if (params.selectedOption == 'all') {
            Date theDate = new Date();
            theDate.setTime(theDate.getTime() + (theDate.getTimezoneOffset() + 330) * 60 * 1000);      //converting to IST Time Zone.
            fromDateString = ((theDate).getYear() + 1900) + "-01-01 00:00:00"
            toDateString = ((theDate).getYear() + 1900) + "-" + ((theDate).getMonth() + 1) + "-" + ((theDate).getDate()) + " 23:59:59"
            fromDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(fromDateString)
            toDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(toDateString)
        }
        else if (params.selectedOption == 'daily') {
            fromDateString = params.datePickerDate + " 00:00:00"
            // toDateString = params.datePickerTo.toString().replace('/', '-') + " 23:59:59"
            toDateString = params.datePickerDate.toString() + " 23:59:59"
            fromDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(fromDateString)
            toDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(toDateString)
        }
        else if (params.selectedOption == 'dateRange') {
            fromDateString = params.datePickerFrom.toString().replace('/', '-') + " 00:00:00"
            toDateString = params.datePickerTo.toString().replace('/', '-') + " 23:59:59"
            fromDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(fromDateString)
            toDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(toDateString)
        }
        println "Getting Report Data"
        session.category=params.category
        session.liquorType=params.liquorType
        session.fromDate=params.datePickerFrom
        session.endDate=params.datePickerTo

//        Map returnMap = challanCollectionService.getAllReportData(fromDate, toDate, params)
//        render(template: '/dataCollection/report', model: returnMap)
        println(">>>>>>>parrrrr>>>>>>>>>>>>>>>"+params)
        List returnList = challanCollectionService.getAllReportData(fromDate, toDate, params)

        render returnList as JSON

    }
    /*
   This action is used initialize the admin main page.
    */
    def admin = {}

    /*
   This action is used initialize the home page.
    */
    def home = {}

    def uploadStatement = {
        println "file";
    }

    def retailerOff = {
        int accountHeadId1 = CH.config.retailerOFF.accounthead.Exciseid
        int accountHeadId2 = CH.config.retailerOFF.accounthead.VATid
        String consumerType = CH.config.retailerOFF.accounthead.type
        DistrictOffice districtOffice = springSecurityService.currentUser.districtOffice;
        String districtOfficeName = districtOffice.name
        List<DistrictOffice> districtOfficeList = DistrictOffice.list();
        List consumer = Consumer.findAllByType("Retailer");
        List consumerId = consumer.consumerId;
        [accountHeadId1: accountHeadId1, accountHeadId2: accountHeadId2, consumerType: consumerType, districtOfficeName: districtOfficeName, districtOfficeList: districtOfficeList, consumerId: consumerId];
    }


    @Secured('IS_AUTHENTICATED_FULLY')
    def numToWords = {
        println "params ====>" + params;
        NumToWords numToWords = new NumToWords()
        println "amount is" + params.Amount;
        int amount = Integer.parseInt(params.Amount)
        println "amount as integer" + amount;
        String AmtInWords = numToWords.convert(amount);
        println(" amount in words" + AmtInWords);
        render AmtInWords;
    }


    @Secured('IS_AUTHENTICATED_FULLY')
    def autoPopulate = {
        println "params in autopopulate action" + params;
        String consumerId = params.consumerId;
        Consumer consumer = Consumer.findByConsumerId(consumerId);
        if (consumer) {
            def name = consumer.consumerName;
            println "name" + name;
            render name;
        }
        else {
            println "the consumer does not exist";
            render ""
        }
    }

    def downloadStatement = {
        println "download" ;
        String path = params.filePath.toString().replace('*', '\\') ;
        String fileName = params?.fileName;
        FileInputStream inputStream = new FileInputStream(path)
        response.setContentType("application/octet-stream")
        response.setHeader("Content-disposition", "attachment;filename=" + fileName)
        ServletOutputStream outputStream = response.getOutputStream()
        IOUtils.copy(inputStream, outputStream)
        outputStream.flush()
        outputStream.close()
        inputStream.close()
    }

    def saveStatement = {
        println " Upload////";
        String path = "" ;
        def fileToBeUploaded = request.getFile('reconciliationStatementFile')
        String fileName
        String year = ((new Date()).getYear() + 1900)
        String month = ((new Date()).getMonth() + 1)
        if (SpringSecurityUtils.ifAnyGranted('ROLE_DISTRICT')) {
            DistrictOffice districtOffice = springSecurityService.currentUser.districtOffice
            path = getServletContext().getRealPath("/ReconciliationStatements/" + year + "/" + month + "/" + districtOffice.name)
        }
        fileName = fileToBeUploaded.originalFilename
        println "File Name : " + fileName + " Uploaded :)"
        File directories = new File(path)
        directories.mkdirs()
        path += "/" + fileName;
        fileToBeUploaded.transferTo(new File(path))
        println "File Name : " + fileName + " Uploaded :)"
        flash.message = "File " + fileName + " Uploaded Successfully."
        redirect(action: uploadStatement)
    }

    /*
     This action is used provide response against an ajax call requesting to download the help manual for the system.
      */


    def getDistrictList = {
        List<DistrictOffice> districtList = DistrictOffice.findAllByHeadQuarter('Assam');
        println " the district Office list is" + districtList;
        println "Getting DivisionList For DataEntry Page"
        render districtList.name as JSON
    }

    def helpMannualDownload = {
        String fileName = 'Help_Manual.pdf'
        String path = getServletContext().getRealPath("/data/" + fileName)
        FileInputStream inputStream = new FileInputStream(path)
        response.setContentType("application/octet-stream")
        response.setHeader("Content-disposition", "attachment;filename=" + fileName)
        ServletOutputStream outputStream = response.getOutputStream()
        IOUtils.copy(inputStream, outputStream)
        outputStream.flush()
        outputStream.close()
        inputStream.close()
    }

    /*
This action is used for  VAT report page.
*/

    def vatReport = {
        println "params report....${params}"
        String fromDateString = '', toDateString = ''
        Date fromDate = null, toDate = null;
        // getting the date
        Date theDate = new Date();
        //set the time
        theDate.setTime(theDate.getTime() + (theDate.getTimezoneOffset() + 330) * 60 * 1000);      //converting to IST Time Zone.
        // getting the hours part of the date if its less than 18
        if (theDate.getHours() < 18) {
            theDate.setDate(theDate.getDate() - 1);        //showing data till yesterday's date
        }
        fromDateString = ((theDate).getYear() + 1900) + "-" + ((theDate).getMonth() + 1) + "-" + ((theDate).getDate()) + " 00:00:00"
        toDateString = ((theDate).getYear() + 1900) + "-" + ((theDate).getMonth() + 1) + "-" + ((theDate).getDate()) + " 23:59:59"
        println "::" + fromDateString + "::" + toDateString
        fromDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(fromDateString)
        toDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(toDateString)
        Map returnMap = [:];
        returnMap
    }

    /*
    This function is written in order to provide a list of lists
    containing name, VAT Collection for the domain(s)
    depending on the user working level(headquarter/districtOffice).
    This function is used at the time of report generation.
    */
    @Secured('IS_AUTHENTICATED_FULLY')
    def getVATReportData = {
        println "params vatreportData....${params}"
        String fromDateString = '', toDateString = ''
        Date fromDate = null, toDate = null
        if (params.selectedOption == 'all') {
            Date theDate = new Date();
            theDate.setTime(theDate.getTime() + (theDate.getTimezoneOffset() + 330) * 60 * 1000);      //converting to IST Time Zone.
            fromDateString = ((theDate).getYear() + 1900) + "-01-01 00:00:00"
            toDateString = ((theDate).getYear() + 1900) + "-" + ((theDate).getMonth() + 1) + "-" + ((theDate).getDate()) + " 23:59:59"
            fromDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(fromDateString)
            toDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(toDateString)
        }
        else if (params.selectedOption == 'daily') {
            fromDateString = params.datePickerDate + " 00:00:00"
            toDateString = params.datePickerDate.toString() + " 23:59:59"
            fromDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(fromDateString)
            toDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(toDateString)
        }
        else if (params.selectedOption == 'dateRange') {
            fromDateString = params.datePickerFrom.toString().replace('/', '-') + " 00:00:00"
            toDateString = params.datePickerTo.toString().replace('/', '-') + " 23:59:59"
            fromDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(fromDateString)
            toDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(toDateString)
        }
        println "Getting VAT Report Data"
//        Map returnMap = challanCollectionService.getAllVatReportData(fromDate, toDate, params)
//        render(template: '/dataCollection/vatReport', model: returnMap)

        List returnList = challanCollectionService.getAllVatReportData(fromDate, toDate, params)
         print("????????????????"+returnList)
        render returnList as JSON

    }

    def licenseReport = {
        /* def category = params.category
        String fromDateString = '', toDateString = ''
        Date fromDate = null, toDate = null;
        // getting the date
        Date theDate = new Date();
        //set the time
        theDate.setTime(theDate.getTime() + (theDate.getTimezoneOffset() + 330) * 60 * 1000);      //converting to IST Time Zone.
        // getting the hours part of the date if its less than 18
        if (theDate.getHours() < 18) {
            theDate.setDate(theDate.getDate() - 1);        //showing data till yesterday's date
        }
        fromDateString = ((theDate).getYear() + 1900) + "-" + ((theDate).getMonth() + 1) + "-" + ((theDate).getDate()) + " 00:00:00"
        toDateString = ((theDate).getYear() + 1900) + "-" + ((theDate).getMonth() + 1) + "-" + ((theDate).getDate()) + " 23:59:59"
        fromDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(fromDateString)
        toDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(toDateString)

        Map returnMap = challanCollectionService.getActiveUsers(params)
        println "On Report Page "
        returnMap*/
    }

    /*
This function is written in order to provide a containing license information
depending on the user working level(headquarter/districtOffice).
This function is used at the time of report generation for license.
*/
    @Secured('IS_AUTHENTICATED_FULLY')
    def getLicenseReportData = {
        println "params??????" + params;
        if (params.selectedOption == 'active') {
//            Map returnMap = challanCollectionService.getActiveUsers(params);
//            render(template: '/dataCollection/licenseReport', model: returnMap)
            List returnList = challanCollectionService.getActiveUsers(params);

            def x=returnList as JSON
            println("end"+x)
            render x
        }
        else if (params.selectedOption == 'expired') {
//            Map returnMap = challanCollectionService.getExpiredUsers(params);
//            render(template: '/dataCollection/licenseReport', model: returnMap);
            List returnList = challanCollectionService.getActiveUsers(params);
            render returnList as JSON
        }
    }

    def licenseManufacturer = {
        int accountHeadId = CH.config.manufacturer.accounthead.id
        String consumerType = CH.config.manufacturer.accounthead.type
        println "ConsumerType >> ${consumerType}"
        DistrictOffice districtOffice = springSecurityService.currentUser.districtOffice;
        String districtOfficeName = districtOffice.name
        List<DistrictOffice> districtOfficeList = DistrictOffice.list();
        println " the district list is" + districtOfficeList;
        List consumer = Consumer.findAllByType("Manufacturer");
        List consumerId = consumer.consumerId;
        render(view: "licenseManufacturer", model: [accountHeadId: accountHeadId, consumerType: consumerType, districtOfficeName: districtOfficeName, districtOfficeList: districtOfficeList, consumerId: consumerId]);
    }

    def licenseDistributor = {
        int accountHeadId = CH.config.distributor.accounthead.id
        String consumerType = CH.config.distributor.accounthead.type
        println "ConsumerType >> ${consumerType}"
        DistrictOffice districtOffice = springSecurityService.currentUser.districtOffice;
        String districtOfficeName = districtOffice.name
        List<DistrictOffice> districtOfficeList = DistrictOffice.list();
        println " the district list is" + districtOfficeList;
        List consumer = Consumer.findAllByType("Distributor");
        List consumerId = consumer.consumerId;
        render(view: "licenseDistributor", model: [accountHeadId: accountHeadId, consumerType: consumerType, districtOfficeName: districtOfficeName, districtOfficeList: districtOfficeList, consumerId: consumerId]);
    }


    def licenseRetailerOn = {
        println "params???"+params;
        int accountHeadId2 = CH.config.retailerOn.accounthead.VATid
        String consumerType = CH.config.retailerOn.accounthead.type
        println "ConsumerType >> ${consumerType}"
        DistrictOffice districtOffice = springSecurityService.currentUser.districtOffice;
        String districtOfficeName = districtOffice.name
        List<DistrictOffice> districtOfficeList = DistrictOffice.list();
        println " the district list is" + districtOfficeList;
        List consumer = Consumer.findAllByType("Retailer");
        List consumerId = consumer.consumerId;
        render(view: "licenseRetailerOn", model: [accountHeadId2: accountHeadId2, consumerType: consumerType, districtOfficeName: districtOfficeName, districtOfficeList: districtOfficeList, consumerId: consumerId]);
    }

    def licenseRetailerOff = {
        println"params====="+params;
        int accountHeadId2 = CH.config.retailerOFF.accounthead.VATid
        String consumerType = CH.config.retailerOFF.accounthead.type
        println "ConsumerType >> ${consumerType}"
        DistrictOffice districtOffice = springSecurityService.currentUser.districtOffice;
        String districtOfficeName = districtOffice.name
        List<DistrictOffice> districtOfficeList = DistrictOffice.list();
        println " the district list is" + districtOfficeList;
        List consumer = Consumer.findAllByType("Retailer");
        List consumerId = consumer.consumerId;
        render(view: "licenseRetailerOn", model: [accountHeadId2: accountHeadId2, consumerType: consumerType, districtOfficeName: districtOfficeName, districtOfficeList: districtOfficeList, consumerId: consumerId]);
    }


    @Secured('IS_AUTHENTICATED_FULLY')
    def licenseFee = {
        DistrictOffice districtOffice = springSecurityService.currentUser.districtOffice
        Boolean flag = (!challanCollectionService.updateLicenseFeeDetails(params, districtOffice));

        render "Collection Saved";
    }

    @Secured('IS_AUTHENTICATED_FULLY')
    def getStatements = {
        List statementList = []
        if (params.selectedOption == 'district') {
            DistrictOffice districtOffice = DistrictOffice.findByName(params.domain)
            districtOffice.each { district ->
                statementList += challanCollectionService.getStatements(params.year, params.month, district)
            }
        }
        render statementList as JSON
    }

    def reconciliationStatements = {
        println "params" ;
        Map monthList = ['JAN': 1, 'FEB': 2, 'MAR': 3, 'APR': 4, 'MAY': 5, 'JUN': 6, 'JUL': 7, 'AUG': 8, 'SEP': 9, 'OCT': 10, 'NOV': 11, 'DEC': 12]
        String year = ((new Date()).getYear() + 1900).toString()
        String month = ((new Date()).getMonth() + 1).toString()
        List statementList = []
        List districtList=[];
        println "head" ;
        if (SpringSecurityUtils.ifAnyGranted('ROLE_HEADQUARTER')) {
            districtList = DistrictOffice.list()
            districtList.each { district ->
                districtList += challanCollectionService.getStatements(year, month, district)
                println "district...."+districtList;
            }
            println "return";
            Map returnMap = challanCollectionService.getAnalyticsData()
            println "return"+returnMap;
            returnMap += [monthList: monthList]
            returnMap += [statementList: statementList]
            returnMap
        }
//
    }

    def totalExciseList =
        {
            println("meeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee in grid action"+params)
            def sortIndex = params.sidx ?: 'name'
            def sortOrder  = params.sord ?: 'asc'
            def maxRows = Integer.valueOf(params.rows)
            def currentPage = Integer.valueOf(params.page) ?: 1
            def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
            String fromDateString = '', toDateString = ''
            Date fromDate = null, toDate = null

            fromDateString = session.fromDate.toString().replace('/', '-') + " 00:00:00"
            toDateString = session.endDate.toString().replace('/', '-') + " 23:59:59"
            fromDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(fromDateString)
            toDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(toDateString)


            List returnList = challanCollectionService.getGridData(fromDate, toDate, session.liquorType, session.category)


            String strSQL = "from ChallanCollectionDetails where categoryType='"+session.category+"' and liquorId='"+session.liquorType+"' and dataEntryDate between'"+session.fromDate+"' and'"+session.endDate+"'"  ;



            if (params.id)
                println("jjjjjj")
                strSQL = strSQL + " and id like '" + "%${params.id}%" + "'"

            if (params.accountHeadAmount)
                strSQL = strSQL + " and accountHeadAmount like '" + "%${params.accountHeadAmount}%" + "' "

            if (params.categoryType)
                strSQL = strSQL + " and categoryType like '" + "%${params.categoryType}%" + "' "


            strSQL = strSQL + "order by " + sortIndex + " " + sortOrder




            def clientInstance = ChallanCollectionDetails.executeQuery(strSQL, [max: maxRows, offset: rowOffset])

            def totalRows = ChallanCollectionDetails.findAll().size()

            def numberOfPages = Math.ceil(totalRows / maxRows)

            def jsonCells = clientInstance.collect
                    {
                        [
                                cell:
                                        [
                                                it.id,
                                                it.districtId,
                                                it.categoryType

                                        ]
//                                id: it.id
                        ]
                    }

            println("kkkkkkkkkkk"+jsonCells)

            def jsonData= [rows: returnList, page: currentPage, records: totalRows, total: numberOfPages]

            render jsonData as grails.converters.JSON
        }

}