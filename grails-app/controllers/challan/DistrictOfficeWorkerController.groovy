package challan

import com.challan.UserRole
import com.challan.Role
import com.challan.User
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils

class DistrictOfficeWorkerController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def springSecurityService
    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [districtOfficeWorkerInstanceList: DistrictOfficeWorker.list(params), districtOfficeWorkerInstanceTotal: DistrictOfficeWorker.count()]
    }

    def create = {
        def districtOfficeWorkerInstance = new DistrictOfficeWorker()
        districtOfficeWorkerInstance.properties = params
        return [districtOfficeWorkerInstance: districtOfficeWorkerInstance]
    }

    def save = {
        def districtOfficeWorkerInstance = new DistrictOfficeWorker(params)
        if (districtOfficeWorkerInstance.save(flush: true)) {


            Role role = Role.findByAuthority('ROLE_DISTRICT')
            User user = User.get(districtOfficeWorkerInstance.id)
            UserRole userRole = new UserRole(role: role, user: user)
            if (userRole.save(flush: true))
                println "UserRole Saved`"
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'districtOfficeWorker.label', default: 'DistrictOfficeWorker'), districtOfficeWorkerInstance.id])}"
            redirect(action: "show", id: districtOfficeWorkerInstance.id)
        }
        else {
            render(view: "create", model: [districtOfficeWorkerInstance: districtOfficeWorkerInstance])
        }
    }

    def show = {
        def districtOfficeWorkerInstance = DistrictOfficeWorker.get(params.id)
        if (!districtOfficeWorkerInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'districtOfficeWorker.label', default: 'DistrictOfficeWorker'), params.id])}"
            redirect(action: "list")
        }
        else {
            [districtOfficeWorkerInstance: districtOfficeWorkerInstance]
        }
    }


    def edit = {
        def districtOfficeWorkerInstance = DistrictOfficeWorker.get(params.id)

        List<DistrictOffice> districtOfficeList = []
        if (SpringSecurityUtils.ifAllGranted('ROLE_HEADQUARTER,ROLE_ADMIN')) {
            HeadQuarter headQuarter = springSecurityService.currentUser.headQuarter
            districtOfficeList = DistrictOffice.findAllByHeadQuarter(headQuarter)
        }

        User user = User.findByUsername(districtOfficeWorkerInstance.username)
        Role role = Role.findByAuthority('ROLE_ADMIN')
        UserRole userRole = UserRole.findByUserAndRole(user, role)
        Boolean admin = false
        if (userRole)
            admin = true

        if (!districtOfficeWorkerInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'circleLevelWorker.label', default: 'DistrictOfficeWorker'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [districtOfficeWorkerInstance: districtOfficeWorkerInstance, districtOfficeList: districtOfficeList, admin: admin]
        }
    }

    def update = {
        def districtOfficeWorkerInstance = DistrictOfficeWorker.get(params.id)

        List<DistrictOffice> districtOfficeList = []
        if (SpringSecurityUtils.ifAllGranted('ROLE_HEADQUARTER,ROLE_ADMIN')) {
            HeadQuarter headQuarter = springSecurityService.currentUser.headQuarter
            districtOfficeList = DistrictOffice.findAllByHeadQuarter(headQuarter)
        }

        User user = User.findByUsername(districtOfficeWorkerInstance.username)
        Role role = Role.findByAuthority('ROLE_ADMIN')
        UserRole userRole = UserRole.findByUserAndRole(user, role)
        Boolean admin = false
        if (userRole)
            admin = true

        if (districtOfficeWorkerInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (districtOfficeWorkerInstance.version > version) {

                    districtOfficeWorkerInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'circleLevelWorker.label', default: 'CircleLevelWorker')] as Object[], "Another user has updated this CircleLevelWorker while you were editing")
                    render(view: "edit", model: [districtOfficeWorkerInstance: districtOfficeWorkerInstance, districtOfficeList: districtOfficeList, admin: admin])
                    return
                }
            }
            districtOfficeWorkerInstance.properties = params
            if (!districtOfficeWorkerInstance.hasErrors() && districtOfficeWorkerInstance.save(flush: true)) {
                if (params.admin && !userRole) {
                    UserRole.create(user, role)
                }
                else if (!params.admin && userRole) {
                    UserRole.remove(user, role)
                }


                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'circleLevelWorker.label', default: 'CircleLevelWorker'), districtOfficeWorkerInstance.id])}"
                redirect(action: "show", id: districtOfficeWorkerInstance.id)
            }
            else {
                render(view: "edit", model: [districtOfficeWorkerInstance: districtOfficeWorkerInstance, districtOfficeList: districtOfficeList, admin: admin])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'circleLevelWorker.label', default: 'CircleLevelWorker'), params.id])}"
            redirect(action: "list")
        }
    }

//    def edit = {
    //        def districtOfficeWorkerInstance = DistrictOfficeWorker.get(params.id)
    //        if (!districtOfficeWorkerInstance) {
    //            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'districtOfficeWorker.label', default: 'DistrictOfficeWorker'), params.id])}"
    //            redirect(action: "list")
    //        }
    //        else {
    //            return [districtOfficeWorkerInstance: districtOfficeWorkerInstance]
    //        }
    //    }
    //
    //    def update = {
    //        def districtOfficeWorkerInstance = DistrictOfficeWorker.get(params.id)
    //        if (districtOfficeWorkerInstance) {
    //            if (params.version) {
    //                def version = params.version.toLong()
    //                if (districtOfficeWorkerInstance.version > version) {
    //
    //                    districtOfficeWorkerInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'districtOfficeWorker.label', default: 'DistrictOfficeWorker')] as Object[], "Another user has updated this DistrictOfficeWorker while you were editing")
    //                    render(view: "edit", model: [districtOfficeWorkerInstance: districtOfficeWorkerInstance])
    //                    return
    //                }
    //            }
    //            districtOfficeWorkerInstance.properties = params
    //            if (!districtOfficeWorkerInstance.hasErrors() && districtOfficeWorkerInstance.save(flush: true)) {
    //                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'districtOfficeWorker.label', default: 'DistrictOfficeWorker'), districtOfficeWorkerInstance.id])}"
    //                redirect(action: "show", id: districtOfficeWorkerInstance.id)
    //            }
    //            else {
    //                render(view: "edit", model: [districtOfficeWorkerInstance: districtOfficeWorkerInstance])
    //            }
    //        }
    //        else {
    //            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'districtOfficeWorker.label', default: 'DistrictOfficeWorker'), params.id])}"
    //            redirect(action: "list")
    //        }
    //    }

    def delete = {
        def districtOfficeWorkerInstance = DistrictOfficeWorker.get(params.id)
        if (districtOfficeWorkerInstance) {
            try {
                districtOfficeWorkerInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'districtOfficeWorker.label', default: 'DistrictOfficeWorker'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'districtOfficeWorker.label', default: 'DistrictOfficeWorker'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'districtOfficeWorker.label', default: 'DistrictOfficeWorker'), params.id])}"
            redirect(action: "list")
        }
    }
}
