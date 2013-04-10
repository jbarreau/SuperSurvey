package supersurveys

enum TypeQuestion{
	ChoixMultiple,ChoixSimple	
}

enum Etat{
	inCompletion,inVote,Close//ChoixMultiple,ChoixSimple//créé, en cour, fermé	
}

class Question {
	String text
	Date dateCreation
	int temps // Un temps en secondes
	int nbVotesEffectue
	TypeQuestion type
	Etat etat
	
	static hasMany = [reponses:Reponse]
	
	//// On annule cette appartenance car si on supprime un membre on ne veut
	//// Pas forcÃ©ment supprimer les questions associÃ©es 
	//// static belongsTo = [proprietaire:User] // Ã  supprimer une fois lu
	
    static constraints = {
		text nullable: false, blank: false
		dateCreation nullable: false
		temps nullable: true, min: 5
		nbVotes nullable: false
		type nullable: false
    }
}
