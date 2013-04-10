package supersurveys

class Reponse {

	String text
	boolean visible
	boolean correcte
	int nbVotes
	
	static belongsTo = [question : Question]
	static hasMany = [commentaires : Commentaire]
	
    static constraints = {
		text nullable: false, blank: false
		visible nullable: false
		correcte nullable: false
    }
}
