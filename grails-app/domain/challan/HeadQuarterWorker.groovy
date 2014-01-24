package challan

import com.challan.User

class HeadQuarterWorker extends User {

   static belongsTo = [headQuarter:HeadQuarter]
    static constraints = {
    }
}
