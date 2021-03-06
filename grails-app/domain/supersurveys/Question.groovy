package supersurveys

enum TypeQuestion{
	ChoixMultiple,ChoixSimple	
}

public enum Etat{
	inCompletion,inVote,close//ChoixMultiple,ChoixSimple//créé, en cour, fermé	
}

class Question {
	String text
	Date dateCreation = new Date()
	int temps // Un temps en secondes // Non géré finalement
	int nbVotes=0
	TypeQuestion type
	Etat etat
	
	static hasMany = [reponses:Reponse]
	
	//// On annule cette appartenance car si on supprime un membre on ne veut
	//// Pas forcément supprimer les questions associées 
	//// static belongsTo = [proprietaire:User] // à supprimer une fois lu
	
    static constraints = {
		text nullable: false, blank: false
		dateCreation nullable: false
		//temps nullable: true, min: 5
		type nullable: false
    }
	
	static mapping = {
		reponses sort:'id'
	}
	
	public String toString(){
		return text
	}
}
