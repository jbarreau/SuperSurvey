package supersurveys

import org.springframework.dao.DataIntegrityViolationException

class QuestionController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [questionInstanceList: Question.list(params), questionInstanceTotal: Question.count()]
    }

    def create() {
        [questionInstance: new Question(params)]
    }

    def save() {
        def questionInstance = new Question(params)
		questionInstance.setEtat(Etat.inCompletion)
        if (!questionInstance.save(flush: true)) {
            render(view: "create", model: [questionInstance: questionInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'question.label', default: 'Question'), questionInstance.id])
        redirect(action: "edit", id: questionInstance.id)
    }
	
	def isProfLogged = false
    
	def show(Long id) {
        def questionInstance = Question.get(id)
        if (!questionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'question.label', default: 'Question'), id])
            redirect(action: "list")
            return
        }
		Question q = Question.get(id);
        
		switch (questionInstance.etat){
			case Etat.inCompletion:
				if(isProfLogged){
					render(view: "manage", model:[questionInstance: questionInstance])
				}else{
					render(view: "proposer", model:[questionInstance: questionInstance])
				}
			
				
			break
			case Etat.inVote:
				
			break
			case Etat.close:
				
			break
			
		}

    }

    def edit(Long id) {
        def questionInstance = Question.get(id)
        if (!questionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'question.label', default: 'Question'), id])
            redirect(action: "list")
            return
        }

        [questionInstance: questionInstance]
    }

    def update(Long id, Long version) {
        def questionInstance = Question.get(id)
        if (!questionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'question.label', default: 'Question'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (questionInstance.version > version) {
                questionInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'question.label', default: 'Question')] as Object[],
                          "Another user has updated this Question while you were editing")
                render(view: "edit", model: [questionInstance: questionInstance])
                return
            }
        }

        questionInstance.properties = params

        if (!questionInstance.save(flush: true)) {
            render(view: "edit", model: [questionInstance: questionInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'question.label', default: 'Question'), questionInstance.id])
        redirect(action: "show", id: questionInstance.id)
    }

    def delete(Long id) {
        def questionInstance = Question.get(id)
        if (!questionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'question.label', default: 'Question'), id])
            redirect(action: "list")
            return
        }

        try {
            questionInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'question.label', default: 'Question'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'question.label', default: 'Question'), id])
            redirect(action: "show", id: id)
        }
    }
	
	/**
	 * Traitement du formulaire de la proposition d'une réponse par un élève
	 * Puis redirection vers la question en question
	 * @param id
	 * @return
	 */
	def proposer(Long id){
		def questionInstance = Question.get(id)
	
		if (!questionInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'question.label', default: 'Question'), id])
			redirect(action: "index")
			return
		}
		
		def reponseInstance = new Reponse(
			text: params.reponse,
			question: questionInstance,
			visible: true,
			correcte: true
		)
		reponseInstance.save()
		
		flash.message = "Votre proposition a bien été prise en compte, merci pour votre participation"
		redirect(action:"show", id: id)
		
	}
	
	def startVote(Long id){
		Question.get(id).etat = Etat.inVote
		render(view: "vote", model: [questionInstance: questionInstance])
	}
	
	def cloture(Long id){
		Question.get(id).etat = Etat.close//close
		redirect(action: "showStat", id: questionInstance.id)
	}
	
	def showStat(Long id){
		if (Question.get(id).etat==Etat.close)
			render(view: "showStat", model: [questionInstance: questionInstance])
	}
}
