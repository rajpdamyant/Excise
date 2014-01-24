//package challan
//
//import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils
//
//import com.challan.User
//import com.challan.UserRole
//import com.challan.Role
//
//class SuperintendentOfficeWorkerController {
//
//    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
//    def springSecurityService
//    def index = {
//        redirect(action: "list", params: params)
//    }
//
//    def list = {
//        params.max = Math.min(params.max ? params.int('max') : 10, 100)
//
//        List<SuperintendentOffice> superintendentOfficeList = []
//        List<SuperintendentOfficeWorker> superintendentOfficeWorkerList = []
//        int superintendentOfficeWorkerInstanceTotal = 0
//        if (SpringSecurityUtils.ifAllGranted('ROLE_ADMIN')) {
//            if (SpringSecurityUtils.ifAnyGranted('ROLE_HEADQUARTER')) {
//                superintendentOfficeList = SuperintendentOffice.list()
//                superintendentOfficeWorkerList = SuperintendentOfficeWorker.findAllBySuperintendentOfficeInList(superintendentOfficeList, params)
//                superintendentOfficeWorkerInstanceTotal = SuperintendentOfficeWorker.findAllBySuperintendentOfficeInList(superintendentOfficeList).size()
//            }
//
//            else if (SpringSecurityUtils.ifAnyGranted('ROLE_DISTRICT')) {
//                DistrictOffice districtOffice = springSecurityService.currentUser.districtOffice
//                superintendentOfficeList = SuperintendentOffice.findAllByDistrictOffice(districtOffice)
//                superintendentOfficeWorkerList = SuperintendentOfficeWorker.findAllBySuperintendentOfficeInList(superintendentOfficeList, params)
//                superintendentOfficeWorkerInstanceTotal = SuperintendentOfficeWorker.findAllBySuperintendentOfficeInList(superintendentOfficeList).size()
//            }
//        }
//
//        [superintendentOfficeWorkerInstanceList: superintendentOfficeWorkerList, superintendentOfficeWorkerInstanceTotal: superintendentOfficeWorkerInstanceTotal]
//    }
//
//    def create = {
//
//        def superintendentOfficeWorkerInstance = new SuperintendentOfficeWorker()
//        superintendentOfficeWorkerInstance.properties = params
//
//        List<SuperintendentOffice> superintendentOfficeList = []
//        if (SpringSecurityUtils.ifAllGranted('ROLE_ADMIN')) {
//            if (SpringSecurityUtils.ifAnyGranted('ROLE_HEADQUARTER')) {
//                superintendentOfficeList = SuperintendentOffice.list()
//            }
//
//            else if (SpringSecurityUtils.ifAnyGranted('ROLE_DISTRICT')) {
//                DistrictOffice districtOffice = springSecurityService.currentUser.districtOffice
//                superintendentOfficeList = SuperintendentOffice.findAllByDistrictOffice(districtOffice)
//            }
//        }
//
//
//        return [superintendentOfficeWorkerInstance: superintendentOfficeWorkerInstance, superintendentOfficeList: superintendentOfficeList]
//    }
//
//
//
//
//    def save = {
//
//        def superintendentOfficeWorkerInstance = new SuperintendentOfficeWorker(params)
//        if (superintendentOfficeWorkerInstance.save(flush: true)) {
//            Role role = Role.findByAuthority('ROLE_SUPERINTENDENT')
//            User user = User.get(superintendentOfficeWorkerInstance.id)
//            UserRole userRole = new UserRole(role: role, user: user)
//            if (userRole.save(flush: true))
//                println "UserRole Saved`"
//            flash.message = "${message(code: 'default.created.message', args: [message(code: 'superintendentOfficeWorker.label', default: 'SuperintendentOfficeWorker'), superintendentOfficeWorkerInstance.id])}"
//            redirect(action: "show", id: superintendentOfficeWorkerInstance.id)
//        }
//        else {
//            render(view: "create", model: [superintendentOfficeWorkerInstance: superintendentOfficeWorkerInstance])
//        }
//
//
//    }
//
//
//
//    def show = {
//
//
//        def superintendentOfficeWorkerInstance = SuperintendentOfficeWorker.get(params.id)
//        List roleList = UserRole.findAllByUser(User.findByUsername(superintendentOfficeWorkerInstance.username)).role.authority
//
//
//        if (!superintendentOfficeWorkerInstance) {
//            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'superintendentOfficeWorker.label', default: 'SuperintendentOfficeWorker'), params.id])}"
//            redirect(action: "list")
//        }
//        else {
//            [superintendentOfficeWorkerInstance: superintendentOfficeWorkerInstance]
//        }
//    }
//
//    def edit = {
//
//
//        def superintendentOfficeWorkerInstance = SuperintendentOfficeWorker.get(params.id)
//
//        List<SuperintendentOffice> superintendentOfficeList = []
//        if (SpringSecurityUtils.ifAllGranted('ROLE_ADMIN')) {
//            if (SpringSecurityUtils.ifAnyGranted('ROLE_HEADQUARTER')) {
//                superintendentOfficeList = SuperintendentOffice.list()
//            }
//
//            else if (SpringSecurityUtils.ifAnyGranted('ROLE_DISTRICT')) {
//                DistrictOffice districtOffice = springSecurityService.currentUser.districtOffice
//                superintendentOfficeList = SuperintendentOffice.findAllByDistrictOffice(districtOffice)
//            }
//        }
//
//
//        if (!superintendentOfficeWorkerInstance) {
//            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'superintendentOfficeWorker.label', default: 'SuperintendentOfficeWorker'), params.id])}"
//            redirect(action: "list")
//        }
//        else {
//            return [superintendentOfficeWorkerInstance: superintendentOfficeWorkerInstance]
//        }
//    }
//
//
//
//    def update = {
//
//
//        def superintendentOfficeWorkerInstance = SuperintendentOfficeWorker.get(params.id)
//
//        List<SuperintendentOffice> superintendentOfficeList = []
//        if (SpringSecurityUtils.ifAllGranted('ROLE_ADMIN')) {
//            if (SpringSecurityUtils.ifAnyGranted('ROLE_HEADQUARTER')) {
//                superintendentOfficeList = SuperintendentOffice.list()
//            }
//
//            else if (SpringSecurityUtils.ifAnyGranted('ROLE_DISTRICT')) {
//                DistrictOffice division = springSecurityService.currentUser.districtOffice
//                superintendentOfficeList = SuperintendentOffice.findAllByDistrictOffice(districtOffice)
//            }
//        }
//
//        if (superintendentOfficeWorkerInstance) {
//            if (params.version) {
//                def version = params.version.toLong()
//                if (superintendentOfficeWorkerInstance.version > version) {
//                    superintendentOfficeWorkerInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'superintendentOfficeWorker.label', default: 'SuperintendentOfficeWorker')] as Object[], "Another user has updated this SuperintendentOffice  while you were editing")
//                    render(view: "edit", model: [superintendentOfficeWorkerInstance: superintendentOfficeWorkerInstance, superintendentOfficeList: superintendentOfficeList])
//                    return
//                }
//            }
//            superintendentOfficeWorkerInstance.properties = params
//            if (!superintendentOfficeWorkerInstance.hasErrors() && superintendentOfficeWorkerInstance.save(flush: true)) {
//                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'superintendentOfficeWorker.label', default: 'SuperintendentofficeWorker'), superintendentOfficeWorkerInstance.id])}"
//                redirect(action: "show", id: superintendentOfficeWorkerInstance.id)
//            }
//            else {
//                render(view: "edit", model: [superintendentOfficeWorkerInstance: superintendentOfficeWorkerInstance, superintendentOfficeList: superintendentOfficeList])
//            }
//        }
//        else {
//            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'subDivisionLevelWorker.label', default: 'SubDivisionLevelWorker'), params.id])}"
//            redirect(action: "list")
//        }
//
//
//    }
//
//    def delete = {
//        def superintendentOfficeWorkerInstance = SuperintendentOfficeWorker.get(params.id)
//        if (superintendentOfficeWorkerInstance) {
//            try {
//                superintendentOfficeWorkerInstance.delete(flush: true)
//                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'superintendentOfficeWorker.label', default: 'SuperintendentOfficeWorker'), params.id])}"
//                redirect(action: "list")
//            }
//            catch (org.springframework.dao.DataIntegrityViolationException e) {
//                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'superintendentOfficeWorker.label', default: 'SuperintendentOfficeWorker'), params.id])}"
//                redirect(action: "show", id: params.id)
//            }
//        }
//        else {
//            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'superintendentOfficeWorker.label', default: 'SuperintendentOfficeWorker'), params.id])}"
//            redirect(action: "list")
//        }
//    }
//}
