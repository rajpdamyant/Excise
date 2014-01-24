package challan

class HeadQuarterController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {

        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [headQuarterInstanceList: HeadQuarter.list(params), headQuarterInstanceTotal: HeadQuarter.count()]
    }

    def create = {
        def headQuarterInstance = new HeadQuarter()
        headQuarterInstance.properties = params
        return [headQuarterInstance: headQuarterInstance]
    }

    def save = {
        def headQuarterInstance = new HeadQuarter(params)
        if (headQuarterInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'headQuarter.label', default: 'HeadQuarter'), headQuarterInstance.id])}"
            redirect(action: "show", id: headQuarterInstance.id)
        }
        else {
            render(view: "create", model: [headQuarterInstance: headQuarterInstance])
        }
    }

    def show = {
        def headQuarterInstance = HeadQuarter.get(params.id)
        if (!headQuarterInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'headQuarter.label', default: 'HeadQuarter'), params.id])}"
            redirect(action: "list")
        }
        else {
            [headQuarterInstance: headQuarterInstance]
        }
    }

    def edit = {
        def headQuarterInstance = HeadQuarter.get(params.id)
        if (!headQuarterInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'headQuarter.label', default: 'HeadQuarter'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [headQuarterInstance: headQuarterInstance]
        }
    }

    def update = {
        def headQuarterInstance = HeadQuarter.get(params.id)
        if (headQuarterInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (headQuarterInstance.version > version) {

                    headQuarterInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'headQuarter.label', default: 'HeadQuarter')] as Object[], "Another user has updated this HeadQuarter while you were editing")
                    render(view: "edit", model: [headQuarterInstance: headQuarterInstance])
                    return
                }
            }
            headQuarterInstance.properties = params
            if (!headQuarterInstance.hasErrors() && headQuarterInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'headQuarter.label', default: 'HeadQuarter'), headQuarterInstance.id])}"
                redirect(action: "show", id: headQuarterInstance.id)
            }
            else {
                render(view: "edit", model: [headQuarterInstance: headQuarterInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'headQuarter.label', default: 'HeadQuarter'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def headQuarterInstance = HeadQuarter.get(params.id)
        if (headQuarterInstance) {
            try {
                headQuarterInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'headQuarter.label', default: 'HeadQuarter'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'headQuarter.label', default: 'HeadQuarter'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'headQuarter.label', default: 'HeadQuarter'), params.id])}"
            redirect(action: "list")
        }
    }
}
