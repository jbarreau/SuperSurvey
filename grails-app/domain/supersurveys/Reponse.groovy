package supersurveys

class Reponse {
	
	String text
	boolean visible = true
	boolean correcte = false
	int nbVotes = 0
	
	static belongsTo = [question : Question]
	static hasMany = [commentaires : Commentaire]
	
    static constraints = {
		text nullable: false, blank: false
		visible nullable: false
		correcte nullable: false
    }
	
	public String toString(){
		return this.text
	}
}
