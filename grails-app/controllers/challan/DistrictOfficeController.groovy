package challan

import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils
import com.challan.User
import com.challan.UserRole
import com.challan.Role


class DistrictOfficeController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        List<DistrictOffice> districtOfficeList = []
        int districtOfficeInstanceTotal = 0;
        params.max = Math.min(params.max ? params.int('max') : 10, 100)

        if (SpringSecurityUtils.ifAllGranted('ROLE_ADMIN')) {
            if (SpringSecurityUtils.ifAnyGranted('ROLE_HEADQUARTER')) {
                districtOfficeList = DistrictOffice.list(params)
                districtOfficeInstanceTotal = DistrictOffice.count()
            }

        }

        [districtOfficeInstanceList: districtOfficeList, districtOfficeInstanceTotal: districtOfficeInstanceTotal]

        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [districtOfficeInstanceList: DistrictOffice.list(params), districtOfficeInstanceTotal: DistrictOffice.count()]
    }

    def create = {
        def districtOfficeInstance = new DistrictOffice()
        districtOfficeInstance.properties = params
        return [districtOfficeInstance: districtOfficeInstance]
    }

    def save = {
        def districtOfficeInstance = new DistrictOffice(params)
        if (districtOfficeInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'districtOffice.label', default: 'DistrictOffice'), districtOfficeInstance.id])}"
            redirect(action: "show", id: districtOfficeInstance.id)
        }
        else {
            render(view: "create", model: [districtOfficeInstance: districtOfficeInstance])
        }
    }

    def show = {
        def districtOfficeInstance = DistrictOffice.get(params.id)
        if (!districtOfficeInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'districtOffice.label', default: 'DistrictOffice'), params.id])}"
            redirect(action: "list")
        }
        else {
            [districtOfficeInstance: districtOfficeInstance]
        }
    }

    def edit = {
        def districtOfficeInstance = DistrictOffice.get(params.id)
        if (!districtOfficeInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'districtOffice.label', default: 'DistrictOffice'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [districtOfficeInstance: districtOfficeInstance]
        }
    }

    def update = {
        def districtOfficeInstance = DistrictOffice.get(params.id)
        if (districtOfficeInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (districtOfficeInstance.version > version) {

                    districtOfficeInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'districtOffice.label', default: 'DistrictOffice')] as Object[], "Another user has updated this DistrictOffice while you were editing")
                    render(view: "edit", model: [districtOfficeInstance: districtOfficeInstance])
                    return
                }
            }
            districtOfficeInstance.properties = params
            if (!districtOfficeInstance.hasErrors() && districtOfficeInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'districtOffice.label', default: 'DistrictOffice'), districtOfficeInstance.id])}"
                redirect(action: "show", id: districtOfficeInstance.id)
            }
            else {
                render(view: "edit", model: [districtOfficeInstance: districtOfficeInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'districtOffice.label', default: 'DistrictOffice'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def districtOfficeInstance = DistrictOffice.get(params.id)
        if (districtOfficeInstance) {
            try {
                districtOfficeInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'districtOffice.label', default: 'DistrictOffice'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'districtOffice.label', default: 'DistrictOffice'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'districtOffice.label', default: 'DistrictOffice'), params.id])}"
            redirect(action: "list")
        }
    }
}
