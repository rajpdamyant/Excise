package challan

class Retailer {

    String treasuryID
    String consumerID
    String consumerName
    String districtID
    BigDecimal accountHeadIDVAT
    BigDecimal accountHeadIDEXCISE
    Date dataEntryDate;
    Date dataEnteredDate;
    int liquorId
    String categoryType




    static belongsTo = [districtOffice: DistrictOffice]
    static constraints = {
    }

       //headquater   vat report
    static def getTotalVATAmountForDate( String dname, Date fromDate, Date toDate ,int liquorType,String category) {
         println "name.." +dname;
        BigDecimal totalAmount = 0
         List <Retailer> cd= Retailer.createCriteria() .list {
                eq("liquorId",liquorType)
                 eq("categoryType",category)
                eq("districtID",dname)
                between("dataEntryDate" ,fromDate,toDate)
            }
                println "cd::::"+cd;
               cd.each {abc->
                   totalAmount+=abc.accountHeadIDVAT;
                   println "acctheadamt..."+totalAmount;
               }
        return totalAmount
    }


     //headquater/district excise all report
    static def getTotalExciseAmountForDate(String dname, Date fromDate, Date toDate, int liquorType,String category) {
        BigDecimal totalAmount = 0
        println"dname"+dname;
        println"frmdate"+fromDate;
        println "lastdate"+toDate;
        println "est"+category;
        println "lt"+liquorType;
        List <Retailer> cd= Retailer.createCriteria() .list {
                      eq("liquorId",1)
                      eq("districtID",dname)
                      eq("categoryType",category)
                      between("dataEntryDate" ,fromDate,toDate)
                  }
                     println "cd"+cd;
                     cd.each {abc->
                         totalAmount+=abc.accountHeadIDEXCISE;
                         println "totalAmount.." +totalAmount;
                     }
        return totalAmount
    }


    static  def getHeadQTTotalVATAmountForDate(String districtOffice, Date fromDate, Date toDate, int liquorType,String category){
        println "name.." +districtOffice;
              BigDecimal totalAmount = 0
               List <Retailer> cd= Retailer.createCriteria() .list {
                      eq("liquorId",liquorType)
                      eq("categoryType",category)
                      eq("districtID",districtOffice)
                      between("dataEntryDate" ,fromDate,toDate)
                  }
                     cd.each {abc->
                         totalAmount+=abc.accountHeadIDVAT;
                         println "acctheadamt..."+totalAmount;
                     }
              return totalAmount
    }

}
