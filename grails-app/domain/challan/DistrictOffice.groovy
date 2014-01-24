package challan

class DistrictOffice {

    String name


    static belongsTo = [headQuarter: HeadQuarter]
    static constraints = {
        name(blank: false, nullable: false)
    }

    String toString()
    {
        return   this.name;
    }
}
