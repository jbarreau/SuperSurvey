package supersurveys

import org.springframework.dao.DataIntegrityViolationException

class CommentaireController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [commentaireInstanceList: Commentaire.list(params), commentaireInstanceTotal: Commentaire.count()]
    }

    def create() {
        [commentaireInstance: new Commentaire(params)]
    }

    def save() {
        def commentaireInstance = new Commentaire(params)
        if (!commentaireInstance.save(flush: true)) {
            render(view: "create", model: [commentaireInstance: commentaireInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'commentaire.label', default: 'Commentaire'), commentaireInstance.id])
        redirect(action: "show", id: commentaireInstance.id)
    }

    def show(Long id) {
        def commentaireInstance = Commentaire.get(id)
        if (!commentaireInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'commentaire.label', default: 'Commentaire'), id])
            redirect(action: "list")
            return
        }

        [commentaireInstance: commentaireInstance]
    }

    def edit(Long id) {
        def commentaireInstance = Commentaire.get(id)
        if (!commentaireInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'commentaire.label', default: 'Commentaire'), id])
            redirect(action: "list")
            return
        }

        [commentaireInstance: commentaireInstance]
    }

    def update(Long id, Long version) {
        def commentaireInstance = Commentaire.get(id)
        if (!commentaireInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'commentaire.label', default: 'Commentaire'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (commentaireInstance.version > version) {
                commentaireInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'commentaire.label', default: 'Commentaire')] as Object[],
                          "Another user has updated this Commentaire while you were editing")
                render(view: "edit", model: [commentaireInstance: commentaireInstance])
                return
            }
        }

        commentaireInstance.properties = params

        if (!commentaireInstance.save(flush: true)) {
            render(view: "edit", model: [commentaireInstance: commentaireInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'commentaire.label', default: 'Commentaire'), commentaireInstance.id])
        redirect(action: "show", id: commentaireInstance.id)
    }

    def delete(Long id) {
        def commentaireInstance = Commentaire.get(id)
        if (!commentaireInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'commentaire.label', default: 'Commentaire'), id])
            redirect(action: "list")
            return
        }

        try {
            commentaireInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'commentaire.label', default: 'Commentaire'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'commentaire.label', default: 'Commentaire'), id])
            redirect(action: "show", id: id)
        }
    }
}
