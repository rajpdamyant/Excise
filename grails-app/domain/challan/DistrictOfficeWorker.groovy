package challan

import com.challan.User

class DistrictOfficeWorker extends User {

     static belongsTo = [districtOffice:DistrictOffice]
    static constraints = {
    }

}
