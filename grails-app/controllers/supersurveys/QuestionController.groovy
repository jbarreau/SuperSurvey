package supersurveys



//import javax.security.auth.Subject
import javax.swing.text.View;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.grails.ShiroAnnotationHandlerService;
import org.apache.shiro.grails.ShiroBasicPermission;
import org.apache.shiro.grails.ShiroSecurityService;
import org.apache.shiro.grails.ShiroTagLib;
import org.springframework.dao.DataIntegrityViolationException

class QuestionController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    /*def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [questionInstanceList: Question.list(params), questionInstanceTotal: Question.count()]
    }*/

    def list(long idProf) {
		Question.list(params)
        def questionInstanceListRet = []
		def user = User.findByUsername(SecurityUtils.getSubject().getPrincipal())
		user.questions.each({
			questionInstanceListRet.add(it)
		})
        [questionInstanceList: questionInstanceListRet, questionInstanceTotal: questionInstanceListRet.size()]
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
		//adding question to user.question
		def u = User.findByUsername(SecurityUtils.getSubject().getPrincipal())
		//println  u
		u.questions.addToQuestions(questionInstance)
		u.save()

        flash.message = message(code: 'default.created.message', args: [message(code: 'question.label', default: 'Question'), questionInstance.id])
        redirect(action: "edit", id: questionInstance.id)
    }
	
    
	def show(Long id) {
        def questionInstance = Question.get(id)
        if (!questionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'question.label', default: 'Question'), id])
            redirect(action: "list")
            return
        }
		
		def isProfLogged = SecurityUtils.subject.isAuthenticated() //true // for developing
		//questionInstance.setEtat(Etat.inVote) // Juste pour le test
		switch (questionInstance.etat){
			case Etat.inCompletion:
				if(isProfLogged){
					render(view: "manage", model:[questionInstance: questionInstance])
				}else{
					render(view: "proposer", model:[questionInstance: questionInstance])
				}
				break
			case Etat.inVote:
				if(isProfLogged){
					render(view: "manage", model:[questionInstance: questionInstance])
				}else{
					//render(view: "voter", model:[questionInstance: questionInstance])
					flash.message = flash.message // chelou mais necessaire ^^ // sa metonnerai
					redirect(action:"voter", id:questionInstance.id)
				}
				break
			case Etat.close:
				if(isProfLogged){
					render(view: "manage", model:[questionInstance: questionInstance])
				}else{
					redirect(action:"showStat", id:questionInstance.id)
				}
				break
			default: break
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
		def questionInstance = Question.get(id)
		questionInstance.etat = Etat.inVote
		questionInstance.save()
		redirect(action:"show",id:questionInstance.id)
		//render(view: "voter",model:[questionInstance: questionInstance])
	}
	
	def cloture(Long id){
		def questionInstance = Question.get(id)
		questionInstance.etat = Etat.close
		redirect(action: "showStat", id: questionInstance.id)
	}
	
	/**
	 * Traitement de la réponse à un vote
	 * @param id
	 * @return
	 */
	def voter(Long id){
		def questionInstance = Question.get(id)
		
		if (!questionInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'question.label', default: 'Question'), id])
			redirect(action: "show", id:questionInstance.id)
			return
		}
		
		
		// Si on a envoyé le formulaire, alors on le traite
		if(params.reponseId != null || params.reponseradio != null){
			
			// A desactivé pr les tests
			/*if(session["dejavote"+questionInstance.id]){
				flash.message = "Vous avez déjà voté, merci de ne pas tricher :D"
				redirect(action: "show", id:questionInstance.id)
				return
			}*/
			
			def criteria = Reponse.createCriteria()
			def reponsesInstances
			
			// On unifie les résultats selon si on est radio ou checkbox
			def reponsesVotees = []
			if(params.reponseId != null)
				params.reponseId.each({ reponsesVotees.push(Long.decode(new String(it)))})
			else
				reponsesVotees.push(Long.decode(params.reponseradio))
			
				
			// On récupere les instances des réponses votées
			reponsesInstances = criteria.list {
				'in'("id",reponsesVotees)
				question{ // On verrifie qu'on est sur la bonne question
					idEq((long)questionInstance.id)
				}
			}
			
			// on met à jour les stats
			reponsesInstances.each {
				Reponse r = it
				r.setNbVotes(r.nbVotes+1)
				if(!r.save()){
					flash.message =  "Erreur à l'enregistrement du vote"
					render(view: "voter", model:[questionInstance: questionInstance, defaultValues:reponsesVotees])
					return
				}
			}
			questionInstance.setNbVotes(questionInstance.nbVotes+1)
			if(!questionInstance.save()){
				flash.message =  "Erreur à l'enregistrement du vote"
				render(view: "voter", model:[questionInstance: questionInstance, defaultValues:reponsesVotees.toList()])
				return
			}
			
			// On sauvegarde le fait que le membre a voté
			session["dejavote"+questionInstance.id] = true
			
			flash.message = "Votre vote a bien été pris en compte. Merci pour votre participation. :)"
			redirect(action:"show", id:questionInstance.id)
			return
		}
		println flash.message
		//redirect(action:"show", id:questionInstance.id)
		render(view: "voter", model:[questionInstance: questionInstance])
	}
	
	def showStat(Long id){
        def questionInstance = Question.get(id)
		if (Question.get(id).etat==Etat.close)
			render(view: "showStat", model: [questionInstance: questionInstance])
	}
}
