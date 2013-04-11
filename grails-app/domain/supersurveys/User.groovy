package supersurveys

import com.grailsrocks.authentication.AuthenticationService;

class User {
	String nom
	String prenom
	String email
	String password
	
	// Les deux champs suivants sont utilisés par le plugin authentication
	String login
	int status = AuthenticationService.STATUS_NEW
	
	static hasMany = [questions:Question]

    static constraints = {
    	nom nullable: false, blank: false
		prenom nullable: false, blank: true
		email nullable: false, blank: false, email: true, unique: true
		password nullable: false, minSize: 3
	}
	
	/*
	def onLoggedIn = { User login ->
		println "CA MAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAARRCCHHEEE !!!"
	}
	*/
	
	public String toString(){
		return nom + " " + prenom
	}
}
