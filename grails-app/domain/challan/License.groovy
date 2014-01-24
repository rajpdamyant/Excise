package challan

class License {

    Date dataEntryDate;
    String accountHeadId;
    String districtName;
    String duration;
    String consumerId;
    String consumerName;
    String treasuryChallanId;
    BigDecimal amount;
    int liquorId


    static belongsTo = [districtOffice: DistrictOffice]
    static constraints = {
    }

 }
