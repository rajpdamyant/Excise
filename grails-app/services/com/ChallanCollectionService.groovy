package com

import challan.ChallanCollectionDetails
import challan.DistrictOffice
import challan.HeadQuarter
import grails.converters.JSON

import java.util.*;
import java.text.SimpleDateFormat
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils
import static org.codehaus.groovy.grails.web.context.ServletContextHolder.getServletContext
import org.eclipse.jdt.internal.compiler.codegen.IntegerCache
import javax.security.auth.login.AccountException
import challan.SuperintendentOffice
import java.text.*;
import challan.Retailer
import challan.License
import challan.Liquor
import javax.persistence.Id
import challan.Consumer
import challan.AccountHeadDetails
import org.codehaus.groovy.grails.web.servlet.mvc.GrailsParameterMap


class ChallanCollectionService {
    def challanCollectionService;
    static transactional = false
    def springSecurityService

    /*
      This function is written in order to implement a part of analytics which to provide
      a list of districtList
      depending upon the type of user logged in.
    */

    Map getDataEntryModel() {
        Map finalData = [:]
        if (SpringSecurityUtils.ifAnyGranted('ROLE_DISTRICT ')) {
            DistrictOffice districtOffice = springSecurityService.currentUser.districtOffice;
            println "DistrictOffice Level Worker Of " + districtOffice.name + " At Data Entry Page"
            finalData = [districtName: district.name]
            // this data will be send to data entry.gsp where these values will be retrieves and shown
        }
        return finalData
    }

    /*
   This function is written in order to check that  challan collections entry for today exists or not.
   If  challan collections entry for the particular superintendentOffice has been done previously for today
   then it returns false, else true.
    */

    Boolean checkDataEnteredDate(def params, def districtOffice) {
        return (!challanCollectionService.updateRetailerDetails(params, districtOffice));
    }

    /* This is to save update maufacturer/distr details */

    Boolean updateCollectionDetails(def params, def districtOffice) {
        println "params"+params
        Date dataEnteredDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse('2013-06-11 19:4:10');
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        String str_date = params.selectionDate;
        Date date = df.parse(str_date);

        Boolean challanCollectionDetailsSaved = false;
        // firstly checking the values in my params are not null then check whther

        def treasureIdeList = []
        treasureIdeList.addAll(params?.accountHeadTreasureId)
        def districtOfficeList = []
        districtOfficeList.addAll(params?.districtOfficeList)
        def accountHeadAmountList = []
        accountHeadAmountList.addAll(params?.accountHeadAmount)
        def accountHeadConsumerIdList = []
        accountHeadConsumerIdList.addAll(params?.accountHeadConsumerId)
        def accountHeadConsumerNameList = []
        accountHeadConsumerNameList.addAll(params?.accountHeadConsumerName)


        for(int i=0;i<treasureIdeList.size();i++) {

        ChallanCollectionDetails challanCollectionDetails = new ChallanCollectionDetails();

        challanCollectionDetails.districtId = districtOfficeList[i].toString()

        challanCollectionDetails.treasureId = Integer.parseInt(treasureIdeList[i]);

        challanCollectionDetails.accountHeadAmount = new BigDecimal(accountHeadAmountList[i]);

        challanCollectionDetails.consumerID = accountHeadConsumerIdList[i].toString()

        challanCollectionDetails.consumerName = accountHeadConsumerNameList[i];

        challanCollectionDetails.dataEnteredDate = new Date();

        challanCollectionDetails.dataEntryDate = date;

        challanCollectionDetails.liquorId = Integer.parseInt(params.accountHeadLiquorType);

        challanCollectionDetails.categoryType=params.consumerType;

        challanCollectionDetails.accountHeadId = params.accountHeadId;

        challanCollectionDetails.districtOffice = DistrictOffice.findById(districtOffice.id);

        if (challanCollectionDetails.save(flush: true)) {
             challanCollectionDetailsSaved = true;
                 }
        }
        return challanCollectionDetailsSaved;
    }

    /*
   This function is written in order to provide a list of lists
   containing name, Excise collection  depending on the user working level(district/headquarter).
   This function is used at the time of report generation.
    */


    List getAllReportData(Date fromDate, Date toDate, def params) {

        println "params"+params;
        Map returnMap = [:]
        List finalList = []
        List<DistrictOffice> districtOfficeList = []
        BigDecimal accountHeadAmount = 0
        BigDecimal accountHeadIDEXCISE = 0
        BigDecimal totalAmount = 0;
        BigDecimal grandTotalAmount = 0
        BigDecimal total_excise = 0;
        if (SpringSecurityUtils.ifAnyGranted('ROLE_HEADQUARTER')) {
            HeadQuarter headQuarter = springSecurityService.currentUser.headQuarter
            println "HeadQuarter Level Worker Of " + headQuarter.name + " Viewing the Report"
            districtOfficeList = DistrictOffice.findAllByHeadQuarter(headQuarter)
            int   liquorType= Integer.parseInt(params.liquorType);
            println "params" +liquorType
            String  EstId=  params.EstId ;
            println "est id"+EstId;
            String category=params.category;
            println "cat++"+category;
            totalAmount = 0
            districtOfficeList.each {districtOffice ->
                //Excise collection For Manufacturer and Distributor
                if(category=="RetailerOn" || category=="RetailerOFF")
                {
                    accountHeadIDEXCISE = Retailer.getTotalExciseAmountForDate(districtOffice.name, fromDate, toDate,liquorType,category)
                    total_excise = accountHeadIDEXCISE
                    println "totalexcret " +total_excise;
                }
                else {
                    accountHeadAmount = ChallanCollectionDetails.getHeadQTTotalAmountForDate(districtOffice.name,fromDate, toDate,liquorType,category )
                    println"accountHeadAmount" +accountHeadAmount
                    total_excise = accountHeadAmount
                    println " totexc--" +total_excise;
                }

                finalList += [[districtOffice.name, total_excise]]
                totalAmount += total_excise
            }
            if (!districtOfficeList.isEmpty())
                finalList += [['<strong>Grand Total</strong>', '<strong>' + totalAmount + '</strong>']]

            finalList
//            returnMap = [districtOfficeList: finalList, districtOfficeLevel: true, districtOffice: true]
        }
        else if (SpringSecurityUtils.ifAnyGranted('ROLE_DISTRICT')) {
            DistrictOffice districtOffice = springSecurityService.currentUser.districtOffice
            println "districtOffice Level Worker Of " + districtOffice.name + " Viewing the Report"
            int   liquorType= Integer.parseInt(params.liquorType);
            println "params" +liquorType
            String  EstId=  params.EstId ;
            println "est id"+EstId;
            String dname=districtOffice.name;
            Retailer retailer=new Retailer();
            String category=params.category;
            println "cat++"+category;
            ChallanCollectionDetails challanCollectionDetails= new ChallanCollectionDetails();
            //for manufacturere/distributor
            println "name--" +dname;
            //From Retailer
            if(category=="RetailerOn" || category=="RetailerOFF")
            {
                accountHeadIDEXCISE = Retailer.getTotalExciseAmountForDate(dname, fromDate, toDate ,liquorType,category)
                println "accountHeadIDEXCISe--"+accountHeadIDEXCISE;
                total_excise =  accountHeadIDEXCISE;
                println "totalexcise"+total_excise;
            }
            else {
                println "params---";
                accountHeadAmount = ChallanCollectionDetails.getTotalAmountForDate(dname,fromDate, toDate,liquorType,category )
                println"accountHeadAmount" +accountHeadAmount
                total_excise = accountHeadAmount;
                println "totalexcise..."+total_excise;
            }
            finalList = [[districtOffice.name,total_excise]]
//            returnMap = [districtOfficeList: finalList, districtOfficeLevel: true, districtOffice: true]
        }
        else {
            returnMap = [:]
            println "Sorry, Permision Denied For Viewing The Report For User " + springSecurityService.currentUser
        }
        println("at end"+finalList)
        return finalList
    }

    /*
   This function is written in order to provide a list of lists
   containing name, License Details  depending on the user.
   This function is used at the time of report generation.
    */


    Map getAllLicenseData(Date fromDate, Date toDate) {
        Map returnMap = [:]
        List finalList = []
        List<DistrictOffice> districtOfficeList = []
        BigDecimal amount = 0
        BigDecimal totalAmount = 0
        BigDecimal grandTotalAmount = 0
        if (SpringSecurityUtils.ifAnyGranted('ROLE_HEADQUARTER')) {
            HeadQuarter headQuarter = springSecurityService.currentUser.headQuarter
            println "HeadQuarter Level Worker Of " + headQuarter.name + " Viewing the Report"
            districtOfficeList = DistrictOffice.findAllByHeadQuarter(headQuarter)
            districtOfficeList.each {districtOffice ->
                amount = license.getTotalLicenseAmountForDate(districtOffice as DistrictOffice, fromDate, toDate)
                finalList += [[districtOffice.name, amount]]
            }
            if (!districtOfficeList.isEmpty())
                finalList += [['<strong>Grand Total</strong>', '<strong>' + totalAmount + '</strong>']]
            returnMap = [districtOfficeList: finalList, districtOfficeLevel: true, districtOffice: true]
        }
        else if (SpringSecurityUtils.ifAnyGranted('ROLE_DISTRICT')) {
            DistrictOffice districtOffice = springSecurityService.currentUser.districtOffice
            println "districtOffice Level Worker Of " + districtOffice.name + " Viewing the Report"
            finalList = [[districtOffice.name, amount]]
            totalAmount += amount
            finalList += [['<strong>Grand Total</strong>', '<strong>' + totalAmount + '</strong>']]
            returnMap = [districtOfficeList: finalList, districtOfficeLevel: true, districtOffice: true]
        }
        else {
            returnMap = [:]
            println "Sorry, Permision Denied For Viewing The Report For User " + springSecurityService.currentUser
        }
        return returnMap
    }

    Boolean updateRetailerDetails(def params, def districtOffice) {
        Boolean rdetailsSaved = false;
        println " params====================" + params;
        Date dataEnteredDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse('2013-06-11 19:4:10');
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        String str_date = params.selectionDate;
        Date date = df.parse(str_date);

        def treasureIdeList = []
        treasureIdeList.addAll(params?.accountHeadTreasureId)
        def districtOfficeList = []
        districtOfficeList.addAll(params?.districtOfficeList)
        def accountHeadExciseList = []
        accountHeadExciseList.addAll(params?.accountHeadExcise)
        def accountHeadVatList = []
        accountHeadVatList.addAll(params?.accountHeadVat)
        def accountHeadConsumerIdList = []
        accountHeadConsumerIdList.addAll(params?.accountHeadConsumerId)
        def accountHeadConsumerNameList = []
        accountHeadConsumerNameList.addAll(params?.accountHeadConsumerName)

        for(int i=0;i<treasureIdeList.size();i++) {
        Retailer rdetails = new Retailer();
        rdetails.consumerID = accountHeadConsumerIdList[i].toString()
        rdetails.accountHeadIDEXCISE = new BigDecimal(accountHeadExciseList[i]);
        rdetails.accountHeadIDVAT = new BigDecimal(accountHeadVatList[i]);
        rdetails.consumerName =accountHeadConsumerNameList[i];
        rdetails.treasuryID = Integer.parseInt(treasureIdeList[i]);
        rdetails.categoryType=params.consumerType;
        rdetails.districtID = districtOfficeList[i].toString()
        rdetails.districtOffice = DistrictOffice.findById(districtOffice.id);
        rdetails.dataEnteredDate = new Date();
        rdetails.dataEntryDate = date;
        rdetails.liquorId = Integer.parseInt(params.accountHeadLiquorType);
        rdetails.categoryType= params.consumerType;
        if (rdetails.save(flush: true)) {
            rdetailsSaved = true;
            }

        }
        return (rdetailsSaved);
    }

    /*
   This function is written in order to provide a list of lists
   containing name, VAT collection  depending on the user working level(district/headquarter).
   This function is used at the time of report generation.
    */


    List getAllVatReportData(Date fromDate, Date toDate ,def params) {

        Map returnMap = [:]
        List finalList = []
        List<DistrictOffice> districtOfficeList = []
        BigDecimal accountHeadIDVAT = 0
        BigDecimal totalAmount = 0
        BigDecimal grandTotalAmount = 0
        if (SpringSecurityUtils.ifAnyGranted('ROLE_HEADQUARTER')) {
            HeadQuarter headQuarter = springSecurityService.currentUser.headQuarter
            println "HeadQuarter Level Worker Of " + headQuarter.name + " Viewing the Report"
            districtOfficeList = DistrictOffice.findAllByHeadQuarter(headQuarter)
            int   liquorType= Integer.parseInt(params.liquorType);
            println "params" +liquorType
            String  EstId= params.EstId ;
            println "est id"+EstId;
            String category=params.category;
            totalAmount = 0
            districtOfficeList.each {districtOffice ->
                accountHeadIDVAT = Retailer.getHeadQTTotalVATAmountForDate(districtOffice.name, fromDate, toDate ,liquorType,category)
                println "accountHeadIDVAT.." + accountHeadIDVAT
                finalList += [[districtOffice.name, accountHeadIDVAT]]
                totalAmount += accountHeadIDVAT

            }
            if (!districtOfficeList.isEmpty())
                finalList += [['<strong>Grand Total</strong>', '<strong>' + totalAmount + '</strong>']]

            finalList
//            returnMap = [districtOfficeList: finalList, districtOfficeLevel: true, districtOffice: true]
        }
        else if (SpringSecurityUtils.ifAnyGranted('ROLE_DISTRICT')) {
            DistrictOffice districtOffice = springSecurityService.currentUser.districtOffice
            println "districtOffice Level Worker Of " + districtOffice.name + " Viewing the Report"
            println "d office"+districtOffice.id;
            int   liquorType= Integer.parseInt(params.liquorType);
            println "params" +liquorType
            String  EstId= params.EstId ;
            println "est id"+EstId;
            String dname=districtOffice.name;
            String category=params.category;
            println"category==="+category;
            accountHeadIDVAT = Retailer.getTotalVATAmountForDate(dname, fromDate, toDate,liquorType,category)
            println "accountHeadIDVAT" + accountHeadIDVAT
            finalList = [[districtOffice.name, accountHeadIDVAT]]
            totalAmount += accountHeadIDVAT
            if (!districtOfficeList.isEmpty())
                finalList += [['<strong>Grand Total</strong>', '<strong>' + totalAmount + '</strong>']]
            finalList
//            returnMap = [districtOfficeList: finalList, districtOfficeLevel: true, districtOffice: true]
        }
        else {
            returnMap = [:]
            println "Sorry, Permision Denied For Viewing The Report For User " + springSecurityService.currentUser
        }
        return finalList
    }


    Map getAnalyticsData() {
        List districtOfficeList = [];
        String level = ''  ;
        println "......";
        if (SpringSecurityUtils.ifAnyGranted('ROLE_HEADQUARTER')) {
            districtOfficeList = DistrictOffice.list().name
            level = 'headQuarter'
            [selectList: districtOfficeList, level: level, districtList:districtOfficeList]
        }
    }
    List getStatements(String year, String month, domain) {
        String path = getServletContext().getRealPath("/ReconciliationStatements/" + year + "/" + month + "/" + domain)
        File directory = new File(path)
        List<File> fileList = directory.listFiles()
        List finalList = []
        fileList.each {file ->
            finalList += [[file.getName(), file.getPath().replace('\\', '*')]]
        }
        return finalList
    }


    Boolean updateLicenseFeeDetails(def params, def districtOffice) {

        println("?????????"+params)

        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        String str_date = params.selectedDate;
        Date date = df.parse(str_date);

        Boolean licenseDetailsSaved = false;
        // firstly checking the values in my params are not null then check whther

        def treasureIdeList = []
        treasureIdeList.addAll(params?.accountHeadTreasureId)
        def districtOfficeList = []
        districtOfficeList.addAll(params?.districtOfficeList)
        def accountHeadAmountList = []
        accountHeadAmountList.addAll(params?.accountHeadAmount)
        def accountHeadConsumerIdList = []
        accountHeadConsumerIdList.addAll(params?.accountHeadConsumerId)
        def accountHeadConsumerNameList = []
        accountHeadConsumerNameList.addAll(params?.accountHeadConsumerName)
        def durationList = []
        durationList.addAll(params?.duration)


        for(int i=0;i<treasureIdeList.size();i++) {

        License license1 = License.findByConsumerId(accountHeadConsumerIdList[i]);
        if (license1) {
            license1.districtName = districtOfficeList[i].toString()
            license1.treasuryChallanId = Integer.parseInt(treasureIdeList[i]);
            license1.amount = new BigDecimal(accountHeadAmountList[i]);
            license1.consumerId = params.accountHeadConsumerId
            license1.consumerName = accountHeadConsumerNameList[i];
            license1.duration = durationList[i];
            license1.dataEntryDate = date;
            license1.accountHeadId = params.accountHeadId;
            license1.liquorId = Integer.parseInt(params.accountHeadLiquorType);

//            license1.districtOffice = DistrictOffice.findById(7.toLong());
            license1.districtOffice = DistrictOffice.findById(districtOffice.id);
            if (license1.save(failOnError: true)) {
                licenseDetailsSaved = true;
            }
        }
        else {
            License license = new License();
            license.consumerId= accountHeadConsumerIdList[i].toString()
            license.districtName = districtOfficeList[i].toString()
            license.treasuryChallanId = Integer.parseInt(treasureIdeList[i]);
            license.amount = new BigDecimal(accountHeadAmountList[i]);
            license.consumerId = params.accountHeadConsumerId
            license.consumerName = accountHeadConsumerNameList[i];
            license.duration = durationList[i];
            license.dataEntryDate = date;
            license.accountHeadId = params.accountHeadId;
            license.liquorId = Integer.parseInt(params.accountHeadLiquorType);

//            license.districtOffice = DistrictOffice.findById(7.toLong());
            license.districtOffice = DistrictOffice.findById(districtOffice.id);
            if (license.save(failOnError: true)) {
                licenseDetailsSaved = true;
            }
        }
        }

        return licenseDetailsSaved;
    }


    List  getActiveUsers(def params) {
        GrailsParameterMap
        Boolean expire=true;
        Map returnMap = [:]
        List finalList = [];
        List <DistrictOffice> districtOfficeList
        println "params" +params ;
        if (SpringSecurityUtils.ifAnyGranted('ROLE_HEADQUARTER')) {
            HeadQuarter headQuarter = springSecurityService.currentUser.headQuarter
            println "HeadQuarter Level Worker Of " + headQuarter.name + " Viewing the Report"
            districtOfficeList = DistrictOffice.findAllByHeadQuarter(headQuarter)
            int liquorType = Integer.parseInt(params.liquorType)
            List <License> licenseList = [] ;
            districtOfficeList.each{dname->
                licenseList +=License.createCriteria().list {
                    eq("duration","2011-2012")
                    eq("accountHeadId",params.category)
                    eq("districtName",dname.name);
                    eq("liquorId",liquorType);
                }

            }

            licenseList.each {license ->
                //Excise collection For Manufacturer and Distributor
                finalList += [[license.districtName,license.consumerName, license.amount]] ;
            }
//            println "final list in getactive user function" + finalList
//            returnMap = [finalList: finalList,expire:false];
            finalList
        }
        else if (SpringSecurityUtils.ifAnyGranted('ROLE_DISTRICT')) {
            DistrictOffice districtOffice = springSecurityService.currentUser.districtOffice
            println "districtOffice Level Worker Of " + districtOffice.name + " Viewing the Report"
            int liquorType = Integer.parseInt(params.liquorType)
            List licenseList=License.createCriteria().list {
                eq("duration","2011-2012")
                eq("accountHeadId",params.category)
                eq("districtName",districtOffice.name);
                eq("liquorId",liquorType);
            }
            licenseList.each{license ->
                finalList+= [[license.consumerName, license.amount]];
            }

//            returnMap = [finalList: finalList];
            finalList
        }
        else {
            returnMap = [:]
            println "Sorry, Permision Denied For Viewing The Report For User " + springSecurityService.currentUser
        }
        return finalList
    }


    Map getExpiredUsers(def params) {
        Map returnMap = [:]
        List finalList = [];
        List <DistrictOffice> districtOfficeList
        println "params" +params ;
        if (SpringSecurityUtils.ifAnyGranted('ROLE_HEADQUARTER')) {
            HeadQuarter headQuarter = springSecurityService.currentUser.headQuarter
            println "HeadQuarter Level Worker Of " + headQuarter.name + " Viewing the Report"
            districtOfficeList = DistrictOffice.findAllByHeadQuarter(headQuarter)
            int liquorType = Integer.parseInt(params.liquorType)
            List <License> licenseList = [] ;
            districtOfficeList.each{dname->
                licenseList+= License.createCriteria().list {
                    ne("duration","2011-2012")
                    eq("accountHeadId",params.category)
                    eq("districtName",dname.name);
                    eq("liquorId",liquorType);
                }

            }

            licenseList.each {license ->
                //Excise collection For Manufacturer and Distributor
                finalList += [['-',license.consumerName,'-']] ;
            }
            println "final list in getactive user function" + finalList
            returnMap = [finalList: finalList,expire:false];
        }
        else if (SpringSecurityUtils.ifAnyGranted('ROLE_DISTRICT')) {
            DistrictOffice districtOffice = springSecurityService.currentUser.districtOffice
            println "districtOffice Level Worker Of " + districtOffice.name + " Viewing the Report"
            println "params========"+params ;
            def category=params.category;
            def districtName=districtOffice.name;
            int liquorType = Integer.parseInt(params.liquorType)
            List licenseList=License.createCriteria().list {
                ne("duration","2011-2012")
                eq("accountHeadId",category)
                eq("districtName",districtName);
                eq("liquorId",liquorType);
            }
            println "license in district"+licenseList;
            licenseList.each{license ->
                finalList+= [[license.consumerName]];
            }
            returnMap = [finalList: finalList,expire:true];
        }
        else {
            returnMap = [:]
            println "Sorry, Permision Denied For Viewing The Report For User " + springSecurityService.currentUser
        }
        return returnMap
    }

    List getGridData(fromDate, toDate,liquorTypeID ,categoryType) {


//        Map returnMap = [:]
        List finalList = []
        List<DistrictOffice> districtOfficeList = []
        BigDecimal accountHeadAmount = 0
        BigDecimal accountHeadIDEXCISE = 0
        BigDecimal totalAmount = 0;
        BigDecimal grandTotalAmount = 0
        BigDecimal total_excise = 0;
        if (SpringSecurityUtils.ifAnyGranted('ROLE_HEADQUARTER')) {
            HeadQuarter headQuarter = springSecurityService.currentUser.headQuarter
            districtOfficeList = DistrictOffice.findAllByHeadQuarter(headQuarter)
            int   liquorType= Integer.parseInt(liquorTypeID);
            totalAmount = 0
            districtOfficeList.each {districtOffice ->
                //Excise collection For Manufacturer and Distributor
                if(categoryType=="RetailerOn" || categoryType=="RetailerOFF")
                {
                    accountHeadIDEXCISE = Retailer.getTotalExciseAmountForDate(districtOffice.name, fromDate, toDate,liquorType,categoryType)
                    total_excise = accountHeadIDEXCISE
                }
                else {
                    accountHeadAmount = ChallanCollectionDetails.getHeadQTTotalAmountForDate(districtOffice.name,fromDate, toDate,liquorType,categoryType )
                    total_excise = accountHeadAmount

                }

                finalList += [[districtOffice.name, total_excise]]
                totalAmount += total_excise
            }
            if (!districtOfficeList.isEmpty())
                finalList += [['<strong>Grand Total</strong>', '<strong>' + totalAmount + '</strong>']]

            finalList
//            returnMap = [districtOfficeList: finalList, districtOfficeLevel: true, districtOffice: true]
        }
        else if (SpringSecurityUtils.ifAnyGranted('ROLE_DISTRICT')) {
            DistrictOffice districtOffice = springSecurityService.currentUser.districtOffice
            println "districtOffice Level Worker Of " + districtOffice.name + " Viewing the Report"
            int   liquorType= Integer.parseInt(liquorTypeID);
//            String  EstId=  params.EstId ;
//            println "est id"+EstId;

            Retailer retailer=new Retailer();

            ChallanCollectionDetails challanCollectionDetails= new ChallanCollectionDetails();
            //for manufacturere/distributor

            //From Retailer
            if(categoryType=="RetailerOn" || categoryType=="RetailerOFF")
            {
                accountHeadIDEXCISE = Retailer.getTotalExciseAmountForDate(districtOffice.name, fromDate, toDate ,liquorType,categoryType)
                 total_excise =  accountHeadIDEXCISE;

            }
            else {
                accountHeadAmount = ChallanCollectionDetails.getTotalAmountForDate(districtOffice.name,fromDate, toDate,liquorType,categoryType )
                total_excise = accountHeadAmount;
               }
            finalList = [[districtOffice.name,total_excise]]
//            returnMap = [districtOfficeList: finalList, districtOfficeLevel: true, districtOffice: true]
        }
        else {
//            returnMap = [:]
            println "Sorry, Permision Denied For Viewing The Report For User " + springSecurityService.currentUser
        }


        def reutrnList1=[]
        finalList.eachWithIndex{ list1, idx ->
            def  reutrn_Map=[:]
            def test=[]
            test[0] =  idx +1
            println("kk"+test[0])
            test.addAll( list1   )
            reutrn_Map."cell" =test
            reutrnList1   << reutrn_Map
        }

        return reutrnList1
    }

}