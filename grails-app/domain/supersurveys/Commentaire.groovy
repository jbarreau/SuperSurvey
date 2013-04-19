package supersurveys

class Commentaire {

	String text
	boolean visible = false
	
	static belongsTo = [reponse:Reponse]
	
    static constraints = {
    	text nullable: false, blank: false
	}
	
	public String toString(){
		return text
	}
	
}
