package supersurveys

class Reponse {

	String text
	boolean visible
	boolean correcte
	
	static belongsTo = [question:Question]
	static hasMany = [commentaires:Commentaire]
	
    static constraints = {
		
    }
}
