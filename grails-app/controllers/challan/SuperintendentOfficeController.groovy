//package challan
//
//import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils
//
//class SuperintendentOfficeController {
//
//    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
//    def springSecurityService
//    def index = {
//        redirect(action: "list", params: params)
//    }
//
//    def list = {
//        params.max = Math.min(params.max ? params.int('max') : 10, 100)
//        List<SuperintendentOffice> superintendentOfficeList = []
//        int superintendentOfficeInstanceTotal = 0
//        params.max = Math.min(params.max ? params.int('max') : 10, 100)
//
//        if (SpringSecurityUtils.ifAllGranted('ROLE_ADMIN')) {
//            if (SpringSecurityUtils.ifAnyGranted('ROLE_HEADQUARTER')) {
//                superintendentOfficeList = SuperintendentOffice.list(params)
//                superintendentOfficeInstanceTotal = SuperintendentOffice.count()
//            }
//
//            else if (SpringSecurityUtils.ifAnyGranted('ROLE_DISTRICT')) {
//                DistrictOffice districtOffice = springSecurityService.currentUser.districtOffice
//                superintendentOfficeList = SuperintendentOffice.findAllByDistrictOffice(districtOffice, params)
//                superintendentOfficeInstanceTotal = SuperintendentOffice.findAllByDistrictOffice(districtOffice).size()
//            }
//        }
//        [superintendentOfficeInstanceList: superintendentOfficeList, superintendentOfficeInstanceTotal: superintendentOfficeInstanceTotal]
//    }
//
//    def create = {
//        def superintendentOfficeInstance = new SuperintendentOffice()
//        superintendentOfficeInstance.properties = params
//
//        List<DistrictOffice> districtOfficeList = []
//        if (SpringSecurityUtils.ifAllGranted('ROLE_ADMIN')) {
//            if (SpringSecurityUtils.ifAnyGranted('ROLE_HEADQUARTER')) {
//                districtOfficeList = DistrictOffice.list()
//            }
//
//            else if (SpringSecurityUtils.ifAnyGranted('ROLE_DISTRICT')) {
//                DistrictOffice districtOffice = springSecurityService.currentUser.districtOffice
//                districtOfficeList = [districtOffice]
//            }
//        }
//
//        return [superintendentOfficeInstance: superintendentOfficeInstance, districtOfficeList: districtOfficeList]
//    }
//
//
//
//
//    def save = {
//        def superintendentOfficeInstance = new SuperintendentOffice(params)
//
//
//
//        List<DistrictOffice> districtOfficeList = []
//        if (SpringSecurityUtils.ifAllGranted('ROLE_ADMIN')) {
//            if (SpringSecurityUtils.ifAnyGranted('ROLE_HEADQUARTER')) {
//                districtOfficeList = DistrictOffice.list()
//            }
//
//            else if (SpringSecurityUtils.ifAnyGranted('ROLE_DISTRICT')) {
//                DistrictOffice districtOffice = springSecurityService.currentUser.districtOffice
//                districtOfficeList = [districtOffice]
//            }
//        }
//
//        List superintendentOfficeNameList = SuperintendentOffice.findAllByDistrictOffice(DistrictOffice.get(params.districtOffice.id)).name
//        if (superintendentOfficeNameList.contains(params.name)) {
//            println "name matched"
//            flash.message = 'Name of a Superintendent Office must be unique under a division'
//            render(view: "create", model: [superintendentOfficeInstance: superintendentOfficeInstance, districtofficeList: districtOfficeList])
//        }
//        else {
//            println "name validated"
//            if (superintendentOfficeInstance.save(flush: true)) {
//                flash.message = "${message(code: 'default.created.message', args: [message(code: 'superintendentOffice.label', default: 'Superintendentoffice'), superintendentOfficeInstance.id])}"
//                redirect(action: "show", id: superintendentOfficeInstance.id)
//            }
//            else {
//                render(view: "create", model: [superintendentOfficeInstance: superintendentOfficeInstance, districtOfficeList: districtOfficeList])
//            }
//        }
//
//
//    }
//
//
//
//
//
//
//    def show = {
//        def superintendentOfficeInstance = SuperintendentOffice.get(params.id)
//        if (!superintendentOfficeInstance) {
//            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'superintendentOffice.label', default: 'SuperintendentOffice'), params.id])}"
//            redirect(action: "list")
//        }
//        else {
//            [superintendentOfficeInstance: superintendentOfficeInstance]
//        }
//    }
//
//    def edit = {
//        def superintendentOfficeInstance = SuperintendentOffice.get(params.id)
//
//        List<DistrictOffice> districtOfficeList = []
//        if (SpringSecurityUtils.ifAllGranted('ROLE_ADMIN')) {
//            if (SpringSecurityUtils.ifAnyGranted('ROLE_HEADQUARTER')) {
//                districtOfficeList = DistrictOffice.list()
//            }
//
//            else if (SpringSecurityUtils.ifAnyGranted('ROLE_DISTRICT')) {
//                DistrictOffice districtOffice = springSecurityService.currentUser.districtOffice
//                districtOfficeList = [districtOffice]
//            }
//        }
//
//
//        if (!superintendentOfficeInstance) {
//            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'superintendentOffice.label', default: 'SuperintendentOffice'), params.id])}"
//            redirect(action: "list")
//        }
//        else {
//            return [superintendentOfficeInstance: superintendentOfficeInstance, districtOfficeList: districtOfficeList]
//        }
//    }
//
//    def update = {
//
//
//        def superintendentOfficeInstance = SuperintendentOffice.get(params.id)
//        List<DistrictOffice> districtOfficeList = []
//        if (SpringSecurityUtils.ifAllGranted('ROLE_ADMIN')) {
//            if (SpringSecurityUtils.ifAnyGranted('ROLE_HEADQUARTER')) {
//                districtOfficeList = DistrictOffice.list()
//            }
//
//            else if (SpringSecurityUtils.ifAnyGranted('ROLE_DISTRICT')) {
//                DistrictOffice districtOffice = springSecurityService.currentUser.districtOffice
//                districtOfficeList = [districtOffice]
//            }
//        }
//
//        if (superintendentOfficeInstance) {
//            if (params.version) {
//                def version = params.version.toLong()
//                if (superintendentOfficeInstance.version > version) {
//
//                    superintendentOfficeInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'superintendentoffice.label', default: 'Superintendentoffice')] as Object[], "Another user has updated this SuperintendentOffice while you were editing")
//                    render(view: "edit", model: [superintendentOfficeInstance: superintendentOfficeInstance, districtOfficeList: districtOfficeList])
//                    return
//                }
//            }
//            superintendentOfficeInstance.properties = params
//            if (!superintendentOfficeInstance.hasErrors() && superintendentOfficeInstance.save(flush: true)) {
//                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'superintendentOffice.label', default: 'Superintendent Office'), superintendentOfficeInstance.id])}"
//                redirect(action: "show", id: superintendentOfficeInstance.id)
//            }
//            else {
//                render(view: "edit", model: [superintendentOfficeInstance: superintendentOfficeInstance, districtOfficeList: districtOfficeList])
//            }
//        }
//        else {
//            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'superintendentOffice.label', default: 'SuperintendentOffice'), params.id])}"
//            redirect(action: "list")
//        }
//    }
//
//    def delete = {
//        def superintendentOfficeInstance = SuperintendentOffice.get(params.id)
//        if (superintendentOfficeInstance) {
//            try {
//                superintendentOfficeInstance.delete(flush: true)
//                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'superintendentOffice.label', default: 'SuperintendentOffice'), params.id])}"
//                redirect(action: "list")
//            }
//            catch (org.springframework.dao.DataIntegrityViolationException e) {
//                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'superintendentOffice.label', default: 'SuperintendentOffice'), params.id])}"
//                redirect(action: "show", id: params.id)
//            }
//        }
//        else {
//            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'superintendentOffice.label', default: 'SuperintendentOffice'), params.id])}"
//            redirect(action: "list")
//        }
//    }
//}
