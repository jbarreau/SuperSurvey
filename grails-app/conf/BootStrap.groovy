import supersurveys.User

class BootStrap {

    def init = { servletContext ->
    	User u1 = new User(nom:"Nath",prenom:"bertrand",email:"cmoinath@gmail.com",password:"lol",login:"nath")
		u1.save()
		
	}
    def destroy = {
    }
}
