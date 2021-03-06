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

    def list(long id) {
		if(!SecurityUtils.getSubject().hasRole('ROLE_PROF') && id <= 0){
			// Si pas d'id on retourne pas loggé, retour a l'accueil
			redirect(uri:"/")
			return
		}
		def user; // point virgule nécessaire
		if(id > 0) // Si on a renseigné un id, on affiche les question du prof correspondant
			user = User.findById(id)
		else // Sinon on affiche les question du prof connecté
			user = User.findByUsername(SecurityUtils.getSubject().getPrincipal())
		
		if(user == null){
			redirect(uri:'/')
			return
		}
			
		//Question.list(params)
        def questionInstanceListRet = []
		user.questions.each({
			questionInstanceListRet.add(it)
		})
		
        [questionInstanceList: questionInstanceListRet, questionInstanceTotal: questionInstanceListRet.size(), userInstance: user]
    }

    def create() {
        [questionInstance: new Question(params)]
    }

    def save() {
        def questionInstance = new Question(params)
		questionInstance.setEtat(Etat.inCompletion)
        if (!questionInstance.save(flush: true)) {
			flash.message = "Erreur à la création de la question"
            render(view: "create", model: [questionInstance: questionInstance])
            return
        }
		//adding question to user.question
		def u = User.findByUsername(SecurityUtils.getSubject().getPrincipal())
		//println  u
		u.addToQuestions(questionInstance)
		u.save()

        flash.message = message(code: 'default.created.message', args: [message(code: 'question.label', default: 'Question'), questionInstance.id])
        redirect(action: "show", id: questionInstance.id)
    }
	
    
	/**
	 * Action aiguillage qui redirige vers la bonne action
	 * en fonction de l'état de la question et et le role de l'utilisateur
	 * 
	 * @param id de la question
	 * @return
	 */
	def show(Long id) {
        def questionInstance = Question.get(id)
		
        if (!questionInstance) {
            flash.message = "Aucune question associée à cet id"
			redirect(action: "list")
            return
        }
		println Etat.inCompletion
		def isProfLogged = SecurityUtils.subject.isAuthenticated() //true // for developing
		//questionInstance.setEtat(Etat.inVote) // Juste pour le test
		if(questionInstance.etat == Etat.inCompletion){
				if(isProfLogged){
					//render(view: "manage", model:[questionInstance: questionInstance])
					redirect(action:"manage", id:questionInstance.id)
				}else{
					//render(view: "proposer", model:[questionInstance: questionInstance])
					redirect(action:"proposer", id:questionInstance.id)
				}
		}
		else if(questionInstance.etat == Etat.inVote){
				if(isProfLogged){
					//render(view: "manage", model:[questionInstance: questionInstance])
					redirect(action:"manage", id:questionInstance.id)
				}else{
					//render(view: "voter", model:[questionInstance: questionInstance])
					flash.message = flash.message // chelou mais necessaire ^^ pour persister le flash.message // sa metonnerai
					redirect(action:"voter", id:questionInstance.id)
				}
		}
		else if(questionInstance.etat == Etat.close){
				if(isProfLogged){
					redirect(action: "manage", id:questionInstance.id)
				}else{
					redirect(action:"showStat", id:questionInstance.id)
				}
		}
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
	
	def manage(Long id){
        def questionInstance = Question.get(id)
        if (!questionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'question.label', default: 'Question'), id])
            redirect(action: "list")
            return
        }
		
		render(view:"manage", model:[questionInstance:questionInstance])
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
		
		if(questionInstance.etat != Etat.inCompletion){
			redirect(action: "show", id:questionInstance.id)
			return
		}
			
		render(view:"proposer", model:[questionInstance:questionInstance])
		
	}
	
	def startVote(Long id){
		def questionInstance = Question.get(id)
		
		if (!questionInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'question.label', default: 'Question'), id])
			redirect(action: "index")
			return
		}
		
		if(questionInstance.etat == Etat.inVote){
			flash.message = "La question est déjà en cours de vote"
			redirect(action: "show", id:questionInstance.id)
			return
		}
		
		questionInstance.etat = Etat.inVote
		questionInstance.save()
		redirect(action:"show",id:questionInstance.id)
		//render(view: "voter",model:[questionInstance: questionInstance])
	}
	
	def cloture(Long id){
		def questionInstance = Question.get(id)
		
		if (!questionInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'question.label', default: 'Question'), id])
			redirect(action: "index")
			return
		}

		if(questionInstance.etat == Etat.close){
			flash.message = "Cette question est déjà fermée"
			redirect(action: "show", id:questionInstance.id)
			return
		}
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
		println params
		
		// Si on a envoyé le formulaire, alors on le traite
		if(params.formSend != null){
			
			
			//* Eviter qu'une personne puisse voter 2 fois de suite
			if(session["dejavote"+questionInstance.id]){
				flash.message = "Vous avez déjà voté, merci de ne pas tricher :D"
				redirect(action: "show", id:questionInstance.id)
				return
			}
			//*/
			

			def criteria = Reponse.createCriteria()
			def reponsesInstances
			def estVoteBlanc = false
			
			// On unifie les résultats selon si on est radio ou checkbox
			def reponsesVotees = []
			if(params.reponseId != null){
				if(!params.reponseId.toString()[0].equals("[")) params.reponseId = [params.reponseId]
				params.reponseId.each({ reponsesVotees.push(Long.decode(new String(it)))})
			}
			else if(params.reponseradio != null)
				reponsesVotees.push(Long.decode(params.reponseradio))
			else { 
				// Vote blanc, on laisse le tableau vide
				estVoteBlanc = true
				
			}
							
			if(!estVoteBlanc){
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
			redirect(action:"voter", id:questionInstance.id)
			return
		}
		
		//redirect(action:"show", id:questionInstance.id)
		render(view: "voter", model:[questionInstance: questionInstance])
	}
	
	def showStat(Long id){
        def questionInstance = Question.get(id)
		
		if (Question.get(id).etat == Etat.inCompletion){
			flash.message = "Cette question n'a pas encore été lancée"
			redirect(action:"show", id:id)
			return;	
		}
		
		render(view: "showStat", model: [questionInstance: questionInstance])
	}
}
