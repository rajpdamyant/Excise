class UrlMappings {

    static mappings = {
        "/$controller/$action?/$id?" {
            constraints {
                // apply constraints here
            }
        }

        "/"(action: "auth", controller: "login")
//        "500"(view: '/error')
        "500"(controller: "errors", action: "serverError")

    }
}
