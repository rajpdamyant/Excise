package challan

class SuperintendentOffice {
     String name
    static belongsTo = [districtOffice: DistrictOffice]
    static constraints = {
        name(blank: false, nullable: false)

}
}