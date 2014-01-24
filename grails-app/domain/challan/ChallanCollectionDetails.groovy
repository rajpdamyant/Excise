package challan

import javax.persistence.Transient


class ChallanCollectionDetails {

    int treasureId
    Date dataEnteredDate
    Date dataEntryDate
    int liquorId
    String consumerID
    String consumerName
    String accountHeadId;
    BigDecimal accountHeadAmount;     //Excise
    String districtId;
    String categoryType


    static belongsTo = [districtOffice: DistrictOffice]
    static constraints = {
    }
    //headquater all report  /distrct
    static def getTotalAmountForDate(String dname, Date fromDate, Date toDate, int liquorType, String category) {
        println "dname--"+dname;
        println "liquortype"+liquorType;
        println"cats"+category;
        BigDecimal totalAmount = 0;

        List<ChallanCollectionDetails> cd = ChallanCollectionDetails.createCriteria().list {
            eq("liquorId", liquorType)
            eq("categoryType", category)
            eq("districtId", dname)
            between("dataEntryDate", fromDate, toDate)
        }
           println"cd+++"+cd;
        cd.each {abc ->
            totalAmount += abc.accountHeadAmount;
        }
        println "totalAmount...." + totalAmount;
        return totalAmount
    }

    static def getTotalAmount(def districtOffice) {
        BigDecimal totalAmount = 0
        ChallanCollectionDetails.findAllByDistrictOffice(districtOffice).each {
            totalAmount += it.accountHeadAmount
        }
        return totalAmount
    }

    static def getHeadQTTotalAmountForDate(String districtOffice, Date fromDate, Date toDate, int liquorType, String category) {
        println("???????????????????"+fromDate)
        BigDecimal totalAmount = 0
        List<ChallanCollectionDetails> cd = ChallanCollectionDetails.createCriteria().list {
            eq("liquorId", liquorType)
            eq("categoryType",category)
            eq("districtId", districtOffice)
            between("dataEntryDate", fromDate, toDate)
        }
        println("values======"+cd)
        cd.each {abc ->
            totalAmount += abc.accountHeadAmount;
        }
        println "totalAmount...." + totalAmount;
        return totalAmount
    }
}