package supersurveys

class User {
    String username
    String passwordHash
	String nom
	String prenom
	String email
	
    static hasMany = [ questions:Question, roles: Role, permissions: String ]

    static constraints = {
        username(nullable: false, blank: false, unique: true)
        passwordHash(nullable: false, blank: false	 )
    	nom nullable: false, blank: false
		prenom nullable: false, blank: true
		email nullable: false, blank: false, email: true, unique: true
    }
	
	public String toString(){
		return nom + " " + prenom
	}
}
