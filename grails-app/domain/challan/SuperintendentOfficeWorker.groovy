package challan

import com.challan.User

class SuperintendentOfficeWorker extends User {

    static belongsTo = [superintendentOffice: SuperintendentOffice]
    static constraints = {
    }


}
