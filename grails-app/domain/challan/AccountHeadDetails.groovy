package challan

class AccountHeadDetails {

    int consumerID
    String consumerName
    String accountHeadId;
    BigDecimal accountHeadAmount;

    static belongsTo = [challanCollectionDetails: ChallanCollectionDetails]
    static constraints = {
        accountHeadId(nullable: true, blank: true);
        accountHeadAmount(nullable: true, blank: true);
        consumerID(blank: false)
        consumerName(blank: false)
    }
}