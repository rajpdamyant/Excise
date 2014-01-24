package challan
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils

import com.challan.User
import com.challan.UserRole
import com.challan.Role

class HeadQuarterWorkerController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [headQuarterWorkerInstanceList: HeadQuarterWorker.list(params), headQuarterWorkerInstanceTotal: HeadQuarterWorker.count()]
    }

    def create = {
        def headQuarterWorkerInstance = new HeadQuarterWorker()
        headQuarterWorkerInstance.properties = params
        return [headQuarterWorkerInstance: headQuarterWorkerInstance]
    }

    def save = {






        def headQuarterWorkerInstance = new HeadQuarterWorker(params)
        if (headQuarterWorkerInstance.save(flush: true)) {

            Role role = Role.findByAuthority('ROLE_HEADQUARTER')
            User user = User.get(headQuarterWorkerInstance.id)
            UserRole userRole = new UserRole(role: role,user: user)
            if(userRole.save(flush: true))
                println " UserRole Saved"

            flash.message = "${message(code: 'default.created.message', args: [message(code: 'headQuarterWorker.label', default: 'HeadQuarterWorker'), headQuarterWorkerInstance.id])}"
            redirect(action: "show", id: headQuarterWorkerInstance.id)
        }
        else {
            render(view: "create", model: [headQuarterWorkerInstance: headQuarterWorkerInstance])
        }
    }

    def show = {
        def headQuarterWorkerInstance = HeadQuarterWorker.get(params.id)
        if (!headQuarterWorkerInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'headQuarterWorker.label', default: 'HeadQuarterWorker'), params.id])}"
            redirect(action: "list")
        }
        else {
            [headQuarterWorkerInstance: headQuarterWorkerInstance]
        }
    }

    def edit = {
        def headQuarterWorkerInstance = HeadQuarterWorker.get(params.id)
        if (!headQuarterWorkerInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'headQuarterWorker.label', default: 'HeadQuarterWorker'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [headQuarterWorkerInstance: headQuarterWorkerInstance]
        }
    }

    def update = {
        def headQuarterWorkerInstance = HeadQuarterWorker.get(params.id)
        if (headQuarterWorkerInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (headQuarterWorkerInstance.version > version) {

                    headQuarterWorkerInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'headQuarterWorker.label', default: 'HeadQuarterWorker')] as Object[], "Another user has updated this HeadQuarterWorker while you were editing")
                    render(view: "edit", model: [headQuarterWorkerInstance: headQuarterWorkerInstance])
                    return
                }
            }
            headQuarterWorkerInstance.properties = params
            if (!headQuarterWorkerInstance.hasErrors() && headQuarterWorkerInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'headQuarterWorker.label', default: 'HeadQuarterWorker'), headQuarterWorkerInstance.id])}"
                redirect(action: "show", id: headQuarterWorkerInstance.id)
            }
            else {
                render(view: "edit", model: [headQuarterWorkerInstance: headQuarterWorkerInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'headQuarterWorker.label', default: 'HeadQuarterWorker'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def headQuarterWorkerInstance = HeadQuarterWorker.get(params.id)
        if (headQuarterWorkerInstance) {
            try {
                headQuarterWorkerInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'headQuarterWorker.label', default: 'HeadQuarterWorker'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'headQuarterWorker.label', default: 'HeadQuarterWorker'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'headQuarterWorker.label', default: 'HeadQuarterWorker'), params.id])}"
            redirect(action: "list")
        }
    }
}
