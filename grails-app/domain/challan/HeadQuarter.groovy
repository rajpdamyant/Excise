package challan

class HeadQuarter {
    String name

    static constraints = {
        name(blank: false,nullable: false)
    }

}
