package supersurveys

enum TypeQuestion{
	ChoixMultiple,ChoixSimple	
}

class Question {
	String value
	TypeQuestion type

    static constraints = {
    }
}
