package supersurveys

enum TypeQuestion{
	ChoixMultiple,ChoixSimple	
}

public enum Etat{
	inCompletion,inVote,close//ChoixMultiple,ChoixSimple//cr��, en cour, ferm�	
}

class Question {
	String text
	Date dateCreation
	int temps // Un temps en secondes
	int nbVotes
	TypeQuestion type
	Etat etat
	
	static hasMany = [reponses:Reponse]
	
	//// On annule cette appartenance car si on supprime un membre on ne veut
	//// Pas forcément supprimer les questions associées 
	//// static belongsTo = [proprietaire:User] // à supprimer une fois lu
	
    static constraints = {
		text nullable: false, blank: false
		dateCreation nullable: false
		temps nullable: true, min: 5
		nbVotes nullable: false
		type nullable: false
    }
	
	public String toString(){
		return text
	}
}
