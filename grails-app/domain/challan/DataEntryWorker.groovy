package challan

import com.challan.User

class DataEntryWorker extends User{

    static belongsTo = [districtOffice:DistrictOffice]


    static constraints = {
    }
}
