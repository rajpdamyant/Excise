package challan

class CreateAccountController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [createAccountInstanceList: CreateAccount.list(params), createAccountInstanceTotal: CreateAccount.count()]
    }

    def create = {
        def createAccountInstance = new CreateAccount()
        createAccountInstance.properties = params
        return [createAccountInstance: createAccountInstance]
    }

    def save = {
        def createAccountInstance = new CreateAccount(params)
        if (createAccountInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'createAccount.label', default: 'CreateAccount'), createAccountInstance.id])}"
            redirect(action: "show", id: createAccountInstance.id)
        }
        else {
            render(view: "create", model: [createAccountInstance: createAccountInstance])
        }
    }

    def show = {
        def createAccountInstance = CreateAccount.get(params.id)
        if (!createAccountInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'createAccount.label', default: 'CreateAccount'), params.id])}"
            redirect(action: "list")
        }
        else {
            [createAccountInstance: createAccountInstance]
        }
    }

    def edit = {
        def createAccountInstance = CreateAccount.get(params.id)
        if (!createAccountInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'createAccount.label', default: 'CreateAccount'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [createAccountInstance: createAccountInstance]
        }
    }

    def update = {
        def createAccountInstance = CreateAccount.get(params.id)
        if (createAccountInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (createAccountInstance.version > version) {

                    createAccountInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'createAccount.label', default: 'CreateAccount')] as Object[], "Another user has updated this CreateAccount while you were editing")
                    render(view: "edit", model: [createAccountInstance: createAccountInstance])
                    return
                }
            }
            createAccountInstance.properties = params
            if (!createAccountInstance.hasErrors() && createAccountInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'createAccount.label', default: 'CreateAccount'), createAccountInstance.id])}"
                redirect(action: "show", id: createAccountInstance.id)
            }
            else {
                render(view: "edit", model: [createAccountInstance: createAccountInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'createAccount.label', default: 'CreateAccount'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def createAccountInstance = CreateAccount.get(params.id)
        if (createAccountInstance) {
            try {
                createAccountInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'createAccount.label', default: 'CreateAccount'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'createAccount.label', default: 'CreateAccount'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'createAccount.label', default: 'CreateAccount'), params.id])}"
            redirect(action: "list")
        }
    }
}
