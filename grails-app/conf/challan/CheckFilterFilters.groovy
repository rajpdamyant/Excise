package challan

import grails.plugins.springsecurity.SpringSecurityService


class CheckFilterFilters {

    def SpringSecurityService
    def filters = {
        all(controller: '*', action: '*') {
            before = {
                if (!springSecurityService.isLoggedIn()) {
                    if (controllerName in ['login']) {
                        return true
                    }
                    else {
                        println "Not Allowed, Redirecting To Login"
                        redirect(controller: 'login', action: 'auth')
                        return false
                    }
                }
                else {
                    if (session.isNew()) {
                        println "Session Expired"
                        redirect(controller: 'logout', action: 'index')
                        return false
                    }
                    else {
                        if ((controllerName in ['login', 'logout','errors','dataCollection', 'districtOffice', 'districtOfficeWorker','dataEntryWorker','form'])) {
                            return true
                        }
                        else {
                            println "Not Allowed, Redirecting To DataCollection Home"
                            redirect(controller: 'dataCollection', action: 'home')
                            return false
                        }
                    }
                }
            }
            after = {

            }
            afterView = {

            }
        }
    }

}
