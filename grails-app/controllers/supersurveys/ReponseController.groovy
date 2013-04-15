package supersurveys

import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException

class ReponseController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    /*def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [reponseInstanceList: Reponse.list(params), reponseInstanceTotal: Reponse.count()]
    }*/
	
	def save() {
		def reponseInstance = new Reponse(params)
		if (!reponseInstance.save(flush: true)) {
			render(view: "create", model: [reponseInstance: reponseInstance])
			return
		}

		flash.message = message(code: 'default.created.message', args: [message(code: 'reponse.label', default: 'Reponse'), reponseInstance.id])
		redirect(action: "edit", id: reponseInstance.id)
	}
	
    def saveAJAX() {
		params.question = Question.get(params.idQuest)
        def reponseInstance = new Reponse(params)
        if (!reponseInstance.save(flush: true)) {
            render(view: "create", model: [reponseInstance: reponseInstance])
            return
        }
		
		render reponseInstance as JSON
    }
	
    def show(Long id) {
        def reponseInstance = Reponse.get(id)
        if (!reponseInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'reponse.label', default: 'Reponse'), id])
            redirect(action: "list")
            return
        }

        [reponseInstance: reponseInstance]
    }

    def edit(Long id) {
        def reponseInstance = Reponse.get(id)
        if (!reponseInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'reponse.label', default: 'Reponse'), id])
            redirect(action: "list")
            return
        }

        [reponseInstance: reponseInstance]
    }

    def update(Long id, Long version) {
        def reponseInstance = Reponse.get(id)
        if (!reponseInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'reponse.label', default: 'Reponse'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (reponseInstance.version > version) {
                reponseInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'reponse.label', default: 'Reponse')] as Object[],
                          "Another user has updated this Reponse while you were editing")
                render(view: "edit", model: [reponseInstance: reponseInstance])
                return
            }
        }

        reponseInstance.properties = params

        if (!reponseInstance.save(flush: true)) {
            render(view: "edit", model: [reponseInstance: reponseInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'reponse.label', default: 'Reponse'), reponseInstance.id])
        redirect(action: "show", id: reponseInstance.id)
    }

    def delete(Long id) {
        def reponseInstance = Reponse.get(id)
        if (!reponseInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'reponse.label', default: 'Reponse'), id])
            redirect(action: "list")
            return
        }

        try {
            reponseInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'reponse.label', default: 'Reponse'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'reponse.label', default: 'Reponse'), id])
            redirect(action: "show", id: id)
        }
    }
	
	def listByQuestion(long idQuest) {
		//params.max = Math.min(max ?: 10, 100)
		//[reponseInstanceList: Reponse.list(params), reponseInstanceTotal: Reponse.count()]
	}
    
	def create() {
        [reponseInstance: new Reponse(params)]
    }
	
	
	def proposerSave(){
		def  id = params.idquestion
		def questionInstance = Question.get(id)
		if (!questionInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'question.label', default: 'Question'), id])
			redirect(controller:"question",action: "index")
			return
		}
		
		if(questionInstance.etat != Etat.inCompletion){
			redirect(controller:"question", action: "show", id:questionInstance.id)
			return
		}
		
		if(params != null){
			// On récupère les paramètres en entrée
			def reponseInstance = new Reponse(
				text: params.reponse,
				question: questionInstance,
				visible: true,
				correcte: true
			)
			reponseInstance.save()
			redirect(controller:"question", action:"show", id:id)
			return
		}
			
		flash.message = "Votre proposition a bien été prise en compte, merci pour votre participation"
		redirect(controller:"question", action:"show", id:questionInstance.id)	
	}
}
