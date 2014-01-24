import com.challan.Role
import com.challan.User
import com.challan.UserRole


class BootStrap {

    def springSecurityService
    def init = { servletContext ->
        createChallanCollectionRoles()
        createChallanCollectionUsers()
    }



    void createChallanCollectionRoles() {

        if (!(Role.findByAuthority('ROLE_ADMIN'))) {
            new Role(authority: 'ROLE_ADMIN').save(flush: true)
        }

        if (!(Role.findByAuthority('ROLE_HEADQUARTER'))) {
            new Role(authority: 'ROLE_HEADQUARTER').save(flush: true)
        }

        if (!(Role.findByAuthority('ROLE_DISTRICT'))) {
            new Role(authority: 'ROLE_DISTRICT').save(flush: true)
        }
//        if (!(Role.findByAuthority('ROLE_SUPERINTENDENT'))) {
        //            new Role(authority: 'ROLE_SUPERINTENDENT').save(flush: true)
        //        }

        //        if (!(AccountHeadDetails.findByAccountHeadId('100'))) {
        //            new AccountHeadDetails(authority: 'ROLE_SUPERINTENDENT').save(flush: true)
        //        }

        if (!(Role.findByAuthority('ROLE_DATAENTRY'))) {
            new Role(authority: 'ROLE_DISTRICT ').save(flush: true)
        }
//
    }
    void createChallanCollectionUsers() {
        Role role_admin = Role.findByAuthority('ROLE_ADMIN')
        Role role_user_headquarter= Role.findByAuthority('ROLE_HEADQUARTER')
        Role role_user_district = Role.findByAuthority('ROLE_DISTRICT')
        Role role_user_dataentry = Role.findByAuthority('ROLE_DATAENTRY')
        //Super_Admin
        if (!(User.findByUsername('user_admin'))) {
            User userAdmin;
            userAdmin = new User(username: 'user_admin', password: 'damyant@123!#', email: 'admin@damyant.com', enabled: true, accountExpired: false, accountLocked: false, passwordExpired: false)
            if (userAdmin.save()) {
                UserRole.create userAdmin, role_admin
                println "saved"
            }
            else {
                println "errors are"
                userAdmin.errors.allErrors.each {
                    println "Error --->> ${it}"
                }
            }

        }
        if (!(User.findByUsername('user_hq'))) {
            User userHeadquarter;
            userHeadquarter = new User(username: 'user_hq', password: 'damyant@123', email: 'admin@damyant.com', enabled: true, accountExpired: false, accountLocked: false, passwordExpired: false)
            if (userHeadquarter.save()) {
                UserRole.create userHeadquarter, role_user_headquarter
                println "saved"
            }
            else {
                println "errors are"
                userHeadquarter.errors.allErrors.each {
                    println "Error --->> ${it}"
                }
            }

        }
        if(!(User.findByUsername('user_district')))  {
            User userDistrict
            userDistrict = new User(username: 'user_district',password: 'damyant@123', email: 'admin@damyant.com', enabled: true, accountExpired: false, accountLocked: false, passwordExpired: false)
            if(userDistrict.save()){
                UserRole.create userDistrict, role_user_district
                println "saved"
            }
            else {
                println "errors are"
                userDistrict.errors.allErrors.each {
                    println "Error --->> ${it}"
                }
            }
        }
        if(!(User.findByUsername('user_operator')))  {
            User userDataentry
            userDataentry = new User(username: 'user_operator',password: 'damyant@123', email: 'admin@damyant.com', enabled: true, accountExpired: false, accountLocked: false, passwordExpired: false)
            if(userDataentry.save()){
                UserRole.create userDataentry, role_user_dataentry
                println "saved"
            }
            else {
                println "errors are"
                userDataentry.errors.allErrors.each {
                    println "Error --->> ${it}"
                }
            }
        }
    }



    def destroy = {
    }
}













